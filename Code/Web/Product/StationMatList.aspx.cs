using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Product.BLL;

namespace SKT.LeanMES.Web.Product
{
    public partial class StationMatList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {          
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxProduct));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "StationMatId";
            this.Master.DefaultSortExpression = "StationMatId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("Station", txtStationName.Text.Trim().Replace("'", "''"));
            searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim().Replace("'", "''"));

            if (txtCategoryOne.Text.Trim()!="")
            {
                searchSettings.AddCondition("CategoryOne", txtCategoryOne.Text.Trim().Replace("'", "''"));                
            }
            if (txtCategoryTwo.Text.Trim() != "")
            {
                searchSettings.AddCondition("CategoryTwo", txtCategoryTwo.Text.Trim().Replace("'", "''"));
            }
            if (txtCategoryThree.Text.Trim() != "")
            {
                searchSettings.AddCondition("CategoryThree", txtCategoryThree.Text.Trim().Replace("'", "''"));
            }

            this.Master.SearchSettings = searchSettings;
            
            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.Product.BLL.StationMateriel bll = new SKT.LeanMES.Product.BLL.StationMateriel();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }

            }

        }        
    }


}