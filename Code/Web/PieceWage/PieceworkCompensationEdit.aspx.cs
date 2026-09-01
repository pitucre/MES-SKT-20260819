using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.PieceWage.BLL;
using SKT.LeanMES.PieceWage.Model;
namespace SKT.LeanMES.Web.PieceWage
{
    public partial class PieceworkCompensationEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPieceWage));
            if (!this.IsPostBack)
            {

                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.PieceWage.BLL.PieceworkCompensation()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private PieceworkCompensationInfo PageData
        {
            set
            {
                this.txtPieceCountingTime.Text=value.PieceCountingTime.ToString();
                this.txtUserName.Text = value.Username;
                this.hdnUserId.Value = Convert.ToString(value.UserID);
                this.txtwage.Text = Convert.ToString(value.Wage);
                this.txtRemark.Text = value.Remark;

            }
        }
    }
}