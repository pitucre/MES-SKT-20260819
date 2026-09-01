using System;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class ItemMouldRelationEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxItemMouldRelation));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    
                    this.PageData = (new ItemMouldRelation()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }



        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ItemMouldRelationInfo PageData
        {
            set
            {
                this.txtMouldName.Text = value.BomName;
                this.HiddenItemId.Value = value.ItemId.ToString();
                this.txtItemName.Text = "(" + value.ItemCode + ")" + value.ItemName;
                this.HiddenMouldBomId.Value = value.MouldId.ToString();
                this.txtRemark.Text = value.Remark;

            }
        }
    }
}