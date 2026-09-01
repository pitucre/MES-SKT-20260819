using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warning
{
    public partial class WarningView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            LeanMES.Warning.Model.WarningInfo warningInfo = (new SKT.LeanMES.Warning.BLL.Warning()).GetInfo(Convert.ToInt32(idString));

            this.lblWarningName.Text = warningInfo.WarningName;
            switch (warningInfo.WarningGroup)
            {
                case 0:
                    this.lblWarningGroup.Text = "";
                    break;
                case 1:
                    this.lblWarningGroup.Text = Resources.Enum.SystemWarning;
                    break;
                case 2:
                    this.lblWarningGroup.Text = Resources.Enum.ManufactureWarning;
                    break;
                case 3:
                    this.lblWarningGroup.Text = Resources.Enum.QualityWarning;
                    break;
                default:
                    this.lblWarningGroup.Text = "";
                    break;
            }
            this.lblWarningType.Text = warningInfo.WarningTypeName;
            this.lblWarningDesc.Text = warningInfo.WarningDesc;
            this.lblWarningLevel.Text = Convert.ToString(warningInfo.WarningLevel);

            switch (warningInfo.CycleType)
            {
                case 0:
                    this.lblCycleType.Text = "By Count";
                    this.labCycleTime.Text = "";
                    this.labPreWarning.Text = "";
                    break;
                case 1:
                    this.lblCycleType.Text = "By Minute";
                    this.labCycleTime.Text = "Minute";
                    this.labPreWarning.Text = "Minute";
                    break;
                case 2:
                    this.lblCycleType.Text = "By Hours";
                    this.labCycleTime.Text = "Hours";
                    this.labPreWarning.Text = "Hours";
                    break;
                case 3:
                    this.lblCycleType.Text = "By Day";
                    this.labCycleTime.Text = "Day";
                    this.labPreWarning.Text = "Day";
                    break;
                case 4:
                    this.lblCycleType.Text = "By Week";
                    this.labCycleTime.Text = "Week";
                    this.labPreWarning.Text = "Week";
                    break;
                case 5:
                    this.lblCycleType.Text = "By Month";
                    this.labCycleTime.Text = "Month";
                    this.labPreWarning.Text = "Month";
                    break;
                case 6:
                    this.lblCycleType.Text = "By Year";
                    this.labCycleTime.Text = "Year";
                    this.labPreWarning.Text = "Year";
                    break;
                default:
                    this.lblCycleType.Text = "";
                    break;
            }

            this.lblCycleTime.Text = Convert.ToString(warningInfo.CycleTime);
            this.lblPreWarning.Text = Convert.ToString(warningInfo.PreWarning);
            this.lblRatioNum.Text = warningInfo.RatioNum.ToString();


            switch (warningInfo.MessageType)
            {
                case 0:
                    this.lblMessageType.Text = "";
                    break;
                case 1:
                    this.lblMessageType.Text = Resources.Enum.SMS;
                    break;
                case 2:
                    this.lblMessageType.Text = Resources.Enum.Email;
                    break;
                case 3:
                    this.lblMessageType.Text = Resources.Enum.Whistle;
                    break;
                default:
                    this.lblMessageType.Text = "";
                    break;
            }

            this.lblRecipientLevel1.Text = warningInfo.RecipientLevelNames1;
            this.lblIntervalTime1.Text = warningInfo.IntervalTime1.ToString();
            this.lblReceiveContent1.Text = warningInfo.ReceiveContent1;
            this.lblRecipientLevel2.Text = warningInfo.RecipientLevelNames2;
            this.lblIntervalTime2.Text = warningInfo.IntervalTime2.ToString();
            this.lblReceiveContent2.Text = warningInfo.ReceiveContent2;
            this.lblRecipientLevel3.Text = warningInfo.RecipientLevelNames3;
            this.lblReceiveContent3.Text = warningInfo.ReceiveContent3;
            this.lblCreateBy.Text = warningInfo.CreateBy;
            this.lblCreateDateTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(warningInfo.CreateDateTime);
            this.lblModifyBy.Text = warningInfo.ModifyBy;
            this.lblModifyDateTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(warningInfo.ModifyDateTime);
            this.lblRemark.Text = warningInfo.Remark;
            this.lblRatio.Text = warningInfo.WarningVal.ToString();
           
        }
    }
}