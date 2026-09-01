/*-------------------------------------------------
// Copyright(C)2018 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:AccessoryThaw.cs
// 文件功能描述：用于辅料解冻（从PC版 生产管理-辅料管理-辅料列表 解冻功能移植而来）
// 
// 创建标识：Sperkey.Zhong 2018/06/05
// 
// 
//--------------------------------------------------*/
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class PDAAgeingBadCollection : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClientConfig));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxLogin));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPickListClient));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClientController));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxClient));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxServicesAgeing));
        }
    }
}