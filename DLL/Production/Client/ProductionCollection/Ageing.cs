using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ProductionCollection.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.ProductionCollection
{
    public class Ageing
    {
        #region 老化开始
        /// <summary>
        /// 获取SN的老化信息
        /// </summary>
        /// <param name="SN"></param>
        /// <returns></returns>
        public string GetAgeingRackBySN(string SN)
        {
            string AgeingRack = "";
            string strsql = @"SELECT AgeingRack FROM  Prod_AgeingInfo WHERE SN='" + SN + "' and Status=0";
            var list = ComMethod.GetListBySql<AgeingInfo>(strsql, null);
            if (list.Count > 0)
                AgeingRack = list[0].AgeingRack;
            return AgeingRack;
        }
        /// <summary>
        /// 扫描sn，记录老化信息，如果老化方式是以产品老化，直接开始老化
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="routeId"></param>
        /// <param name="orderId"></param>
        /// <param name="ageingRack"></param>
        /// <param name="userId"></param>
        public void StartAgeing(string sn, string stationId, string resourceId, string routeId, string orderId, string ageingRack, string userId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SN",SqlDbType.VarChar,50),
                new SqlParameter("@StationId",SqlDbType.VarChar,50),
                new SqlParameter("@ResourceId",SqlDbType.VarChar,50),
                new SqlParameter("@RouteId",SqlDbType.VarChar,50),
                new SqlParameter("@OrderId",SqlDbType.VarChar,50),
                new SqlParameter("@AgeingRack",SqlDbType.VarChar,50),
                new SqlParameter("@UserId",SqlDbType.VarChar,50)
            };
            parms[0].Value = sn;
            parms[1].Value = stationId;
            parms[2].Value = resourceId;
            parms[3].Value = routeId;
            parms[4].Value = orderId;
            parms[5].Value = ageingRack;
            parms[6].Value = userId;
            ComMethod.Edit("uspPoAgeingScan", parms);
        }
        /// <summary>
        /// 查询老化方式
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public AgeingInfo GetAgeingType(string sn)
        {
            AgeingInfo model = new AgeingInfo();
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@sn",SqlDbType.VarChar,512)
            };
            parms[0].Value = sn;
            model = ComMethod.Get<AgeingInfo>("uspAgeingProdCheck", parms);
            return model;
        }
        /// <summary>
        /// 老化架老化开始
        /// </summary>
        /// <param name="rackNo"></param>
        public void RackStart(string rackNo, string userId)
        {
            //string strsql = @"UPDATE dbo.Prod_AgeingInfo SET Status=1,StartTime=GETDATE(),CreateBy='" + userId + "',CreateTime=GETDATE() WHERE AgeingRack='" + rackNo + "' and Status=0";
            //ComMethod.EditBySql(strsql, null);
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@RackNo",SqlDbType.VarChar,50),
                new SqlParameter("@UserId",SqlDbType.VarChar,50)
            };
            parms[0].Value = rackNo;
            parms[1].Value = userId;
            ComMethod.Edit("uspPoAgeingRackStart", parms);
        }
        /// <summary>
        /// 判断老化架,并查出老化架已关联的GRN
        /// </summary>
        /// <param name="No"></param>
        /// <returns></returns>
        public List<AgeingInfo> IsTurnover(string No)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@No",SqlDbType.VarChar,50)
            };
            parms[0].Value = No;
            return ComMethod.GetList<AgeingInfo>("uspAgeingRckCheck", parms);
        }
        /// <summary>
        /// 老化架最大装载数量
        /// </summary>
        public void RckCheckMax(string No)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@No",SqlDbType.VarChar,50)
            };
            parms[0].Value = No;
             ComMethod.GetList<AgeingInfo>("uspAgeingRckCheckMax", parms);
        }
        /// <summary>
        /// 判断老化架对应产品 和SN对应产品是否一致
        /// </summary>
        public void CheckTurnoverData(string No,string SN)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SN",SqlDbType.VarChar,100),
                new SqlParameter("@No",SqlDbType.VarChar,100)
            };
            parms[0].Value = SN;
            parms[1].Value = No;
            ComMethod.GetList<AgeingInfo>("uspAgeingRckCheckTurnoverData", parms);
        }

        /// <summary>
        /// 获取SN 产品老化方式
        /// </summary>
        /// <param name="SN"></param>
        /// <returns></returns>
        public int GetAgeingTypeBySN(string SN)
        {
             int AgeingType = 0;
            string strsql = @"SELECT t2.AgeingType FROM dbo.Prod_Unit t1
INNER JOIN Basal_Ageing t2 ON  t1.ItemID=t2.ItemId
WHERE t1.SN='"+SN+"'";
            var list = ComMethod.GetListBySql<AgeingInfo>(strsql, null);
            if (list.Count > 0)
                AgeingType = list[0].AgeingType;
            return AgeingType;
        }
        public void Unbind(string SN)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SN",SqlDbType.VarChar,50)
            };
            parms[0].Value = SN;
            ComMethod.Edit("uspAgeingRackUnBindBySN", parms);
        }
        public void RemoveBySNList(string SN)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SNList",SqlDbType.VarChar,50)
            };
            parms[0].Value = SN;
            ComMethod.Edit("uspAgeingRemoveBySN", parms);
        }
        #endregion

        #region 老化结束
        /// <summary>
        /// 判断输入的是NCCODE ：1,SN： 2,AGEINGRACK：3
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public int IsNCCode(string code)
        {
            int stesult = 0;
            string sqlstr = @"SELECT 1 Id FROM dbo.Basal_NCCode WHERE NCCode=@code
                            UNION 
                            SELECT 2 Id FROM dbo.Basal_TurnoverGroup WHERE TurnoverGroupName=@code
                            UNION
                            SELECT 3 Id FROM dbo.Prod_Unit WHERE (SN=@code OR CustomerSN=@code)";
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@code",SqlDbType.VarChar,50)
            };
            parms[0].Value = code;
            List<AgeingInfo> list = ComMethod.GetListBySql<AgeingInfo>(sqlstr, parms);
            if (list.Count > 0)
            {
                stesult = list[0].Id;
            }
            return stesult;
        }
        //老化结束采集
        //force  1:不强制 2：强制
        public void AgeingEnd(string sn, string stationId, string resourceId, string routeId, string orderId, string ageingRack, string userId, string force)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@sn",SqlDbType.VarChar,50),
                new SqlParameter("@stationId",SqlDbType.VarChar,50),
                new SqlParameter("@ResourceId",SqlDbType.VarChar,50),
                new SqlParameter("@routeId",SqlDbType.VarChar,50),
                new SqlParameter("@orderId",SqlDbType.VarChar,50),
                new SqlParameter("@ageingRack",SqlDbType.VarChar,50),
                new SqlParameter("@userId",SqlDbType.VarChar,50),
                new SqlParameter("@force",SqlDbType.VarChar,50)
            };
            parms[0].Value = sn;
            parms[1].Value = stationId;
            parms[2].Value = resourceId;
            parms[3].Value = routeId;
            parms[4].Value = orderId;
            parms[5].Value = ageingRack;
            parms[6].Value = userId;
            parms[7].Value = force;
            ComMethod.Edit("uspPoAgeingEndScan", parms);
        }
        //不良采集
        public void NCCodecollect(string sn, string stationId, string resourceId, string routeId, string orderId, string ncCode, string userId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SN",SqlDbType.VarChar,50),
                new SqlParameter("@StationId",SqlDbType.VarChar,50),
                new SqlParameter("@ResourceId",SqlDbType.VarChar,50),
                new SqlParameter("@RouteId",SqlDbType.VarChar,50),
                new SqlParameter("@OrderId",SqlDbType.VarChar,50),
                new SqlParameter("@NCCode",SqlDbType.VarChar,50),
                new SqlParameter("@UserId",SqlDbType.VarChar,50)
            };
            parms[0].Value = sn;
            parms[1].Value = stationId;
            parms[2].Value = resourceId;
            parms[3].Value = routeId;
            parms[4].Value = orderId;
            parms[5].Value = ncCode;
            parms[6].Value = userId;
            ComMethod.Edit("uspPoAgeingNCCodeScan", parms);
        }
        //通过SN或者老化架返回SN，用户查询上下站
        public string GetGetAgeingEndBySN(string SN)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SN",SqlDbType.VarChar,50),
            };
            parms[0].Value = SN;
            var result = ComMethod.Get("uspGetAgeingEndBySN", parms);
            return result;
        }
        public DataTable getPercentAgeagingBLL(string ScanSN, int ProdOrderid, string stationId, string resourceId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SN",SqlDbType.VarChar,100),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
            };

            parms[0].Value = ScanSN;
            parms[1].Value = ProdOrderid;
            parms[2].Value = stationId;
            parms[3].Value = resourceId;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspgetPercentAgeaging", parms);
        }

        public DataTable GetorderRefreshBySNBLL(string SN)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SN",SqlDbType.VarChar,100),

            };

            parms[0].Value = SN;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetorderRefreshBySN", parms);
        }

        public DataTable getStationByUidBLL(string UIid)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UIid",SqlDbType.VarChar,100),

            };

            parms[0].Value = UIid;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetStationByUid", parms);
        }
        #endregion
    }
}
