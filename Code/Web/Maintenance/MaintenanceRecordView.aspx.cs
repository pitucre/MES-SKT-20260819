using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Maintenance.BLL;
using SKT.LeanMES.Maintenance.Model;

namespace SKT.LeanMES.Web.Maintenance
{
    public partial class MaintenanceRecordView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
            {
                MaintenanceRecord bll = new MaintenanceRecord();
                MaintenanceRecordInfo model = null;
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
        private MaintenanceRecordInfo PageData
        {
            set
            {
                this.lblEquipmentCode.Text = value.EquipmentCode;
                this.lblEquipmentTypeName.Text = value.EquipmentTypeName;
                this.lblEquipmentName.Text = value.EquipmentName;
                this.lblMaintainDetail.Text = value.MaintainDetail;
                this.lblMaintainPerson.Text = value.MaintainActionPerson;
                this.lblMaintainDateTime.Text = value.MaintainDateTime.ToString();
                this.lblRemark.Text = value.Remark;
            }
        }
    }
}