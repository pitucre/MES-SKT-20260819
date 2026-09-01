using System;
using System.Collections.Generic;
using AjaxPro;
using NPOI.SS.Formula.Functions;
using SKT.Common.Model;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;
using System.Data;
using System.IO;
using SKT.LeanMES.SDP.BLL;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Quality
{
    public partial class RMAEdit : BasePage
    {
        public string IsAdd = "新增";
        public string JSon = "ss";
        List<RmaDetailInfo> rmaDetailInfoList = new List<RmaDetailInfo>();
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(RMAEdit));
            var bll = new Rma();
            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);

                if (id > 0)
                {
                    PageData = bll.GetInfo(id);
                    hdRmaId.Value = id.ToString();

                }
                else
                {
                    txtCancelTime.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    try
                    {
                        txtRmaNo.Text = bll.GetRmaNo(-27);
                    }
                    catch (Exception ex)
                    {
                       WebHelper.HandleException("", ex, true);
                    }
                   
                    
                }
            }
        }


        [AjaxMethod]
        public InspectionTypeInfo GetInspectionTypeInf(int id)
        {

            try
            {
                var bll = new InspectionType();
                return bll.GetInfo(id);
            }
            catch (Exception)
            {
                return null;

            }
        }


        [AjaxMethod]
        public void Edit(string jsonStr)
        {

            try
            {
                var bll = new Rma();
                bll.Edit(jsonStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

            }
        }

        [AjaxMethod]
        public List<RmaDetailInfo> GetDetailList(string rmaNo)
        {

            try
            {
                var bll = new Rma();
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.AddCondition(" RmaNo", rmaNo);

                var result = bll.GetAllDetail(0, int.MaxValue, "", searchSettings);
                return result;
            }
            catch (Exception ex)
            {
                return null;

            }
        }

        protected RmaInfo PageData
        {
            set
            {
                this.txtRmaNo.Text = value.RmaNo;
                ddlRmaType.SelectedIndex = value.RTypeId;
                txtCancelTime.Text = value.CancelTime.ToString("yyyy-MM-dd");
                txtNumber.Text = value.Number.ToString();
                txtRemark.Text = value.Remark.ToString();
                hdnItemId.Value = value.MachineTypeId.ToString();
                txtItemCode.Text = value.ItemCode.ToString();
                hdStatus.Value = value.Status.ToString();
                hdnCustomerId.Value = value.CustomerId.ToString();
                txtCustomerName.Text = value.CustomerName;
                if (value.FilePath != null)
                {
                    //this.lblRCCAPath.Text = rcca.Substring(rcca.LastIndexOf("/") + 1, rcca.Length - rcca.LastIndexOf("/") - 1);
                    this.lblRMAPath.Text = String.Format("<A href='{0}' target='_blank' >{1}</a>", value.FilePath, value.FilePath.Substring(value.FilePath.LastIndexOf("/") + 1, value.FilePath.Length - value.FilePath.LastIndexOf("/") - 1)); ;
                    hdnRMAFilePath.Value = value.FilePath;
                }
                if (value.Status != 0)
                {
                    IsAdd = "";
                }



            }
        }


        protected void Upload_Click(object sender, EventArgs e)
        {
            DataTable sNTb;
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
                    return ;
                }

                string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/");

                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
                string filePath = path + "/" + fileBomUrl.FileName;
                this.fileBomUrl.PostedFile.SaveAs(filePath);
                fileBomUrl.PostedFile.InputStream.Close();
                fileBomUrl.PostedFile.InputStream.Dispose();

                // filePath = @"D://产品序号模板.xlsx";
                sNTb = NPOIHelpers.Import(filePath); //SKT.LeanMES.Web.AppCode.Utility.ExcelHelper.QueryExcel(filePath, WebHelper.ExcelConnString);

                if (sNTb != null && sNTb.Rows.Count > 0)
                {
                    for (int i = 0; i < sNTb.Rows.Count; i++)
                    {
                        RmaDetailInfo rmaDetailInfo = new RmaDetailInfo();
                        rmaDetailInfo.SerialNumber = sNTb.Rows[i][0].ToString();
                        rmaDetailInfo.RejectsDesc = sNTb.Rows[i][1].ToString();
                        rmaDetailInfo.Remark = sNTb.Rows[i][2].ToString();
                        rmaDetailInfoList.Add(rmaDetailInfo);
                    }
                }
            }

            //JavaScriptSerializer jss = new JavaScriptSerializer();
            //string strHtml = jss.Serialize(sNTb);

            JSon = UIModel.ToJson(sNTb);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "tempclick", "<script>   test(" + JSon + "); </script>");

            return;
        }


        //[AjaxMethod]
        //public List<RmaDetailInfo> GetSNList()
        //{
            //List<RmaDetailInfo> rmaDetailInfoList = new List<RmaDetailInfo>();
            //RmaDetailInfo rmaDetailInfo = new RmaDetailInfo();

            //if (!fileBomUrl.HasFile)
            //{
            //    WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
            //    return null;
            //}
            //else
            //{
            //    string fileExtension = System.IO.Path.GetExtension(fileBomUrl.PostedFile.FileName).ToLower();
            //    string allowExtension = ".xls";
            //    string allowTwoExtension = ".xlsx";
            //    if (fileExtension != allowExtension && fileExtension != allowTwoExtension)
            //    {
            //        WebHelper.ShowMessage(Resources.Messages.FileTypeError.ToString());
            //        return null;
            //    }

            //    string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/");

            //    if (!Directory.Exists(path))
            //    {
            //        Directory.CreateDirectory(path);
            //    }
            //    string filePath = path + "/" + fileBomUrl.FileName;
            //    this.fileBomUrl.PostedFile.SaveAs(filePath);
            //    fileBomUrl.PostedFile.InputStream.Close();
            //    fileBomUrl.PostedFile.InputStream.Dispose();

            //    // filePath = @"D://产品序号模板.xlsx";
            //    DataTable sNTb = SKT.LeanMES.Web.AppCode.Utility.ExcelHelper.QueryExcel(filePath, WebHelper.ExcelConnString);

            //    if (sNTb != null && sNTb.Rows.Count > 0)
            //    {
            //        for (int i = 0; i < sNTb.Rows.Count; i++)
            //        {
            //            rmaDetailInfo.SerialNumber = sNTb.Rows[i][0].ToString();
            //            rmaDetailInfo.RejectsDesc = sNTb.Rows[i][0].ToString();
            //            rmaDetailInfo.Remark = sNTb.Rows[i][0].ToString();
            //            rmaDetailInfoList.Add(rmaDetailInfo);
            //        }
            //    }



            //}
        //    string s = Son;
        //    return rmaDetailInfoList;
        //}

    }
}