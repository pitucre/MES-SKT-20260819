using System;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.SerialNumber.Model;
 using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SerialNumber
{
    public partial class MesVouchTypeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSerialNumber));
            string vouchTypeID = Request.QueryString["ID"];
            int vouchID = Convert.ToInt32(vouchTypeID);
            if (vouchID > -1)
            {
                SKT.LeanMES.SerialNumber.BLL.MesVouchType bllVouch = new MesVouchType();
                this.NextNumber = bllVouch.GetInfo(vouchID);
            }

        }
        protected MesVouchTypeInfo NextNumber
        {
            set
            {
                this.txtTypeName.Text = value.VouchName;
                this.txtCodingRule.Text = value.EncodeStr;
                this.hdnSelectCodingRuleId.Value = value.EncodeRule.ToString();
                this.txtRuleName.Text = value.RuleStr;
                this.hdnSelectRuleNameId.Value = value.RuleName.ToString();
                this.txtPackRuleName.Text = value.PackRuleStr;
                this.hdnSelectPackNameId.Value = value.PackRule.ToString();
                this.txtDesc.Text = value.Remark;
                this.hdnFrmTypeName.Value = value.VouchName;
            }
        }
    }
}