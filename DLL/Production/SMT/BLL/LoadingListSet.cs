using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.SMT.Model;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.SMT.BLL
{
    public class LoadingListSet
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 获取排产工单信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<LoadingListSetOrderInfo> GetPlanOrderList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadingListSetOrderInfo> list = new List<LoadingListSetOrderInfo>();
            //表名或者视图
            string strTb = "vwGetLinePlanOrderList";
            //主键
            string strKey = "LinePlanId";
            //查询栏位字串
            string strColumns = @"[LinePlanId], [PlanOrderNo], [ItemId], [ItemCode], [ItemName],[LineId], [LineName],[State],[StatusDesc], [TableName], [TableDesc]";

            return ComMethod.GetComList<LoadingListSetOrderInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }
        /// <summary>
        /// 获取机台列表信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<LoadingListSetEquipmentInfo> GetEquipmentList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadingListSetEquipmentInfo> list = new List<LoadingListSetEquipmentInfo>();
            //表名或者视图
            string strTb = "vwGetEquipmentList";
            //主键
            string strKey = "EquipmentId";
            //查询栏位字串
            string strColumns = @"[EquipmentId], [EquipmentCode], [EquipmentModel], [EquipmentName], [SequenceNo],[LineId], [IsLoading],[IsOffLine], [IsScanPos]";

            return ComMethod.GetComList<LoadingListSetEquipmentInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 根据排程工单过滤对应的设备 
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<LoadingListSetEquipmentInfo> GetEquipmentListByOrder(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadingListSetEquipmentInfo> list = new List<LoadingListSetEquipmentInfo>();
            //表名或者视图
            string strTb = "vwGetEquipMentByOrder";
            //主键
            string strKey = "EquipmentId";
            //查询栏位字串
            string strColumns = @"[EquipmentId], [EquipmentCode], [EquipmentModel], [EquipmentName], [SequenceNo],[LineId], [IsLoading],[IsOffLine], [IsScanPos]";

            return ComMethod.GetComList<LoadingListSetEquipmentInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 通过排产工单号，机台获取上料清单信息
        /// </summary>
        /// <param name="lineId"></param>
        /// <param name="sequenceNo"></param>
        /// <param name="itemId"></param>
        /// <returns></returns>
        public string[] GetLoadingListId(string orderNo, int lineId, int sequenceNo, int itemId)
        {
            string[] loadingArr = new string[3];

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@SequenceNo", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@LoadingListId", SqlDbType.Int),
                new SqlParameter("@LoadingListName", SqlDbType.NVarChar,4000),
                new SqlParameter("@LoadingListSolt", SqlDbType.NVarChar,4000),
                new SqlParameter("@orderNo", SqlDbType.NVarChar)
            };
            parms[0].Value = lineId;
            parms[1].Value = sequenceNo;
            parms[2].Value = itemId;
            parms[3].Value = -1;
            parms[3].Direction = ParameterDirection.InputOutput;
            parms[4].Value = "";
            parms[4].Direction = ParameterDirection.InputOutput;
            parms[5].Value = "";
            parms[5].Direction = ParameterDirection.InputOutput;
            parms[6].Value = orderNo;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetLoadingListInfo", parms);

            loadingArr[0] = Convert.ToString(parms[3].Value);
            loadingArr[1] = Convert.ToString(parms[4].Value);
            loadingArr[2] = Convert.ToString(parms[5].Value);
            return loadingArr;
        }
        /// <summary>
        /// 通过排产工单号\机台  获取插槽
        /// </summary>
        /// <param name="lineId"></param>
        /// <param name="sequenceNo"></param>
        /// <param name="itemId"></param>
        /// <returns></returns>
        public string GetLoadingListIds(string OrderNo, int EquipmentId)
        {
            string loadingArr = "";

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNo", SqlDbType.VarChar,50),
                new SqlParameter("@EquipmentId", SqlDbType.Int),
                new SqlParameter("@LoadingListSolt", SqlDbType.NVarChar,4000),
            };
            parms[0].Value = OrderNo;
            parms[1].Value = EquipmentId;
            parms[2].Direction = ParameterDirection.InputOutput;
            parms[2].Value = "";
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetLoadingListInfos", parms);

            loadingArr = Convert.ToString(parms[2].Value);
            return loadingArr;
        }
        /// <summary>
        /// 获取feeder和GRN关系
        /// </summary>
        /// <returns></returns>
        public string GetFeedAndMaterialList(string feeder)
        {
            string grn = "";
            string sqlstr = "SELECT MaterialIdCode FROM dbo.Prod_FeedAndMaterial where FeedCode = '"+feeder+"'";
            using (SqlDataReader red = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sqlstr))
            {
                if (red.Read())
                {
                    grn = red.GetString(0);
                }
                red.Close();
            }
            return grn;
        }

        /// <summary>
        /// 获取工单信息
        /// </summary>
        public string GetOrderList(string OrderNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNo", SqlDbType.VarChar,50)
            };
            parms[0].Value = OrderNo;
            string q = "";
            if (OrderNo != "")
            {
                var sqlStr = "SELECT * FROM Prod_Order(NOLOCK) WHERE OrderNO LIKE '%'+@OrderNo+'%' AND Status = 1";
                q = ComMethod.GetListBySql(sqlStr, parms);
            }
            else
            {
                var sqlStr = "SELECT * FROM Prod_Order(NOLOCK) WHERE OrderNO LIKE '%'+@OrderNo+'%' AND Status = 1";
                q = ComMethod.GetListBySql(sqlStr, null);
            }

            return q;
        }
        /// <summary>
        /// 获取上料核对排产工单信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<LoadingListSetOrderInfo> GetIPQCSMTOrderList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadingListSetOrderInfo> list = new List<LoadingListSetOrderInfo>();
            //表名或者视图
            string strTb = "vwGetSMTLinePlanOrderList";
            //主键
            string strKey = "LinePlanId";
            //查询栏位字串
            string strColumns = @"[LinePlanId], [PlanOrderNo], [ItemId], [ItemCode], [ItemName],[LineId], [LineName],[State],[StatusDesc], [TableName], [TableDesc]";

            return ComMethod.GetComList<LoadingListSetOrderInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 获取当前扫描的插槽号
        /// </summary>
        /// <param name="orderNo"></param>
        /// <returns></returns>
        public string GetScanNum(string orderNo,int machineId,string area)
        {
            string result = "-1";
            //string sqlstr = @"SELECT  TOP 1 isnull(b.Area,'') +'$'+a.Position FROM Prod_MachineTableSlotMuMap AS a 
                               // LEFT JOIN dbo.Prod_LoadingListDetail AS b ON b.Position = a.Position AND a.LoadingListID = b.LoadingListID WHERE PlanBillNo = '" + orderNo + "' AND Equipment ="+ machineId + " AND MaterialUnitID<>-1 ORDER BY ID DESC";

            string sqlstr = @"SELECT  CONVERT(NVARCHAR(50), COUNT(*)) AS CurNum
                        FROM Prod_MachineTableSlotMuMap AS a
                        WHERE PlanBillNo = '" + orderNo + "' AND Equipment = "+machineId+ "  AND a.Area='"+ area + "'; ";
            using (SqlDataReader red = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sqlstr))
            {
                while (red.Read())
                {
                    result = red.GetString(0);
                }
                red.Close();
            }
            return result;
        }

        /// <summary>
        /// 获取上料区信息
        /// </summary>
        /// <param name="orderNo"></param>
        /// <param name="equipmentId"></param>
        /// <returns></returns>
        public List<string> GetAreaList(string orderNo,int equipmentId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNo", SqlDbType.VarChar,50),
                new SqlParameter("@EquipmentId", SqlDbType.Int),
            };
            parms[0].Value = orderNo;
            parms[1].Value = equipmentId;

            List<string> list = new List<string>();
            using (SqlDataReader red = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetAreaList", parms))
            {
                while (red.Read())
                {
                    list.Add(red.GetString(0));
                }
                red.Close();
            }
            return list;
        }

        /// <summary>
        /// 获取区位信息
        /// </summary>
        /// <param name="linePlanOrder"></param>
        /// <returns></returns>
        public List<string> GetAreaListNew(string linePlanOrder)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StockListName", SqlDbType.VarChar,50)
            };
            parms[0].Value = linePlanOrder;

            List<string> list = new List<string>();
            var sqlStr = "SELECT DISTINCT Area FROM Prod_StockList WHERE StockListName LIKE @StockListName+'%'";
            using (SqlDataReader red = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sqlStr, parms))
            {
                while (red.Read())
                {
                    list.Add(red.GetString(0));
                }
                red.Close();
            }
            return list;
        }

        public string GetSMTMaterial(int areainfo, string stationinfo, string linePO)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Area", SqlDbType.Int),
                new SqlParameter("@Positon", SqlDbType.VarChar,50),
                new SqlParameter("@StockListName", SqlDbType.VarChar,50)
            };
            parms[0].Value = areainfo;
            parms[1].Value = stationinfo;
            parms[2].Value = linePO;

            return ComMethod.GetList("uspGetSMTMaterial", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
