using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using SKT.LeanMES.MSD.BLL;
using SKT.LeanMES.MSD.Model;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;

namespace SKT.LeanMES.Web.MSD
{
    public partial class MsdMaterielEdit : BasePage
    {
        public Int32 ItemId;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMSD));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MsdMaterielEdit));
            if (!this.IsPostBack)
            {
                string idStr = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
                int.TryParse(idStr, out ItemId);
                BindMSL();
                if (ItemId != -1)
                {
                    ItemInfo model = (new Item()).GetInfo(ItemId);
                    this.PageData = model;
                    btnSelectItem.Disabled = true;
                }
            }
          
        }
        [AjaxMethod]
        public void Edit(MsdMeterielInfo entity)
        {
            try
            {
                MsdMateriel bll = new MsdMateriel();

                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 绑定MSD等级信息
        /// </summary>
        protected void BindMSL()
        {
            SKT.LeanMES.MSD.BLL.Msl bll = new LeanMES.MSD.BLL.Msl();
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            var list = bll.GetAll(0, 100, "MslId", searchSettings);

            this.ddlMSL.DataSource = list;
            this.ddlMSL.DataTextField = "MSL";
            this.ddlMSL.DataValueField = "MslId";

            this.ddlMSL.DataBind();

            ddlMSL.Items.Insert(0, new ListItem(Resources.lang.Choose, "-1"));

        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ItemInfo PageData
        {
            set
            {
                this.hdnItemId.Value = value.ItemID.ToString();
                this.txtItemCode.Text = value.ItemCode;
                this.txtFloorLife.Text = value.FloorLife.ToString();
                txtBakeCount.Text = value.BakeCount.ToString();
                if (ddlMSL.Items.FindByText(value.MSL) != null)
                {
                    ddlMSL.Items.FindByText(value.MSL).Selected = true;
                }
                txtItemName.Text = value.ItemName;

            }
        }
    }
}