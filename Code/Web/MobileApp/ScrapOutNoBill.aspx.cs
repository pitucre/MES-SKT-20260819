/*-------------------------------------------------
// Copyright(C)2018 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:WarehouseReturnToSupplier.cs
// 文件功能描述：仓库退料到供应商
// 
// 创建标识：Sperkey.Zhong 2018/06/08
// 
// 
//--------------------------------------------------*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class ScrapOutNoBill : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxScrapNoBillOut));
        }
    }
}