using SKT.LeanMES.AccessoryManagement.BLL;
using SKT.LeanMES.AccessoryManagement.Model;
using SKT.LeanMES.ProdUnit.BLL;
using SKT.LeanMES.ProdUnit.Model;
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

namespace SKT.LeanMES.Web.AccessoryManagement
{
    public partial class AccessoryAndItemRelationImport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        #region 上传文件 解析Excel
        /// <summary>
        /// 上传文件 解析Excel
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void linkUploadFile_Click(object sender, EventArgs e)
        {
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

                    fuPickList.PostedFile.SaveAs(filePath + "\\" + filename); //
                    filename = filePath + "\\" + filename;//


                    //string strCom = "";
                    //string strExtension = System.IO.Path.GetExtension(fuPickList.PostedFile.FileName).ToLower();

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

                    //string Column = "F1 as NumberID,";
                    //Column += "F2 as ItemCode,";
                    //Column += "F3 as AccessoryCode";

                    //string StrSql = "SELECT " + Column + " from  [" + strCom + "]  where not(F1='编号') ";

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

                    DataTable dt = NPOIHelpers.Import(filename);// ds.Tables[0];
                    try
                    {
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            dt.Columns[0].ColumnName = "NumberID";
                            dt.Columns[1].ColumnName = "ItemCode";
                            dt.Columns[2].ColumnName = "AccessoryCode";
                        }
                    }
                    catch (Exception ex) {
                        WebHelper.ShowMessage(ex.Message.ToString());
                        return;
                    }
                    SavePackRelationImport(dt);
                   // myConn.Close();
                }
            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage(ex.Message.ToString());
            }
        }
        #endregion

        #region 保存数据到数据库
        /// <summary>
        /// 保存数据到数据库
        /// </summary>
        /// <param name="dt"></param>
        public void SavePackRelationImport(DataTable dt)
        {
            List<AccessoryItemRelationImportresRes> list = null;
            try
            {
                AccessoryItemRelation bll = new AccessoryItemRelation();


                list = bll.SaveAccessoryItemRelationImport(dt, AccountController.GetCurrentUser().UserName);
                string jsonStr = "";
                JavaScriptSerializer jss = new JavaScriptSerializer();
                jss.MaxJsonLength = int.MaxValue;
                jsonStr = jss.Serialize(list);

                Page.ClientScript.RegisterStartupScript(this.GetType(), "tempclick", "<script> ShowErrorPackRelation(" + jsonStr + "); </script>");

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion
    }
}