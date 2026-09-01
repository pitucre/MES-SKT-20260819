using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.PackPrint.Model;
using SKT.LeanMES.PackPrint.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxServiceListingConfig
    {
        /// <summary>
        /// 获取容器信息包装信息列表
        /// </summary>
        /// <param name="ContainerId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ListingConfigInfo> GetListingConfigs(int ItemId,int listType)
        {
            try
            {
                ListingConfig bll = new ListingConfig();
                List<ListingConfigInfo> Listentity = bll.GetListingConfigInfos(ItemId,listType);
                return Listentity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 获取容器信息包装信息列表
        /// </summary>
        /// <param name="ContainerId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<PackingDetailInfo> GetPackingDetail(int ItemId)
        {
            try
            {
                PackingDetail bll = new PackingDetail();
                List<PackingDetailInfo> Listentity = bll.GetPackingDetail(ItemId);
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