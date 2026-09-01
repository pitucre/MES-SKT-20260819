using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using System.Linq;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentCheckOutPlanList : BasePage
    {
        private int IsWarning = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            IsWarning = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "IsWarning")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentCheckOutPlan));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "EquipmentCheckOutPlanId";
            this.Master.DefaultSortExpression = "EquipmentCheckOutPlanId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition(" EqCode",this.txtEqCode.Text.Replace(" ",""));
            searchSettings.AddCondition(" EquipmentName", this.txtEqName.Text.Replace(" ", ""));

            var CheckType = this.txtCheckType.SelectedValue;
            if (CheckType != "-1")
            {
                searchSettings.AddCondition(" CheckType", CheckType);
            }
            var selectWarning = this.selectWarning.Value;
            if(selectWarning!="")
            {
                searchSettings.AddCondition(" IsWarning", selectWarning);

            }
            searchSettings.AddCondition(" CheckOutProjectName", this.txtCheckProject.Text.Replace(" ", ""));
            searchSettings.AddCondition("", "");
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                //if (Request.Form["hdnOperate"].ToLower() == "delete")
                //{
                //    SKT.LeanMES.Equipment.BLL.EquipmentCheckOutPlan bll = new SKT.LeanMES.Equipment.BLL.EquipmentCheckOutPlan();
                //    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                //    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                //}
            }
        }

        #region GridView行绑定
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                EquipmentCheckOutPlanInfo info = e.Row.DataItem as EquipmentCheckOutPlanInfo;

            
                //预警状态为“Warning”的单元格显示为红色填充
                if (info.IsWarning == 1)
                {
                    e.Row.Cells[IsWarning].Text = "Is Warning";
                    e.Row.Cells[IsWarning].BackColor = System.Drawing.Color.Red;
                }
                else
                {
                    e.Row.Cells[IsWarning].Text = "No Warning";

                }
            }
        }
        #endregion

    }
}