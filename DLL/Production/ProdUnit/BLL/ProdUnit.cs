using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ProdUnit.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Utility;
using SKT.Common.Model;
using System.Data.SqlClient;
using System.Data;

namespace SKT.LeanMES.ProdUnit.BLL
{
    public class ProdUnit
    {
        /// <summary>
        /// 获取产品序列号信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public ProdUnitInfo GetProdUnitInfo(string sn)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@SerialNumber",SqlDbType.VarChar,50)
            };

            parms[0].Value = sn;

            ProdUnitInfo entity = null;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Unit_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ProdUnitInfo();
                    entity.UnitId = rdr.GetInt64(0);
                    entity.StationId = rdr.GetInt32(1);
                    entity.IsPass = rdr.GetBoolean(2);
                    entity.StatusId = rdr.GetInt32(3);
                    entity.RouterId = rdr.GetInt32(4);
                    entity.PanelId = rdr.GetInt64(5);
                    entity.LineId = rdr.GetInt32(6);
                    entity.ProdOrderId = rdr.GetInt32(7);
                    entity.RmaId = rdr.GetInt32(8);
                    entity.BomId = rdr.GetInt32(9);
                    entity.ResourceId = rdr.GetInt32(10);
                    entity.ItemId = rdr.GetInt32(11);
                    entity.UserId = rdr.GetInt32(12);
                    entity.CreateTime = rdr.GetDateTime(13);
                    entity.LastUpdate = rdr.GetDateTime(14);
                }
                rdr.Close();
            }

            return entity;
        }

        public ProdUnitInfo GetUnitInfoByResId(int resId,string sn)
        {
            ProdUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@SN",SqlDbType.VarChar,50)
            };

            parms[0].Value = resId;
            parms[1].Value = sn;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetUnitInfoByResId", parms))
            {
                if (rdr.Read())
                {
                    entity = new ProdUnitInfo();
                    entity.ItemId = rdr.GetInt32(0);
                    entity.RouterId = rdr.GetInt32(1);
                    entity.UnitId = rdr.GetInt64(2);
                    entity.ProdOrderId = rdr.GetInt32(3);
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 查询详细信息
        /// </summary>
        /// <param name="searchId"></param>
        /// <param name="flage"></param>
        /// <returns></returns>
        public ProdUnitInfo GetProcessFormBySearch(String searchId, Int32 flage)
        {
            ProdUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SearchId", SqlDbType.NVarChar,512),
                    new SqlParameter("@Flage", SqlDbType.Int)
                };
            parms[0].Value = searchId;
            parms[1].Value = flage;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetProcessFormBySearch", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProdUnitInfo();
                    entity.OrderNo = rdr.GetString(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.ItemSpec = rdr.GetString(2);
                    entity.Qty = rdr.GetInt32(3);
                    entity.Units = rdr.GetString(4);
                    entity.RouterName = rdr.GetString(5);
                    entity.RouterId = rdr.GetInt32(6);
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 查询工单下所有的序列号信息
        /// </summary>
        /// <returns></returns>
        public List<ProdUnitInfo> GetTurnNoInfoBySearch(String SearchString, Int32 flage, String saveScanSN, Int32 stationId, DateTime startDate, DateTime endDate)
        {
            List<ProdUnitInfo> list = new List<ProdUnitInfo>();
            ProdUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@SearchStr", SqlDbType.NVarChar, 512),
                new SqlParameter("@Flage", SqlDbType.Int),
                new SqlParameter("@FirstSN", SqlDbType.NVarChar,512),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@StartDate", SqlDbType.DateTime),
                new SqlParameter("@EndDate",SqlDbType.DateTime)
            };
            parms[0].Value = SearchString;
            parms[1].Value = flage;
            parms[2].Value = saveScanSN;
            parms[3].Value = stationId;
            parms[4].Value = startDate;
            parms[5].Value = endDate;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetSerialNumberInfoBySearch", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProdUnitInfo();
                    entity.UnitId = rdr.GetInt64(0);
                    entity.SerialNumber = rdr.GetString(1);
                    entity.Station = rdr.IsDBNull(2) ? "" : rdr.GetString(2);
                    entity.CreateTime = rdr.GetDateTime(3);
                    entity.LastUpdate = rdr.GetDateTime(4);
                    entity.OrderNo = rdr.GetString(5);
                    entity.ItemCode = rdr.GetString(6);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 查询路由名称获取相关工位信息
        /// </summary>
        /// <returns></returns>
        public List<ProdUnitInfo> GetProcessStationByRouterName(String routerName)
        {
            List<ProdUnitInfo> list = new List<ProdUnitInfo>();
            ProdUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                   new   SqlParameter("@RouterName",SqlDbType.NVarChar,200)
            };
            parms[0].Value = routerName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspProcessStationByRouterName", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProdUnitInfo();
                    entity.RouterId = rdr.GetInt32(0);
                    entity.StationId = rdr.GetInt32(1);
                    entity.Station = rdr.GetString(2);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 保存产品变更
        /// </summary>
        public void SaveProductionChange(Int32 routerId, Int32 stationId, int userId, String userName, String serialNumbers, int isUnAss, int chkIsUnCustomerSN, int chkIsUnAgeing, string remark, int orderId = -1, int itemId = -1)
        {
            SqlParameter[] parms = new SqlParameter[] {
                   new SqlParameter("@OrderId", SqlDbType.Int),
                   new SqlParameter("@ItemId", SqlDbType.Int),
                   new SqlParameter("@RouterId", SqlDbType.Int),
                   new SqlParameter("@StationId", SqlDbType.Int),
                   new SqlParameter("@UserId", SqlDbType.Int),
                   new SqlParameter("@UserName", SqlDbType.NVarChar, 20),
                   new SqlParameter("@SerialNumbers", SqlDbType.NVarChar,-1),
                   new SqlParameter("@IsUnAss", SqlDbType.Int),
                   new SqlParameter("@IsUnCustomerSN", SqlDbType.Int),

                   new SqlParameter("@IsUnAgeing", SqlDbType.Int),
                  new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
            };
            parms[0].Value = orderId;
            parms[1].Value = itemId;
            parms[2].Value = routerId;
            parms[3].Value = stationId;
            parms[4].Value = userId;
            parms[5].Value = userName;
            parms[6].Value = serialNumbers;
            parms[7].Value = isUnAss;
            parms[8].Value = chkIsUnCustomerSN;

            parms[9].Value = chkIsUnAgeing;
            parms[10].Value = remark;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveProductionChange", parms);
        }

        /// <summary>
        /// 根据物料条码获取生产详细信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public DataTable GetProdDetailInfo(string sn)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SN",SqlDbType.VarChar)
            };
            parms[0].Value = sn;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetProdDetailInfo", parms);
        }

        /// <summary>
        /// 强制变更
        /// </summary>
        /// <param name="SNList"></param>
        /// <param name="stationId"></param>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        public void SaveForceChange(string SNList, int stationId, int userId, string userName, int isUnAss, int isUnCustomerSN)
        {
            SqlParameter[] parms = new SqlParameter[] {
                    new SqlParameter("@SNList", SqlDbType.NVarChar),
                   new SqlParameter("@StationId", SqlDbType.Int),
                   new SqlParameter("@UserId", SqlDbType.Int),
                   new SqlParameter("@UserName", SqlDbType.NVarChar,20),
                   new SqlParameter("@IsUnAss", SqlDbType.Int),
                   new SqlParameter("@IsUnCustomerSN", SqlDbType.Int),
            };
            parms[0].Value = SNList;
            parms[1].Value = stationId;
            parms[2].Value = userId;
            parms[3].Value = userName;
            parms[4].Value = isUnAss;
            parms[5].Value = isUnCustomerSN;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspForceChange", parms);
        }
    }
}
