using SKT.LeanMES.Warehouse.Model;
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

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseLocationImport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxPrint));
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

                    DataTable dt = NPOIHelpers.Import(filename); ;
                    try
                    {
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            dt.Columns[0].ColumnName = "CWhCode";
                            dt.Columns[1].ColumnName = "CStoreCode";
                            dt.Columns[2].ColumnName = "CPosCode";
                            dt.Columns[3].ColumnName = "CStoreName";
                            dt.Columns[4].ColumnName = "CPosName";
                            dt.Columns[5].ColumnName = "LocationType";
                            dt.Columns[6].ColumnName = "Remark";
                            dt.Columns[7].ColumnName = "ProductIsOnly";
                            dt.Columns[8].ColumnName = "InOrder";
                            dt.Columns[9].ColumnName = "AGVLandmarkCode";
                            dt.Columns[10].ColumnName = "IsUniPakPos";
                        }
                        dt.Columns.Add(new DataColumn()
                        {
                            ColumnName = "ShiftCode",
                            DataType = typeof(string)
                        });
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message.ToString());
                        return;
                    }


                    int row = dt.Rows.Count;
                    if (row == 0)
                    {
                        WebHelper.ShowMessage("上传没有数据，请录入！");
                    }
                    ////去除标题行
                    //if (row > 1)
                    //{
                    //    dt.Rows.Remove(dt.Rows[0]);
                    //}
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
            List<WarehouseLocationInfo> list = null;
            try
            {
                SKT.LeanMES.Warehouse.BLL.Warehouse bllUnit = new LeanMES.Warehouse.BLL.Warehouse();
                list = bllUnit.checkExoportWareLocation(dt);

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