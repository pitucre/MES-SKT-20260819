using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.SerialNumber.Model;
using SKT.LeanMES.SerialNumber.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxOfflineSNConfig
    {
        /// <summary>
        /// 编辑离线条码规则信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void OfflineSNConfigEdit(OfflineSNConfigInfo entity)
        {
            try
            {
                new OfflineSNConfig().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

    }
}