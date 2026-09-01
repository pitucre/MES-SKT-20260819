using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialReceiveList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInspection));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "InspectionId";
            this.Master.DefaultSortExpression = "InspectionId desc"; //也可不赋值


            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            string deliverNo = this.txtDeliverNo.Value;
            searchSettings.AddCondition("DeliverNo", deliverNo);

            string poCode = this.txtPONO.Value;
            //searchSettings.AddCondition("POCode", poCode);

            string VendorCode = this.txtVendorCode.Value;
            searchSettings.AddCondition("VendorCode", VendorCode);

            string IQCNo = this.txtIQCNo.Value;
            searchSettings.AddCondition("InspectionNo", IQCNo);

            string CreateBy = this.txtCreateBy.Value;
            searchSettings.AddCondition("CreateBy", CreateBy);

            if (!String.IsNullOrEmpty(this.txtSOCode.Value.Trim()))
            {
                searchSettings.AddCondition("SOCode", this.txtSOCode.Value.Trim());
            }


            string where = "";
            string Status = hfStatus.Value;
            if (Status == "")
            {
                Status = "-1";
            }


            string CheckResult = hfCheckResult.Value;
            if (CheckResult == "")
            {
                CheckResult = "-1";
            }
            where += " (" + Status + "=-1 or Status=" + Status + ") ";
            where += " and ( '" + CheckResult + "'='-1' or CheckResult='" + CheckResult + "' ) ";
            where += " and ( '" + ItemCode.Value + "'='' or ItemCode like '%" + ItemCode.Value + "%' ) ";

            if (chkIsPrint.Checked)
            {
                where += " and ISNULL(PrintQty,0) = 0 ";

            }
            string deliveryTimeEnd = txtDeliveryTimeEnd.Text;
            if (deliveryTimeEnd != "")
            {
                deliveryTimeEnd = Convert.ToDateTime(deliveryTimeEnd).AddDays(1).ToString();
            }
            if (txtDeliveryTimeStart.Text != "" && deliveryTimeEnd != "")
            {
                where += " and  DeliverCreateDate BETWEEN '" + txtDeliveryTimeStart.Text + "' AND  '" + deliveryTimeEnd + "'  ";
            }
            else if (txtDeliveryTimeStart.Text != "")
            {
                where += " and  DeliverCreateDate >= '" + txtDeliveryTimeStart.Text + "'";
            }
            else if (deliveryTimeEnd != "")
            {
                where += " and  DeliverCreateDate <= '" + deliveryTimeEnd + "'";
            }

            string ReceiveTimeEnd = txtReceiveTimeEnd.Text;
            if (ReceiveTimeEnd != "")
            {
                ReceiveTimeEnd = Convert.ToDateTime(ReceiveTimeEnd).AddDays(1).ToString();
            }
            if (txtReceiveTimeStart.Text != "" && ReceiveTimeEnd != "")
            {
                where += " and  CreateDateTime BETWEEN '" + txtReceiveTimeStart.Text + "' AND  '" + ReceiveTimeEnd + "'  ";
            }
            else if (txtReceiveTimeStart.Text != "")
            {

                where += " and  CreateDateTime >= '" + txtReceiveTimeStart.Text + "'";
            }
            else if (ReceiveTimeEnd != "")
            {

                where += " and  CreateDateTime <= '" + ReceiveTimeEnd + "'";
            }

            if (!string.IsNullOrEmpty(poCode))
            {
                where += " and POCode like '%" + poCode + "%' ";
            }
            //处理结果
            string iqcResult = this.selIQCResult.Value;
            if (!string.IsNullOrEmpty(iqcResult))
            {
                searchSettings.AddCondition("ManageResultId", iqcResult);
            }

            searchSettings.ExtensionCondition = where;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //设定视图、表名
            this.Master.TableOrView = "vwMaterialReceive";
            if (IsPostBack)
            {
                //导出
                if (this.hdnOperate.Value.ToLower() == "exportexcel")
                {
                    DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwMaterialReceive", "ORDER BY InspectionId DESC", searchSettings, "InspectionId", null);
                    var arrTemplateField = new string[] { "SentQty", "InspectionQty", "QualifiedQty", "NCQty" };
                    Dictionary<string, Dictionary<string, string>> changeValues = null;
                    var setTextTypeColumms = new List<string> { "VendorCode" };

                    CommonMethod.ExportToSpreadsheet(ds, "仓库收料列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1, arrTemplateField, changeValues, setTextTypeColumms);
                }
            }
        }
        #region  DataTable导出到Excel

        public static void ExportToSpreadsheet(DataTable table, string name)
        {
            var r = new Random();
            var rf = "";
            for (var j = 0; j < 10; j++)
            {
                rf = r.Next(int.MaxValue).ToString();
            }

            var context = HttpContext.Current;
            context.Response.Clear();
            context.Response.ContentType = "text/csv";
            context.Response.ContentEncoding = Encoding.UTF8;
            context.Response.AppendHeader("Content-Disposition",
                "attachment; filename=" + HttpUtility.UrlEncode(name) + ".xls");
            context.Response.HeaderEncoding = Encoding.UTF8;
            context.Response.BinaryWrite(Encoding.UTF8.GetPreamble());

            foreach (DataColumn column in table.Columns)
            {
                context.Response.Write(column.ColumnName + ",");
                //context.Response.Write(column.ColumnName + "(" + column.DataType + "),");   
            }

            context.Response.Write(Environment.NewLine);
            double test;

            foreach (DataRow row in table.Rows)
            {
                for (var i = 0; i < table.Columns.Count; i++)
                {
                    if (i != 8)
                    {
                        if (double.TryParse(row[i].ToString(), out test)) context.Response.Write("=");
                        //context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                        context.Response.Write("\"" + row[i].ToString() + "\",");
                    }
                    else
                    {
                        if (row[i].ToString() != "")
                            context.Response.Write("\"" + Convert.ToDateTime(row[i]).ToString("yyyy-MM-dd") +
                                                   "\",");
                        else
                            context.Response.Write("\"" + row[i].ToString().Replace("\"", "\"\"") + "\",");
                    }
                }
                context.Response.Write(Environment.NewLine);
            }

            context.Response.End();
        }

        #endregion

        //操作事件
        protected void Operate_Changed(object sender, EventArgs e)
        {
            IQCBatch bll = new IQCBatch();
            //WebHelper.ShowMessage(hdnOperate.Value + Convert.ToInt32(Request.Form["hdnIdString"]).ToString());
            string strXmlPath = "";
            string strTargePath = "";
            string strFileName = "";
            string xmlName = "";
            try
            {

                xmlName = "IQCReceiveReportFile.xml";

                strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + xmlName;
                if (ConfigurationManager.AppSettings["FilePath"] != null)
                {
                    //strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                    strTargePath = CommonMethod.WebRoot + ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";

                    DataSet ds = bll.getIQCPdfReportDs(Convert.ToInt32(Request.Form["hdnIdString"]));
                    if (ds == null) return;
                    //PDF产生
                    strFileName = PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlPath, ds, strTargePath, CommonMethod.WebRoot);
                    //导出文件
                    CommonMethod.exportFile(strFileName, strTargePath);
                }
                else
                {
                    WebHelper.ShowMessage("在系统配置文件中未找到文件上传路径节点 [FilePath]！");
                }
            }
            catch (Exception ex) { WebHelper.HandleException("", ex, true); }
        }

    }
}