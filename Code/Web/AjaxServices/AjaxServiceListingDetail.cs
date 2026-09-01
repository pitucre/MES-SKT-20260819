using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.PackPrint.Model;
using SKT.LeanMES.PackPrint.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxServiceListingDetail
    {
        /// <summary>
        /// 更新或者增加不良现象信息
        /// </summary>
        /// <param name="entity">不良现象实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public void EditListingConfig(string listStr)
        {
            try
            {
                ListingDetail bll = new ListingDetail();
                bll.Edit(listStr);
            }
            catch (Exception ex)
            {
                //都需要用到三个参数
                WebHelper.HandleException(ex);
            }
        }
    }
}