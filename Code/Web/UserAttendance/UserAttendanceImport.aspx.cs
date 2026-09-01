using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.OleDb;
using System.Data;

namespace SKT.LeanMES.Web.UserAttendance
{
    public partial class UserAttendanceImport : System.Web.UI.Page
    {
        static string CheckXLSFormat(DataTable XLS)
        {
            string error = String.Empty;
            if (!XLS.Columns.Contains("Date"))
            {
                error = "XLS格式错误，缺少Date字段";
            }
            return error;
        }

        protected void ButSave_Click1(object sender, EventArgs e)
        {
            int count = 0;
            if (!fuLoadingList.HasFile)
            {
                this.lblMesg.Text = "上传路径不能为空";
                return;
            }
            else
            {
                string fileExtension = System.IO.Path.GetExtension(fuLoadingList.PostedFile.FileName).ToLower();
                string allowExtension = ".xls";
                string allowTwoExtension = ".xlsx";
                if (fileExtension != allowExtension && fileExtension != allowTwoExtension)
                {
                    this.lblMesg.Text = Resources.Messages.FileTypeError.ToString();
                    return;
                }
            }
            try
            {
                if (fuLoadingList.HasFile)
                {
                    string filename = DateTime.Now.ToString("yyyyMMddhhmmss") + System.IO.Path.GetFileName(fuLoadingList.PostedFile.FileName).ToString();
                    //add by Alen 2014-12-31 --begin
                    string filePath = System.Web.HttpContext.Current.Server.MapPath("..\\TempFile");
                    if (!Directory.Exists(filePath))
                    {
                        try
                        {
                            Directory.CreateDirectory(filePath);
                        }
                        catch (Exception)
                        {
                            this.lblMesg.Text = "Create folder failed.";
                        }
                    }
                    //--end
                    fuLoadingList.PostedFile.SaveAs(filePath + "\\" + filename); //modify by Alen 2014-12-31
                    filename = filePath + "\\" + filename;//modify by Alen 2014-12-31
                    string strExtension = System.IO.Path.GetExtension(fuLoadingList.PostedFile.FileName).ToLower();
                    string strCon = "";
                    switch (strExtension)
                    {
                        case ".xls":
                            strCon = " Provider = Microsoft.Jet.OLEDB.4.0 ; Data Source =" + filename + ";Extended Properties='Excel 8.0; HDR=Yes; IMEX=1'";
                            break;
                        case ".xlsx":
                            strCon = " Provider = Microsoft.ACE.OLEDB.12.0 ; Data Source =" + filename + ";Extended Properties='Excel 12.0; HDR=Yes; IMEX=1'";
                            break;
                        default:
                            strCon = "";
                            break;
                    }

                    OleDbConnection myConn = new OleDbConnection(strCon);
                    myConn.Open();
                    /*add by weixia on 2016.4.8获取第一个导入Excel的名称*/
                    DataTable dtds = myConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                    if (dtds != null && dtds.Rows.Count > 0)
                    {
                        string strCom = dtds.Rows[0][2].ToString().Trim();
                        /**/

                        string StrSql = "SELECT UserName,Date,Category,Department,Duty,EntryDate,IsBecome,Shift,WorkDay,WorkTime,UsualTime,UsualOverTime,WeekendOverTime,Remark from  [" + strCom + "]  ";

                        //,线别 as LineName
                        OleDbDataAdapter myadapter = new OleDbDataAdapter(StrSql, myConn);
                        DataSet ds = new DataSet();
                        myadapter.Fill(ds, "[" + strCom + "]");

                        DataTable dt = ds.Tables[0];
                        string XLSerror = CheckXLSFormat(dt);
                        if (XLSerror != String.Empty)
                        {
                            this.lblMesg.Text = XLSerror;
                            return;
                        }
                        SKT.LeanMES.UserAttendance.BLL.UserAttendance bll = new SKT.LeanMES.UserAttendance.BLL.UserAttendance();
                        string userName = AccountController.GetCurrentUser().UserName;
                        DataTable dts = new DataTable("UserAttendance");
                        DataColumn dc = null;
                        dc = dts.Columns.Add("UserName", Type.GetType("System.String"));
                        dc = dts.Columns.Add("Date", Type.GetType("System.String"));
                        dc = dts.Columns.Add("Category", Type.GetType("System.String"));
                        dc = dts.Columns.Add("Department", Type.GetType("System.String"));
                        dc = dts.Columns.Add("Duty", Type.GetType("System.String"));
                        dc = dts.Columns.Add("EntryDate", Type.GetType("System.String"));
                        dc = dts.Columns.Add("IsBecome", Type.GetType("System.String"));
                        dc = dts.Columns.Add("Shift", Type.GetType("System.String"));
                        dc = dts.Columns.Add("WorkDay", Type.GetType("System.String"));
                        dc = dts.Columns.Add("WorkTime", Type.GetType("System.String"));
                        dc = dts.Columns.Add("UsualTime", Type.GetType("System.String"));
                        dc = dts.Columns.Add("UsualOverTime", Type.GetType("System.String"));
                        dc = dts.Columns.Add("WeekendOverTime", Type.GetType("System.String"));
                        dc = dts.Columns.Add("Remark", Type.GetType("System.String"));
                        DataRow dr;
                        List<string> list = new List<string>();
                        //删除空白行
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if (list.Contains(dt.Rows[i][0].ToString()))
                            {
                                continue;
                            }
                            if (dt.Rows[i][0].ToString() != "")
                            {
                                dr = dts.NewRow();
                                //把查询到的数据添加到新的DataTable中
                                dr["UserName"] = dt.Rows[i][0].ToString();
                                dr["Date"] = dt.Rows[i][1].ToString();
                                dr["Category"] = dt.Rows[i][2].ToString();
                                dr["Department"] = dt.Rows[i][3].ToString();
                                dr["Duty"] = dt.Rows[i][4].ToString();
                                dr["EntryDate"] = dt.Rows[i][5].ToString();
                                dr["IsBecome"] = dt.Rows[i][6].ToString();
                                dr["Shift"] = dt.Rows[i][7].ToString();
                                dr["WorkDay"] = dt.Rows[i][8].ToString();
                                dr["WorkTime"] = dt.Rows[i][9].ToString();
                                dr["UsualTime"] = dt.Rows[i][10].ToString();
                                dr["UsualOverTime"] = dt.Rows[i][11].ToString();
                                dr["WeekendOverTime"] = dt.Rows[i][12].ToString();
                                dr["Remark"] = dt.Rows[i][13].ToString();
                                dts.Rows.Add(dr);
                                list.Add(dt.Rows[i][0].ToString());
                            }
                        }
                        try
                        {
                            count =bll.Import(dts, userName);
                            if (count >= 0)
                            {
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('导入成功'); parent.window.UpdateList();</script>");
                            }
                            myConn.Close();
                        }
                        catch (Exception ex)
                        {
                            WebHelper.ShowMessage(ex.Message);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                this.lblMesg.Text = ex.Message.ToString();
                WebHelper.HandleException(ex);
                return;
            }

        }
    }
}