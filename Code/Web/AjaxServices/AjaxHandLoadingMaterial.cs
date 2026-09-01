using AjaxPro;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxHandLoadingMaterial
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
        /// <summary>
        /// 查询可进行手插上料的工单
        /// </summary>
        [AjaxMethod]
        public List<HandLoadingMaterialInfo> GetTOPOrderList(string value)
        {
            try
            {
                string where = "";
                if (value != "")
                {
                    where = string.Format(" and OrderNO like '%{0}%'", value);
                }
                return new HandLoadingMaterial().GetTOPOrderList(where);
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

        [AjaxMethod]
        public List<HandLoadingMaterialInfo> GetTOPLineList(string value)
        {
            try
            {
                string where = "";
                if (value != "")
                {
                    where = string.Format(" and LineName like '%{0}%'", value);
                }
                return new HandLoadingMaterial().GetTOPLineList(where);
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
        /// 查询工序
        /// </summary>
        [AjaxMethod]
        public List<HandLoadingMaterialInfo> GetTOPStationList(string value)
        {
            try
            {
                string where = "WHERE 1=1";
                if (value != "WHERE 1=1")
                {
                    where += string.Format(" AND Station like '%{0}%'", value);
                }
                return new HandLoadingMaterial().GetTOPStationList(where);
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
                HandLoadingMaterialInfo model = new HandLoadingMaterial().Loading(pid,orderno, stationid, grn, username);
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
                HandLoadingMaterialInfo model = new HandLoadingMaterial().Continued(pid,orderno, stationid, oldgrn, newgrn, username);
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
                result = new HandLoadingMaterial().Opeation(OrderNo, LineId, Type, UserName);
                return result;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}