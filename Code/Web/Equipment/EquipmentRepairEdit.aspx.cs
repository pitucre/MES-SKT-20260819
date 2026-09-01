using System;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentRepairEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentRepair));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                var equimentRepair = new EquipmentRepair();
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = equimentRepair.GetInfo(Convert.ToInt32(idString));
                }
                else
                {
                    try
                    {
                        this.txtRepairNo.Text = equimentRepair.GetEquipmentRepairNo(-18);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                        Page.ClientScript.RegisterStartupScript(GetType(), "dd", "parent.window.Refresh();", true);
                    }
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentRepairInfo PageData
        {
            set
            {
                this.txtRepairNo.Text = value.RepairNo;
                RepairTime.Value = value.RepairTime.ToString("yyyy-MM-dd HH:mm:ss");
                this.txtSongCarRen.Text = value.CreateByCName;
                hdSongCarRen.Value = value.CreateBy;
                this.txtEqCode.Value = value.EqCode.ToString();
                EquipmentName.Text = value.EquipmentName;
                this.txtEquipmentName.Text = value.EqCode;
                this.txtRepairDesc.Text = value.RepairDesc;
                txtRepairBy.Text = value.RepairByCName;
                hdRepairBy.Value = value.RepairBy;
                StartTime.Value = value.RepairSTime.ToString("yyyy-MM-dd HH:mm:ss") == "1900-01-01 00:00:00" ? "" : value.RepairSTime.ToString("yyyy-MM-dd HH:mm:ss");
                EndTime.Value = value.RepairETime.ToString("yyyy-MM-dd HH:mm:ss") == "1900-01-01 00:00:00" ? "" : value.RepairETime.ToString("yyyy-MM-dd HH:mm:ss");
                txtHandleContent.Text = value.HandleContent;
                PartList.Text = value.PartContent;
            }
        }
    }
}