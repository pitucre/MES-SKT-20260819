using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.BasalData
{
    public partial class MaskGroupEdit : BasePage
    {
        #region protected mumbers
        private int columnIndex_ValidFrom = -1;
        private int columnIndex_ValidTo = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ValidFrom = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ValidFrom")) + 1;
            columnIndex_ValidTo = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ValidTo")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaskGroup));
            Int32 MaskID = Convert.ToInt32(Request.QueryString["ID"]);//从主页面中传递过来的Mask ID
            if (MaskID == -1)
            {
                MaskID = (Convert.ToInt32(Request.Form["hdnTIDString"]) == 0) ? -1 : Convert.ToInt32(Request.Form["hdnTIDString"]); //从隐藏控件读取当前的 Mask ID
            }

            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "Sequence";
            this.Master.DefaultSortDirection = SortDirection.Ascending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            //  searchSettings.AddCondition("MaskID", MaskID.ToString());
            searchSettings.ExtensionCondition = "MaskID =" + MaskID + "";

            this.Master.SearchSettings = searchSettings;

            if (this.IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.MaskGroup.BLL.MaskGroupMember bll = new SKT.LeanMES.MaskGroup.BLL.MaskGroupMember();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }

            if (MaskID != -1) //编辑存在的掩码时屏蔽不能修改的内容
            {
                SKT.LeanMES.MaskGroup.BLL.MaskGroup bllType = new SKT.LeanMES.MaskGroup.BLL.MaskGroup();
                SKT.LeanMES.MaskGroup.Model.MaskGroupInfo model = null;
                model = bllType.GetInfo(MaskID);
                if (model != null)
                {
                    this.MaskData = model;
                }
            }

        }

        /// <summary>
        /// 编辑状态下获得对应CertID的数据
        /// </summary>
        protected SKT.LeanMES.MaskGroup.Model.MaskGroupInfo MaskData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtName.Text = Resources.Buttons.COM_Copy + " - " + value.MaskGroup;
                }
                else
                {
                    this.txtName.Text = value.MaskGroup;
                }
                this.txtDesc.Text = value.Description;
            }
        }


        #endregion

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //6改为columnIndex_ValidFrom
                //7改为columnIndex_ModifyBy
                e.Row.Cells[columnIndex_ValidFrom].Text = Common.Utility.TypeHelper.ToShortDateString(Convert.ToDateTime(e.Row.Cells[columnIndex_ValidFrom].Text));
                e.Row.Cells[columnIndex_ValidTo].Text = (String.IsNullOrEmpty(Common.Utility.TypeHelper.ToShortDateString(Convert.ToDateTime(e.Row.Cells[columnIndex_ValidTo].Text)))) ? "无限期" : Common.Utility.TypeHelper.ToShortDateString(Convert.ToDateTime(e.Row.Cells[columnIndex_ValidTo].Text));
            }
        }
    }
}