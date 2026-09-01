using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.MaterialConfig.Model;
using SKT.LeanMES.Web.MaterialConfig;
using SKT.LeanMES.PubItems.BLL;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialIQCReturnList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));
 
            SKT.LeanMES.MaterialConfig.BLL.MaterialSysConfig sysConfig = new LeanMES.MaterialConfig.BLL.MaterialSysConfig();
            MaterialSysConfigInfo model = sysConfig.GetInfo("8");
            if (model != null)
            {
                this.PageData = model;
            }
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ReturnFormId";
            this.Master.DefaultSortExpression = "ReturnFormId DESC";


            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            string txtReveivedNO = HttpUtility.UrlEncode(this.txtReveivedNO.Value.Trim());
            string txtVendorName = this.txtVendorName.Value.Trim();
            string txtVendorCode = HttpUtility.UrlEncode(this.txtVendorCode.Value.Trim());
            int intVenderId = AccountController.GetCurrentUser().UserType;

            string strWhere = " 1=1 ";

            if (this.txtReturnNo.Value.Trim() != "")
            {
                searchSettings.AddCondition("ReturnFormNo", this.txtReturnNo.Value.Trim());
            }
            //供应商登录
           /* if (intVenderId != -1)
            {
                this.txtVendorName.Visible = false;
                searchSettings.AddCondition("SupplierId", intVenderId.ToString());
            }*/
            if (!string.IsNullOrEmpty(txtReveivedNO))
            {
                searchSettings.AddCondition("DeliverNo", txtReveivedNO);
            }
            if (!string.IsNullOrEmpty(txtVendorCode))//供应商
            {
                searchSettings.AddCondition("VendorCode", txtVendorCode);
            }
            if (!string.IsNullOrEmpty(txtVendorName))//供应商
            {
                searchSettings.AddCondition("VendorName", txtVendorName);
            }
            if (!string.IsNullOrEmpty(this.txtPoCode.Value.Trim()))//poCode
            {
                //searchSettings.AddCondition("POCode", HttpUtility.UrlEncode(this.txtPoCode.Value.Trim()));
                strWhere += string.Format(" AND  POCode  like '%{0}%' ", HttpUtility.UrlEncode(this.txtPoCode.Value.Trim()));
            }
            if (!string.IsNullOrEmpty(this.txtItemCope.Value.Trim()))//物料代码
            {
                searchSettings.AddCondition("ItemCode", HttpUtility.UrlEncode(this.txtItemCope.Value.Trim()));
            }
            if (!string.IsNullOrEmpty(this.txtLoweredUserName.Value.Trim()))//采购员
            {
                searchSettings.AddCondition("LoweredUserName", this.txtLoweredUserName.Value.Trim());
            }
            //退货状态
            string stus = this.selStatus.Value;
            if (stus != "")
            {
                searchSettings.AddCondition("Status", stus);
            }

           
            //退货时间
            string txtDateFrom = this.txtDateFrom.Value.Trim();
            string txtDateTo = this.txtDateTo.Value.Trim();
            string dateFrom = "";
            string dateTo = "";

            dateFrom = txtDateFrom;
            dateTo = txtDateTo;
            this.txtDateFrom.Value = dateFrom;
            this.txtDateTo.Value = dateTo;
            DateTime tmFrom;
            DateTime tmTo;
            if (txtDateFrom != "" && txtDateTo != "")
            {
                //判断日期
                if (!DateTime.TryParse(txtDateFrom, out tmFrom) || !DateTime.TryParse(txtDateTo, out tmTo))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    strWhere += " AND CreateDateStr BETWEEN '" + dateFrom + "' AND '" + dateTo + "' ";
                }
            }
            else
            {
                if (txtDateFrom != "" && txtDateTo == "")
                {
                    if (!DateTime.TryParse(txtDateFrom, out tmFrom))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                    }
                    else
                    {
                        strWhere += " AND ( CreateDateStr >= '" + dateFrom + "')";
                    }
                }
                if (txtDateTo != "" && txtDateFrom == "")
                {
                    if (!DateTime.TryParse(txtDateTo, out tmTo))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                    }
                    else
                    {
                        strWhere += " AND (CreateDateStr <= '" + dateTo + "')";
                    }
                }
            }

            searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? strWhere : " and " + strWhere;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                try
                {
                    if (this.hdnOperate.Value.ToLower() == "pdfprint")
                    {
 
                        string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "IQCReturnForm.xml";
                        string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                        string strJson = this.hdnIdString.Value;
                        //获取PDF文件流
                        //string strFileName = (new SKT.LeanMES.PubItems.BLL.PubItems()).GetPdf("uspGetIqcReturnpPrint", strJson, strTargePath, strXmlPath, CommonMethod.WebRoot);
                        //导出文件
                        //CommonMethod.exportFile(strFileName, strTargePath);

                        this.hdnOperate.Value = "";
                        this.hdnIdString.Value = "";
                        byte[] buff = (new SKT.LeanMES.PubItems.BLL.PubItems()).GetPdfBuff("uspGetIqcReturnpPrint", strJson, strXmlPath, CommonMethod.WebRoot);
                        Response.ContentType = "application/pdf";
                        Response.BinaryWrite(buff);
                        
                    }
                    ////导出
                    //if (this.hdnOperate.Value.ToLower() == "exportexcel")
                    //{
                    //    DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwGetIQCreturnList", "ORDER BY Createdate DESC", searchSettings, "ReturnFormId", this.hdnIdString.Value);
                    //    CommonMethod.ExportToSpreadsheet(ds, "退货单列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1);
                    //}
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            int widthSum = 0;
            for (int i = 0; i < GridView1.Columns.Count; i++)
            {
                widthSum = widthSum + Convert.ToInt32(GridView1.Columns[i].HeaderStyle.Width.Value);
            }
            this.GridView1.Width = widthSum;
        }

        private MaterialSysConfigInfo PageData
        {
            set
            {
                this.hfGrnCheckFlag.Value = value.ConfigResult;
            }
        }

    }

}