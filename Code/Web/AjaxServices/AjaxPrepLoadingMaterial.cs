using AjaxPro;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// 前置加工上料
    /// </summary>
    public class AjaxPrepLoadingMaterial
    {
        /// <summary>
        /// 查询可进行手插上料的工单
        /// </summary>
        [AjaxMethod]
        public List<HandLoadingMaterialInfo> GetOrderList()
        {
            try
            {
                return new HandLoadingMaterial().GetOrderList();
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public List<HandLoadingMaterialInfo> GetLineList()
        {
            try
            {
                return new HandLoadingMaterial().GetLineList();
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 查询工序
        /// </summary>
        [AjaxMethod]
        public List<HandLoadingMaterialInfo> GetStationList()
        {
            try
            {
                return new HandLoadingMaterial().GetStationList();
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 获取上料信息
        /// </summary>
        /// <param name="orderNo"></param>
        /// <returns></returns>
        public List<HandLoadingMaterialInfo> GetLoadingInfo(string orderNo)
        {
            try
            {
                return new HandLoadingMaterial().GetLoadingInfo(orderNo);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 上料
        /// </summary>
        /// <param name="orderno"></param>
        /// <param name="stationid"></param>
        /// <param name="grn"></param>
        /// <param name="username"></param>
        [AjaxMethod]
        public HandLoadingMaterialInfo Loading(int pid, string orderno, int stationid, string grn, string username)
        {
            try
            {
                HandLoadingMaterialInfo model = new PrepLoadingMaterial().Loading(pid, orderno, stationid, grn, username);
                return model;
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 续料
        /// </summary>
        /// <param name="orderno"></param>
        /// <param name="stationid"></param>
        /// <param name="oldgrn"></param>
        /// <param name="newgrn"></param>
        /// <param name="username"></param>
        [AjaxMethod]
        public HandLoadingMaterialInfo Continued(int pid, string orderno, string stationid, string oldgrn, string newgrn, string username)
        {
            try
            {
                HandLoadingMaterialInfo model = new PrepLoadingMaterial().Continued(pid, orderno, stationid, oldgrn, newgrn, username);
                return model;
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 开拉、停拉、卸料操作
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <param name="LineId"></param>
        /// <param name="Type"></param>
        /// <param name="UserName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int Opeation(string OrderNo, int LineId, int Type, string UserName)
        {
            try
            {
                int result = 0;
                result = new PrepLoadingMaterial().Opeation(OrderNo, LineId, Type, UserName);
                return result;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}