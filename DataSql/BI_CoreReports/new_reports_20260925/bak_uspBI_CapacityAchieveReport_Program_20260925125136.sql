/*
  P96 产能达成分析 (BI中心 缺口报表-新建)
  数据源 : dbo.Prod_EquimentOrderPord (日x机台x工单 计划量Qty/ProdNum, WorkDate为ISO varchar, 机台为旧码)
           dbo.Prod_EquipmentDayProd(+Dtl) (日x真机号x工单 实际OK+NG)
           dbo.Prod_Order + dbo.Prod_OrderStatus + dbo.Basal_Item (工单/状态/产品)
           dbo.Basal_Equipment_Ext(ExtFieldsId=1) 旧码->真码
  粒度   : 日期 x 机台 x 工单
  约定   : @PageSize=-1 或 @PageIndex<=0 -> 全量返回; 否则 ROW_NUMBER 分页并回写 @TotalCount
  创建   : 2026-09-25 全新对象(以 _Program 结尾, 无原有对象备份需求)
*/
CREATE PROCEDURE [dbo].[uspBI_CapacityAchieveReport_Program]
(
    @StartDate   VARCHAR(20) = '',
    @EndDate     VARCHAR(20) = '',
    @MachineCode VARCHAR(50) = '',
    @OrderNo     VARCHAR(50) = '',
    @Status      VARCHAR(50) = '',
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

    SELECT  LegacyCode    = x.ExtFieldValue,
            RealCode      = MIN(e.EquipmentCode),
            EquipmentName = MIN(e.EquipmentName)
    INTO #lmap
    FROM dbo.Basal_Equipment e WITH (NOLOCK)
    JOIN dbo.Basal_Equipment_Ext x WITH (NOLOCK)
         ON x.TableDataId = e.EquipmentId AND x.ExtFieldsId = 1
    WHERE ISNULL(x.ExtFieldValue, '') <> ''
    GROUP BY x.ExtFieldValue;

    SELECT  D          = TRY_CONVERT(DATE, p.WorkDate, 120),
            RealCode   = COALESCE(lm.RealCode, p.EquipmentCode),
            p.OrderNo,
            PlanQty    = SUM(ISNULL(p.Qty, 0)),
            PordProd   = SUM(ISNULL(p.ProdNum, 0))
    INTO #plan
    FROM dbo.Prod_EquimentOrderPord p WITH (NOLOCK)
    LEFT JOIN #lmap lm ON lm.LegacyCode = p.EquipmentCode
    WHERE p.WorkDate >= @S
      AND p.WorkDate <= @E
    GROUP BY TRY_CONVERT(DATE, p.WorkDate, 120), COALESCE(lm.RealCode, p.EquipmentCode), p.OrderNo;

    SELECT  D        = CAST(d.WorkDate AS DATE),
            d.EquipmentCode,
            p.OrderNo,
            ActQty   = SUM(ISNULL(dt.OkQty, 0) + ISNULL(dt.NgQty, 0))
    INTO #act
    FROM dbo.Prod_EquipmentDayProd d WITH (NOLOCK)
    JOIN dbo.Prod_EquipmentDayProdDtl dt WITH (NOLOCK)
      ON dt.EquipmentDayProdId = d.EquipmentDayProdId
    LEFT JOIN dbo.Prod_Order p WITH (NOLOCK) ON p.ProdOrderID = dt.ProdOrderID
    WHERE d.WorkDate >= @SD
      AND d.WorkDate <  @ED
    GROUP BY CAST(d.WorkDate AS DATE), d.EquipmentCode, p.OrderNo;

    SELECT  D          = COALESCE(pl.D, ac.D),
            RealCode   = COALESCE(pl.RealCode, ac.EquipmentCode),
            OrderNo    = COALESCE(pl.OrderNo, ac.OrderNo),
            PlanQty    = ISNULL(pl.PlanQty, 0),
            PordProd   = ISNULL(pl.PordProd, 0),
            ActQty     = ISNULL(ac.ActQty, 0)
    INTO #day
    FROM #plan pl
    FULL OUTER JOIN #act ac
                 ON ac.D = pl.D
                AND ac.EquipmentCode = pl.RealCode
                AND ISNULL(ac.OrderNo, '') = ISNULL(pl.OrderNo, '');

    SELECT  d.D,
            d.RealCode,
            d.OrderNo,
            ItemCode   = ISNULL(i.ItemCode, ''),
            ItemName   = ISNULL(i.ItemName, ''),
            StatusDesc = ISNULL(os.StatusDesc, ''),
            d.PlanQty,
            DayQty     = CASE WHEN d.ActQty > 0 THEN d.ActQty ELSE d.PordProd END,
            OrderPlan  = ISNULL(o.Qty_to_Build, 0),
            OrderDone  = ISNULL(o.Qty_Done, 0),
            DayAchPct  = CAST(CASE WHEN d.PlanQty <= 0 THEN NULL
                                   ELSE ROUND(100.0 * (CASE WHEN d.ActQty > 0 THEN d.ActQty ELSE d.PordProd END) / d.PlanQty, 2)
                              END AS DECIMAL(10, 2)),
            OrderAchPct = CAST(CASE WHEN ISNULL(o.Qty_to_Build, 0) <= 0 THEN NULL
                                    ELSE ROUND(100.0 * ISNULL(o.Qty_Done, 0) / o.Qty_to_Build, 2)
                               END AS DECIMAL(10, 2))
    INTO #tmp
    FROM #day d
    LEFT JOIN dbo.Prod_Order o WITH (NOLOCK) ON o.OrderNO = d.OrderNo
    LEFT JOIN dbo.Basal_Item i WITH (NOLOCK) ON i.ItemID = o.ItemId
    LEFT JOIN dbo.Prod_OrderStatus os WITH (NOLOCK) ON os.StatusID = o.Status
    WHERE (d.PlanQty > 0 OR d.DayQty > 0)
      AND (@MachineCode = '' OR d.RealCode = @MachineCode OR EXISTS (SELECT 1 FROM #lmap lm2
              WHERE lm2.RealCode = d.RealCode AND lm2.LegacyCode = @MachineCode))
      AND (@OrderNo = '' OR d.OrderNo LIKE '%' + @OrderNo + '%')
      AND (@Status = '' OR ISNULL(os.StatusDesc, '') LIKE '%' + @Status + '%');

    SELECT @TotalCount = COUNT(1) FROM #tmp;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT D, RealCode, OrderNo, ItemCode, ItemName, StatusDesc,
                   PlanQty, DayQty, OrderPlan, OrderDone, DayAchPct, OrderAchPct,
                   ROW_NUMBER() OVER (ORDER BY D DESC, RealCode ASC, OrderNo ASC) AS rn
            FROM #tmp
        )
        SELECT  [日期]       = c.D,
                [机台]       = c.RealCode,
                [工单号]     = c.OrderNo,
                [产品料号]   = c.ItemCode,
                [产品名称]   = c.ItemName,
                [工单状态]   = c.StatusDesc,
                [日计划量]   = c.PlanQty,
                [日完成量]   = c.DayQty,
                [日达成率%]  = c.DayAchPct,
                [订单计划量] = c.OrderPlan,
                [订单完成量] = c.OrderDone,
                [订单达成率%] = c.OrderAchPct
        FROM c
        WHERE c.rn > (@PageIndex - 1) * @PageSize
          AND c.rn <= @PageIndex * @PageSize
        ORDER BY c.rn;
    END
    ELSE
    BEGIN
        SELECT  [日期]       = t.D,
                [机台]       = t.RealCode,
                [工单号]     = t.OrderNo,
                [产品料号]   = t.ItemCode,
                [产品名称]   = t.ItemName,
                [工单状态]   = t.StatusDesc,
                [日计划量]   = t.PlanQty,
                [日完成量]   = t.DayQty,
                [日达成率%]  = t.DayAchPct,
                [订单计划量] = t.OrderPlan,
                [订单完成量] = t.OrderDone,
                [订单达成率%] = t.OrderAchPct
        FROM #tmp t
        ORDER BY t.D DESC, t.RealCode ASC, t.OrderNo ASC;
    END

    DROP TABLE #tmp;
END
