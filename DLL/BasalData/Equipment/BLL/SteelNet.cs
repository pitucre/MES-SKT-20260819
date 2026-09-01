using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Equipment.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using SKT.LeanMES.CommonHelper.BLL;
namespace SKT.LeanMES.Equipment.BLL
{
    /// <summary>
    /// 钢网/刮刀
    /// </summary>
    public class SteelNet
    {
        public List<SteelNetInfo> GetOrderList()
        {
            List<SteelNetInfo> list = new List<SteelNetInfo>();
            string sqlstr = @"SELECT ProdOrderID AS OrderId ,OrderNO AS OrderNo FROM dbo.vwOrderInfoNoLine";
            list = ComMethod.GetListBySql<SteelNetInfo>(sqlstr, null);
            return list;
        }
        public List<SteelNetInfo> GetLineList()
        {
            List<SteelNetInfo> list = new List<SteelNetInfo>();
            string sqlstr = @"SELECT LineId,LineName FROM dbo.Basal_Line";
            list = ComMethod.GetListBySql<SteelNetInfo>(sqlstr, null);
            return list;
        }
        public List<SteelNetInfo> GetSideList()
        {
            List<SteelNetInfo> list = new List<SteelNetInfo>();
            string sqlstr = @"SELECT LoadingListTableId AS SideId,TableName AS SideName FROM Prod_LoadingListTable";
            list = ComMethod.GetListBySql<SteelNetInfo>(sqlstr, null);
            return list;
        }
        public List<SteelNetInfo> GetOrderSteelList(int orderId,int LineId,string Layout)
        {
            List<SteelNetInfo> list = new List<SteelNetInfo>();
            string sqlstr = @"SELECT t2.EquipmentTypeName as SteelTypeName,EquipmentCode as SteelCode, t1.EquipmentID as EQID FROM Prod_SteelNetUpLine t 
                JOIN dbo.Basal_Equipment t1 ON t.EquipmentID=t1.EquipmentId
                JOIN Basal_EquipmentType t2 ON t2.EquipmentTypeId=t1.EquipmentTypeId WHERE t.Status=1 AND ProdOrderID=" + orderId + "";
            if (LineId > -1) {
                sqlstr += " AND t.LineId=" + LineId + "";
            }
            if (!string.IsNullOrEmpty(Layout)) {
                sqlstr += " AND t.Layout='" + Layout + "'";
            }
            list = ComMethod.GetListBySql<SteelNetInfo>(sqlstr, null);
            return list;
        }
        public List<SteelNetInfo> GetOrderSteelTempList(string EquipmentCode)
        {
            List<SteelNetInfo> list = new List<SteelNetInfo>();
            string sqlstr = @"SELECT  t2.EquipmentTypeName AS SteelTypeName ,
                        EquipmentCode AS SteelCode ,
                        t1.EquipmentId AS EQID
                FROM    dbo.Basal_Equipment t1
                        JOIN Basal_EquipmentType t2 ON t2.EquipmentTypeId = t1.EquipmentTypeId
                WHERE   t1.EquipmentCode = '" + EquipmentCode + "'";
            list = ComMethod.GetListBySql<SteelNetInfo>(sqlstr, null);
            return list;
        }
        public List<SteelNetInfo> GetOrderDownLineList(string EquipmentCode)
        {
            List<SteelNetInfo> list = new List<SteelNetInfo>();
            string sqlstr = @"SELECT t2.EquipmentTypeName as SteelTypeName,EquipmentCode as SteelCode, t1.EquipmentID as EQID FROM Prod_SteelNetUpLine t 
                JOIN dbo.Basal_Equipment t1 ON t.EquipmentID=t1.EquipmentId
                JOIN Basal_EquipmentType t2 ON t2.EquipmentTypeId=t1.EquipmentTypeId WHERE t.Status=1 AND t1.EquipmentCode='" + EquipmentCode + "'";
            list = ComMethod.GetListBySql<SteelNetInfo>(sqlstr, null);
            return list;
        }
        /// <summary>
        /// 上线
        /// </summary>
        /// <param name="EQId"></param>
        /// <param name="OrderId"></param>
        /// <param name="username"></param>
        public void SteelNetLineUP(string eqCode, int OrderId, int LineId, string Layout, string username)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar),
                new SqlParameter("@ProdOrderID", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@Layout", SqlDbType.VarChar),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20) };
                parms[0].Value = eqCode;
                parms[1].Value = OrderId;
                parms[2].Value = LineId;
                parms[3].Value = Layout;
                parms[4].Value = username;
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSteelNetLineUP", parms);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 上线
        /// </summary>
        /// <param name="EQId"></param>
        /// <param name="OrderId"></param>
        /// <param name="username"></param>
        public void SteelNetLineUPNew(string eqCode, int OrderId, int LineId, string Layout, string username,int OperType)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar),
                new SqlParameter("@ProdOrderID", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@Layout", SqlDbType.VarChar),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@OperType", SqlDbType.Int)};
                parms[0].Value = eqCode;
                parms[1].Value = OrderId;
                parms[2].Value = LineId;
                parms[3].Value = Layout;
                parms[4].Value = username;
                parms[5].Value = OperType;
                ////SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSteelNetLineUPNew", parms);
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSteelNetLineUPNew2", parms);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 下线
        /// </summary>
        /// <param name="EQId"></param>
        /// <param name="OrderId"></param>
        /// <param name="username"></param>
        public void SteelNetLineDown(string eqCode, string username)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20) };
                parms[0].Value = eqCode;
                parms[1].Value = username;
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSteelNetLineDown", parms);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 下线
        /// </summary>
        /// <param name="EQId"></param>
        /// <param name="OrderId"></param>
        /// <param name="username"></param>
        public void SteelNetLineDownNew(string eqCode, string username, int OperType)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@OperType", SqlDbType.Int)};
                parms[0].Value = eqCode;
                parms[1].Value = username;
                parms[2].Value = OperType;
                /////SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSteelNetLineDownNew", parms);
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSteelNetLineDownNew2", parms);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public void SteelWash(string eqCode, string Tension, string CheckResult, string UserName, int type)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar),
                new SqlParameter("@Tension", SqlDbType.VarChar),//张力
                new SqlParameter("@CheckResult", SqlDbType.VarChar),//外观
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@Type", SqlDbType.Int)};
                parms[0].Value = eqCode;
                parms[1].Value = Tension;
                parms[2].Value = CheckResult;
                parms[3].Value = UserName;
                parms[4].Value = type;
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentClear", parms);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public void SteelWashNew(string eqCode, string Tension, string CheckResult, string UserName, int type)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar),
                new SqlParameter("@Tension", SqlDbType.VarChar),//张力
                new SqlParameter("@CheckResult", SqlDbType.VarChar),//外观
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@Type", SqlDbType.Int)};
                parms[0].Value = eqCode;
                parms[1].Value = Tension;
                parms[2].Value = CheckResult;
                parms[3].Value = UserName;
                parms[4].Value = type;
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentClearNew", parms);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<SteelNetInfo> Search(string eqCode, string orderId)
        {
            string where = "";
            if (!string.IsNullOrEmpty(eqCode))
            {
                where += " AND EquipmentCode='" + eqCode + "' ";
            }
            if (!string.IsNullOrEmpty(orderId))
            {
                where += " AND OrderNO='" + orderId + "' ";
            }
            List<SteelNetInfo> list = new List<SteelNetInfo>();
            string sqlstr = @"SELECT EquipmentCode,t.Layout as SideName,t2.OrderNO as OrderNo FROM dbo.Prod_SteelNetUpLine t
                            JOIN dbo.Basal_Equipment t1 ON t1.EquipmentId=t.EquipmentID
                            JOIN dbo.Prod_Order t2 ON t2.ProdOrderID=t.ProdOrderID
                            WHERE t.Status =1" + where;
            list = ComMethod.GetListBySql<SteelNetInfo>(sqlstr, null);
            return list;
        }
    }
}
