using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.SMT.BLL
{
    /// <summary>
    /// 手插上料
    /// </summary>
    public class HandLoadingMaterial
    {
        /// <summary>
        /// 获取工单
        /// </summary>
        /// <returns></returns>
        public List<HandLoadingMaterialInfo> GetOrderList()
        {
            //update by weixia on 2018.4.16 
            string str = @"SELECT  ProdOrderID as OrderId,OrderNO FROM dbo.Prod_Order WHERE Status in (1,3) ";
            List<HandLoadingMaterialInfo> list = new List<HandLoadingMaterialInfo>();
            list = ComMethod.GetListBySql<HandLoadingMaterialInfo>(str, null);
            return list;
        }

        /// <summary>
        /// 获取工单
        /// </summary>
        /// <returns></returns>
        public List<HandLoadingMaterialInfo> GetTOPOrderList(string where)
        {
            //update by weixia on 2018.4.16 
            string str = @"SELECT TOP 20 ProdOrderID as OrderId,OrderNO FROM dbo.Prod_Order WHERE Status in (1,3) " + where;
            List<HandLoadingMaterialInfo> list = new List<HandLoadingMaterialInfo>();
            list = ComMethod.GetListBySql<HandLoadingMaterialInfo>(str, null);
            return list;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public List<HandLoadingMaterialInfo> GetLineList()
        {
            string str = @"SELECT LineId,LineName FROM dbo.Basal_Line where lineId>0  ";
            List<HandLoadingMaterialInfo> list = new List<HandLoadingMaterialInfo>();
            list = ComMethod.GetListBySql<HandLoadingMaterialInfo>(str, null);
            return list;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public List<HandLoadingMaterialInfo> GetTOPLineList(string where)
        {
            string str = @"SELECT TOP 20 LineId,LineName FROM dbo.Basal_Line where lineId>0  " + where;
            List<HandLoadingMaterialInfo> list = new List<HandLoadingMaterialInfo>();
            list = ComMethod.GetListBySql<HandLoadingMaterialInfo>(str, null);
            return list;
        }
        /// <summary>
        /// 获取站位
        /// </summary>
        /// <returns></returns>
        public List<HandLoadingMaterialInfo> GetStationList()
        {
            string str = @"SELECT StationId,Station FROM dbo.Basal_Station ";
            List<HandLoadingMaterialInfo> list = new List<HandLoadingMaterialInfo>();
            list = ComMethod.GetListBySql<HandLoadingMaterialInfo>(str, null);
            return list;
        }
        /// <summary>
        /// 获取站位
        /// </summary>
        /// <returns></returns>
        public List<HandLoadingMaterialInfo> GetTOPStationList(string where)
        {
            string str = @"SELECT TOP 20 StationId,Station FROM dbo.Basal_Station " + where;
            List<HandLoadingMaterialInfo> list = new List<HandLoadingMaterialInfo>();
            list = ComMethod.GetListBySql<HandLoadingMaterialInfo>(str, null);
            return list;
        }
        /// <summary>
        /// 根据工单获取手插上料信息
        /// </summary>
        /// <returns></returns>
        public List<HandLoadingMaterialInfo> GetLoadingInfo(string orderNo)
        {
            string str = @"SELECT  t3.Station,ItemCode,ItemName,Qty AS DeQty,SUM(t2.BalanceQty) AS AlreadyQty FROM Prod_MaterialStationMuMap t
                        JOIN dbo.Basal_Item t1 ON t1.ItemID=t.ItemID
                        JOIN dbo.Prod_MaterialUnit t2 ON t2.MaterialUnitId=t.MaterialUnitID
						JOIN dbo.Basal_Station t3 ON t3.StationId=t.DetailID
						JOIN dbo.Prod_Order t4 ON t4.ProdOrderID=t.ProdOrderId
						WHERE t4.OrderNO=@orderNo
						GROUP BY t3.Station,ItemCode,ItemName,Qty";
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@orderNo",SqlDbType.VarChar)
            };
            parms[0].Value = orderNo;
            List<HandLoadingMaterialInfo> list = new List<HandLoadingMaterialInfo>();
            list = ComMethod.GetListBySql<HandLoadingMaterialInfo>(str, null);
            return list;
        }
        /// <summary>
        /// 上料
        /// </summary>
        /// <param name="orderno"></param>
        /// <param name="stationid"></param>
        /// <param name="grn"></param>
        /// <param name="username"></param>
        public HandLoadingMaterialInfo Loading(int pid,string orderno, int stationid, string grn, string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@PId",SqlDbType.Int),
                 new SqlParameter("@OrderNo",SqlDbType.VarChar),
                 new SqlParameter("@StationId", SqlDbType.Int),
                 new SqlParameter("@GRN", SqlDbType.VarChar),
                 new SqlParameter("@UserName",SqlDbType.VarChar)
            };
            parms[0].Value = pid;
            parms[1].Value = orderno;
            parms[2].Value = stationid;
            parms[3].Value = grn;
            parms[4].Value = username;
            HandLoadingMaterialInfo model = new HandLoadingMaterialInfo();
            model = ComMethod.Get<HandLoadingMaterialInfo>("uspHandLodingMaterialCheck", parms);
            return model;
        }
        /// <summary>
        /// 续料
        /// </summary>
        /// <param name="orderno"></param>
        /// <param name="stationid"></param>
        /// <param name="oldgrn"></param>
        /// <param name="newgrn"></param>
        /// <param name="username"></param>
        public HandLoadingMaterialInfo Continued(int pid, string orderno, string stationid, string oldgrn, string newgrn, string username)
        { 
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@PId",SqlDbType.Int),
                 new SqlParameter("@orderno",SqlDbType.VarChar),
                 new SqlParameter("@stationid", SqlDbType.Int),
                 new SqlParameter("@oldGRN", SqlDbType.VarChar),
                 new SqlParameter("@newGRN", SqlDbType.VarChar),
                 new SqlParameter("@username",SqlDbType.VarChar)
            };
            parms[0].Value = pid;
            parms[1].Value = orderno;
            parms[2].Value = stationid;
            parms[3].Value = oldgrn;
            parms[4].Value = newgrn;
            parms[5].Value = username;
            HandLoadingMaterialInfo model = new HandLoadingMaterialInfo();
            model = ComMethod.Get<HandLoadingMaterialInfo>("uspHandContinuedMaterialCheck", parms);
            return model;
        }
        /// <summary>
        /// 开拉、停拉、卸料操作
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <param name="LineId"></param>
        /// <param name="Type"></param>
        /// <param name="UserName"></param>
        public int Opeation(string OrderNo, int LineId, int Type, string UserName)
        {
            int result=0;
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@orderNo",SqlDbType.VarChar),
                 new SqlParameter("@LineId", SqlDbType.Int),
                 new SqlParameter("@Type", SqlDbType.Int),
                 new SqlParameter("@UserName", SqlDbType.VarChar)
            };
            parms[0].Value = OrderNo;
            parms[1].Value = LineId;
            parms[2].Value = Type;
            parms[3].Value = UserName;
            DataTable dt = new DataTable();
            if (Type == 0)
            {
                result = (int)SQLHelper.ExecuteScalarStoredProcedure(SQLHelper.MESConnString, "uspHnadLoadingStatusChange", parms);
            }
            else
            {
                SQLHelper.ExecuteScalarStoredProcedure(SQLHelper.MESConnString, "uspHnadLoadingStatusChange", parms);
            }
            return result;
        }
    }
}
