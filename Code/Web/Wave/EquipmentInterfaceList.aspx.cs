using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Wave
{
    public partial class EquipmentInterfaceList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInterfaceManagement));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "CreateTime DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (hdnDeviceType.Value.Trim() != "")
            {
                searchSettings.AddCondition("DeviceType", hdnDeviceType.Value.Trim());
            }
            if (hdnBrandType.Value.Trim() != "")
            {
                searchSettings.AddCondition("BrandType", hdnBrandType.Value.Trim());
            }
            if (hdnSplict.Value != "")
            {
                searchSettings.AddCondition("Split", hdnSplict.Value);
            }
            if (hdnFileType.Value != "")
            {
                searchSettings.AddCondition("FileType", hdnFileType.Value);
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        string id = Request.Form["hdnIdString"].ToString();
                        SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, "DELETE FROM Prod_InterfaceManagementList WHERE ID IN (" + id + ")", null);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {

                        throw;
                    }


                }
            }
        }
    }
}