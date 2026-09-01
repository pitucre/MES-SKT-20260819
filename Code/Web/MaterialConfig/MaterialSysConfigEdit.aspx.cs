using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.MaterialConfig.Model;


namespace SKT.LeanMES.Web.MaterialConfig
{

    public partial class MaterialSysConfigEdit : BasePage
    {
        public Int32 configTypeId = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SKT.LeanMES.MaterialConfig.BLL.MaterialSysConfig sysConfig = new LeanMES.MaterialConfig.BLL.MaterialSysConfig();
                    MaterialSysConfigInfo model = sysConfig.GetInfo(Convert.ToInt32(idString));
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
        private MaterialSysConfigInfo PageData
        {

            set
            {
                this.ddlConfigType.SelectedValue = value.ConfigTypeId.ToString();
                configTypeId = value.ConfigTypeId;
                if (configTypeId == 1)
                {
                    ddlPrintType.SelectedValue = value.ConfigResult.ToString();
                }
                else if (configTypeId == 2)
                {
                    ddlReceiveType.SelectedValue = value.ConfigResult.ToString();
                }
                else if (configTypeId == 5)
                {
                    ddlIsCheckBox.SelectedValue =value.ConfigResult.ToString().Split('|')[0];
                    CheckBox1.Checked = value.ConfigResult.ToString().Split('|')[1] == "1" ? true : false;
                    CheckBox2.Checked = value.ConfigResult.ToString().Split('|')[2] == "1" ? true : false;
                    CheckBox3.Checked = value.ConfigResult.ToString().Split('|')[3] == "1" ? true : false;
                }
                else if (configTypeId == 7)
                {
                    var jsonConfig = new JavaScriptSerializer().Deserialize<objRule>(value.ConfigResult);
                    ddlRuleObj.SelectedValue = jsonConfig.ruleObj;
                    ddlRuleUnit.SelectedValue = jsonConfig.ruleUnit;

                }
                else if (configTypeId > 2 && configTypeId < 10 && configTypeId != 7 && configTypeId != 5)
                {
                    ddlIsCheckBox.SelectedValue = value.ConfigResult.ToString();
                }

                else if (configTypeId == 10)
                {
                    hdnWhCode.Value = value.ConfigResult;
                    txtWhCode.Text = value.ConfigDesc;
                }
                else if (configTypeId == 11)
                {
                    txtJITFirst.Text = value.ConfigResult;
                }
                else if (configTypeId == 12)
                {
                    txtJITWarn.Text = value.ConfigResult;
                }
                else if (configTypeId == 13)
                {
                    txtJITSendTime.Text = value.ConfigResult;
                }
                else if (configTypeId == 14)
                {
                    ddlSMTPanelType.SelectedValue = value.ConfigResult.ToString();
                }
                else if (configTypeId == 15)
                {
                    txtKanbanWelcomeMSG.Text = value.ConfigResult.ToString();
                }
                else if (configTypeId == 16)
                {
                    ddlChangeHandle.SelectedValue = value.ConfigResult.ToString();
                }
                else if (configTypeId == 17)
                {
                    ddlIsCheckBox.SelectedValue = value.ConfigResult.ToString();
                }
                else if (configTypeId == 18)
                {
                    txtBarCodeLocation.Text = value.ConfigResult.ToString();
                }
                else if (configTypeId == 19)
                {
                    var item = this.ddlThawUserType.Items.FindByText(value.ConfigDesc);
                    this.ddlThawUserType.SelectedValue = item.Value;
                    this.txtThawUserNum.Text = value.ConfigResult;
                }
                else if (configTypeId == 22)
                {
                    ddlIsCheckBox.SelectedValue = value.ConfigResult.ToString();
                }
                else if (configTypeId == 23)
                {
                    ddlIsCheckBox.SelectedValue = value.ConfigResult.ToString();
                }
                else if (configTypeId == 24)
                {
                    ddlIsCheckBox.SelectedValue = value.ConfigResult.ToString();
                }
                else if (configTypeId == 25)
                {
                    ddlIsCheckBox.SelectedValue = value.ConfigResult.ToString();
                }
                else if (configTypeId == 26)
                {
                    ddlIsCheckBox.SelectedValue = value.ConfigResult.ToString();
                }
                this.txtRemark.Text = value.Remark;
            }
        }

        private class objRule
        {
            public string ruleObj { get; set; }
            public string ruleUnit { get; set; }
        }
    }
}