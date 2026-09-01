using System;
using SKT.LeanMES.Labels.BLL;
using SKT.LeanMES.Labels.Model;
using System.Collections.Generic;
using AjaxPro;

namespace SKT.LeanMES.Web.Labels
{
    public partial class LabelZPLEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxLabels));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    LabelZPL lblZPL = new LabelZPL();
                    LabelZPLInfo lblZPLInfo = null;
                    lblZPLInfo = lblZPL.GetInfo(Convert.ToInt32(idString));
                    //取Basal_LabelZPLValues数据
                    SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                    searchSettings.ExtensionCondition = "LabelZplId = " + lblZPLInfo.LabelZplId.ToString();
                    LabelZPLValues lblValue = new LabelZPLValues();
                    List<LabelZPLValuesInfo> ListValueInfo = lblValue.GetAll(0, 2000, "LabelZplId", searchSettings);
                    string Value = "";
                    foreach (LabelZPLValuesInfo ZPLValue in ListValueInfo)
                    {
                        Value += ZPLValue.ZplValues;
                    }
                    txtZPLValue.Text = Value;

                    this.PageData = lblZPLInfo;

                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private LabelZPLInfo PageData
        {
            set
            {
                this.ddlZPLType.SelectedValue = value.ZplType.ToString();
                this.txtZplName.Text = value.ZplName;
                this.txtDescription.Text = value.Description;
            }
        }
        /// <summary>
        ///  返回 ZPLValuesInfo实体类
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public LabelZPLValuesInfo ZPLValues()
        {
            LabelZPLValuesInfo ZPLValues = new LabelZPLValuesInfo();
            return ZPLValues;
        }
    }
}