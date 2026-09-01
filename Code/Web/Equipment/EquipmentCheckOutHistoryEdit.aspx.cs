using System;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using System.IO;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentCheckOutHistoryEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentCheckOutHistory));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new EquipmentCheckOutPlan()).GetInfo(Convert.ToInt32(idString));
                }
                txtInspectionTime.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            }
        }
        private EquipmentCheckOutPlanInfo PageData
        {
            set
            {
              
                labeqcode.Text = value.EqCode;
                //labType.Text = value.CheckTypeName;
                labproject.Text = value.CheckProjectName;
                //labcyle.Text = value.CycleTypeName;
            }
        }
        protected void linkUploadFile_Click(object sender, EventArgs e)
        {
            string filePath = "";
            if (!fuLoadingList.HasFile)
            {
                WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
                return;
            }

            string fileExtension = System.IO.Path.GetExtension(fuLoadingList.PostedFile.FileName).ToLower();


            string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/EQFile/CheckOutFile");

            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            try
            {
                filePath = path + "/" + fuLoadingList.FileName;
                lbFileReady.Text = fuLoadingList.FileName;
                this.fuLoadingList.PostedFile.SaveAs(filePath);
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                fuLoadingList.PostedFile.InputStream.Close();
                fuLoadingList.PostedFile.InputStream.Dispose();
            }
        }
    }
}