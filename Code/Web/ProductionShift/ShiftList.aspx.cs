using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.ProductionShift
{
    public partial class ShiftList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ShiftId";
            this.Master.DefaultSortExpression = "ShiftId DESC"; //也可不赋值txtFactoryCode

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ShiftName", Server.HtmlEncode(this.txtShiftName.Value));
            searchSettings.AddCondition("Remark", Server.HtmlEncode(this.txtShiftRemark.Value));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.ProductionShift.BLL.ProductionShift bll = new SKT.LeanMES.ProductionShift.BLL.ProductionShift();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                    }
                }
            }
        }
    }
}