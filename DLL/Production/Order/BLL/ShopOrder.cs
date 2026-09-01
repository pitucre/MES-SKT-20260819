using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Order.Model;
using SKT.LeanMES.CommonHelper.BLL;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Dapper;
using SKT.LeanMES.ERP;

namespace SKT.LeanMES.Order.BLL
{
    public class ShopOrder
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ORDER 信息。
        /// </summary>
        /// <param name="entity">ORDER 实体对象。</param>
        public Int32 Edit(ShopOrderInfo entity, string pst, string pcd, string ssd, string sct)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProdOrderID", SqlDbType.Int),
                new SqlParameter("@OrderNO", SqlDbType.NVarChar, 50),
                new SqlParameter("@OrderType", SqlDbType.Int),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@Priority", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@BOMId", SqlDbType.Int),
                new SqlParameter("@RouterId", SqlDbType.Int),
                new SqlParameter("@CustomerID", SqlDbType.Int),
                new SqlParameter("@CustomerOrder", SqlDbType.NVarChar, 50),
                new SqlParameter("@CustomerOrderQty",SqlDbType.Int),
                new SqlParameter("@Qty_to_Build", SqlDbType.Int),
                new SqlParameter("@Planned_Start_Time", SqlDbType.DateTime),
                new SqlParameter("@Planned_Completed_Date", SqlDbType.DateTime),
                new SqlParameter("@Scheduled_Start_Date", SqlDbType.DateTime),
                new SqlParameter("@Scheduled_Completed_Time", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Qty_to_Line", SqlDbType.Int),
                new SqlParameter("@MaskId", SqlDbType.Int),
                new SqlParameter("@BomVersion", SqlDbType.VarChar,50),
                
                //,new SqlParameter("@PrivacyBOMFlag", SqlDbType.Int)
                //,new SqlParameter("@PrivacyParamFlag", SqlDbType.Int)
            };

            parms[0].Value = entity.ProdOrderID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.OrderNO;
            parms[2].Value = entity.OrderType;
            parms[3].Value = entity.Status;
            parms[4].Value = entity.Priority;
            parms[5].Value = entity.ItemId;
            parms[6].Value = entity.BOMId;
            parms[7].Value = entity.RouterId;
            parms[8].Value = entity.CustomerID;
            parms[9].Value = entity.CustomerOrder;
            parms[10].Value = entity.CustomerOrderQty;
            parms[11].Value = entity.Qty_to_Build;
            parms[12].Value = Convert.ToDateTime(pst);
            parms[13].Value = Convert.ToDateTime(pcd);
            parms[14].Value = Convert.ToDateTime(ssd);
            parms[15].Value = Convert.ToDateTime(sct);
            parms[16].Value = entity.CreateBy;
            parms[17].Value = entity.ModifyBy;
            parms[18].Value = entity.Qty_to_Line;
            parms[19].Value = entity.MaskId;
            parms[20].Value = entity.BomVersion;
            //parms[19].Value = entity.PrivacyBOM;
            //parms[20].Value = entity.PrivacyParam;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Order_Edit", parms);

            return (Int32)parms[0].Value;
        }

        public void RouterBind(int id, int routerId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProdOrderID", SqlDbType.Int),
                new SqlParameter("@RouterId", SqlDbType.Int),
                new SqlParameter("@User", SqlDbType.VarChar, 20)};

            parms[0].Value = id;
            parms[1].Value = routerId;
            parms[2].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspRouterBind", parms);
        }

        /// <summary>
        /// 改变序号当前工位
        /// </summary>
        /// <param name="strSN">序号</param>
        /// <param name="OpeID">目标工位ID</param>
        /// <param name="MoveBy">操作者</param>
        /// <param name="intResult">结果</param>
        public Int32 MoveSNStep(string strSN, Int32 OpeID, Int32 MoveBy, Int32 intResult)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumber", SqlDbType.NVarChar,50),
                new SqlParameter("@OpeID", SqlDbType.Int),
                new SqlParameter("@MoveBy", SqlDbType.Int),
                new SqlParameter("@Result", SqlDbType.Int)
            };

            parms[0].Value = strSN;
            parms[1].Value = OpeID;
            parms[2].Value = MoveBy;
            parms[3].Value = intResult;
            parms[3].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspChangeSNCurrentStep", parms);

            return (Int32)parms[3].Value;
        }

        /// <summary>
        /// 改变序号当前工位
        /// </summary>
        /// <param name="strSN">序号</param>
        /// <param name="OpeID">目标工位ID</param>
        /// <param name="MoveBy">操作者</param>
        /// <param name="intResult">结果</param>
        public Int32 ReturnOrder2Router(string strWO, Int32 OpeID, Int32 MoveBy, Int32 intResult)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WO", SqlDbType.NVarChar,50),
                new SqlParameter("@OpeID", SqlDbType.Int),
                new SqlParameter("@MoveBy", SqlDbType.Int),
                new SqlParameter("@Result", SqlDbType.Int)
            };

            parms[0].Value = strWO;
            parms[1].Value = OpeID;
            parms[2].Value = MoveBy;
            parms[3].Value = intResult;
            parms[3].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspChangeWOCurrentStep", parms);

            return (Int32)parms[3].Value;
        }


        /// <summary>
        /// 根据 ORDERId 字符串删除 ORDER 信息。
        /// </summary>
        /// <param name="idString">ORDERId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(Int32 id, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = id;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Order_Delete", parms);
        }

        /// <summary>
        /// 根据 ORDERId 获取实体信息。
        /// </summary>
        /// <param name="oRDERId">ORDERId。</param>
        /// <returns>ORDER 实体对象。</returns>
        public ShopOrderInfo GetInfo(Int32 soId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ShopOrderId", SqlDbType.Int)
            };
            parms[0].Value = soId;
            return ComMethod.Get<ShopOrderInfo>("Prod_Order_GetInfo", parms, SQLHelper.MESConnString);

            //ShopOrderInfo entity = null;

            //SqlParameter[] parms = new SqlParameter[]{
            //    new SqlParameter("@ShopOrderId", SqlDbType.Int)
            //};

            //parms[0].Value = soId;

            //using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Order_GetInfo", parms))
            //{
            //    if (rdr.Read())
            //    {
            //        entity = new ShopOrderInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
            //            rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetString(9), rdr.GetInt32(10),
            //            rdr.GetInt32(11), rdr.GetInt32(12), rdr.GetInt32(13), rdr.GetInt32(14), rdr.GetDateTime(15),
            //            rdr.GetDateTime(16), rdr.GetDateTime(17), rdr.GetDateTime(18), rdr.GetDateTime(19), rdr.GetDateTime(20),
            //            rdr.GetDateTime(21), rdr.GetString(22), rdr.GetDateTime(23), rdr.GetString(24), rdr.GetDateTime(25));

            //        entity.ItemName = rdr.GetString(26);
            //        entity.ItemVer = rdr.GetString(27);
            //        entity.BOMName = rdr.GetString(28);
            //        entity.BOMVer = rdr.GetString(29);
            //        entity.RouterName = rdr.GetString(30);
            //        entity.CustomerName = rdr.GetString(31);

            //        entity.ItemCode = rdr.GetString(32);
            //        entity.GeneratedPanelQty = rdr.GetInt32(33);
            //        entity.PrivacyBOM = rdr.GetInt32(34);
            //        entity.PrivacyOpeParam = rdr.GetInt32(35);
            //        entity.PrivacyItemParam = rdr.GetInt32(36);
            //        entity.MaskId = rdr.GetInt32(37);
            //        entity.MaskGroupName = rdr.GetString(38);
            //    }
            //    rdr.Close();
            //}

            //return entity;
        }

        //工单排期专用  //Modify:2017/09/07 Beck Ye 新增ItemSpec,ItemCode字段
        public ShopOrderInfo GetInfoByOrderId(Int32 soId)
        {
            ShopOrderInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderId", SqlDbType.Int)
            };

            parms[0].Value = soId;


            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Order_GetInfoByOrderId", parms))
            {
                if (rdr.Read())
                {
                    entity = new ShopOrderInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetString(9), rdr.GetInt32(10),
                        rdr.GetInt32(11), rdr.GetInt32(12), rdr.GetInt32(13), rdr.GetInt32(14), rdr.GetDateTime(15),
                        rdr.GetDateTime(16), rdr.GetDateTime(17), rdr.GetDateTime(18), rdr.GetDateTime(19), rdr.GetDateTime(20),
                        rdr.GetDateTime(21), rdr.GetString(22), rdr.GetDateTime(23), rdr.GetString(24), rdr.GetDateTime(25));


                    entity.BOMName = rdr.GetString(28);
                    entity.BOMVer = rdr.GetString(29);
                    entity.RouterName = rdr.GetString(30);
                    entity.CustomerName = rdr.GetString(31);
                    entity.LineStatue = rdr.GetInt32(32);
                    entity.ItemName = rdr.GetString(33);
                    entity.ItemSpec = rdr.GetString(34);
                    entity.ItemCode = rdr.GetString(35);
                    entity.PanelQty = rdr.GetInt32(36);
                    entity.FQty= rdr.GetDecimal(37);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 OrderNO 获取实体信息  生产排程专用。
        /// </summary>
        /// <param name="OrderNO">OrderNO。</param>
        /// <returns>ORDER 实体对象。</returns>
        public ShopOrderInfo GetInfo(string OrderNO)
        {
            ShopOrderInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNO", SqlDbType.NVarChar,50)
            };

            parms[0].Value = OrderNO;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Order_GetInfoByOrderNO", parms))
            {
                if (rdr.Read())
                {
                    entity = new ShopOrderInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetString(9), rdr.GetInt32(10),
                        rdr.GetInt32(11), rdr.GetInt32(12), rdr.GetInt32(13), rdr.GetInt32(14), rdr.GetDateTime(15),
                        rdr.GetDateTime(16), rdr.GetDateTime(17), rdr.GetDateTime(18), rdr.GetDateTime(19), rdr.GetDateTime(20),
                        rdr.GetDateTime(21), rdr.GetString(22), rdr.GetDateTime(23), rdr.GetString(24), rdr.GetDateTime(25));

                    entity.ItemName = rdr.GetString(26);
                    entity.ItemVer = rdr.GetString(27);
                    entity.BOMName = rdr.GetString(28);
                    entity.BOMVer = rdr.GetString(29);
                    entity.RouterName = rdr.GetString(30);
                    entity.CustomerName = rdr.GetString(31);

                    entity.ItemCode = rdr.GetString(32);
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// 得到工单投入数量
        /// </summary>
        /// <param name="orderID">工单ID</param>
        public Int32 getOrderInputQtyByID(Int32 orderID)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderID", SqlDbType.Int),
                new SqlParameter("@InputQty", SqlDbType.Int)
            };

            parms[0].Value = orderID;
            parms[1].Value = 0;
            parms[1].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetWOInputQtyByID", parms);

            return (Int32)parms[1].Value;
        }
        /// <summary>
        /// 获取符合规则的数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ShopOrderInfo> GetOrderAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {

            List<ShopOrderInfo> list = new List<ShopOrderInfo>();
            //表名或者视图
            string strTb = "vwProOrderList";
            string strKey = "ProdOrderID";   
            string strColumns = @"ProdOrderGroupID,ProdOrderID, OrderNO, ItemId,OrderType,Status,CustomerOrder ";
            list = ComMethod.GetComList<ShopOrderInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;

            //List<ShopOrderInfo> list = new List<ShopOrderInfo>();
            //ShopOrderInfo entity = null;
            //SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProOrderList",
            // "ProdOrderID", "ProdOrderGroupID,ProdOrderID, OrderNO, ItemId,OrderType,Status,CustomerOrder ", searchSettings, sortExpression);
            //using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            //{
            //    while (rdr.Read())
            //    {
            //        entity = new ShopOrderInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4), rdr.GetString(5));
            //        list.Add(entity);
            //    }
            //    rdr.Close();
            //}
            //recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            //return list;
        }

        /// <summary>
        /// 分页获取 ORDER 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="oRDERCount">oRDER 总数。</param>
        /// <returns>ORDER 列表。</returns>
        public List<ShopOrderInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ShopOrderInfo> list = new List<ShopOrderInfo>();
            //表名或者视图
            string strTb = "vwOrderInfo";
            //主键
            string strKey = "ProdOrderID";
            //查询栏位字串
            string strColumns = @"ProdOrderID,OrderNO,OrderType,[Status],Priority,ItemId,BOMId
                    ,  RouterId,CustomerID,CustomerOrder
                    , CustomerOrderQty,Qty_to_Build,Qty_Released,Qty_Done,Qty_Scrapped,Release_date,Planned_Start_Time
                    , Planned_Completed_Date,Scheduled_Start_Date,Scheduled_Completed_Time,Actual_Start_Date,Actual_Completed_Date
                    , CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,ItemName,ItemRev,R_Name
                    , CustomerName,ItemCode,Qty_to_Line, [Site]
                    , Qty_GenerateBoxNO, GeneratedPanelQty, Qty_ReplaceSN 
                    , IsMESadd, OrderTypeName ,LineName ,StatusDesc ,IsMESaddDesc,PlanStart,PlanFinish";
            list = ComMethod.GetComList<ShopOrderInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 分页获取 ORDER 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="oRDERCount">oRDER 总数。</param>
        /// <returns>ORDER 列表。</returns>
        public List<ShopOrderInfo> GetAllNoLine(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ShopOrderInfo> list = new List<ShopOrderInfo>();
            //表名或者视图
            string strTb = "vwOrderInfoNoLine a left join  SYS_Users u on u.UserName=a.ModifyBy ";
            //主键
            string strKey = "ProdOrderID";
            //查询栏位字串
            string strColumns = @"ProdOrderGroupID, ProdOrderID,OrderNO,OrderType,[Status],Priority,ItemId,BOMId
                      ,  RouterId,CustomerID,CustomerOrder
                      , CustomerOrderQty,Qty_to_Build,Qty_Released,Qty_Done,Qty_Scrapped,Release_date,Planned_Start_Time
                      , Planned_Completed_Date,Scheduled_Start_Date,Scheduled_Completed_Time,Actual_Start_Date,Actual_Completed_Date
                      , a.CreateBy,a.CreateDateTime,ISNULL(u.CName,'') as ModifyBy,a.ModifyDateTime,ItemName,ItemRev,R_Name
                      , CustomerName,ItemCode,Qty_to_Line, [Site]
                      , Qty_GenerateBoxNO, GeneratedPanelQty, Qty_ReplaceSN 
                      , IsMESadd, OrderTypeName ,StatusDesc ,IsMESaddDesc,PlanStart,PlanFinish,ItemSpec,CPN,InventoryQuantity";
            list = ComMethod.GetComList<ShopOrderInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public List<string> GetSN(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<string> list = new List<string>();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, " Prod_SerialNumber a ", " UID ",
                "Value", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    string SN = rdr.GetString(0);

                    list.Add(SN);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 ORDER 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="oRDERCount">oRDER 总数。</param>
        /// <returns>ORDER 列表。</returns>
        public List<ShopOrderInfo> GetAll_Old(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ShopOrderInfo> list = new List<ShopOrderInfo>();
            ShopOrderInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, " [Prod_Order] A INNER JOIN Basal_Item B ON A.ItemId = B.ItemID Left JOIN Basal_Bom C ON A.BOMId = C.BOMID Left JOIN Basal_Router D ON A.RouterId = D.RouterID Left JOIN Basal_Customer E ON A.CustomerID = E.CustomerID Left JOIN BOM F ON B.BOMID = F.BOMID Left JOIN Basal_Customer G ON B.RouterID = G.RouterID Left JOIN Basal_Customer H ON B.CustomerID = H.CustomerID", "ProdOrderID",
                "ProdOrderID,OrderNO,OrderType,A.[Status],Priority,A.ItemId,A.BOMId,CASE WHEN A.RouterId <> -1 THEN A.RouterId ELSE B.RouterId END,A.CustomerID,CustomerOrder,CustomerOrderQty,Qty_to_Build,Qty_Released,Qty_Done,Qty_Scrapped,Release_date,Planned_Start_Time,Planned_Completed_Date,Scheduled_Start_Date,Scheduled_Completed_Time,Actual_Start_Date,Actual_Completed_Date,A.CreateBy,A.CreateTime,A.ModifyBy,A.ModifyTime,ItemName,ItemRev,CASE WHEN A.BOMId <> -1 THEN C.BOMName ELSE F.BOMName END,CASE WHEN A.BOMId <> -1 THEN C.Revision ELSE CASE WHEN F.BOMId=-1 THEN '' ELSE F.Revision END END,CASE WHEN A.RouterId <> -1 THEN D.R_Name ELSE G.R_Name END,CASE WHEN A.CustomerID <> -1 THEN E.CustomerName ELSE H.CustomerName END", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ShopOrderInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetString(9), rdr.GetInt32(10),
                        rdr.GetInt32(11), rdr.GetInt32(12), rdr.GetInt32(13), rdr.GetInt32(14), rdr.GetDateTime(15),
                        rdr.GetDateTime(16), rdr.GetDateTime(17), rdr.GetDateTime(18), rdr.GetDateTime(19), rdr.GetDateTime(20),
                        rdr.GetDateTime(21), rdr.GetString(22), rdr.GetDateTime(23), rdr.GetString(24), rdr.GetDateTime(25));

                    entity.ItemName = rdr.GetString(26) + " (" + rdr.GetString(27) + ")";
                    entity.ItemVer = rdr.GetString(27);
                    entity.BOMName = rdr.GetString(29) == "" ? rdr.GetString(28) : rdr.GetString(28) + "(" + rdr.GetString(29) + ")";
                    entity.BOMVer = rdr.GetString(29);
                    entity.RouterName = rdr.GetString(30);
                    entity.CustomerName = rdr.GetString(31);
                    entity.ItemName2 = rdr.GetString(26);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 返工 工单资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="oRDERCount">oRDER 总数。</param>
        /// <returns>ORDER 列表。</returns>
        public List<ShopOrderInfo> GetReworkAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ShopOrderInfo> list = new List<ShopOrderInfo>();
            ShopOrderInfo entity = null;
            string itemvev = "";
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, @"[Prod_Order] A 
                    Inner JOIN Basal_Item B ON A.ItemId = B.ItemID and A.OrderType = 3
                    Left JOIN Basal_Bom C ON A.BOMId = C.BOMID 
                    Left JOIN Basal_Router D ON A.RouterId = D.R_ID 
                    Left JOIN Basal_Customer E ON A.CustomerID = E.CustomerID", "ProdOrderID",
                @"ProdOrderID,OrderNO,OrderType,A.[Status],Priority,A.ItemId,A.BOMId,
                CASE WHEN A.RouterId <> -1 THEN A.RouterId ELSE B.RouterId END,A.CustomerID,CustomerOrder,
                CustomerOrderQty,Qty_to_Build,Qty_Released,Qty_Done,Qty_Scrapped,Release_date,Planned_Start_Time,
                Planned_Completed_Date,Scheduled_Start_Date,Scheduled_Completed_Time,Actual_Start_Date,Actual_Completed_Date,
                A.CreateBy,A.CreateTime,A.ModifyBy,A.ModifyTime,ItemName,ItemRev,isnull(D.R_Name, ''),isnull(E.CustomerName,''),
                B.ItemCode,A.Qty_to_Line, a.[Site], a.Qty_GenerateBoxNO"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ShopOrderInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetString(9), rdr.GetInt32(10),
                        rdr.GetInt32(11), rdr.GetInt32(12), rdr.GetInt32(13), rdr.GetInt32(14), rdr.GetDateTime(15),
                        rdr.GetDateTime(16), rdr.GetDateTime(17), rdr.GetDateTime(18), rdr.GetDateTime(19), rdr.GetDateTime(20),
                        rdr.GetDateTime(21), rdr.GetString(22), rdr.GetDateTime(23), rdr.GetString(24), rdr.GetDateTime(25));
                    itemvev = rdr.IsDBNull(27) ? "" : rdr.GetString(27);
                    entity.ItemName = rdr.IsDBNull(26) ? "" : rdr.GetString(26) + (itemvev != null || itemvev.Length > 0 ? "" : " (" + itemvev + ")");
                    entity.ItemName2 = rdr.IsDBNull(26) ? "" : rdr.GetString(26);
                    entity.ItemVer = itemvev;
                    entity.RouterName = rdr.IsDBNull(28) ? "" : rdr.GetString(28);
                    entity.CustomerName = rdr.IsDBNull(29) ? "" : rdr.GetString(29);
                    entity.ItemCode = rdr.GetString(30);
                    entity.Qty_to_Line = rdr.GetInt32(31);
                    entity.Site = rdr.GetString(32);
                    entity.Qty_GenerateBoxNO = rdr.GetInt32(33);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 分页获取 ORDER 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="oRDERCount">oRDER 总数。</param>
        /// <returns>ORDER 列表。</returns>
        public List<ShopOrderInfo> GetAllStatusParse(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ShopOrderInfo> list = new List<ShopOrderInfo>();
            ShopOrderInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, " [PRODUCTION_ORDER] A with(nolock) INNER JOIN ITEM B ON A.ItemId = B.ItemID", "ProdOrderID",
                "ProdOrderID,OrderNO,A.ItemId,OrderType,A.[Status],Priority,Qty_to_Build,Qty_Released,Qty_Done,Qty_Scrapped,B.ItemName,A.CustomerOrder", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ShopOrderInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2));
                    entity.OrderType = rdr.GetInt32(3);
                    entity.Status = rdr.GetInt32(4);
                    entity.Qty_to_Build = rdr.GetInt32(6);
                    entity.ItemName = rdr.GetString(10);
                    entity.ItemName2 = ((SKT.LeanMES.Order.Model.EnumShopOrderStatus)Enum.Parse(typeof(SKT.LeanMES.Order.Model.EnumShopOrderStatus), rdr.GetInt32(4).ToString())).ToString();
                    entity.CustomerOrder = rdr.GetString(11);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 获取工单和物料，用于发料
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="oRDERCount">oRDER 总数。</param>
        /// <returns>ORDER 列表。</returns>
        public List<ShopOrderInfo> GetAllWoItem(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ShopOrderInfo> list = new List<ShopOrderInfo>();
            ShopOrderInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProductionOrder", "ProdOrderID",
                "OrderNO, CustomerOrder,Qty_to_Build ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ShopOrderInfo(-1, rdr.GetString(0), -1);
                    entity.ItemName = "";
                    entity.CustomerOrder = rdr.GetString(1);
                    entity.Qty_to_Build = rdr.GetInt32(2);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// add by weixia on 2018.3.28 工单释放拼板
        /// </summary>
        /// <param name="Qty"></param>
        /// <param name="WOID"></param>
        /// <param name="ItemID"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public SNInfo ReleasePanelSN(Int32 remainQty, Int32 snCount, Int32 releaseQty, Int32 WOID, Int32 ItemID, Int32 userId)
        {
            SNInfo sninfo = new SNInfo();
            List<string> list = new List<string>();

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@RemainQty",SqlDbType.Int),
                new SqlParameter("@SNCount",SqlDbType.Int),
                new SqlParameter("@ReleaseQty",SqlDbType.Int),
                new SqlParameter("@WoId",SqlDbType.Int),
                new SqlParameter("@ItemId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@RuleType", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemModel", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemCategory", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemSpecification", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemType", SqlDbType.Int)
            };
            parms[0].Value = remainQty;
            parms[1].Value = snCount;
            parms[2].Value = releaseQty;
            parms[3].Value = WOID;
            parms[4].Value = ItemID;
            parms[5].Value = userId;
            parms[6].Direction = ParameterDirection.Output;
            parms[7].Direction = ParameterDirection.Output;
            parms[8].Direction = ParameterDirection.Output;
            parms[9].Direction = ParameterDirection.Output;
            parms[10].Direction = ParameterDirection.Output;
            parms[11].Direction = ParameterDirection.Output;
            parms[12].Direction = ParameterDirection.Output;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspReleasePanelShopOrder", parms))
            {
                while (rdr.Read())
                {
                    list.Add(rdr.GetString(0));
                }
                rdr.Close();
            }
            sninfo.SNList = list;
            return sninfo;
        }


        /// <summary>
        /// 释放工单
        /// </summary>
        /// <param name="Qty"></param>
        /// <param name="WOID"></param>
        /// <param name="ItemID"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public SNInfo ReleaseSO(Int32 Qty, Int32 WOID, Int32 ItemID, Int32 userId)
        {
            SNInfo sninfo = new SNInfo();
            List<string> list = new List<string>();

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ReleaseQty",SqlDbType.Int),
                new SqlParameter("@WoId",SqlDbType.Int),
                new SqlParameter("@ItemId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@RuleType", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemModel", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemCategory", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemSpecification", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemType", SqlDbType.Int)
            };
            parms[0].Value = Qty;
            parms[1].Value = WOID;
            parms[2].Value = ItemID;
            parms[3].Value = userId;
            parms[4].Direction = ParameterDirection.Output;
            parms[5].Direction = ParameterDirection.Output;
            parms[6].Direction = ParameterDirection.Output;
            parms[7].Direction = ParameterDirection.Output;
            parms[8].Direction = ParameterDirection.Output;
            parms[9].Direction = ParameterDirection.Output;
            parms[10].Direction = ParameterDirection.Output;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspReleaseShopOrder", parms))
            {
                while (rdr.Read())
                {
                    list.Add(rdr.GetString(0));
                }
                rdr.Close();
            }

            //sninfo.SNRule = Convert.ToInt32(parms[4].Value);
            //sninfo.ItemCode = parms[5].Value.ToString();
            //sninfo.ItemName = parms[6].Value.ToString();
            //sninfo.ItemModel = parms[7].Value.ToString();
            //sninfo.ItemCategory = parms[8].Value.ToString();
            //sninfo.ItemSpecification = parms[9].Value.ToString();
            //sninfo.ItemType = ((EnumItemType)Enum.Parse(typeof(EnumItemType), parms[10].Value.ToString())).ToString(); 
            sninfo.SNList = list;
            return sninfo;
        }

        /// <summary>
        /// 释放批次条码
        /// </summary>
        /// <param name="Qty"></param>
        /// <param name="WOID"></param>
        /// <param name="ItemID"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public SNInfo ReleaseBatchSO(Int32 Qty, decimal BatchQty, Int32 WOID, Int32 ItemID, Int32 userId)
        {
            SNInfo sninfo = new SNInfo();
            List<string> list = new List<string>();

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ReleaseQty",SqlDbType.Int),
                new SqlParameter("@WoId",SqlDbType.Int),
                new SqlParameter("@ItemId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@RuleType", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemModel", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemCategory", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemSpecification", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemType", SqlDbType.Int),
                new SqlParameter("@BatchQty",SqlDbType.Decimal)
            };
            parms[0].Value = Qty;
            parms[1].Value = WOID;
            parms[2].Value = ItemID;
            parms[3].Value = userId;
            parms[4].Direction = ParameterDirection.Output;
            parms[5].Direction = ParameterDirection.Output;
            parms[6].Direction = ParameterDirection.Output;
            parms[7].Direction = ParameterDirection.Output;
            parms[8].Direction = ParameterDirection.Output;
            parms[9].Direction = ParameterDirection.Output;
            parms[10].Direction = ParameterDirection.Output;
            parms[11].Value = BatchQty;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspReleaseBatchShopOrder", parms))
            {
                while (rdr.Read())
                {
                    list.Add(rdr.GetString(0));
                }
                rdr.Close();
            }

            sninfo.SNList = list;
            return sninfo;
        }



        /// <summary>
        /// 释放批次条码
        /// </summary>
        /// <param name="Qty"></param>
        /// <param name="WOID"></param>
        /// <param name="ItemID"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public SNInfo ReleaseBatchSOAndPass(Int32 Qty, decimal BatchQty, Int32 WOID, Int32 ItemID, Int32 userId,int OpenId,int resId)
        {
            SNInfo sninfo = new SNInfo();
            List<string> list = new List<string>();

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ReleaseQty",SqlDbType.Int),
                new SqlParameter("@WoId",SqlDbType.Int),
                new SqlParameter("@ItemId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@OpenId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@RuleType", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemModel", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemCategory", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemSpecification", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemType", SqlDbType.Int),
                new SqlParameter("@BatchQty",SqlDbType.Decimal)
            };
            parms[0].Value = Qty;
            parms[1].Value = WOID;
            parms[2].Value = ItemID;
            parms[3].Value = userId;
            parms[4].Value = OpenId;
            parms[5].Value = resId;
            parms[6].Direction = ParameterDirection.Output;
            parms[7].Direction = ParameterDirection.Output;
            parms[8].Direction = ParameterDirection.Output;
            parms[9].Direction = ParameterDirection.Output;
            parms[10].Direction = ParameterDirection.Output;
            parms[11].Direction = ParameterDirection.Output;
            parms[12].Direction = ParameterDirection.Output;
            parms[13].Value = BatchQty;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspReleaseBatchShopOrderAndPass", parms))
            {
                while (rdr.Read())
                {
                    list.Add(rdr.GetString(0));
                }
                rdr.Close();
            }

            sninfo.SNList = list;
            return sninfo;
        }



        /// <summary>
        /// 
        /// </summary>
        /// <param name="Qty"></param>
        /// <param name="BatchQty">最小包装数量</param>
        /// <param name="WOID"></param>
        /// <param name="ItemID"></param>
        /// <param name="LotCode"></param>
        /// <param name="ClassId">班组</param>
        /// <param name="EquimentCode">设备</param>
        /// <param name="EquipmentMoudle">模具</param>
        /// <param name="Remark"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public SNInfo ReleaseBatchSOCPIn(Int32 Qty, decimal BatchQty, Int32 WOID, Int32 ItemID, string LotCode, int ClassId, string EquimentCode, string EquipmentMoudle, string ProdDate, string Remark, Int32 userId,string stationdtlJson=null)
        {
            SNInfo sninfo = new SNInfo();
            List<string> list = new List<string>();
            DataTable dt = new DataTable();
            dt.Columns.Add("process");
            dt.Columns.Add("resource");
            dt.Columns.Add("passTime");
            dt.Columns.Add("qty");
            dt.Columns.Add("employee");
            dt.Columns.Add("lineid");
            if (!string.IsNullOrEmpty(stationdtlJson))
            {
                JArray dtl = JsonConvert.DeserializeObject<JArray>(stationdtlJson);
                if(dtl!=null && dtl.Count >0)
                {
                    foreach(JObject jo in dtl)
                    {
                        DataRow ndr = dt.NewRow();
                        ndr.BeginEdit();
                        ndr["process"] = jo["process"];
                        ndr["resource"] = jo["resource"];
                        ndr["passTime"] = jo["passTime"];
                        ndr["qty"] = jo["qty"];
                        ndr["employee"] = "";
                        ndr["lineid"] = jo["lineid"];
                        ndr.EndEdit();
                        dt.Rows.Add(ndr);
                    }
                }
            }
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ReleaseQty",SqlDbType.Int){ Value = Qty},
                new SqlParameter("@WoId",SqlDbType.Int){ Value = WOID},
                new SqlParameter("@ItemId",SqlDbType.Int){ Value = ItemID},
                new SqlParameter("@UserId",SqlDbType.Int){ Value = userId},
                new SqlParameter("@Class", SqlDbType.Int){ Value = ClassId},
                new SqlParameter("@EquipmentCode", SqlDbType.NVarChar){ Value = EquimentCode},
                new SqlParameter("@EquipmentMoudle", SqlDbType.NVarChar){ Value = EquipmentMoudle},
                new SqlParameter("@ProdDate", SqlDbType.NVarChar){ Value = ProdDate},
                new SqlParameter("@LotCode", SqlDbType.NVarChar){ Value = LotCode},
                new SqlParameter("@Remark", SqlDbType.NVarChar){ Value = Remark},
                new SqlParameter("@BatchQty",SqlDbType.Decimal){ Value = BatchQty},
                new SqlParameter("@processitems",SqlDbType.Structured){ Value = dt}
            };

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspReleaseBatchShopOrderCPIn", parms))
            {
                while (rdr.Read())
                {
                    list.Add(rdr.GetString(0));
                }
                rdr.Close();
            }

            sninfo.SNList = list;
            return sninfo;
        }



        /// <summary>
        /// 根据已释放的产品数量，选择的工位，生成置换条码。
        /// </summary>
        /// <param name="Qty"></param>
        /// <param name="WOID"></param>
        /// <param name="ItemID"></param>
        /// <param name="StationID">工位ID</param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public List<string> ReleaseReplaceSN(Int32 Qty, Int32 WOID, Int32 ItemID, Int32 StationId, Int32 userId)
        {
            List<string> list = new List<string>();

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ReleaseQty",SqlDbType.Int),
                new SqlParameter("@WoId",SqlDbType.Int),
                new SqlParameter("@ItemId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int)
            };
            parms[0].Value = Qty;
            parms[1].Value = WOID;
            parms[2].Value = ItemID;
            parms[3].Value = StationId;
            parms[4].Value = userId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspReleaseSNByStation", parms))
            {
                while (rdr.Read())
                {
                    list.Add(rdr.GetString(0));
                }
                rdr.Close();
            }
            return list;
        }


        /// <summary>
        /// 根据工单释放数量 和 输入的包装箱数量  生成指定的包装箱
        /// 
        /// </summary>
        /// <param name="Qty">需要生成的数量</param>
        /// <param name="WOID"></param>
        /// <param name="ItemID"></param>
        /// <param name="userName"></param>
        /// <returns>包装箱号列表</returns>
        public List<string> GenerateBoxNO(Int32 Qty, Int32 WOID, Int32 ItemID, String userName)
        {
            List<string> list = new List<string>();

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ReleaseQty",SqlDbType.Int),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@ItemId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar, 20)
            };
            parms[0].Value = Qty;
            parms[1].Value = WOID;
            parms[2].Value = ItemID;
            parms[3].Value = userName;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGenerateBoxNO", parms))
            {
                while (rdr.Read())
                {
                    list.Add(rdr.GetString(0));
                }
                rdr.Close();
            }
            return list;
        }


        /// <summary>
        /// 生成指定的拼板
        /// 
        /// </summary>
        /// <param name="Qty">需要生成的数量</param>
        /// <param name="WOID"></param>
        /// <param name="ItemID"></param>
        /// <param name="userId"></param>
        /// <returns>拼板序列号列表</returns>
        public List<string> GeneratePanelSN(Int32 Qty, Int32 WOID, Int32 ItemID, Int32 userId)
        {
            List<string> list = new List<string>();

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ReleaseQty",SqlDbType.Int),
                new SqlParameter("@WoId",SqlDbType.Int),
                new SqlParameter("@ItemId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int)
            };
            parms[0].Value = Qty;
            parms[1].Value = WOID;
            parms[2].Value = ItemID;
            parms[3].Value = userId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspReleasePanelSN", parms))
            {
                while (rdr.Read())
                {
                    list.Add(rdr.GetString(0));
                }
                rdr.Close();
            }
            return list;
        }


        /// <summary>
        /// 获取该工单，剩余可生成的拼板数。
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public int GetResiduePanelQty(int prodOrderId)
        {
            int qty = 0;

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@Qty",SqlDbType.Int)
            };
            parms[0].Value = prodOrderId;
            parms[1].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetResiduePanelQty", parms);

            qty = Convert.ToInt32(parms[1].Value.ToString());
            return qty;
        }

        /// <summary>
        /// 获取工单条码
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ShopOrderInfo> GetShopOrderDetail(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            var columns = "ProdOrderID,OrderNO,UID,SerialNumber,CreateTime,IsLaserCarving,LaserCarvingStatus,OpeID,Station,BatchQty,PassResult";
            return ComMethod.GetComList<ShopOrderInfo>(ref this.recordCount, startRow, maxRows, "vwShopOrderDetail", "ProdOrderID", columns, sortExpression, searchSettings);

            //List<ShopOrderInfo> list = new List<ShopOrderInfo>();
            //ShopOrderInfo entity = null;

            //SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwShopOrderDetail", "ProdOrderID",
            //    "[ProdOrderId], OrderNO, [Uid], [SerialNumber], [CreateTime]", searchSettings, sortExpression);

            //using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            //{
            //    while (rdr.Read())
            //    {
            //        entity = new ShopOrderInfo();
            //        entity.ProdOrderID = rdr.GetInt32(0);
            //        entity.OrderNO = rdr.GetString(1);
            //        entity.UID = rdr.GetInt64(2);
            //        entity.SerialNumber = rdr.GetString(3);
            //        entity.CreateTime = rdr.GetDateTime(4);

            //        list.Add(entity);
            //    }
            //    rdr.Close();
            //}

            //recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            //return list;
        }

        /// <summary>
        /// 根据工单号获取物料清单名等基本信息
        /// </summary>
        /// <param name="formNo"></param>
        /// <returns></returns>
        public ShopOrderInfo GetItemInfoByFormNo(String formNo, Int32 flage)
        {
            ShopOrderInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FormNo", SqlDbType.NVarChar,100),
                new SqlParameter("@Flage", SqlDbType.Int)
            };

            parms[0].Value = formNo;
            parms[1].Value = flage;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetItemInfoByFormNo", parms))
            {
                while (rdr.Read())
                {
                    entity = new ShopOrderInfo();
                    entity.OrderNO = rdr.GetString(0);
                    entity.BOMName = rdr.GetString(1);
                    entity.ItemId = rdr.GetInt32(2);
                    entity.ItemCode = rdr.GetString(3);
                    entity.ItemName = rdr.GetString(4);
                    // entity.ItemSpec = rdr.GetString(5);
                    entity.BOMName = rdr.GetString(6);
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 根据工单，工位 获取此工单，此工位还可释放的置换条码数。
        /// </summary>
        /// <param name="prodorderId"></param>
        /// <param name="stationId"></param>
        /// <returns>已释放的置换条码数，可释放的置换条码数。</returns>
        public int[] GetCanReleaseQty(int prodorderId, int stationId)
        {
            int[] qty = new int[2] { 0, 0 };
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProdOrderId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@ReleasedQty", SqlDbType.Int),
                new SqlParameter("@CanReleaseQty", SqlDbType.Int)
            };

            parms[0].Value = prodorderId;
            parms[1].Value = stationId;
            parms[2].Direction = ParameterDirection.Output;
            parms[3].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetCanReleaseQty", parms);

            qty[0] = Convert.ToInt32(parms[2].Value);
            qty[1] = Convert.ToInt32(parms[3].Value);

            return qty;
        }


        /// <summary>
        /// add by  zhibin.Chen 2016-1-5
        /// 用于工单条码重打印。 根据所选择的UID字符串，检查这些UID对应的ItemId是否一致。如果一致，那么返回ItemId, ProdOrderId。
        /// </summary>
        /// <param name="UIDstr"></param>
        /// <returns>ItemId, ProdOrderId</returns>
        public Int32[] GetItemIdByUIDstr(string UIDstr)
        {
            Int32[] arr = new Int32[3];
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UIDstr", SqlDbType.VarChar, 1000),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ProdOrderId", SqlDbType.Int),
                new SqlParameter("@AcquisitionMode", SqlDbType.Int)
            };

            parms[0].Value = UIDstr;
            parms[1].Direction = ParameterDirection.Output;
            parms[2].Direction = ParameterDirection.Output;
            parms[3].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetItemIdByUIDstr", parms);

            arr[0] = Convert.ToInt32(parms[1].Value);
            arr[1] = Convert.ToInt32(parms[2].Value);
            arr[2] = Convert.ToInt32(parms[3].Value);

            return arr;
        }

        public ShopOrderInfo GetInfoBySerialNumber(string serialNumber)
        {
            ShopOrderInfo entity = new ShopOrderInfo();

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@serialNumber", SqlDbType.NVarChar,50)
            };

            parms[0].Value = serialNumber;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Order_GetInfoBySerialNumber", parms))
            {
                if (rdr.Read())
                {
                    entity.ProdOrderID = rdr.GetInt32(0);
                    entity.OrderNO = rdr.GetString(1);
                    entity.OrderType = rdr.GetInt32(2);
                    entity.Status = rdr.GetInt32(3);
                    entity.Priority = rdr.GetInt32(4);
                    entity.ItemId = rdr.GetInt32(5);
                    entity.BOMId = rdr.GetInt32(6);
                    entity.RouterId = rdr.GetInt32(7);
                    entity.CustomerID = rdr.GetInt32(8);
                    entity.CustomerOrder = rdr.GetString(9);
                    entity.Qty_Released = rdr.GetInt32(10);
                    entity.Qty_to_Build = rdr.GetInt32(11);
                    entity.Qty_Done = rdr.GetInt32(12);
                    entity.Qty_Scrapped = rdr.GetInt32(13);
                    entity.Release_date = rdr.GetDateTime(14);
                    entity.Planned_Start_Time = rdr.GetDateTime(15);
                    entity.Planned_Completed_Date = rdr.GetDateTime(16);
                    entity.Scheduled_Start_Date = rdr.GetDateTime(17);
                    entity.Scheduled_Completed_Time = rdr.GetDateTime(18);
                    entity.Actual_Start_Date = rdr.GetDateTime(19);
                    entity.CreateBy = rdr.GetString(21);
                    entity.CreateDateTime = rdr.GetDateTime(22);
                    entity.ModifyBy = rdr.GetString(23);
                    entity.ModifyDateTime = rdr.GetDateTime(24);
                    entity.ItemName = rdr.GetString(25);
                    entity.ItemVer = rdr.GetString(26);
                    entity.BOMName = rdr.GetString(27);
                    entity.BOMVer = rdr.GetString(28);
                    entity.RouterName = rdr.GetString(29);
                    entity.CustomerName = rdr.GetString(30);
                    entity.ItemCode = rdr.GetString(31);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 获取订单及数量信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<CustomerOrderInfo> GetCustomerOrder(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CustomerOrderInfo> list = new List<CustomerOrderInfo>();
            CustomerOrderInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetCustomerOrder", "ProdOrderID",
                "ProdOrderID,OrderNO,CustomerOrder,SourceBillNo,Qty,CustomerName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new CustomerOrderInfo();
                    entity.ProdOrderID = rdr.GetInt32(0);
                    entity.OrderNO = rdr.GetString(1);
                    entity.CustomerOrder = rdr.GetString(2);
                    entity.SourceBillNo = rdr.GetString(3);
                    entity.Qty = rdr.GetInt32(4);
                    entity.CustomerName = rdr.GetString(5); 
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 获取订单列表  added by zhi.li 20180926
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<CustomerOrderInfo> GetSourceBillNo(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CustomerOrderInfo> list = new List<CustomerOrderInfo>();
            CustomerOrderInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_CustomerOrder", "CustomerOrderID",
                "CustomerOrderID,CustomerOrder,CustomerName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new CustomerOrderInfo();
                    entity.CustomerOrderID = rdr.GetInt32(0);
                    entity.CustomerOrder = rdr.GetString(1);
                    entity.CustomerName = rdr.GetString(2);
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public DataTable GetMoldingOrderInfo(string OrderID, string MachineID, string LinePlanCode)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@OrderID",SqlDbType.Int),
                new SqlParameter("@MachineID",SqlDbType.Int),
                new SqlParameter("@LinePlanCode",SqlDbType.NVarChar,200)
            };

            parms[0].Value = OrderID;
            parms[1].Value = MachineID;
            parms[2].Value = LinePlanCode;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetMoldingOrderInfo", parms);
        }

        public DataTable GetOrderGoodRate(string LinePlanCode, string MoudlCode)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@LinePlanCode",SqlDbType.NVarChar,200),
                new SqlParameter("@MoudlCode",SqlDbType.NVarChar,200)
            };
            parms[0].Value = LinePlanCode;
            parms[1].Value = MoudlCode;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetOrderGoodRate", parms);
        }

        /// <summary>
        /// 分页获取 PackingAccessoriesConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="packingAccessoriesConfigCount">packingAccessoriesConfig 总数。</param>
        /// <returns>PackingAccessoriesConfig 列表。</returns>
        public List<ShopOrderInfo> GetInjectMoudlLinePlanAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ShopOrderInfo> list = new List<ShopOrderInfo>();
            //表名或者视图
            string strTb = "VWInjectMoudlLinePlan";
            //主键
            string strKey = "ProdOrderID";
            //查询栏位字串
            string strColumns = @"ProdOrderID,
                                  OrderNO,
                                  ItemCode,
                                  ItemName,
                                  ItemSpec,
                                  CPN,
                                  Planned_Start_Time,
                                  Qty_to_Build,
                                  Qty_Done,
                                  WaitQty,Version,BomVersion";

            return ComMethod.GetComList<ShopOrderInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        #region ERP回写(形态转换)

        /// <summary>
        /// 形态转换-ERP回写
        /// </summary>
        public List<string> SaveFormChangeCheck(string strJson)
        {
            var msg = string.Empty;
            string erpReturnNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.FormChangeCheck;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            List<string> list = new List<string>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var entity = JsonConvert.DeserializeAnonymousType(strJson, new
                    {
                        FormChangeNo = "",
                        cBarCode = "",
                        GRNs = "",
                        ModifyBy = "",
                    });
                     
                    
                    var dp = new DynamicParameters();
                    dp.Add("@FormChangeNo", entity.FormChangeNo);
                    dp.Add("@cBarCode", entity.cBarCode);
                    dp.Add("@GRNs", entity.GRNs);
                    dp.Add("@ModifyBy", entity.ModifyBy);
                    reader = conn.ExecuteReader("uspSaveFormChange", dp, tran, null, CommandType.StoredProcedure);
                    dtWrite.Load(reader);
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                    if (dtWrite != null && dtWrite.Rows.Count > 0)
                    {
                        foreach(DataRow dr in dtWrite.Rows)
                        {
                            list.Add(dr["GRNString"].ToString());
                        }
                    }

                    //是否需要回写
                    isWriteBack = WriteBackERP.IsWriteBack(em);
                    if (isWriteBack)
                    {
                        if (dtWrite == null || dtWrite.Rows.Count <= 0)
                        {
                            msg = "未获取到需要回写ERP数据";
                            throw new Exception(msg);
                        }
                         
                        DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间
                         
                        ERPU9ReturnInfo info = WriteBackERP.SendPostU9(conn, em, dtWrite, entity.FormChangeNo, entity.ModifyBy, dtEnterTime, dtAfterExecProcTime);

                        //logList.Add(new WriteBackLogInfo
                        //{
                        //    WriteBackCode = em.ToString(),
                        //    ERPMsg = info.Msg,
                        //    ERPResult = info.Result ? 1 : 0,
                        //    ERPNo = info.ERPNo,
                        //    MESBillNo = entity.FormChangeNo,
                        //    WriteBackData = info.SendInfo,
                        //    ReceiveData = info.ReceiveData,
                        //    EnterTime = dtEnterTime,
                        //    AfterExecProcTime = dtAfterExecProcTime,
                        //    AfterExecERPTime = info.dtAfterExecERPTime,
                        //    CreateDateTime = DateTime.Now
                        //});

                        if (!info.Result)
                        {
                            throw new Exception(info.Msg);
                        }
                    }

                    tran.Commit();
                }
                catch (Exception ex)
                {
                    try
                    {
                        tran.Rollback();
                        throw new Exception("事务处理失败，已回滚。", ex);
                    }
                    catch (Exception rollbackEx)
                    {

                        throw ex;
                    }
                }
                finally
                {
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                    foreach (var log in logList)
                    {
                        WriteBackERP.AddWriteBackLog(conn, log);
                    }
                    conn.Close();
                }
            }
            return list;
        }

        #endregion

        #region 获取形态转换单主表

        /// <summary>
        /// 分页获取 形态转换单列表。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        public List<FormChangeInfo> GetAllFormChangeList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<FormChangeInfo> list = new List<FormChangeInfo>();
            //表名或者视图
            string strTb = "vw_Prod_FormChangeList";
            //主键
            string strKey = "FormChangeId";
            //查询栏位字串
            string strColumns = @" CreateBy, CreateDateTime,   DocumentType,  FactoryCode, FormChangeDate,   FormChangeId,  FormChangeNo,  ModifyBy,  ModifyDateTime,  Organization,  Project, Status, WarehouseCode, WarehouseName,StatusName";
            list = ComMethod.GetComList<FormChangeInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        #endregion

        #region [关联工单]
        public void AddProdOrderGroup(Int32 prodorderid1,Int32 prodorderid2,Int32 prodorderid3,Int32 prodorderid4,string idStr, string createby)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProdOrdId1", SqlDbType.Int),
                new SqlParameter("@ProdOrdId2", SqlDbType.Int),
                new SqlParameter("@ProdOrdId3", SqlDbType.Int),
                new SqlParameter("@ProdOrdId4", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@idStr", SqlDbType.VarChar, 500)
            };

            parms[0].Value = prodorderid1;
            parms[1].Value = prodorderid2;
            parms[2].Value = prodorderid3;
            parms[3].Value = prodorderid4;
            parms[4].Value = createby;
            parms[5].Value = idStr;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspShopOrderAddGroup", parms);
        }
        #endregion
        #region [解除工单]
        public void ReleaseProdOrderGroup(Int32 groupid,string createby)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProdOrdGroupId", SqlDbType.Int),               
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
               
            };

            parms[0].Value = groupid;
            parms[1].Value = createby;           

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspShopOrderReleaseGroup", parms);
        }
        #endregion
    }

}