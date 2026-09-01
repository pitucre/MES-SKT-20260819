using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web;

namespace SKT.LeanMES.Web.ProductionShift
{
    public partial class ShiftEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServicesShift));
            Int32 TypeID = Convert.ToInt32(Request.QueryString["ID"]);//从主页面中传递过来的Shift ID

            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MemberId";
            this.Master.DefaultSortExpression = "ShiftId";
            this.Master.DefaultSortDirection = SortDirection.Ascending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ShiftId", TypeID.ToString());

            this.Master.SearchSettings = searchSettings;

            if (this.IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.ProductionShift.BLL.Shift_Member bll = new SKT.LeanMES.ProductionShift.BLL.Shift_Member();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                    }
                }
            }

            if (TypeID != -1) //编辑存在的Shift ID时屏蔽不能修改的内容
            {
                SKT.LeanMES.ProductionShift.BLL.ProductionShift bllType = new SKT.LeanMES.ProductionShift.BLL.ProductionShift();
                SKT.LeanMES.ProductionShift.Model.ProductionShiftInfo model = null;
                model = bllType.GetInfo(TypeID);
                if (model != null)
                {
                    this.TypeData = model;
                    this.txtShiftName.Enabled = false;
                    //add by weixia on 2015/3/2 控制班别名称不可编辑
                    this.txtShiftName.ReadOnly = true;
                    this.txtShiftRemark.Enabled = false;
                }
            }

        }

        /// <summary>
        /// 编辑状态下获得对应CertID的数据
        /// </summary>
        protected SKT.LeanMES.ProductionShift.Model.ProductionShiftInfo TypeData
        {
            set
            {
                this.txtShiftName.Text = value.ShiftName;
                this.txtShiftRemark.Text = value.Remark;
            }
        }
    }
}