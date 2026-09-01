using System;
using SKT.LeanMES.Labels.BLL;
using SKT.LeanMES.Labels.Model;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.IO;

namespace SKT.LeanMES.Web.Labels
{
    public partial class LabelDocumentEdit : BasePage
    {
        private string numbertype = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxLabels));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                //绑定下拉框
                Bind("Status", this.ddlStatus);
                Bind("DocumentType", this.ddlDocumentType);
                Bind("PrintMethod", this.ddlPrintMethod);
                Bind("PrintBy", this.ddlPrintBy);
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new LabelDocument()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private LabelDocumentInfo PageData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtDocumentName.Text = Resources.Buttons.COM_Copy + " - " + value.DocumentName;
                }
                else
                {
                    this.txtDocumentName.Text = value.DocumentName;
                }
                this.txtDescription.Text = value.Description;
                this.txtTemplateName.Text = value.TemplateName;
                this.txtTemplateID.Value = Convert.ToString(value.TemplateID);
                this.txtPrintQty.Text = Convert.ToString(value.Print_Qty);
                this.ddlPrintBy.Text = value.Print_By;
                this.ddlPrintMethod.Text = value.Print_Method;
                this.ddlDocumentType.Text = value.Document_Type;
                this.ddlStatus.Text = value.Status;
                this.txtPlateQty.Text = value.PlateQty.ToString();
                this.txtPrinterName.Text = value.PrinterName;
                this.txtTemplatePath.Text = value.TemplatePath;
                if (!string.IsNullOrWhiteSpace(value.TemplatePath))
                {
                    string url = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/PrintUpdate/" + value.TemplatePath);
                    if (File.Exists(url) && (value.TemplatePath.Contains(".zpl") || value.TemplatePath.Contains(".postek")))
                        this.txtCommand.Text = File.ReadAllText(url);
                }
            }
        }
        /// <summary>
        /// 下拉框绑定
        /// </summary>
        /// <param name="Value">查询字段值</param>
        /// <param name="DDList">下拉框</param>
        private void Bind(string Value, DropDownList DDList)
        {

            SKT.LeanMES.SerialNumber.BLL.Dictionary dictionary = new LeanMES.SerialNumber.BLL.Dictionary();
            List<SKT.LeanMES.SerialNumber.Model.DictionaryInfo> dInfos = dictionary.GetListInfo(Value);
            DDList.DataSource = dInfos;
            DDList.DataTextField = "Value";
            DDList.DataValueField = "Value";
            DDList.DataBind();
        }

        /// <summary>
        /// 下拉框绑定
        /// </summary>
        /// <param name="Value">查询字段值</param>
        /// <param name="DDList">下拉框</param>
        private void Bind_ValueID(string Value, DropDownList DDList)
        {

            SKT.LeanMES.SerialNumber.BLL.Dictionary dictionary = new LeanMES.SerialNumber.BLL.Dictionary();
            List<SKT.LeanMES.SerialNumber.Model.DictionaryInfo> dInfos = dictionary.GetListInfo(Value);
            DDList.DataSource = dInfos;
            DDList.DataTextField = "Value";
            DDList.DataValueField = "DictionaryDataId";

            if (dInfos.Count > 1)
            {
                DDList.SelectedIndex = 1;
            }

            DDList.DataBind();
        }
    }
}