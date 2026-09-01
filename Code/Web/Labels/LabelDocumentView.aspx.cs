using System;
using System.Linq;
using SKT.LeanMES.Labels.BLL;
using SKT.LeanMES.Labels.Model;
using SKT.LeanMES.SerialNumber.BLL;
using System.Collections.Generic;
using SKT.LeanMES.SerialNumber.Model;

namespace SKT.LeanMES.Web.Labels
{
    public partial class LabelDocumentView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            LabelDocumentInfo labelDocumentInfo = (new LabelDocument()).GetInfo(Convert.ToInt32(idString));


            this.lblDocumentName.Text = labelDocumentInfo.DocumentName;

            this.lblDescription.Text = labelDocumentInfo.Description;

            this.lblTemplateName.Text = labelDocumentInfo.TemplateName;

            this.lblPrint_Qty.Text = Convert.ToString(labelDocumentInfo.Print_Qty);
            this.lblPrint_By.Text = labelDocumentInfo.Print_By;
            this.lblPrint_Method.Text = labelDocumentInfo.Print_Method;
            this.lblDocument_Type.Text = labelDocumentInfo.Document_Type;
            this.lblStatus.Text = (String)this.GetGlobalResourceObject("Common", labelDocumentInfo.Status);
            this.lblPrinterName.Text = labelDocumentInfo.PrinterName;
            this.lblPlateQty.Text = Convert.ToString(labelDocumentInfo.PlateQty);
        }
    }
}