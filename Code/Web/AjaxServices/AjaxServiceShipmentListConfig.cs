using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.PackPrint.Model;
using SKT.LeanMES.PackPrint.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxServiceShipmentListConfig
    {
        /// <summary>
        /// 更新或者增加不良现象信息
        /// </summary>
        /// <param name="entity">不良现象实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public void EditShipmentListConfig(string listStr)
        {
            try
            {
                ShipmentListConfig bll = new ShipmentListConfig();
                bll.Edit(listStr);
            }
            catch (Exception ex)
            {
                //都需要用到三个参数
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取容器信息包装信息列表
        /// </summary>
        /// <param name="ContainerId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ShipmentListConfigInfo> GetShipmentListConfigs(int ItemId)
        {
            try
            {
                ShipmentListConfig bll = new ShipmentListConfig();
                List<ShipmentListConfigInfo> Listentity = bll.GetShipmentListConfigInfos(ItemId);
                return Listentity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
    }
}