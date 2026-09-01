using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web;
using SKT.LeanMES.DataType.Model;

namespace SKT.LeanMES.Web.BasalData
{
    public partial class DataTypeEdit : BasePage
    {
        #region protected mumbers
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxDataType));
            Int32 TypeID = Convert.ToInt32(Request.QueryString["ID"]);//从主页面中传递过来的DataType ID
            if (TypeID == -1)
            {
                TypeID = (Convert.ToInt32(Request.Form["hdnTIDString"]) == 0) ? -1 : Convert.ToInt32(Request.Form["hdnTIDString"]); //从隐藏控件读取当前的 DataType ID
            }

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "DataFieldId";
            this.Master.DefaultSortExpression = "Sequence";
            this.Master.DefaultSortDirection = SortDirection.Ascending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "DataTypeId=" + TypeID.ToString();
            this.Master.SearchSettings = searchSettings;

            if (this.IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.DataType.BLL.DataField bll = new SKT.LeanMES.DataType.BLL.DataField();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }

            if (TypeID != -1) //编辑存在的DataType ID时屏蔽不能修改的内容
            {
                SKT.LeanMES.DataType.BLL.DataType bllType = new SKT.LeanMES.DataType.BLL.DataType();
                DataTypeInfo model = null;
                model = bllType.GetInfo(TypeID);
                if (model != null)
                {
                    this.TypeData = model;
                    if (Request.QueryString["Action"] != "Copy")
                    {
                        this.ddlCat.Enabled = false;
                        this.txtName.Enabled = false;
                    }
                }
            }

        }

        /// <summary>
        /// 编辑状态下获得对应CertID的数据
        /// </summary>
        protected DataTypeInfo TypeData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtName.Text = Resources.Buttons.COM_Copy + " - " + value.DataTypeName;
                }
                else
                {
                    this.txtName.Text = value.DataTypeName;
                }
                this.ddlCat.SelectedValue = value.Category;
                this.txtDesc.Text = value.Description;
                this.txtActivity.Text = value.ValidationActivity;
            }
        }


        #endregion
    }
}