using System;
using System.Configuration;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialDeliverList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxDelivery));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "DeliverId";
            this.Master.DefaultSortExpression = "CreateDateTime DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            string txtReveivedNO = this.txtReveivedNO.Value.Trim();
            string txtVendorName = this.txtVendorName.Value.Trim();
            int intVenderId = AccountController.GetCurrentUser().UserType;
            ////供应商登录
            //if (intVenderId != -1)
            //{
            //    this.txtVendorName.Visible = false;
            //    searchSettings.AddCondition("SupplierId", intVenderId.ToString());
            //}
            if (!string.IsNullOrEmpty(txtReveivedNO))
            {
                searchSettings.AddCondition("DeliverNo", txtReveivedNO);
            }
            if (!string.IsNullOrEmpty(txtVendorName))//供应商
            {
                searchSettings.AddCondition("VendorName", txtVendorName);
            }
            if (!string.IsNullOrEmpty(this.txtPoCode.Value.Trim()))//poCode
            {
                searchSettings.AddCondition("PoCode", this.txtPoCode.Value.Trim());
            }
            if (!string.IsNullOrEmpty(this.txtItemCope.Value.Trim()))//物料代码
            {
                searchSettings.AddCondition("ItemCode", this.txtItemCope.Value.Trim());
            }
            if (ddlStatus.SelectedValue !="-1")//物料代码
            {
                searchSettings.AddCondition("DeliState", ddlStatus.SelectedValue);
            }

            string strWhere = "";
            string createDateTimeStart = this.txtDateTime.Text.Trim();
            string createDateTimeEnd = this.txtDateEnd.Text.Trim();
            //供应商登录
            if (intVenderId != -1)
            {
                this.txtVendorName.Visible = false;

                strWhere += String.IsNullOrEmpty(strWhere) ? "  SupplierId=" + intVenderId + "" : " and  SupplierId=" + intVenderId + "";


            }
            if (createDateTimeStart != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? "  Convert(varchar(11),CreateDateTime,120) >= '" + createDateTimeStart + "'" : " and  Convert(varchar(11),CreateDateTime,120) >= '" + createDateTimeStart + "'";
            }
            if (createDateTimeEnd != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? "  Convert(varchar(11),CreateDateTime,120) <= '" + createDateTimeEnd + "'" : " and  Convert(varchar(11),CreateDateTime,120) <= '" + createDateTimeEnd + "'";
            }
            searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? strWhere : " and " + strWhere;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (IsPostBack)
            {
                SKT.LeanMES.Material.BLL.Deliver bll = new SKT.LeanMES.Material.BLL.Deliver();
                try
                {
                    if (this.hdnOperate.Value.ToLower() == "pdfprint")
                    {
                        string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "DeliveryForm.xml";
                        string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                        string strFileName = bll.GetDeliverPdfPrint(Convert.ToInt32(Request.Form["hdnIdString"]), strTargePath, strXmlPath, CommonMethod.WebRoot);
                        this.hdnOperate.Value = "";
                        //导出文件
                        CommonMethod.exportFile(strFileName, strTargePath);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }
            }
        }
    }
}