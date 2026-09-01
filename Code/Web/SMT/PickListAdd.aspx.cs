using System;
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
using System.IO;
using System.Text.RegularExpressions;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.SMT
{
    public partial class PickListAdd : BasePage
    {

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
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServicesPickList));
            int groudId = Convert.ToInt32(Request.QueryString["ID"]);
            if (!IsPostBack)
            {
                GetLoadStatus();
            }
            if (groudId > -1)
            {
                PickListInfo model = null;
                SKT.LeanMES.SMT.BLL.PickList bll = new SKT.LeanMES.SMT.BLL.PickList();
                model = bll.GetInfo(groudId);
                if (model != null)
                {
                    this.PageData = model;
                }
            }

            if (!this.IsPostBack)
            {
                GetLoadStatus();
            }

        }

        protected void linkUploadFile_Click(object sender, EventArgs e)
        {
            this.txtModelName.Text = this.hdnItemName.Value;

            //check the loading list file
            if (!fuPickList.HasFile)
            {
                WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
                return;
            }
            else
            {
                string fileExtension = System.IO.Path.GetExtension(fuPickList.PostedFile.FileName).ToLower();
                string allowExtension = ".xls";
                string allowTwoExtension = ".xlsx";
                if (fileExtension != allowExtension && fileExtension != allowTwoExtension)
                {
                    WebHelper.ShowMessage(Resources.Messages.FileTypeError.ToString());
                    return;
                }
                this.txtPickListName.Text = System.IO.Path.GetFileName(fuPickList.PostedFile.FileName).ToString().Substring(0, System.IO.Path.GetFileName(fuPickList.PostedFile.FileName).ToString().LastIndexOf("."));

            }

            try
            {
                if (fuPickList.HasFile)
                {
                    string filename = DateTime.Now.ToString("yyyyMMddhhmmss") + System.IO.Path.GetFileName(fuPickList.PostedFile.FileName).ToString();
                    //add by Alen 2014-12-31 --begin
                    string filePath = Server.MapPath("..\\TempFile");
                    if (!Directory.Exists(filePath))
                    {
                        try
                        {
                            Directory.CreateDirectory(filePath);
                        }
                        catch (Exception)
                        {
                            throw new ApplicationException("Create folder failed.");
                        }
                    }
                    //--end
                    fuPickList.PostedFile.SaveAs(filePath + "\\" + filename); //modify by Alen 2014-12-31
                    filename = filePath + "\\" + filename;//modify by Alen 2014-12-31

                    //  string strExtension = System.IO.Path.GetExtension(filename);
                    //string strCom = "";
                    //string strExtension = System.IO.Path.GetExtension(fuPickList.PostedFile.FileName).ToLower();
                    ///*  if (strExtension == ".xls")
                    //  {
                    //      strCom = GetSheetName(filename);
                    //  }*/
                    //string strCon = "";
                    //switch (strExtension)
                    //{
                    //    case ".xls":
                    //        strCon = " Provider = Microsoft.Jet.OLEDB.4.0 ; Data Source =" + filename + ";Extended Properties='Excel 8.0; HDR=NO; IMEX=1'";
                    //        break;
                    //    case ".xlsx":
                    //        strCon = " Provider = Microsoft.ACE.OLEDB.12.0 ; Data Source =" + filename + ";Extended Properties='Excel 12.0; HDR=NO; IMEX=1'";
                    //        break;
                    //    default:
                    //        strCon = "";
                    //        break;
                    //}


                    //OleDbConnection myConn = new OleDbConnection(strCon);
                    //myConn.Open();
                    /*add by weixia on 2016.4.8获取第一个导入Excel的名称*/
                     DataTable dt = NPOIHelpers.Import(filename);/*myConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);*/
                    try
                    {
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            dt.Columns[0].ColumnName = "产品编码";
                        }
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message.ToString());
                        return;
                    }


                    string XLSerror = CheckXLSFormat(dt);

                    //if (XLSerror != String.Empty)
                    //{
                    //    WebHelper.ShowMessage(XLSerror);
                    //    GridView1.DataSource = null;
                    //    GridView1.DataBind();
                    //    this.txtPickListName.Text = XLSerror;
                    //    return;
                    //}

                    //ds.Tables[0].Rows.RemoveAt(0);//删除XLS 表头信息
                    string Machine = String.Empty;
                    string Qty = "";
                    string station = String.Empty;
                    for (int r = 0; r < dt.Rows.Count; r++) //循环所有行 
                    {
                        if(dt.Rows[r][0].ToString().Trim()== "" && dt.Rows[r][1].ToString().Trim()=="" && dt.Rows[r][2].ToString().Trim() == "")
                        {
                            continue;
                        }

                            if (dt.Rows[r][0].ToString().Trim() == "")
                        {
                            WebHelper.ShowMessage("产品编码不能为空!");                           
                            return;
                        }

                        if(dt.Rows[r][1].ToString().Trim() == "")
                        {
                            WebHelper.ShowMessage("数量不能为空!");
                            return;
                        }
                        decimal changQty = 0;
                        if (!decimal.TryParse(dt.Rows[r][1].ToString().Trim(), out changQty))
                        { 
                            WebHelper.ShowMessage("数量需为数字类型!");
                            return;
                        }
                        int group = 0;
                        if (!int.TryParse(dt.Rows[r][2].ToString().Trim(), out group))
                        {
                            WebHelper.ShowMessage("扣料组需为数字类型!");
                            return;
                        }
                        Machine = (dt.Rows[r][0].ToString().Trim() != "") ? dt.Rows[r][0].ToString().Trim() : Machine;
                        Qty = (dt.Rows[r][1].ToString().Trim() != "") ? dt.Rows[r][1].ToString().Trim() : Qty;
                        station = (dt.Rows[r][2].ToString().Trim() != "") ? dt.Rows[r][2].ToString().Trim() : station;
                        string machineName = Regex.Replace(Machine, @"\n\w{1,3}", "", RegexOptions.IgnoreCase | RegexOptions.Compiled);
                        //   string head = Regex.Replace(Machine, @"[^\n]+\n", "", RegexOptions.IgnoreCase | RegexOptions.Compiled);
                        Qty = Regex.Replace(Qty, @"[^\n]+\n", "", RegexOptions.IgnoreCase | RegexOptions.Compiled);
                        station = Regex.Replace(station, @"[^\n]+\n", "", RegexOptions.IgnoreCase | RegexOptions.Compiled);
                        //    string Table = GetHead(head);
                        //    string SlotNo = LineName + machineName + Table + dt.Rows[r][2].ToString();

                        dt.Rows[r][0] = Machine;
                        dt.Rows[r][1] = Qty;
                        dt.Rows[r][2] = station;
                    }

                    List<string> ListKeyValue = new List<string>();
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                   // myConn.Close();
                }
            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage(ex.Message.ToString());
                GridView1.DataSource = null;
                GridView1.DataBind();
                this.txtPickListName.Text = ex.Message.ToString();

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

        /*Check xls columns*/
        static string CheckXLSFormat(DataTable XLS)
        {
            string error = String.Empty;
            /* if (!XLS.Columns.Contains("Machine"))
             {
                 error = "XLS格式错误，缺少Machine字段";
             }
             if (!XLS.Columns.Contains("Pos"))
             {
                 error = "XLS格式错误，缺少Pos字段";
             }
             if (!XLS.Columns.Contains("Slot"))
             {
                 error = "XLS格式错误，缺少Slot字段";
             }
             if (!XLS.Columns.Contains("PN"))
             {
                 error = "XLS格式错误，缺少PN字段";
             }*/
            return error;
        }

        protected void ButSave_Click(object sender, EventArgs e)
        {
            this.txtModelName.Text = this.hdnItemName.Value;
            if (GridView1.Rows.Count == 0)
            {
                WebHelper.ShowMessage(Resources.Messages.NoPickListDetail);
                return;
            }
            try
            {
                DataTable GridDT = GridView2DataTable(GridView1);
                for (int i = 0; i < GridDT.Rows.Count; i++)
                {
                    if (string.IsNullOrEmpty(GridDT.Rows[i][1].ToString()))
                    {
                        WebHelper.ShowMessage("物料有空值");
                        return;
                    }
                    if (string.IsNullOrEmpty(GridDT.Rows[i][2].ToString()))
                    {
                        WebHelper.ShowMessage("数量有空值");
                        return;
                    }
                    else
                    {
                        try
                        {
                            decimal.Parse(GridDT.Rows[i][2].ToString());
                        }
                        catch (Exception)
                        {
                            WebHelper.ShowMessage("数量栏位有非法字符");
                            return;
                        }
                    }
                    if (string.IsNullOrEmpty(GridDT.Rows[i][3].ToString()))
                    {
                        WebHelper.ShowMessage("扣料组编码有空值");
                        return;
                    }
                    else
                    {
                        try
                        {
                            int.Parse(GridDT.Rows[i][3].ToString());
                        }
                        catch (Exception)
                        {
                            WebHelper.ShowMessage("扣料组编码栏位有非法字符");
                            return;
                        }
                    }
                    if (string.IsNullOrEmpty(GridDT.Rows[i][4].ToString()))
                    {
                        WebHelper.ShowMessage("扣料组描述有空值");
                        return;
                    }
                }
                int Emsg = 0;

                int ItemId = Convert.ToInt32(hdnItemId.Value.ToString());
                string SetupName = this.txtPickListName.Text.ToString();

                string Revision = this.txtRev.Text.ToString();

                if (ItemId == -1)
                {
                    WebHelper.ShowMessage(Resources.Messages.ItemsNameEmpty);
                    return;
                }
                if (SetupName == "")
                {
                    WebHelper.ShowMessage(Resources.Messages.SetupNameEmpty);
                    return;
                }
                if (Revision == "")
                {
                    WebHelper.ShowMessage(Resources.Messages.RevisionEmpty);
                    return;
                }

                DateTime CreationTime = DateTime.Now;
                PickListInfo LLinfo = new PickListInfo();
                LLinfo.ItemID = ItemId;
                LLinfo.ListName = SetupName;
                LLinfo.CustomerID = -1;
                LLinfo.Revision = Revision;
                LLinfo.StationID = -1;
                LLinfo.LineID = -1;
                LLinfo.IsFullSet = this.cbFullSet.Checked;
                LLinfo.Remark = this.txtRemark.Text;
                LLinfo.CreateBy = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;

                SKT.LeanMES.SMT.BLL.PickList bll = new LeanMES.SMT.BLL.PickList();
                Emsg = bll.SavePickListAdd(LLinfo, GridDT);

                if (Emsg > 0)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('导入成功'); parent.window.UpdateList();</script>");
                }
            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage(ex.Message.ToString());
            }
        }


        /// <summary>
        /// 从GridView的数据生成DataTable
        /// </summary>
        /// <param name="gv">GridView对象</param>
        public static DataTable GridView2DataTable(GridView gv)
        {
            DataTable table = new DataTable();
            int rowIndex = 0;
            List<string> cols = new List<string>();
            if (!gv.ShowHeader && gv.Columns.Count == 0)
            {
                return table;
            }
            GridViewRow headerRow = gv.HeaderRow;
            int columnCount = headerRow.Cells.Count;
            for (int i = 0; i < columnCount; i++)
            {
                string text = GetCellText(headerRow.Cells[i]);
                cols.Add(text);
            }
            foreach (GridViewRow r in gv.Rows)
            {
                if (r.RowType == DataControlRowType.DataRow)
                {
                    DataRow row = table.NewRow();
                    int j = 0;
                    for (int i = 0; i < columnCount; i++)
                    {
                        string text = GetCellText(r.Cells[i]);
                        if (!String.IsNullOrEmpty(text))
                        {
                            if (rowIndex == 0)
                            {
                                string columnName = cols[i];
                                if (String.IsNullOrEmpty(columnName))
                                {
                                    continue;
                                }
                                if (table.Columns.Contains(columnName))
                                {
                                    continue;
                                }
                                DataColumn dc = table.Columns.Add();
                                dc.ColumnName = columnName;
                                dc.DataType = typeof(string);
                            }
                            row[j] = text.Replace("&nbsp;","");
                            j++;
                        }
                    }
                    rowIndex++;
                    table.Rows.Add(row);
                }
            }
            return table;
        }

        public static string GetCellText(TableCell cell)
        {
            string text = cell.Text;
            if (!string.IsNullOrEmpty(text))
            {
                return text;
            }
            foreach (Control control in cell.Controls)
            {
                if (control != null && control is IButtonControl)
                {
                    IButtonControl btn = control as IButtonControl;
                    text = btn.Text.Replace("\r\n", "").Trim();
                    break;
                }
                if (control != null && control is ITextControl)
                {
                    LiteralControl lc = control as LiteralControl;
                    if (lc != null)
                    {
                        continue;
                    }
                    ITextControl l = control as ITextControl;

                    text = l.Text.Replace("\r\n", "").Trim();
                    break;
                }
            }
            return text;
        }

        private bool IsInteger(string s)
        {
            try
            {
                int i = Convert.ToInt32(s);
            }
            catch
            {
                return false;
            }
            return true;
        }

        private PickListInfo PageData
        {
            set
            {

            }
        }

        /***获取状态***/
        public void GetLoadStatus()
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            SKT.LeanMES.SMT.BLL.LIST_Status status = new SKT.LeanMES.SMT.BLL.LIST_Status();
            List<SKT.LeanMES.SMT.Model.LIST_StatusInfo> statusInfo = status.GetAll(0, 100, "id", searchSettings);
            statusInfo = statusInfo.Where(a => a.Id == 0).ToList();
            ddlStatus.DataSource = statusInfo;
            ddlStatus.DataTextField = "Description";
            ddlStatus.DataValueField = "id";
            ddlStatus.DataBind();
        }

        /// <summary>
        /// 给定一个page，一个消息字符串。在/form标记前加入客户端弹出框脚本。
        /// </summary>
        /// <param name="page"></param>
        /// <param name="info"></param>
        public static void Alert(System.Web.UI.Page page, string info)
        {
            string scriptstr = string.Format("<script type='text/javascript'>alert('{0}');window.closed()</script>", info);

            if (!page.ClientScript.IsStartupScriptRegistered(page.GetType(), "clientScriptAlert"))
            {
                page.ClientScript.RegisterStartupScript(page.GetType(), "clientScriptAlert", scriptstr);
            }
        }
    }
}