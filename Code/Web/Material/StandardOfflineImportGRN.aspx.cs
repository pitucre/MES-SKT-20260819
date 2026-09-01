using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class StandardOfflineImportGRN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxMaterial));
        }

        #region 上传文件 解析Excel
        /// <summary>
        /// 上传文件 解析Excel
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void linkUploadFile_Click(object sender, EventArgs e)
        {
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
                //this.txtPickListName.Text = System.IO.Path.GetFileName(fuPickList.PostedFile.FileName).ToString().Substring(0, System.IO.Path.GetFileName(fuPickList.PostedFile.FileName).ToString().LastIndexOf("."));

            }

            try
            {
                if (fuPickList.HasFile)
                {
                    string filename = DateTime.Now.ToString("yyyyMMddhhmmss") + System.IO.Path.GetFileName(fuPickList.PostedFile.FileName).ToString();
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
                    fuPickList.PostedFile.SaveAs(filePath + "\\" + filename); //
                    filename = filePath + "\\" + filename;//

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

                    //DataTable dtds = myConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                    //strCom = dtds.Rows[0][2].ToString().Trim();
                    ///**/

                    //string StrSql = @"SELECT  F1 as  GRN,F2 as Qty,F3 as  PoCode ,F4 as VendorCode,F5 as VendorName
                    //                  ,F6 as ItemCode,F7 as RowID,F8 as LotCode,F9 as DateCode,F10 as WeekCode,F11 as MPN
                    //                from  [" + strCom + "]  where not( F1='' and F2='' and F3='' and F4='' and F5='' and F6='' and F7='' and F8='' and F9=''  or F1='GRN') ";

                    ////string StrSql = "SELECT * from  [" + strCom + "]";

                    //OleDbDataAdapter myadapter = new OleDbDataAdapter(StrSql, myConn);
                    //DataSet ds = new DataSet();
                    //try
                    //{
                    //    myadapter.Fill(ds, "[" + strCom + "]");
                    //}
                    //catch (Exception ex)
                    //{
                    //    WebHelper.ShowMessage(ex.Message.ToString());
                    //    return;
                    //}


                    DataTable dt = NPOIHelpers.Import(filename); //ds.Tables[0];
                    try
                    {
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            dt.Columns[0].ColumnName = "GRN";
                            dt.Columns[1].ColumnName = "Qty";
                            dt.Columns[2].ColumnName = "PoCode";
                            dt.Columns[3].ColumnName = "VendorCode";
                            dt.Columns[4].ColumnName = "VendorName";
                            dt.Columns[5].ColumnName = "ItemCode";
                            dt.Columns[6].ColumnName = "RowID";
                            dt.Columns[7].ColumnName = "LotCode";
                            dt.Columns[8].ColumnName = "DateCode";
                            dt.Columns[9].ColumnName = "WeekCode";
                            dt.Columns[10].ColumnName = "MPN";
                        }
                    }
                    catch (Exception ex) {
                          WebHelper.ShowMessage(ex.Message.ToString());
                          return;
                    }

                    VerifyOfflineGRN(dt);
                    //myConn.Close();
                }
            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage(ex.Message.ToString());
                //GridView1.DataSource = null;
                //GridView1.DataBind();
                //this.txtPickListName.Text = ex.Message.ToString();

            }
        }
        #endregion

        #region 保存数据到数据库
        /// <summary>
        /// 保存数据到数据库
        /// </summary>
        /// <param name="dt"></param>
        public void VerifyOfflineGRN(DataTable dt)
        {
            List<OfflineGRNInfo> list = null;
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                list = bllUnit.VerifyOfflineGRN(dt);

                string jsonStr = "";

                JavaScriptSerializer jss = new JavaScriptSerializer();
                jss.MaxJsonLength = int.MaxValue;
                jsonStr = jss.Serialize(list);

                Page.ClientScript.RegisterStartupScript(this.GetType(), "tempclick", "<script> ShowOfflineGRN(" + jsonStr + "); </script>");

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion
    }
}