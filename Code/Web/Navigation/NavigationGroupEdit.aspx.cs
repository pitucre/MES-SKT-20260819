using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Navigation.BLL;
using SKT.LeanMES.Navigation.Model;
using SKT.Common.Model;
using System.Data;
using System.IO;

namespace SKT.LeanMES.Web.Navigation
{
    public partial class NavigationGroupEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxNavigation));
           
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SKT.LeanMES.Navigation.BLL.Navigation bll = new LeanMES.Navigation.BLL.Navigation();
                    NavigationInfo model = bll.GetInfo(Convert.ToInt32(idString));
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
            
            

        }       

        private NavigationInfo PageData
        {
            set
            {
                this.txtSequence.Text = value.Sequence.ToString();
                this.lbFileReady.Text = value.Icon.ToString();
                this.txtName.Text = value.NavigationgpName.ToString();
            }
        }

        protected void linkUploadFile_Click(object sender, EventArgs e)
        {
            string filePath = "";
            if (!fileBomUrl.HasFile)
            {
                WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
                return;
            }
            else
            {
                string fileExtension = System.IO.Path.GetExtension(fileBomUrl.PostedFile.FileName).ToLower();
                string allowExtension = ".png";
                if (fileExtension !=allowExtension)
                {
                    WebHelper.ShowMessage(Resources.Messages.FileTypeError.ToString());
                    return;
                }
                string path = Server.MapPath(WebHelper.WebRoot + "/Content/Theme/Metro/Images/Icon");
                if (!Directory.Exists(path))
                {
                   Directory.CreateDirectory(path);
                }
                try
                {
                    filePath = path + "/" + fileBomUrl.FileName;
                    lbFileReady.Text = fileBomUrl.FileName;
                    this.filepaths.Value = filePath;
                    this.fileBomUrl.PostedFile.SaveAs(filePath);
                }
                catch (Exception)
                {

                    throw;
                }
                finally
                {
                    fileBomUrl.PostedFile.InputStream.Close();
                    fileBomUrl.PostedFile.InputStream.Dispose();
                }
                this.filepaths.Value = filePath;

                //this.fileBomUrl.PostedFile.ContentType;
                //fileBomUrl.PostedFile.InputStream.Close();
                //fileBomUrl.PostedFile.InputStream.Dispose();


            }
        }
    } 
}