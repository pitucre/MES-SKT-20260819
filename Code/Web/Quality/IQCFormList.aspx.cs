using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Material.BLL;
using System.Data;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Web.AppCode.Utility;
using SKT.LeanMES.Model;

namespace SKT.LeanMES.Web.Quality
{
    public partial class IQCFormList : BasePage
    {
        private int columnIndex_UrgentName = -1;
        private int columnIndex_ItemName = -1;
        private int columnIndex_ItemSpec = -1;
        private int columnIndex_StatusName = -1;
        private int columnIndex_InspectionResult = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_UrgentName = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UrgentName")) + 1;
            columnIndex_ItemName = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ItemName")) + 1;
            columnIndex_ItemSpec = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ItemSpec")) + 1;
            columnIndex_StatusName = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "StatusName")) + 1;
            columnIndex_InspectionResult = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "InspectionResult")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxInspection));

            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "InspectionId";
            Master.DefaultSortExpression = "UrgentName";
            Master.DefaultSortDirection = SortDirection.Ascending;
            Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = " 1 = 1 ";

            if (txtPoCode.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += string.Format("  AND POCode like '%{0}%' ", txtPoCode.Text.Trim());
            }
            //searchSettings.AddCondition("POCode", txtPoCode.Text.Trim());
            searchSettings.AddCondition("SuplierCode", txtVendorCode.Text.Trim());
            searchSettings.AddCondition("DeliverNo", txtDeliNo.Text.Trim());
            searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());
            searchSettings.AddCondition("InspectionUser", txtInspectionUser.Text.Trim());


            if (!String.IsNullOrEmpty(this.txtSOCode.Value.Trim()))
            {
                searchSettings.AddCondition("SOCode", this.txtSOCode.Value.Trim());
            }

            if (txtGrn.Text != "")
            {
                string IQCOrder = (new MaterialIQC()).GetIQCOrder(txtGrn.Text);
                if (IQCOrder == "")
                {
                    IQCOrder = "AAAAAAAAAAAAAAA";
                }
                searchSettings.AddCondition("InspectionNo", IQCOrder.Trim());
            }
            else
            {
                searchSettings.AddCondition("InspectionNo", txtIqcBatchNO.Text.Trim());
            }

            //检验结果
            string inspectionResult = this.selInspectionResult.Value;
            if (inspectionResult != "")
            {
                if (string.Equals(inspectionResult, "1"))
                {
                    //合格
                    searchSettings.AddCondition("InspectionResult", inspectionResult);
                }
                else
                {
                    //不合格
                    searchSettings.ExtensionCondition += " AND InspectionResult IN (0,2)";
                }
            }
            //检验状态
            string iqcType = this.selIQCType.Value;
            if (!string.IsNullOrEmpty(iqcType))
            {
                if (string.Equals(iqcType, "2"))
                {
                    //已经检验就包括非待检验的所有状态
                    searchSettings.ExtensionCondition += " AND Status > 1";
                }
                else
                {
                    searchSettings.AddCondition("Status", iqcType);
                }
            }
            //处理结果
            string iqcResult = this.selIQCResult.Value;
            if (!string.IsNullOrEmpty(iqcResult))
            {
                searchSettings.AddCondition("ManageResult", iqcResult);
            }
            //IQC审核结果
            if (!string.IsNullOrEmpty(selIsVerify.Value))
            {
                if (selIsVerify.Value == "0")
                {
                    searchSettings.ExtensionCondition += " AND ISNULL(VerifyBy,'')=''";
                }
                else if (selIsVerify.Value == "1")
                {
                    searchSettings.ExtensionCondition += " AND ISNULL(VerifyBy,'')<>''";
                }
            }
            string txtDateFrom = this.txtDateFrom.Value.Trim();
            string txtDateTo = this.txtDateTo.Value.Trim();
            string txtDateF = this.txtDateF.Value.Trim();
            string txtDateT = this.txtDateT.Value.Trim();
            string dateFrom = "";
            string dateTo = "";
            string dateF = "";
            string dateT = "";

            dateFrom = txtDateFrom;
            dateTo = txtDateTo;
            dateF = txtDateF;
            dateT = txtDateT;

            this.txtDateFrom.Value = dateFrom;
            this.txtDateTo.Value = dateTo;
            this.txtDateF.Value = dateF;
            this.txtDateT.Value = dateT;

            DateTime tmFrom;
            DateTime tmTo;
            DateTime tmF;
            DateTime tmT;


            if (txtDateFrom != "" && txtDateTo != "")
            {
                //判断日期
                if (!DateTime.TryParse(txtDateFrom, out tmFrom) || !DateTime.TryParse(txtDateTo, out tmTo))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " AND CreateDateTime BETWEEN '" + dateFrom + "' AND '" + Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy-MM-dd") + "' ";
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
                        searchSettings.ExtensionCondition += " AND (CreateDateTime >= '" + dateFrom + "')";

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
                        searchSettings.ExtensionCondition += " AND (CreateDateTime <= '" + Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy-MM-dd") + "')";
                    }
                }
            }

            if (txtDateF != "" && txtDateT != "")
            {
                //判断日期
                if (!DateTime.TryParse(txtDateF, out tmF) || !DateTime.TryParse(txtDateT, out tmT))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " AND CheckDate BETWEEN '" + dateF + "' AND '" + Convert.ToDateTime(dateT).AddDays(1).ToString("yyyy-MM-dd") + "' ";
                }
            }
            else
            {
                if (txtDateF != "" && txtDateT == "")
                {
                    if (!DateTime.TryParse(txtDateF, out tmF))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += " AND (CheckDate >= '" + dateF + "')";

                    }
                }
                if (txtDateT != "" && txtDateF == "")
                {
                    if (!DateTime.TryParse(txtDateT, out tmT))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                    }
                    else
                    {
                        searchSettings.ExtensionCondition += " AND (CheckDate <= '" + Convert.ToDateTime(dateT).AddDays(1).ToString("yyyy-MM-dd") + "')";
                    }
                }
            }



            //var orderNo = ddlSearch.SelectedValue;
            //if (this.selIQCType.Value != "")
            //{
            //    searchSettings.AddCondition("Status", this.selIQCType.Value);
            //}
            //if (txtSrcNo.Text != "")
            //{
            //    searchSettings.AddCondition(orderNo, txtSrcNo.Text.Trim());
            //}



            //searchSettings.ExtensionCondition = "InspectionTypeId=1";
            Master.SearchSettings = searchSettings;
            GridView1.PageIndex = 0;

            //foreach (string str in bll.GetInspectionTypeList()){ddlInspectionType.Items.Add(str);}
            //bll.GetInspectionTypeList();

            if (this.IsPostBack)
            {
                try
                {                
                    //导出
                    if (this.hdnOperate.Value.ToLower() == "exportexcel")
                    {             
                        DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwProdMaterialIQCList", "ORDER BY InspectionId DESC", searchSettings, "InspectionId", Request.Form["hdnIdString"]);
                        var tempFiledNames = new string[] { "InspectionQty" };

                        Dictionary<string, Dictionary<string, string>> changeValues = new Dictionary<string, Dictionary<string, string>>();
                        changeValues["InspectionResult"] = new Dictionary<string, string> {
                            {"1","合格" },
                            { "0","不合格"},
                            {"default","" },
                        };
                        CommonMethod.ExportToSpreadsheet(ds, "IQC来料检查列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1, tempFiledNames, changeValues,new List<string>() { "SuplierCode" });

                        //var list = new SKT.LeanMES.Material.BLL.MaterialIQC().GetAll(int.MinValue, int.MaxValue, " InspectionId DESC ", searchSettings);

                        //NPOIHelpers.Export(list, this.GridView1, "IQC来料检查列表" + DateTime.Now.ToString("yyyyMMddhhmmss") + ".xlsx");
                    }
                    else if (this.hdnOperate.Value.ToLower() == "exportexcel")
                    {
                        //bll.WarehouseReturnSupplierDelete(new LeanMES.Material.Model.ReturnToVendorInfo
                        //{
                        //    ReturnOrder = Request.Form["hdnIdString"].ToString(),
                        //    UpdateBy = AccountController.GetCurrentUser().UserName
                        //});
                        //WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                }
            }
        }

        //操作事件
        protected void Operate_Changed(object sender, EventArgs e)
        {
            IQCBatch bll = new IQCBatch();
            //WebHelper.ShowMessage(hdnOperate.Value + Convert.ToInt32(Request.Form["hdnIdString"]).ToString());
            string strXmlPath = "";
            string strTargePath = "";
            string strFileName = "";

            try
            {
                string action = this.hdnOperate.Value.ToLower();
                this.hdnOperate.Value = "";
                switch (action)
                {
                    case "delete":
                        bll.IQCDelete(Request.Form["hdnIdString"], AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                        break;
                    case "iqcpdfprint":
                        strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "IQCFormReportFile.xml";
                        if (ConfigurationManager.AppSettings["FileAdd"] != null)
                        {
                            strTargePath = ConfigurationManager.AppSettings["FileAdd"].ToString() + "Temp\\";
                            strFileName = bll.GetIQCFormPdf(Convert.ToInt32(Request.Form["hdnIdString"]), strTargePath, strXmlPath, CommonMethod.WebRoot);
                            //导出文件
                            CommonMethod.exportFile(strFileName, strTargePath);
                        }
                        else
                        {
                            WebHelper.ShowMessage("在系统配置文件中未找到文件上传路径节点 [FileAdd]！");
                        }
                        break;
                    case "iqcreportpdfprint":
                        strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "IQCReportFile.xml";
                        if (ConfigurationManager.AppSettings["FilePath"] != null)
                        {
                            //strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                            strTargePath = CommonMethod.WebRoot + ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                            strFileName = bll.GetIQCReportPdf(Convert.ToInt32(Request.Form["hdnIdString"]), strTargePath, strXmlPath, CommonMethod.WebRoot);
                            //导出文件
                            CommonMethod.exportFile(strFileName, strTargePath);
                        }
                        else
                        {
                            WebHelper.ShowMessage("在系统配置文件中未找到文件上传路径节点 [FilePath]！");
                        }
                        break;
                    case "iqcorderreportpdfprint":
                        strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "IQCReceiveReportFile.xml";
                        if (ConfigurationManager.AppSettings["FilePath"] != null)
                        {
                            //strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                            strTargePath = CommonMethod.WebRoot + ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";

                            DataSet ds = bll.getIQCPdfReportDs(Convert.ToInt32(Request.Form["hdnIdString"]));
                            if (ds == null) break;
                            //PDF产生
                            strFileName = PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlPath, ds, strTargePath, CommonMethod.WebRoot);
                            //导出文件
                            CommonMethod.exportFile(strFileName, strTargePath);
                        }
                        else
                        {
                            WebHelper.ShowMessage("在系统配置文件中未找到文件上传路径节点 [FilePath]！");
                        }
                        break;
                }

            }
            catch (Exception ex) { WebHelper.HandleException("", ex, true); }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //IsFile 档案文件
                //if (e.Row.Cells[22].Text != "0")
                //{
                //    e.Row.Cells[22].Text = "<img src=\"../Content/images/icon/view.png\"  onclick=\"viewFile('" + e.Row.Cells[1].Text + "')\"  style=\"cursor:pointer;\"/>";
                //}
                //else
                //{
                //    e.Row.Cells[22].Text = "";
                //}
                //检验结果
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //19改为columnIndex_ModifyDateTime
                if (e.Row.Cells[columnIndex_InspectionResult].Text == "1")
                {
                    e.Row.Cells[columnIndex_InspectionResult].Text = "合格";
                }
                else if (e.Row.Cells[columnIndex_InspectionResult].Text == "0" || e.Row.Cells[19].Text == "2")
                {
                    e.Row.Cells[columnIndex_InspectionResult].Text = "不合格";
                }
                //else if (e.Row.Cells[18].Text == "2")
                //{
                //    e.Row.Cells[18].Text = "IQC已经处理";
                //}
                else
                {
                    e.Row.Cells[columnIndex_InspectionResult].Text = "";
                }

                //if (e.Row.Cells[18].Text == "0")
                //{
                //    e.Row.Cells[18].Text = "不合格"; 
                //}
                //else if (e.Row.Cells[18].Text == "1")
                //{
                //    e.Row.Cells[18].Text = "合格";
                //}
                //else if (e.Row.Cells[18].Text == "2")
                //{
                //    e.Row.Cells[18].Text = "IQC已经处理";
                //}
                //else 
                //{
                //    e.Row.Cells[18].Text = "";
                //}
                //紧急情况UrgentName
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //2改为columnIndex_UrgentName
                if (e.Row.Cells[columnIndex_UrgentName].Text == "紧急" && "待检验" == e.Row.Cells[columnIndex_StatusName].Text)
                {
                    e.Row.Cells[columnIndex_UrgentName].ForeColor = System.Drawing.Color.Red;
                }
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //5改为columnIndex_ItemName
                if (e.Row.Cells[columnIndex_ItemName].Text.Length > 6)
                {
                    e.Row.Cells[columnIndex_ItemName].Text = e.Row.Cells[columnIndex_ItemName].Text.Substring(0, 6) + "<a href='#' onmousedown='showData(\"" + e.Row.Cells[columnIndex_ItemName].Text + "\")'>...</a>";
                }
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //6改为columnIndex_ItemSpec
                if (e.Row.Cells[columnIndex_ItemSpec].Text.Length > 12)
                {
                    e.Row.Cells[columnIndex_ItemSpec].Text = e.Row.Cells[columnIndex_ItemSpec].Text.Substring(0, 10) + "<a href='#' onmousedown='showData(\"" + e.Row.Cells[columnIndex_ItemSpec].Text + "\")'>...</a>";
                }
            }
        }
    }
}