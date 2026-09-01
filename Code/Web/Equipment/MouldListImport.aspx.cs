using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Plan.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldListImport : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPrint));
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
                            dt.Columns[0].ColumnName = "EquipmentCode";
                            dt.Columns[1].ColumnName = "EquipmentName";
                            dt.Columns[2].ColumnName = "CustomName";
                            dt.Columns[3].ColumnName = "SupplierName";
                            dt.Columns[4].ColumnName = "WarehouseLocation";
                            dt.Columns[5].ColumnName = "Company";
                            dt.Columns[6].ColumnName = "FactoryDate";
                            dt.Columns[7].ColumnName = "Model";
                            dt.Columns[8].ColumnName = "StandarLive";
                            dt.Columns[9].ColumnName = "UseCount";
                            dt.Columns[10].ColumnName = "MachineTonnage";
                            dt.Columns[11].ColumnName = "MoldTonnage";
                            dt.Columns[12].ColumnName = "Size";
                            dt.Columns[13].ColumnName = "Matrix";
                            dt.Columns[14].ColumnName = "Cavity";
                            dt.Columns[15].ColumnName = "MoldTimes";
                            dt.Columns[16].ColumnName = "FactoryMouldCode";
                            dt.Columns[17].ColumnName = "FactoryMouldName";
                        }
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

                    VerifyOfflineGRN(dt);
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
        public void VerifyOfflineGRN(DataTable dt)
        {
            List<EquipmentsMoudleInfo> list = null;
            try
            {
                SKT.LeanMES.Equipment.BLL.Equipments bllUnit = new LeanMES.Equipment.BLL.Equipments();
                list = bllUnit.CheckImportEquipmentsMoudle(dt);

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