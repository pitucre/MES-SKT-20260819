using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Labels.BLL;
using SKT.LeanMES.Labels.Model;

namespace SKT.LeanMES.Web.Labels
{
    public partial class LabelItemDocumentEdit : BasePage
    {
        private string numbertype = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxLabels));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new LabelItemDocuments()).GetInfo(Convert.ToInt32(idString));
                }
                
                BindSerialNumberType();
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

            if (ddlType.Items.FindByValue(numbertype) != null)
            {
                this.ddlType.SelectedValue = numbertype;
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private LabelItemDocumentsInfo PageData
        {
            set
            {
                this.txtItem.Text = value.ItemName;
                this.hdnItemId.Value = Convert.ToString(value.ItemID);
                this.txtStation.Text = string.IsNullOrEmpty(value.Station) ? "*" : value.Station;
                this.hdnStationId.Value = Convert.ToString(value.StationId);
                this.txtDoc.Text = value.DocumentName;
                this.hdnDocID.Value = Convert.ToString(value.DocID);
                numbertype = Convert.ToString(value.TypeId);
                this.ddlSequence.SelectedValue = Convert.ToString(value.Sequence);
            }
        }
    }
}