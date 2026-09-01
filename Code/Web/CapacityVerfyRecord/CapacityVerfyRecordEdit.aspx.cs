using System;
using SKT.LeanMES.CapacityVerfyRecord.BLL;
using SKT.LeanMES.CapacityVerfyRecord.Model;

namespace SKT.LeanMES.Web.CapacityVerfyRecord
{
    public partial class CapacityVerfyRecordEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxCapacityVerfyRecord));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.CapacityVerfyRecord.BLL.CapacityVerfyRecord()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private CapacityVerfyRecordInfo PageData
        {
            set
            {
                this.labNO.Text = Convert.ToString(value.NO);
                this.labUserName.Text = Convert.ToString(value.UserName);
                this.labCreateBy.Text = Convert.ToString(value.CreateBy);
                this.txtAuditingSalary.Text = Convert.ToString(value.AuditingSalary);
                this.labSalary.Text = Convert.ToString(value.Salary);
                this.labCreateTime.Text = Convert.ToString(value.CreateTime);
                this.labEquipmentCode.Text = Convert.ToString(value.EquipmentCode);
                this.labStation.Text = Convert.ToString(value.Station); ;
                this.labItemCode.Text = Convert.ToString(value.ItemCode); ;
                this.labItemName.Text = Convert.ToString(value.ItemName);
                this.labQueryDate.Text = Convert.ToString(value.QueryDate);
                this.labRemark.Text = value.Remark;
                this.labPrice.Text = Convert.ToString(value.Price);
                this.labQty.Text = Convert.ToString(value.Qty);
            }
        }
    }
}