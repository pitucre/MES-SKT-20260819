using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Turnover.BLL;
using SKT.LeanMES.Turnover.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Turnover
{
    public partial class TurnoverGroupEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxTurnover));

            if (!this.IsPostBack)
            {
                GetInfo();

                string IdStr = Request.QueryString["ID"];
                int Id = Convert.ToInt32(IdStr);

                if (Id > 0)
                {
                    TurnoverGroup bll = new TurnoverGroup();
                    TurnoverGroupInfo model = null;
                    model = bll.GetInfo(Convert.ToInt32(Id));
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }

        /***绑定下拉框数据**/
        public void GetInfo()
        {
            /****获取周转箱类型********/
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            TurnoverType bll = new TurnoverType();
            List<TurnoverTypeInfo> model = bll.GetAll(0, 100, "TurnoverTypeId", searchSettings);
            ddlTurnoverType.DataSource = model;
            ddlTurnoverType.DataTextField = "TurnoverTypeName";
            ddlTurnoverType.DataValueField = "TurnoverTypeId";
            ddlTurnoverType.DataBind();

            ddlTurnoverType.Items.Insert(0, new ListItem("选择周转箱类型", "-1"));
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private TurnoverGroupInfo PageData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtTurnoverGroupName.Text = Resources.Buttons.COM_Copy + " - " + value.TurnoverGroupName;
                }
                else
                {
                    this.txtTurnoverGroupName.Text = value.TurnoverGroupName;
                }
                this.txtMinStowQty.Text = value.MinQty.ToString();
                this.txtMaxStowQty.Text = value.MaxQty.ToString();
                this.ddlTurnoverType.SelectedValue = value.TurnoverTypeId.ToString();
                this.hdnItemId.Value = value.ItemId.ToString();
                this.txtItem.Text = value.ItemName;
            }
        }
    }
}