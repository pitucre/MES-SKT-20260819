using SKT.LeanMES.Warning.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warning
{
    public partial class WarningEdit : BasePage
    {
        public int warningType;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarning));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.Warning.BLL.Warning()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private WarningInfo PageData
        {
            set
            {
                this.txtWarningName.Text = value.WarningName;
                this.ddlWarningGroup.SelectedValue = Convert.ToString(value.WarningGroup);
                this.warningType = value.WarningType;
                //this.ddlWarningType.SelectedValue = Convert.ToString(value.WarningType);
                this.txtWarningDesc.Text = value.WarningDesc;
                this.txtWarningLevel.Text = Convert.ToString(value.WarningLevel);
                this.ddlCycleType.SelectedValue = Convert.ToString(value.CycleType);
                this.txtCycleTime.Text = Convert.ToString(value.CycleTime);
                switch (value.CycleType)
                {
                    case 0:
                        this.labCycleTime.Text = "";
                        this.labPreWarning.Text = "";
                        break;
                    case 1:
                        this.labCycleTime.Text = "Minute";
                        this.labPreWarning.Text = "Minute";
                        break;
                    case 2:
                        this.labCycleTime.Text = "Hours";
                        this.labPreWarning.Text = "Hours";
                        break;
                    case 3:
                        this.labCycleTime.Text = "Day";
                        this.labPreWarning.Text = "Day";
                        break;
                    case 4:
                        this.labCycleTime.Text = "Week";
                        this.labPreWarning.Text = "Week";
                        break;
                    case 5:
                        this.labCycleTime.Text = "Month";
                        this.labPreWarning.Text = "Month";
                        break;
                    case 6:
                        this.labCycleTime.Text = "Year";
                        this.labPreWarning.Text = "Year";
                        break;
                    default:
                        break;
                }
                this.txtPreWarning.Text = Convert.ToString(value.PreWarning);
                this.txtRatioNum.Text = value.RatioNum.ToString();
                this.ddlMessageType.SelectedValue = Convert.ToString(value.MessageType);

                this.txtRecipientLevel1.Text = value.RecipientLevelNames1;
                this.hdfValue1.Value = value.RecipientLevel1;
                this.lblRecipientLevel1.Text = "";
                this.hidRecipientLevel1.Value = value.RecipientLevelNames1;

                this.txtReceiveContent1.Text = value.ReceiveContent1;

                this.txtRecipientLevel2.Text = value.RecipientLevelNames2;
                this.hdfValue2.Value = value.RecipientLevel2;
                this.lblRecipientLevel2.Text = "";
                this.hidRecipientLevel2.Value = value.RecipientLevelNames2;

                this.txtReceiveContent2.Text = value.ReceiveContent2;

                this.txtRecipientLevel3.Text = value.RecipientLevelNames3;
                this.hdfValue3.Value = value.RecipientLevel3;
                this.lblRecipientLevel3.Text = "";
                this.hidRecipientLevel3.Value = value.RecipientLevelNames3;

                this.txtReceiveContent3.Text = value.ReceiveContent3;
                this.txtRemark.Text = value.Remark;

                this.txtLineId.Value = value.LineId.ToString();
                this.txtLine.Text = value.LineName;
                this.txtIntervalTime1.Text = value.IntervalTime1.ToString();
                this.txtIntervalTime2.Text = value.IntervalTime2.ToString();

                this.lblWarningVal.Text = value.WarningVal.ToString();
            }
        }
    }
}