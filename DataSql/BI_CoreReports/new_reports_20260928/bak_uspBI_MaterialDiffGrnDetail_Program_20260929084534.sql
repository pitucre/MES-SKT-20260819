/*
  W12 线边/料桶物料差异分析 - GRN 明细下钻 (BI中心 缺口报表-新建)
  数据源 : dbo.Prod_InjectionLoadingMaterialHistory (注塑上料/卸料: GRN/Qty=时点余额/料桶/ResIds)
           dbo.Prod_InjectionLoadingMaterial (当前在桶映射)
           dbo.Prod_MaterialUnit (GRN->单元: Quantity/BalanceQty/PartId)
           dbo.Prod_MaterialUnitHistory (累计扣料 ActionType=7, 排除 ActionDesc='修改GRN状态')
           dbo.Prod_InjectionLoadingMaterialRelationRes + dbo.Basal_Resource (料桶->机台 兜底)
           dbo.Basal_Item (料号->名称)
           dbo.Data_ErrMessage (不够扣料/可用数量为0 报错, 按料号聚合)
  粒度   : GRN (同一 GRN 多个物料单元按 GRN 汇总)
  口径   : 上料时点余额L = 该 GRN 最近一次上料 h.Qty
           上料后扣料   = ActionType=7 且 CreateDateTime >= L (仅当前在桶 GRN 计算)
           当前余额B    = 该 GRN 全部物料单元 BalanceQty 合计
           在桶差异kg   = (L - 上料后扣料) - B   仅当前仍在料桶内的 GRN, NULL=无法计算
           卸料丢弃kg   = 区间内最近一次卸料时点余额 (>0 表示卸料后账面仍记着、已从料桶移除)
  过滤   : @DiffType 空=全部 | Diff=有差异 | Dump=卸料丢弃 | Zero=零余额/负余额 | Err=有报错
  分页   : @PageSize=-1 或 @PageIndex<=0 -> 全量返回; 否则 ROW_NUMBER 分页并回写 @TotalCount
  创建   : 2026-09-28 全新对象(以 _Program 结尾, 无原有对象备份需求)
*/
CREATE PROCEDURE [dbo].[uspBI_MaterialDiffGrnDetail_Program]
(
    @StartDate   VARCHAR(20) = '',
    @EndDate     VARCHAR(20) = '',
    @BucketCode  VARCHAR(50) = '',
    @ItemCode    VARCHAR(50) = '',
    @GRN         VARCHAR(50) = '',
    @MachineCode VARCHAR(50) = '',
    @DiffType    VARCHAR(20) = '',
    @PageSize    INT = -1,
    @PageIndex   INT = -1,
    @TotalCount  INT = -1 OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    DECLARE @S VARCHAR(10), @E VARCHAR(10);
    SET @S = LEFT(CASE WHEN ISNULL(@StartDate, '') = '' THEN CONVERT(VARCHAR(10), DATEADD(DAY, -30, GETDATE()), 120) ELSE @StartDate END, 10);
    SET @E = LEFT(CASE WHEN ISNULL(@EndDate, '') = '' THEN CONVERT(VARCHAR(10), GETDATE(), 120) ELSE @EndDate END, 10);
    DECLARE @SD DATETIME = @S;
    DECLARE @ED DATETIME = DATEADD(DAY, 1, @E);

    /* 1) 料桶->机台 (当前绑定, 兜底) */
    SELECT  MaterialBucketCode = rr.MaterialBucketCode,
            BucketMachine      = MIN(r.EquipmentCode),
            BucketMachineName  = MIN(r.ResName)
    INTO #bres
    FROM dbo.Prod_InjectionLoadingMaterialRelationRes rr WITH (NOLOCK)
    JOIN dbo.Basal_Resource r WITH (NOLOCK) ON r.ResourceId = rr.ResId
    GROUP BY rr.MaterialBucketCode;

    /* 2) 每个 GRN 最近一次上料 -> 料桶 / 时点余额L / 时间 / 资源 */
    SELECT  GRN,
            MaterialBucketCode,
            LQty    = ISNULL(Qty, 0),
            LTime   = CreateDateTime,
            ResIds
    INTO #lastLoad
    FROM (SELECT ROW_NUMBER() OVER (PARTITION BY GRN ORDER BY CreateDateTime DESC, HId DESC) AS rn,
                 GRN, MaterialBucketCode, Qty, CreateDateTime, ResIds
          FROM dbo.Prod_InjectionLoadingMaterialHistory WITH (NOLOCK)
          WHERE OperateType = N'注塑上料'
            AND ISNULL(GRN, '') <> '') x
    WHERE rn = 1;

    /* 3) 上料资源 -> 真机号 (上料时点的机台) */
    SELECT  ll.GRN,
            MachCode = MIN(r.EquipmentCode),
            MachName = MIN(r.ResName)
    INTO #grnMach
    FROM #lastLoad ll
    CROSS APPLY (SELECT v = LTRIM(RTRIM(sp.value))
                 FROM STRING_SPLIT(ISNULL(ll.ResIds, ''), '|') sp
                 WHERE ISNUMERIC(LTRIM(RTRIM(sp.value))) = 1) s
    JOIN dbo.Basal_Resource r WITH (NOLOCK) ON r.ResourceId = CAST(s.v AS INT)
    GROUP BY ll.GRN;

    /* 4) 当前在桶 (按 GRN 聚合) */
    SELECT  ilm.GRN,
            MaterialBucketCode = MIN(ilm.MaterialBucketCode),
            ItemId   = MAX(ilm.ItemId),
            ItemCode = MAX(ilm.ItemCode),
            InBucket = COUNT(*)
    INTO #cur
    FROM dbo.Prod_InjectionLoadingMaterial ilm WITH (NOLOCK)
    WHERE ISNULL(ilm.GRN, '') <> ''
    GROUP BY ilm.GRN;

    /* 5) 区间内上料 */
    SELECT  GRN,
            LoadCnt  = COUNT(*),
            LoadQty  = SUM(ISNULL(Qty, 0)),
            LoadNull = SUM(CASE WHEN Qty IS NULL THEN 1 ELSE 0 END)
    INTO #loadP
    FROM dbo.Prod_InjectionLoadingMaterialHistory WITH (NOLOCK)
    WHERE OperateType = N'注塑上料'
      AND CreateDateTime >= @SD AND CreateDateTime < @ED
      AND ISNULL(GRN, '') <> ''
    GROUP BY GRN;

    /* 6) 区间内卸料 (含最近一次卸料时点余额) */
    SELECT  GRN,
            UnloadCnt     = COUNT(*),
            UnloadQty     = SUM(ISNULL(Qty, 0)),
            LastUnload    = MAX(CreateDateTime),
            LastUnloadQty = MAX(ISNULL(Qty, 0))
    INTO #unloadP
    FROM dbo.Prod_InjectionLoadingMaterialHistory WITH (NOLOCK)
    WHERE OperateType = N'注塑卸料'
      AND CreateDateTime >= @SD AND CreateDateTime < @ED
      AND ISNULL(GRN, '') <> ''
    GROUP BY GRN;

    /* 7) 区间内扣料 */
    SELECT  GRN = mu.SerialNumber,
            DedCnt = COUNT(*),
            DedQty = SUM(ISNULL(mh.Qty, 0))
    INTO #dedP
    FROM dbo.Prod_MaterialUnitHistory mh WITH (NOLOCK)
    JOIN dbo.Prod_MaterialUnit mu WITH (NOLOCK) ON mu.MaterialUnitId = mh.MaterialUnitId
    WHERE mh.ActionType = 7
      AND ISNULL(mh.ActionDesc, '') <> N'修改GRN状态'
      AND mh.CreateDateTime >= @SD AND mh.CreateDateTime < @ED
      GROUP BY mu.SerialNumber;

    /* 8) GRN 全集 (区间事件 + 当前在桶) */
    SELECT GRN
    INTO #src
    FROM (SELECT GRN FROM #loadP
          UNION SELECT GRN FROM #unloadP
          UNION SELECT GRN FROM #dedP
          UNION SELECT GRN FROM #cur) x
    WHERE ISNULL(x.GRN, '') <> '';

    /* 9) GRN 对应物料单元快照 */
    SELECT  SerialNumber,
            PartId   = MAX(PartId),
            QtyAll   = SUM(ISNULL(Quantity, 0)),
            BalAll   = SUM(ISNULL(BalanceQty, 0)),
            UnitCnt  = COUNT(*),
            ZeroUnit = SUM(CASE WHEN ISNULL(BalanceQty, 0) <= 0 THEN 1 ELSE 0 END),
            NegUnit  = SUM(CASE WHEN ISNULL(BalanceQty, 0) < 0 THEN 1 ELSE 0 END)
    INTO #unit
    FROM dbo.Prod_MaterialUnit WITH (NOLOCK)
    WHERE SerialNumber IN (SELECT GRN FROM #src)
    GROUP BY SerialNumber;

    /* 10) 上料后扣料 (仅当前在桶 GRN 需要) */
    SELECT  GRN = mu.SerialNumber,
            DedAll    = SUM(ISNULL(mh.Qty, 0)),
            DedAllCnt = COUNT(*),
            DedAfter  = SUM(CASE WHEN mh.CreateDateTime >= ISNULL(ll.LTime, '1900-01-01') THEN ISNULL(mh.Qty, 0) ELSE 0 END)
    INTO #dedAll
    FROM dbo.Prod_MaterialUnitHistory mh WITH (NOLOCK)
    JOIN dbo.Prod_MaterialUnit mu WITH (NOLOCK) ON mu.MaterialUnitId = mh.MaterialUnitId
    JOIN #cur c ON c.GRN = mu.SerialNumber
    LEFT JOIN #lastLoad ll ON ll.GRN = mu.SerialNumber
    WHERE mh.ActionType = 7
      AND ISNULL(mh.ActionDesc, '') <> N'修改GRN状态'
    GROUP BY mu.SerialNumber;

    /* 11) 报错 (按料号, 消息格式: 0302-00001(...)不够扣料... / 物料编码[0302-00001]物料名称[..]可用数量为0) */
    SELECT  ItemCode,
            ErrCnt      = COUNT(*),
            LastErrTime = MAX(ErrTime)
    INTO #err
    FROM (SELECT ItemCode =
                     CASE WHEN CHARINDEX(N'[', ErrMessage) > 0
                               AND CHARINDEX(N']', ErrMessage) > CHARINDEX(N'[', ErrMessage)
                          THEN SUBSTRING(ErrMessage,
                                         CHARINDEX(N'[', ErrMessage) + 1,
                                         CHARINDEX(N']', ErrMessage) - CHARINDEX(N'[', ErrMessage) - 1)
                          WHEN CHARINDEX('(', ErrMessage) > 0
                          THEN LEFT(ErrMessage, CHARINDEX('(', ErrMessage) - 1)
                          ELSE NULL END,
                 ErrTime
          FROM dbo.Data_ErrMessage WITH (NOLOCK)
          WHERE ErrTime >= @SD AND ErrTime < @ED
            AND (ErrMessage LIKE N'%不够扣料%' OR ErrMessage LIKE N'%可用数量为0%')) x
    WHERE ISNULL(x.ItemCode, '') <> ''
    GROUP BY x.ItemCode;

    /* 12) GRN 明细 */
    SELECT  Bucket  = ISNULL(c.MaterialBucketCode, ISNULL(ll.MaterialBucketCode, '')),
            GRN     = s.GRN,
            ItemId  = ISNULL(c.ItemId, u.PartId),
            ItemCodeUsed = ISNULL(c.ItemCode, ''),
            MachCode = ISNULL(gm.MachCode, b.BucketMachine),
            MachName = ISNULL(gm.MachName, b.BucketMachineName),
            QtyAll   = ISNULL(u.QtyAll, 0),
            UnitCnt  = ISNULL(u.UnitCnt, 0),
            LoadCnt  = ISNULL(lp.LoadCnt, 0),
            LoadQty  = ISNULL(lp.LoadQty, 0),
            LoadNull = ISNULL(lp.LoadNull, 0),
            LTime    = ll.LTime,
            LQty     = CASE WHEN ll.GRN IS NULL THEN NULL ELSE ISNULL(ll.LQty, 0) END,
            DedCnt   = ISNULL(dp.DedCnt, 0),
            DedQty   = ISNULL(dp.DedQty, 0),
            DedAfter = da.DedAfter,
            UnloadCnt = ISNULL(up.UnloadCnt, 0),
            UnloadQty = ISNULL(up.UnloadQty, 0),
            UTime    = up.LastUnload,
            UQty     = CASE WHEN up.GRN IS NULL THEN NULL ELSE ISNULL(up.LastUnloadQty, 0) END,
            BalAll   = ISNULL(u.BalAll, 0),
            InBucket = CASE WHEN c.GRN IS NULL THEN 0 ELSE 1 END,
            ZeroUnit = CASE WHEN c.GRN IS NULL THEN 0 ELSE ISNULL(u.ZeroUnit, 0) END,
            NegUnit  = ISNULL(u.NegUnit, 0),
            ErrCnt   = ISNULL(e.ErrCnt, 0),
            LastErr  = e.LastErrTime
    INTO #grn
    FROM #src s
    LEFT JOIN #lastLoad ll ON ll.GRN = s.GRN
    LEFT JOIN #cur c       ON c.GRN = s.GRN
    LEFT JOIN #bres b      ON b.MaterialBucketCode = ISNULL(c.MaterialBucketCode, ll.MaterialBucketCode)
    LEFT JOIN #grnMach gm  ON gm.GRN = s.GRN
    LEFT JOIN #unit u      ON u.SerialNumber = s.GRN
    LEFT JOIN #loadP lp    ON lp.GRN = s.GRN
    LEFT JOIN #unloadP up  ON up.GRN = s.GRN
    LEFT JOIN #dedP dp     ON dp.GRN = s.GRN
    LEFT JOIN #dedAll da   ON da.GRN = s.GRN
    LEFT JOIN dbo.Basal_Item i WITH (NOLOCK) ON i.ItemID = ISNULL(c.ItemId, u.PartId)
    LEFT JOIN #err e       ON e.ItemCode = ISNULL(i.ItemCode, c.ItemCode);

    SELECT  g.Bucket,
            g.GRN,
            ItemCode = ISNULL(i.ItemCode, g.ItemCodeUsed),
            ItemName = ISNULL(i.ItemName, ''),
            Machine  = ISNULL(g.MachCode, ''),
            MachineName = ISNULL(g.MachName, ''),
            g.QtyAll, g.UnitCnt, g.LoadCnt, g.LoadQty, g.LoadNull,
            g.LTime, g.LQty, g.DedCnt, g.DedQty, g.DedAfter,
            g.UnloadCnt, g.UnloadQty, g.UTime, g.UQty,
            g.BalAll, g.InBucket, g.ZeroUnit, g.NegUnit,
            DiffOpen = CASE WHEN g.InBucket = 1 AND g.LTime IS NOT NULL
                            THEN (ISNULL(g.LQty, 0) - ISNULL(g.DedAfter, 0)) - g.BalAll
                            ELSE NULL END,
            DumpQty  = CASE WHEN ISNULL(g.UQty, 0) > 0 THEN g.UQty ELSE 0 END,
            g.ErrCnt, g.LastErr,
            Verdict  = CASE
                           WHEN g.NegUnit > 0 THEN N'负余额'
                           WHEN g.InBucket = 1 AND g.ZeroUnit > 0 THEN N'零余额占位'
                           WHEN g.InBucket = 1 AND g.LTime IS NULL THEN N'缺上料记录'
                           WHEN g.InBucket = 1 AND ABS((ISNULL(g.LQty, 0) - ISNULL(g.DedAfter, 0)) - g.BalAll) > 0.005 THEN N'在桶账实不符'
                           WHEN ISNULL(g.UQty, 0) > 0.005 THEN N'卸料未结转'
                           ELSE N'正常'
                       END
    INTO #grn2
    FROM #grn g
    LEFT JOIN dbo.Basal_Item i WITH (NOLOCK) ON i.ItemID = g.ItemId;

    SELECT  g2.*
    INTO #tmp
    FROM #grn2 g2
    WHERE (@BucketCode = '' OR g2.Bucket LIKE '%' + @BucketCode + '%')
      AND (@GRN = '' OR g2.GRN LIKE '%' + @GRN + '%')
      AND (@MachineCode = '' OR g2.Machine LIKE '%' + @MachineCode + '%'
                             OR g2.MachineName LIKE '%' + @MachineCode + '%')
      AND (@ItemCode = '' OR g2.ItemCode LIKE '%' + @ItemCode + '%'
                          OR g2.ItemName LIKE '%' + @ItemCode + '%')
      AND (@DiffType = ''
           OR (@DiffType = 'Diff' AND (ABS(ISNULL(g2.DiffOpen, 0)) > 0.005 OR g2.DumpQty > 0.005))
           OR (@DiffType = 'Dump' AND g2.DumpQty > 0.005)
           OR (@DiffType = 'Zero' AND (g2.ZeroUnit > 0 OR g2.NegUnit > 0))
           OR (@DiffType = 'Err' AND g2.ErrCnt > 0));

    SELECT @TotalCount = COUNT(1) FROM #tmp;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT t.*, ROW_NUMBER() OVER (ORDER BY CASE WHEN t.Verdict = N'正常' THEN 1 ELSE 0 END ASC,
                                                     ABS(ISNULL(t.DiffOpen, 0)) + ISNULL(t.DumpQty, 0) DESC,
                                                     t.Bucket ASC, t.GRN ASC) AS rn
            FROM #tmp t
        )
        SELECT  [料桶]        = c.Bucket,
                [机台]        = c.Machine,
                [机台名称]    = c.MachineName,
                [GRN]         = c.GRN,
                [物料编码]    = c.ItemCode,
                [物料名称]    = c.ItemName,
                [GRN总量kg]   = c.QtyAll,
                [物料单元数]  = c.UnitCnt,
                [区间上料次数] = c.LoadCnt,
                [区间上料量kg] = c.LoadQty,
                [上料未记余额条数] = c.LoadNull,
                [最近上料时间] = c.LTime,
                [上料时点余额kg] = c.LQty,
                [区间扣料次数] = c.DedCnt,
                [区间扣料量kg] = c.DedQty,
                [上料后扣料量kg] = c.DedAfter,
                [区间卸料次数] = c.UnloadCnt,
                [区间卸料剩余kg] = c.UnloadQty,
                [卸料时间]    = c.UTime,
                [卸料时点余额kg] = c.UQty,
                [当前余额kg]  = c.BalAll,
                [在桶]        = c.InBucket,
                [在桶零余额单元数] = c.ZeroUnit,
                [负余额单元数] = c.NegUnit,
                [在桶差异kg]  = c.DiffOpen,
                [卸料丢弃kg]  = c.DumpQty,
                [报错次数]    = c.ErrCnt,
                [最后报错时间] = c.LastErr,
                [判定]        = c.Verdict
        FROM c
        WHERE c.rn > (@PageIndex - 1) * @PageSize
          AND c.rn <= @PageIndex * @PageSize
        ORDER BY c.rn;
    END
    ELSE
    BEGIN
        SELECT  [料桶]        = t.Bucket,
                [机台]        = t.Machine,
                [机台名称]    = t.MachineName,
                [GRN]         = t.GRN,
                [物料编码]    = t.ItemCode,
                [物料名称]    = t.ItemName,
                [GRN总量kg]   = t.QtyAll,
                [物料单元数]  = t.UnitCnt,
                [区间上料次数] = t.LoadCnt,
                [区间上料量kg] = t.LoadQty,
                [上料未记余额条数] = t.LoadNull,
                [最近上料时间] = t.LTime,
                [上料时点余额kg] = t.LQty,
                [区间扣料次数] = t.DedCnt,
                [区间扣料量kg] = t.DedQty,
                [上料后扣料量kg] = t.DedAfter,
                [区间卸料次数] = t.UnloadCnt,
                [区间卸料剩余kg] = t.UnloadQty,
                [卸料时间]    = t.UTime,
                [卸料时点余额kg] = t.UQty,
                [当前余额kg]  = t.BalAll,
                [在桶]        = t.InBucket,
                [在桶零余额单元数] = t.ZeroUnit,
                [负余额单元数] = t.NegUnit,
                [在桶差异kg]  = t.DiffOpen,
                [卸料丢弃kg]  = t.DumpQty,
                [报错次数]    = t.ErrCnt,
                [最后报错时间] = t.LastErr,
                [判定]        = t.Verdict
        FROM #tmp t
        ORDER BY CASE WHEN t.Verdict = N'正常' THEN 1 ELSE 0 END ASC,
                 ABS(ISNULL(t.DiffOpen, 0)) + ISNULL(t.DumpQty, 0) DESC,
                 t.Bucket ASC, t.GRN ASC;
    END

    DROP TABLE #grn, #grn2, #tmp;
END
