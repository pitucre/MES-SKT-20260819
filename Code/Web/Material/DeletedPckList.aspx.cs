using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.Material
{
    public partial class DeletedPckList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "Pkd_pk";


            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            string sn = this.txtPckpd.Value;
            if (sn != "*")
            {
                string cmdt = " ( Pkd_pk = '" + sn + "' or pkd_wo_nbr = '" + sn + "')";
                searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? cmdt : " and " + cmdt;
            }
            else
            {
                searchSettings.AddCondition("Pkd_pk", sn);
            }

                    

            this.Master.SearchSettings = searchSettings;

            this.GridView1.PageIndex = 0;

            //删除
            if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "reuse")
            {
                string idString = Request.Form["hdnIdString"].ToString();
                try
                {
                    (new MaterialUnit()).ReUsePickingList(idString, AccountController.GetCurrentUser().UserName);
                    this.ClientScript.RegisterClientScriptBlock(this.GetType(), "refresh", "alert('"+"Resources.Messages.ReUsePckSuccessful"+"');window.location=location.href;", true);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }
            }

                
            
        }
    }
}