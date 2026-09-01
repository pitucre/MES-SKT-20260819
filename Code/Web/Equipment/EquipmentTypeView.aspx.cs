using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentTypeView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
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

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentTypeInfo PageData
        {
            set
            {
                this.lblEquipmentTypeCode.Text = value.EquipmentTypeCode;
                this.lblEquipmentTypeName.Text = value.EquipmentTypeName;
                this.lblLoading.Text = value.IsLoading ? "True" : "False";
                this.lblOffLine.Text = value.IsOffLine ? "True" : "False";
                this.lblScanPos.Text = value.IsScanPos ? "True" : "False";
                this.lblRemark.Text = value.Remark;
                this.lblParentTypeName.Text = value.ParentTypeName;
            }
        }
    }
}