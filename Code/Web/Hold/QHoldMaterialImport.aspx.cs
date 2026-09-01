using Newtonsoft.Json;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Hold
{
    public partial class QHoldMaterialImport : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
        }
        #region 上传文件 解析Excel
        /// <summary>
        /// 上传文件 解析Excel
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Upload_Click(object sender, EventArgs e)
        {
            //check the loading list file
            if (!fileBomUrl.HasFile)
            {
                WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
                return;
            }
            else
            {
                string fileExtension = System.IO.Path.GetExtension(fileBomUrl.PostedFile.FileName).ToLower();
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
                if (fileBomUrl.HasFile)
                {
                    string filename = DateTime.Now.ToString("yyyyMMddhhmmss") + System.IO.Path.GetFileName(fileBomUrl.PostedFile.FileName).ToString();
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
                    fileBomUrl.PostedFile.SaveAs(filePath + "\\" + filename); //
                    filename = filePath + "\\" + filename;//

                    //  string strExtension = System.IO.Path.GetExtension(filename);
                    //string strCom = "";
                    //string strExtension = System.IO.Path.GetExtension(fileBomUrl.PostedFile.FileName).ToLower();
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

                  

                    //string StrSql = "SELECT F1 as  SerialNumber,F2 as Cause from  [" + strCom + "] where not(F1='编号')";

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


                    DataTable dt = NPOIHelpers.Import(filename); ;
                    if (dt != null && dt.Rows.Count > 0) {
                        dt.Columns[0].ColumnName = "SerialNumber";
                        dt.Columns[1].ColumnName = "Cause";
                    }


                    VerifyQHoldGrn(dt);
                    //myConn.Close();
                }
            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage(ex.Message.ToString());

            }
        }
        #endregion

        #region 把excel数据呈现在界面上
        /// <summary>
        /// 把excel数据呈现在界面上
        /// </summary>
        /// <param name="dt"></param>
        public void VerifyQHoldGrn(DataTable dt)
        {
            List<HoldInfo> list = null;
            try
            {
                SKT.LeanMES.Quality.BLL.Hold bllUnit = new SKT.LeanMES.Quality.BLL.Hold();
                list = bllUnit.VerifyQHoldGrn(dt);
                string jsonStr = "";
                JavaScriptSerializer jss = new JavaScriptSerializer();
                jss.MaxJsonLength = int.MaxValue;
                jsonStr = jss.Serialize(list);
                //jsonStr = JsonConvert.SerializeObject(dt);

                Page.ClientScript.RegisterStartupScript(this.GetType(), "tempclick", "<script> LoadExcelInfo(" + jsonStr + "); </script>");

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion
    }
}