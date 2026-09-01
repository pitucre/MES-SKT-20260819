 

using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SMT.BLL
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
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
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

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "PRODUCTION_ORDER_Edit", parms);

            return (Int32)parms[0].Value;
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

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "PRODUCTION_ORDER_Delete", parms);
        }

        /// <summary>
        /// 根据 ORDERId 获取实体信息。
        /// </summary>
        /// <param name="oRDERId">ORDERId。</param>
        /// <returns>ORDER 实体对象。</returns>
        public ShopOrderInfo GetInfo(Int32 soId)
        {
            ShopOrderInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ShopOrderId", SqlDbType.Int)
            };

            parms[0].Value = soId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "PRODUCTION_ORDER_GetInfo", parms))
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
            ShopOrderInfo entity = null; 
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProOrderList",
             "ProdOrderID", " ProdOrderID, OrderNO, ItemId,OrderType,Status,CustomerOrder ", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ShopOrderInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2),rdr.GetInt32(3),rdr.GetInt32(4),rdr.GetString(5));
                    list.Add(entity);
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
        public List<ShopOrderInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ShopOrderInfo> list = new List<ShopOrderInfo>();
            ShopOrderInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, " [PRODUCTION_ORDER] A with(nolock) INNER JOIN ITEM B ON A.ItemId = B.ItemID Left JOIN ROUTER D ON A.RouterId = D.R_ID Left JOIN CUSTOMER E ON A.CustomerID = E.CustomerID Left JOIN ROUTER G ON B.RouterID = G.R_ID Left JOIN CUSTOMER H ON B.CustomerID = H.CustomerID", "ProdOrderID",
                "ProdOrderID,OrderNO,OrderType,A.[Status],Priority,A.ItemId,A.BOMId,CASE WHEN A.RouterId <> -1 THEN A.RouterId ELSE B.RouterId END,A.CustomerID,CustomerOrder,CustomerOrderQty,Qty_to_Build,Qty_Released,Qty_Done,Qty_Scrapped,Release_date,Planned_Start_Time,Planned_Completed_Date,Scheduled_Start_Date,Scheduled_Completed_Time,Actual_Start_Date,Actual_Completed_Date,A.CreateBy,A.CreateTime,A.ModifyBy,A.ModifyTime,ItemName,ItemRev,isnull(D.R_Name, ''),isnull(E.CustomerName,'')", searchSettings, sortExpression);

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
                    entity.RouterName = rdr.GetString(28);
                    entity.CustomerName = rdr.GetString(29);
                    entity.ItemName2 = rdr.GetString(26);

                    list.Add(entity);
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

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, " [PRODUCTION_ORDER] A INNER JOIN ITEM B ON A.ItemId = B.ItemID Left JOIN BOM C ON A.BOMId = C.BOMID Left JOIN ROUTER D ON A.RouterId = D.R_ID Left JOIN CUSTOMER E ON A.CustomerID = E.CustomerID Left JOIN BOM F ON B.BOMID = F.BOMID Left JOIN ROUTER G ON B.RouterID = G.R_ID Left JOIN CUSTOMER H ON B.CustomerID = H.CustomerID", "ProdOrderID",
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
                    //entity.ItemName2 = ((SKT.MES.Production.Model.EnumShopOrderStatus)Enum.Parse(typeof(SKT.MES.Production.Model.EnumShopOrderStatus), rdr.GetInt32(4).ToString())).ToString();
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
    }
}