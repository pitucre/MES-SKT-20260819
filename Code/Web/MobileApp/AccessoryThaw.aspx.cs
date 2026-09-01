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
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class AccessoryThaw : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccessory));

            //2018-6-6设置先进先出权限
            int userId = AccountController.GetCurrentUser().UserId;
            this.hdFIFO.Value = Common.Account.BLL.Users.CheckUserIsWarrantted(userId, 30480600) ? "1" : "-1"; //用户FIFO权限  1：有权限 -1：没有权限
        }
    }
}