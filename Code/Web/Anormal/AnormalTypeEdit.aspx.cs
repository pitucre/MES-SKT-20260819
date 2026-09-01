using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Anormal.BLL;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Anormal.Model;

namespace SKT.LeanMES.Web.Anormal
{
    public partial class AnormalTypeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetAbnormalInfo();
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxAnormal));
            string UnitId = Request.QueryString["ID"].ToString();
            if (UnitId != null && Convert.ToInt32(UnitId) > 0)
            {
                AnormalType anormalBll = new AnormalType();
                AnormalTypeInfo model = null;
                model = anormalBll.GetInfo(Convert.ToInt32(UnitId));
                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private AnormalTypeInfo PageData
        {
            set
            {
                this.ddlAnormalGroup.SelectedValue = value.AnormalGroupId.ToString();
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtAnormalTypeName.Text = Resources.Buttons.COM_Copy + " - " + value.AnormalTypeName.ToString();
                }
                else
                {
                    this.txtAnormalTypeName.Text = value.AnormalTypeName.ToString();
                }
                this.txtAnormalTypeCode.Text = value.AnormalTypeCode.ToString();
                this.txtDesc.Text = value.Descriptions.ToString();
            }
        }
        /// <summary>
        /// 类型分组绑定
        /// </summary>
        public void GetAbnormalInfo()
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            AnormalGroup groupBll = new AnormalGroup();
            List<AnormalGroupInfo> groupInfo = groupBll.GetAll(0, -1, "AnormalGroupId", searchSettings);
            ddlAnormalGroup.DataSource = groupInfo;
            ddlAnormalGroup.DataTextField = "AnormalGroupName";
            ddlAnormalGroup.DataValueField = "AnormalGroupId";
            ddlAnormalGroup.DataBind();
        }
    }
}