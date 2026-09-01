using System;
using System.Collections;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.Web.AjaxServices;
using System.Data.OleDb;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.PubItems.Model;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.SMT
{
    public partial class LoadingListAdd : BasePage
    {
        public string xlsTbJson;
        public string colNameJson;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.EmptyDataText = Resources.Messages.EmptyDataText;
            this.GridView1.EmptyDataRowStyle.CssClass = "ListTableEmptyDataRow";

            this.GridView1.CssClass = "ListTable";
            this.GridView1.HeaderStyle.CssClass = "ListTableHeader";
            this.GridView1.RowStyle.CssClass = "ListTableOddRow";
            this.GridView1.AlternatingRowStyle.CssClass = "ListTableEvenRow";
            this.GridView1.SelectedRowStyle.CssClass = "ListTableSelectedRow";
            this.GridView1.PagerStyle.CssClass = "ListTablePager";

            //生成类型下拉控件
            //模板类型
            //SearchSettings searchLoadType = new SKT.Common.Model.SearchSettings();
            //searchLoadType.AddCondition("EnableFlag", "1");
            //hfJsonLoadType.Value = (new LeanMES.SMT.BLL.LoadingType()).GetLoadType(searchLoadType);
            //SMT线别设备类型
            //hfJsonLineRelation.Value = (new LeanMES.SMT.BLL.LoadingType()).GetSMTLineRelationType(null);
            hfJsonLineRelation.Value = (new LeanMES.SMT.BLL.LoadingType()).GetSMTLineRelationTypeT(null);

            ////SMT线别设备类型排序

            //hfJsonSeq.Value = (new LeanMES.SMT.BLL.LoadingType()).GetSMTLineSequence(null);

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServicesLoadingList));
            int groudId = Convert.ToInt32(Request.QueryString["ID"]);
            if (!IsPostBack)
            {
                GetLoadStatus();
                GetLayout();
                txtRev.Text = "1";
            }
            if (groudId > -1)
            {
                LoadinglistInfo model = null;
                SKT.LeanMES.SMT.BLL.LoadingList bll = new SKT.LeanMES.SMT.BLL.LoadingList();
                model = bll.GetInfo(groudId);
                if (model != null)
                {
                    this.PageData = model;
                }
            }

        }

        // 转换/取代excel每个内容的文本的特殊符号
        public string GetFixCellText(string strText)
        {
            string newStr = "";
            List<string> bidStrlist = new List<string>();
            //bidStrlist.Add(",");
            bidStrlist.Add("'");
            bidStrlist.Add(";");
            bidStrlist.Add(":");
            bidStrlist.Add("%");
            bidStrlist.Add("@");
            bidStrlist.Add("&");
            bidStrlist.Add("#");
            bidStrlist.Add("\"");
            bidStrlist.Add("<");
            bidStrlist.Add(">");
            bidStrlist.Add("\n");//Add By Alen 2018-01-25 增加excel 强制换行符替换
            for (int i = 0; i < bidStrlist.Count; i++)
            {
                newStr = strText.Replace(bidStrlist[i], " ");       //替换SQL敏感字符 Modify By Alen 2018-01-25 将所有非法字符由替换为空
            }
            return newStr;
        }

        protected void linkUploadFile_Click(object sender, EventArgs e)
        {
            if (!fuLoadingList.HasFile)
            {
                WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
                return;
            }
            if (ddlLoadType.SelectedValue == "-1")
            {
                WebHelper.ShowMessage("请先选择模板类型！");
                return;
            }

            string fileExtension = System.IO.Path.GetExtension(fuLoadingList.PostedFile.FileName).ToLower();
            string allowExtension = ".xls";
            string allowTwoExtension = ".xlsx";
            string allowExtension_3 = ".csv";
            if (fileExtension != allowExtension
                && fileExtension != allowTwoExtension
                && fileExtension != allowExtension_3)
            {
                WebHelper.ShowMessage(Resources.Messages.FileTypeError.ToString());
                return;
            }
            string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/SMT");

            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            string filePath = path + "/" + fuLoadingList;

            try
            {

                this.fuLoadingList.PostedFile.SaveAs(filePath);
            }
            catch
            {

            }
            finally
            {
                fuLoadingList.PostedFile.InputStream.Close();
                fuLoadingList.PostedFile.InputStream.Dispose();
            }


            DataTable csvDataTable = new DataTable();
            if (fileExtension == allowExtension_3)
            {
                #region
                csvDataTable = AppCode.Utility.Aspose.ImportExcel.ReadExcelToTable(filePath);
                var firstRow = csvDataTable.Rows[0].ItemArray;
                for (int i = 0; i < firstRow.Count(); i++)
                {
                    var columnName = firstRow[i].ToString();
                    if (string.IsNullOrEmpty(columnName))
                    {
                        columnName = Guid.NewGuid().ToString();
                    }
                    csvDataTable.Columns[i].ColumnName = columnName;//每一列名称
                }
                csvDataTable.Rows.Remove(csvDataTable.Rows[0]);
                #endregion
                #region 原解析csv文件
                //FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);

                //StreamReader sr = new StreamReader(fs, System.Text.Encoding.Default);
                //try
                //{
                //    //string t = sr.ReadToEnd();
                //    string t = sr.ReadLine();
                //    string[] strColum = t.Split(',');   //CVS 文件默认以逗号隔
                //    for (int i = 0; i < strColum.Length; i++)
                //    {
                //        csvDataTable.Columns.Add(strColum[i]);
                //    }
                //    while (!sr.EndOfStream)
                //    {
                //        string strTest = sr.ReadLine();
                //        string[] strTestAttribute = strTest.Split(',');
                //        DataRow dr = csvDataTable.NewRow();
                //        for (int i = 0; i < strColum.Length; i++)
                //        {
                //            if (!string.IsNullOrWhiteSpace(strTestAttribute[i]))
                //            {
                //                dr[strColum[i]] = strTestAttribute[i];
                //            }
                //        }
                //        csvDataTable.Rows.Add(dr);
                //    }
                //}
                //catch
                //{
                //}
                //finally
                //{
                //    fs.Close();
                //    fs.Dispose();
                //    sr.Close();
                //    sr.Dispose();
                //}
                #endregion


            }
            else
            {

            }

            try
            {
                DataTable xlsTable = new DataTable();
                LoadingTypeInfo selLoadingType = new LoadingTypeInfo();
                selLoadingType=new LeanMES.SMT.BLL.LoadingType().GetInfo(Convert.ToInt32(ddlLoadType.SelectedValue));
                int startRowIndex = 1;
                if (selLoadingType != null && selLoadingType.BeginRow > 1)
                    startRowIndex = selLoadingType.BeginRow;
                if (fileExtension == allowExtension_3)
                {
                    xlsTable = csvDataTable;
                }
                else
                {
                    xlsTable = NPOIHelpers.Import(filePath, 0, startRowIndex-1, startRowIndex, false);//表头取值索引0开始-1，内容行=表头取值+1
                    //var xlsTable2 = SKT.LeanMES.Web.AppCode.Utility.ExcelHelper.QueryExcel(filePath, WebHelper.ExcelConnString);
                }
                ////判断为空时去掉
                //DataView dv = xlsTable.DefaultView;
                //dv.RowFilter = " F2 is not null ";
                //xlsTable = dv.ToTable();

                xlsTbJson = JsonConvert.SerializeObject(xlsTable);
                var colCount = xlsTable.Columns.Count;
                ArrayList arrColName = new ArrayList();

                var sqlCreateTab = "IF OBJECT_ID(N'dbo.Prod_SMTLoadTemp') IS NOT NULL " +
                                   "BEGIN DROP TABLE Prod_SMTLoadTemp END " +
                                   "Create Table Prod_SMTLoadTemp(";
                sqlCreateTab += " ColSeq nvarchar(500) null , ";
                for (var i = 0; i < colCount; i++)
                {
                    //arrColName.Add(xlsTable.Columns[i].ToString());
                    arrColName.Add(xlsTable.Rows[0][i].ToString());
                    //sqlCreateTab += " " + xlsTable.Columns[i] +" nvarchar(50) null , ";
                    sqlCreateTab += " ExcCol_" + i + " nvarchar(MAX) null , ";
                }
                colNameJson = JsonConvert.SerializeObject(arrColName);
                sqlCreateTab = sqlCreateTab.Substring(0, sqlCreateTab.Length - 1); //去除最后逗号
                sqlCreateTab += ")";

                SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, sqlCreateTab, null);//创建临时表#Prod_SMTLoadTemp

                StringBuilder sqlInsertTab = new StringBuilder();
                sqlInsertTab.Append("INSERT INTO Prod_SMTLoadTemp VALUES ");
                for (var r = 0; r < xlsTable.Rows.Count; r++)   //数据插入，行循环
                {
                    bool AllEnpty = false;
                    StringBuilder sbInsertCol = new StringBuilder();
                    sbInsertCol.Append(" ( " + r + ",");
                    for (var c = 0; c < colCount; c++)      //数据插入，列循环
                    {
                        if (c == colCount - 1)
                        {
                            sbInsertCol.Append("N'" + GetFixCellText(xlsTable.Rows[r][c].ToString()) + "' ");
                        }
                        else
                        {
                            sbInsertCol.Append("N'" + GetFixCellText(xlsTable.Rows[r][c].ToString()) + "',");
                        }

                        if (GetFixCellText(xlsTable.Rows[r][c].ToString()) != "")
                        {
                            AllEnpty = true;
                        }

                        if (GetFixCellText(xlsTable.Rows[r][c].ToString()) != "")
                        {
                            AllEnpty = true;
                        }
                    }

                    if (r == xlsTable.Rows.Count - 1)//最后一组数据去除逗号
                    {
                        sbInsertCol.Append(" ) ");
                    }
                    else
                    {
                        sbInsertCol.Append(" ), ");
                    }

                    if (AllEnpty)
                    {
                        sqlInsertTab.Append(sbInsertCol.ToString());
                    }
                }
                //插入数据到临时表
                if (sqlInsertTab.ToString() != "INSERT INTO Prod_SMTLoadTemp VALUES ")
                {
                    SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, sqlInsertTab.ToString().TrimEnd(new char[] { ',', ' ' }), null);
                }
                lbFileReady.Text = fuLoadingList.FileName;
                lab_SetupName.Text = fuLoadingList.FileName.Substring(0, fuLoadingList.FileName.IndexOf('.') > 0 ? fuLoadingList.FileName.IndexOf('.') : fuLoadingList.FileName.Length);
                lab_SetupName.Text = fuLoadingList.FileName;
                //uspTempLoadingList

                var bll = new SKT.LeanMES.SMT.BLL.LoadingType();
                bll.SaveTempLoading(Convert.ToInt32(ddlLoadType.SelectedValue));

                //获取导入的信息
                //DataTable tb = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, "SELECT * FROM Prod_SMTLoadTemp", null);
                //hfSMTColName.Value = (new PubItems.BLL.PubItems()).GetListJson(tb);

                //2017-7-3重新设计
                //int rId = Convert.ToInt32(Request.QueryString["ID"]);
                //this.Master.PageGridView = this.GridView1;
                //this.Master.RecordIDField = "LoadingListDetailId";
                //this.Master.DefaultSortDirection = SortDirection.Ascending;
                SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                //searchSettings.ExtensionCondition = "LoadingListID =" + groudId + "";
                //this.Master.SearchSettings = searchSettings;

                GridView1.DataSource = bll.GetLoadTypeTempView(0, -1, "", searchSettings);
                GridView1.DataBind();
                xlsTbJson = "[]";
            }
            catch (Exception ex)
            {
                xlsTbJson = "";
                WebHelper.ShowMessage(ex.Message);
            }
            finally
            {
                File.Delete(filePath);
            }

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                int id = e.Row.RowIndex + 1;
                e.Row.Cells[0].Text = id.ToString();
            }
        }


        private LoadinglistInfo PageData
        {
            set
            {

            }
        }
        /***获取状态***/
        public void GetLoadStatus()
        {
            //SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            //SKT.LeanMES.SMT.BLL.LIST_Status status = new SKT.LeanMES.SMT.BLL.LIST_Status();
            //List<SKT.LeanMES.SMT.Model.LIST_StatusInfo> statusInfo = status.GetAll(0, 100, "id", searchSettings);
            //ddlStatus.DataSource = statusInfo;
            //ddlStatus.DataTextField = "Description";
            //ddlStatus.DataValueField = "id";
            //ddlStatus.DataBind();

            /***获取产线名称***/
            //SKT.LeanMES.Resource.BLL.Line line = new LeanMES.Resource.BLL.Line();
            //List<SKT.LeanMES.Resource.Model.LineInfo> lineInfo = line.GetAll(0, 10000, "LineId", searchSettings);
            //ddlLine.Items.Clear();
            //ddlLine.Items.Add(new ListItem("--Selected--", "-1"));
            //for (int i = 0; i < lineInfo.Count; ++i)
            //{

            //    ddlLine.Items.Add(new ListItem(lineInfo[i].LineName.ToString(), lineInfo[i].LineId.ToString()));
            //}
        }

        /// <summary>
        /// 获取面别
        /// </summary>
        public void GetLayout()
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            SKT.LeanMES.SMT.BLL.LoadingListTable layout = new SKT.LeanMES.SMT.BLL.LoadingListTable();
            List<SKT.LeanMES.SMT.Model.LoadingListTableInfo> layoutInfo = layout.GetAll(0, 100, "LoadingListTableId", searchSettings);
            ddlLayout.DataSource = layoutInfo;
            ddlLayout.DataTextField = "TableDesc";
            ddlLayout.DataValueField = "TableName";
            ddlLayout.DataBind();

            SearchSettings ddlType = new SKT.Common.Model.SearchSettings();
            ddlType.AddCondition("EnableFlag", "1");
            var dataList = (new LeanMES.SMT.BLL.LoadingType()).GetLoadType(ddlType);
            var dataListNew = new List<PubItemsInfo>
            {
                new PubItemsInfo {
                    ItemName="全部",
                    ItemValue="-1"
                }
            };
            dataListNew.AddRange(dataList);
            ddlLoadType.DataSource = dataListNew;
            ddlLoadType.DataTextField = "ItemName";
            ddlLoadType.DataValueField = "ItemValue";
            ddlLoadType.DataBind();
        }


    }
}