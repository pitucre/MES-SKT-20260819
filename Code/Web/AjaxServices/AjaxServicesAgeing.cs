using AjaxPro;
using SKT.LeanMES.ProductionCollection;
using SKT.LeanMES.ProductionCollection.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxServicesAgeing
    {
        #region 老化开始采集
        [AjaxMethod]
        public void Unbind(string SN)
        {
            try
            {
                new Ageing().Unbind(SN);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void RemoveBySNList(string SN)
        {
            try
            {
                SN = SN.Replace("[", "").Replace("]", "").Replace("\"", "");
                new Ageing().RemoveBySNList(SN);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public string GetAgeingRackBySN(string SN)
        {
            try
            {
                return new Ageing().GetAgeingRackBySN(SN);
            }
            catch (Exception ex)
            {
                 WebHelper.HandleException(ex);
                throw;
            }
        }
        [AjaxMethod]
        public AgeingInfo GetAgeingType(string sn)
        {
            try
            {
                return new Ageing().GetAgeingType(sn);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        /// <summary>
        /// 扫描sn
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="routeId"></param>
        /// <param name="orderId"></param>
        /// <param name="ageingRack"></param>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void StartAgeing(string sn, string stationId, string resourceId, string routeId, string orderId, string ageingRack, string userId)
        {
            try
            {
                new Ageing().StartAgeing(sn, stationId, resourceId, routeId, orderId, ageingRack, userId);
            }
            catch (Exception ex)
            {

                throw;
            }

        }
        [AjaxMethod]
        public void RackStart(string rackNo,string userId)
        {
            try
            {
                new Ageing().RackStart(rackNo,userId);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        /// <summary>
        /// 判断周转箱是否存在
        /// </summary>
        /// <param name="No"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<AgeingInfo> IsTurnover(string No)
        {
            try
            {
              return new Ageing().IsTurnover(No);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        /// <summary>
        /// 老化架最大装载数量判断
        /// </summary>
        /// <param name="No"></param>
        [AjaxMethod]

        public void RckCheckMax(string No)
        {
            try
            {
                 new Ageing().RckCheckMax(No);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
              
            }
        }
        /// <summary>
        /// 判断老化架对应产品 和SN对应产品是否一致
        /// </summary>
        [AjaxMethod]

        public void CheckTurnoverData(string No, string SN)
        {
            try
            {
                new Ageing().CheckTurnoverData(No, SN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
        
            }
        }
        
        #endregion


        #region 老化结束、不良采集
        [AjaxMethod]
        public int IsNCCode(string code)
        {
            try
            {
               return new Ageing().IsNCCode(code);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        //不良采集
        [AjaxMethod]
        public void NCCodecollect(string sn, string stationId, string resourceId, string routeId, string orderId, string ncCode, string userId)
        {
            try
            {
                new Ageing().NCCodecollect(sn, stationId, resourceId, routeId, orderId, ncCode, userId);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        //老化结束
        [AjaxMethod]
        public void AgeingEnd(string sn, string stationId, string resourceId, string routeId, string orderId, string ageingRack, string userId,string force)
        {
            try
            {
                new Ageing().AgeingEnd(sn, stationId, resourceId, routeId, orderId, ageingRack, userId, force);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public string GetGetAgeingEndBySN(string SN)
        {
            try
            {
               return new Ageing().GetGetAgeingEndBySN(SN);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        /// <summary>
        /// 根据模版ID获取工序ID
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="opeId"></param>
        /// <param name="resouceId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetorderRefreshBySN(string SN)
        {
            DataTable dt = new DataTable();
            string grnstr = string.Empty;
            try
            {
                dt = new Ageing().GetorderRefreshBySNBLL(SN);
                if (dt.Rows.Count > 0)
                {
                    grnstr = ConvertJson.ToJson(dt);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
            return grnstr;
        }

        /// <summary>
        /// 根据模版ID获取工序ID
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="opeId"></param>
        /// <param name="resouceId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string getStationByUid(string UIid)
        {
            DataTable dt = new DataTable();
            string grnstr = string.Empty;
            try
            {
                dt = new Ageing().getStationByUidBLL(UIid);
                if (dt.Rows.Count > 0)
                {
                    grnstr = ConvertJson.ToJson(dt);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
            return grnstr;
        }

        /// <summary>
        /// 获取退料单明细信息
        /// </summary>
        /// <param name="json"></param>
        [AjaxMethod]
        public string getPercentAgeaging(string ScanSN, int ProdOrderid, string stationId, string resourceId)
        {
            DataTable dt = new DataTable();
            string grnstr = string.Empty;
            try
            {
                string userBy = AccountController.GetCurrentUser().UserName;
                dt = new Ageing().getPercentAgeagingBLL(ScanSN, ProdOrderid, stationId, resourceId);
                if (dt.Rows.Count > 0)
                {
                    grnstr = ConvertJson.ToJson(dt);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
            return grnstr;
        }
        #endregion
    }
}