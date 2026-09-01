using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Labels
{
    public partial class LabelItemDocumentList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxLabels));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemDocId";
            this.Master.DefaultSortExpression = "ItemDocId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "(1=1)";
            searchSettings.AddCondition("ItemName", this.txtItem.Text.Trim());
            searchSettings.AddCondition("Station", this.txtStation.Text.Trim());
            if (this.ddlType.SelectedValue != "")
            {
                searchSettings.ExtensionCondition += $" AND TypeId= {this.ddlType.SelectedValue} ";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (!IsPostBack)
            {
                BindSerialNumberType();
            }
            
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Labels.BLL.LabelItemDocuments bll = new SKT.LeanMES.Labels.BLL.LabelItemDocuments();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }

        /// <summary>
        /// 绑定序列号规则类型
        /// </summary>
        protected void BindSerialNumberType()
        {
            //this.ddlNumberType.DataSource = SKT.LeanMES.Web.Utility.EnumHelper.ParseEnumToList(typeof(SKT.LeanMES.SerialNumber.Model.EnumNextNumberType));
            //this.ddlNumberType.DataTextField = "text";
            //this.ddlNumberType.DataValueField = "value";
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            this.ddlType.DataSource = new SKT.LeanMES.SerialNumber.BLL.SerialNumberType().GetAll(0, 100, "SerialNumberTypeId", searchSettings);
            this.ddlType.DataTextField = "SerialNumberType";
            this.ddlType.DataValueField = "SerialNumberTypeId";
            this.ddlType.DataBind();
            this.ddlType.Items.Insert(0, new ListItem(Resources.lang.Choose, ""));
        }

        //protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        string typeIdStr = e.Row.Cells[4].Text.Trim();
        //        string typeText;
        //        switch (typeIdStr)
        //        {
        //            case "1":
        //                typeText = Resources.Enum.Item;
        //                break;
        //            case "2":
        //                typeText = Resources.Enum.Material;
        //                break;
        //            case "3":
        //                typeText = Resources.Enum.Pack;
        //                break;
        //            case "4":
        //                typeText = Resources.Enum.IQC;
        //                break;
        //            case "5":
        //                typeText = Resources.Enum.ReceiveOrder;
        //                break;
        //            case "6":
        //                typeText = Resources.Enum.Pallet;
        //                break;
        //            default:
        //                typeText = String.Empty;
        //                break;
        //        }
        //        e.Row.Cells[4].Text = typeText;
        //    }
        //}
    }
}