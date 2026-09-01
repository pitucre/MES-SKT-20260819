using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentRepairEditNew : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipment));
            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
            {
                EquipmentRepair bll = new EquipmentRepair();
                var model = bll.GetInfo(new EquipmentRepairInfo_JXN { EquipmentRepairId = Id });
                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentRepairInfo_JXN PageData
        {
            set
            {
                this.hidRepairId.Value = value.EquipmentRepairId.ToString();
                this.lblRepairNo.Text = value.RepairNo;
                this.lblStatusName.Text = value.StatusName;
                this.lblEquipmentCode.Text = value.EquipmentCode;
                this.lblEquipmentName.Text = value.EquipmentName;
             //   this.lblAnormalTypeName.Text = value.AnormalTypeName;
                this.lblCreateBy.Text = value.CreateBy;
                this.lblCreateDateTime.Text = value.CreateDateTime == null ? string.Empty : value.CreateDateTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
                this.lblAnormalDesc.Text = value.AnormalDesc;
                this.lblRepairBy.Text = value.RepairBy;
                this.lblRepairSTime.Text = value.RepairStartTime == null ? string.Empty : value.RepairStartTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
                this.lblRepairETime.Text = value.RepairEndTime == null ? string.Empty : value.RepairEndTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
                if (!string.IsNullOrEmpty(value.AnormalImg))
                {
                    this.hidimg.Value = value.AnormalImg;
                }
                //this.lblLineName.Text = value.LineName;
                this.lblStationName.Text = value.Station;
                this.lblUrgencyName.Text = value.UrgencyName;
             //   this.lblStopFlagName.Text = value.StopFlagName;
                this.lblPartNo.Text = value.PartNo;
                this.lblPartQty.Text = value.PartQty == null ? string.Empty : value.PartQty.ToString();
                this.lblAcceptRemark.Text = value.AcceptRemark;
                this.txtRepairFunction.Text = value.RepairFunction;
                this.lblExternalRepairRemark.Text = value.ExternalRepairRemark;
                this.FaultLocation.Text = value.FaultLocation;
                this.FaultCause.Text = value.FaultCause;
            }
        }
    }
}