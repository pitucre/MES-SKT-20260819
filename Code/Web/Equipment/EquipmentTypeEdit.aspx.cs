using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentTypeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));

            if (!this.IsPostBack)
            {
                string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
                int Id;
                if (int.TryParse(IdStr, out Id))
                {
                    EquipmentType bll = new EquipmentType();
                    EquipmentTypeInfo model = null;
                    model = bll.GetInfo(Convert.ToInt32(Id));
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentTypeInfo PageData
        {
            set
            {
                this.txtEquipmentTypeName.Text = value.EquipmentTypeName;
                this.cbLoading.Checked = value.IsLoading;
                this.cbOffLine.Checked = value.IsOffLine;
                this.cbScanPos.Checked = value.IsScanPos;
                this.txtRemark.Text = value.Remark;
            }
        }

    }
}