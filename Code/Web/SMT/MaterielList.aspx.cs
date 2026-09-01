using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SMT
{
    public partial class MaterielList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
                this.Master.SetSearchSettings = true;
                this.Master.PageGridView = this.GridView1;
                this.Master.PageObjectDataSource = this.ObjectDataSource1;
                this.Master.RecordIDField = "ID";
                SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                //searchSettings.ExtensionCondition = " ModelNo ='0' ";

                this.Master.SearchSettings = searchSettings;
                this.GridView1.PageIndex = 0;
            }
            else
            {
                this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
                this.Master.SetSearchSettings = true;
                this.Master.PageGridView = this.GridView1;
                this.Master.PageObjectDataSource = this.ObjectDataSource1;
                this.Master.RecordIDField = "ID";
                SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                searchSettings.AddCondition("ModelNo", this.schModelNo.Text.Trim());
                searchSettings.AddCondition("PartNo", this.schPartNo.Text.Trim());
                
                this.Master.SearchSettings = searchSettings;
                this.GridView1.PageIndex = 0;
            }
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.SMT.BLL.PreAssemblySetting bll = new SKT.LeanMES.SMT.BLL.PreAssemblySetting();
                    try
                    {
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
            }
        }
    }
}