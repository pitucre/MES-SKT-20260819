/*
  W12 线边/料桶物料差异分析 - 汇总 (BI中心 缺口报表-新建)
  实现   : 调用 uspBI_MaterialDiffGrnDetail_Program 取 GRN 明细, 按 料桶 x 物料 聚合,
           叠加 Data_ErrMessage 报错次数(按料号, 取 MAX 避免跨桶重复计数)
  指标   : 上料量(区间) / 卸料剩余(区间) / 扣料量(区间) / 当前余额(快照)
            在桶差异kg = SUM(GRN级: (上料时点余额 - 上料后扣料 - 上料后快照扣料) - 当前余额)  仅当前在桶
            快照扣料   = Prod_PickSnapshotDetail (只减余额、不写扣料流水的扣料路径) 按区间统计
           卸料丢弃kg = SUM(GRN级: 区间内最近一次卸料时点余额 > 0)
           差异合计kg = ABS(在桶差异) + 卸料丢弃
           差异率%    = 差异合计 / 区间上料量
  过滤   : @DiffType 空=全部 | Diff=有差异 | Dump=卸料丢弃 | Zero=零负余额 | Err=有报错
  分页   : @PageSize=-1 或 @PageIndex<=0 -> 全量返回; 否则 ROW_NUMBER 分页并回写 @TotalCount
  创建   : 2026-09-28 全新对象(以 _Program 结尾, 无原有对象备份需求)
*/
CREATE PROCEDURE [dbo].[uspBI_MaterialDiffAnalysis_Program]
(
    @StartDate   VARCHAR(20) = '',
    @EndDate     VARCHAR(20) = '',
    @BucketCode  VARCHAR(50) = '',
    @ItemCode    VARCHAR(50) = '',
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

    /* 1) GRN 明细 (全量, 统一口径) */
    CREATE TABLE #g
    (
        Bucket      VARCHAR(100),
        Machine     VARCHAR(100),
        MachineName NVARCHAR(200),
        GRN         VARCHAR(50),
        ItemCode    VARCHAR(100),
        ItemName    NVARCHAR(200),
        QtyAll      DECIMAL(18, 6),
        UnitCnt     INT,
        LoadCnt     INT,
        LoadQty     DECIMAL(18, 6),
        LoadNull    INT,
        LTime       DATETIME,
        LQty        DECIMAL(18, 6),
        DedCnt      INT,
        DedQty      DECIMAL(18, 6),
        DedAfter    DECIMAL(18, 6),
        SnapCnt     INT,
        SnapQty     DECIMAL(18, 6),
        SnapAfter   DECIMAL(18, 6),
        UnloadCnt   INT,
        UnloadQty   DECIMAL(18, 6),
        UTime       DATETIME,
        UQty        DECIMAL(18, 6),
        BalAll      DECIMAL(18, 6),
        InBucket    INT,
        ZeroUnit    INT,
        NegUnit     INT,
        DiffOpen    DECIMAL(18, 6),
        DumpQty     DECIMAL(18, 6),
        ErrCnt      INT,
        LastErr     DATETIME,
        Verdict     NVARCHAR(50)
    );

    INSERT INTO #g
    EXEC dbo.uspBI_MaterialDiffGrnDetail_Program
        @StartDate = @StartDate,
        @EndDate = @EndDate,
        @BucketCode = @BucketCode,
        @ItemCode = @ItemCode,
        @MachineCode = @MachineCode,
        @PageSize = -1,
        @PageIndex = -1;

    /* 2) 报错 (按料号) */
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
    GROUP BY x.ItemCode OPTION (MAXDOP 1);

    /* 3) 汇总: 料桶 x 物料 */
    SELECT  Bucket       = g.Bucket,
            Machine      = ISNULL(MAX(g.Machine), ''),
            ItemCode     = ISNULL(MAX(g.ItemCode), ''),
            ItemName     = ISNULL(MAX(g.ItemName), ''),
            GrnCnt       = COUNT(*),
            OpenGrnCnt   = SUM(CASE WHEN g.InBucket = 1 THEN 1 ELSE 0 END),
            UnitCnt      = SUM(g.UnitCnt),
            ZeroUnit     = SUM(g.ZeroUnit),
            NegUnit      = SUM(g.NegUnit),
            LoadCnt      = SUM(g.LoadCnt),
            LoadQty      = SUM(g.LoadQty),
            UnloadCnt    = SUM(g.UnloadCnt),
            UnloadQty    = SUM(g.UnloadQty),
            DedCnt       = SUM(g.DedCnt),
            DedQty       = SUM(g.DedQty),
            SnapCnt      = SUM(g.SnapCnt),
            SnapQty      = SUM(g.SnapQty),
            BalAll       = SUM(g.BalAll),
            DiffOpen     = SUM(g.DiffOpen),
            DumpQty      = SUM(g.DumpQty),
            ErrCnt       = ISNULL(MAX(e.ErrCnt), 0),
            LastErr      = MAX(e.LastErrTime)
    INTO #agg
    FROM #g g
    LEFT JOIN #err e ON e.ItemCode = g.ItemCode
    GROUP BY g.Bucket, g.ItemCode OPTION (MAXDOP 1);

    SELECT  a.Bucket,
            a.Machine,
            a.ItemCode,
            a.ItemName,
            a.GrnCnt, a.OpenGrnCnt, a.UnitCnt, a.ZeroUnit, a.NegUnit,
            a.LoadCnt, a.LoadQty, a.UnloadCnt, a.UnloadQty,
            a.DedCnt, a.DedQty, a.SnapCnt, a.SnapQty, a.BalAll,
            a.DiffOpen,
            a.DumpQty,
            DiffTotal = ABS(ISNULL(a.DiffOpen, 0)) + ISNULL(a.DumpQty, 0),
            DiffPct   = CAST(CASE WHEN ISNULL(a.LoadQty, 0) <= 0 THEN NULL
                                  ELSE ROUND(100.0 * (ABS(ISNULL(a.DiffOpen, 0)) + ISNULL(a.DumpQty, 0)) / a.LoadQty, 2)
                             END AS DECIMAL(10, 2)),
            a.ErrCnt, a.LastErr,
            Verdict   = CASE
                            WHEN ISNULL(a.NegUnit, 0) > 0 THEN N'负余额'
                            WHEN ISNULL(a.ErrCnt, 0) > 0 THEN N'已触发报错'
                            WHEN ISNULL(a.ZeroUnit, 0) > 0 THEN N'零余额占位'
                            WHEN ABS(ISNULL(a.DiffOpen, 0)) > 0.005 THEN N'在桶账实不符'
                            WHEN ISNULL(a.DumpQty, 0) > 0.005 THEN N'卸料未结转'
                            ELSE N'正常'
                        END
    INTO #tmp
    FROM #agg a
    WHERE (@BucketCode = '' OR a.Bucket LIKE '%' + @BucketCode + '%')
      AND (@ItemCode = '' OR a.ItemCode LIKE '%' + @ItemCode + '%'
                          OR a.ItemName LIKE '%' + @ItemCode + '%')
      AND (@MachineCode = '' OR a.Machine LIKE '%' + @MachineCode + '%')
      AND (@DiffType = ''
           OR (@DiffType = 'Diff' AND (ABS(ISNULL(a.DiffOpen, 0)) > 0.005 OR ISNULL(a.DumpQty, 0) > 0.005))
           OR (@DiffType = 'Dump' AND ISNULL(a.DumpQty, 0) > 0.005)
           OR (@DiffType = 'Zero' AND (ISNULL(a.ZeroUnit, 0) > 0 OR ISNULL(a.NegUnit, 0) > 0))
           OR (@DiffType = 'Err' AND ISNULL(a.ErrCnt, 0) > 0)) OPTION (MAXDOP 1);

    SELECT @TotalCount = COUNT(1) FROM #tmp;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT t.*, ROW_NUMBER() OVER (ORDER BY t.DiffTotal DESC, t.ErrCnt DESC,
                                                     t.Bucket ASC, t.ItemCode ASC) AS rn
            FROM #tmp t
        )
        SELECT  [料桶]        = c.Bucket,
                [机台]        = c.Machine,
                [物料编码]    = c.ItemCode,
                [物料名称]    = c.ItemName,
                [GRN数]       = c.GrnCnt,
                [在桶GRN数]   = c.OpenGrnCnt,
                [物料单元数]  = c.UnitCnt,
                [在桶零余额单元数] = c.ZeroUnit,
                [负余额单元数] = c.NegUnit,
                [上料次数]    = c.LoadCnt,
                [上料量kg]    = c.LoadQty,
                [卸料次数]    = c.UnloadCnt,
                [卸料剩余kg]  = c.UnloadQty,
                [扣料次数]    = c.DedCnt,
                [扣料量kg]    = c.DedQty,
                [快照扣料次数] = c.SnapCnt,
                [快照扣料量kg] = c.SnapQty,
                [当前余额kg]  = c.BalAll,
                [在桶差异kg]  = c.DiffOpen,
                [卸料丢弃kg]  = c.DumpQty,
                [差异合计kg]  = c.DiffTotal,
                [差异率%]     = c.DiffPct,
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
                [物料编码]    = t.ItemCode,
                [物料名称]    = t.ItemName,
                [GRN数]       = t.GrnCnt,
                [在桶GRN数]   = t.OpenGrnCnt,
                [物料单元数]  = t.UnitCnt,
                [在桶零余额单元数] = t.ZeroUnit,
                [负余额单元数] = t.NegUnit,
                [上料次数]    = t.LoadCnt,
                [上料量kg]    = t.LoadQty,
                [卸料次数]    = t.UnloadCnt,
                [卸料剩余kg]  = t.UnloadQty,
                [扣料次数]    = t.DedCnt,
                [扣料量kg]    = t.DedQty,
                [快照扣料次数] = t.SnapCnt,
                [快照扣料量kg] = t.SnapQty,
                [当前余额kg]  = t.BalAll,
                [在桶差异kg]  = t.DiffOpen,
                [卸料丢弃kg]  = t.DumpQty,
                [差异合计kg]  = t.DiffTotal,
                [差异率%]     = t.DiffPct,
                [报错次数]    = t.ErrCnt,
                [最后报错时间] = t.LastErr,
                [判定]        = t.Verdict
        FROM #tmp t
        ORDER BY t.DiffTotal DESC, t.ErrCnt DESC, t.Bucket ASC, t.ItemCode ASC;
    END

    DROP TABLE #g, #err, #agg, #tmp;
END
