using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.PieceWage.BLL;

namespace SKT.LeanMES.Web.PieceWage
{
    public partial class PieceWageList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPieceWage));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "PieceWageId";
            this.Master.DefaultSortExpression = "PieceWageId DESC"; //也可不赋值
             
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (this.txtPieceWageNO2.Text != "")
            {
                searchSettings.ExtensionCondition += "NO LIKE '%" + this.txtPieceWageNO2.Text + "%' OR Station LIKE '%" + this.txtPieceWageNO2.Text + "%' OR EquipmentCode LIKE '%" + this.txtPieceWageNO2.Text + "%' OR ItemCode LIKE '%" + this.txtPieceWageNO2.Text + "%' OR CreateBy LIKE '%" + this.txtPieceWageNO2.Text + "%' OR CreateDateTime LIKE '%" + this.txtPieceWageNO2.Text + "%'  OR Remark LIKE '%" + this.txtPieceWageNO2.Text + "%'";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.PieceWage.BLL.PieceWage bll = new SKT.LeanMES.PieceWage.BLL.PieceWage();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }

    }
}