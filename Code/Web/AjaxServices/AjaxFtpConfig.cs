using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.ESOP.BLL;
using SKT.LeanMES.ESOP.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxFtpConfig
    {
        /// <summary>
        /// 邮箱服务器信息配置
        /// </summary>
        [AjaxMethod]
        public void FtpServerEdit(FtpServerConfigInfo entity)
        {
            try
            {
                (new FtpServerConfig()).Edit(entity);
            }
            catch(Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

    }
}