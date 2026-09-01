/*-------------------------------------------------
// Copyright(C)2018 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:ProdDetailInfo.cs
// 文件功能描述：扫描SN，获取生产详细信息
// 
// 创建标识：Sperkey.Zhong 2018/06/06
// 
// 
//--------------------------------------------------*/
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class ProdDetailInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxManufacture));
        }
    }
}