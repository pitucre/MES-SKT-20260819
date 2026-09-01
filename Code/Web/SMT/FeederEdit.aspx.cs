using System;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SMT
{
    public partial class FeederEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceFeeder));

            Int32 FeederID = Convert.ToInt32(Request.QueryString["ID"]);
            Bind("FeederCategory", this.ddlFeederCategory, "DictionaryDataId");
            Bind("FeederStatus", this.ddlStatus, "DictionaryDataId");

            if (FeederID != -1)
            {
                if (Request.QueryString["Action"] != "Copy")
                {
                    this.txtSerialNumbe.Enabled = false;
                    this.txtSerialNumbe.ReadOnly = true;
                }
                SKT.LeanMES.SMT.BLL.Feeder bllFeeder = new SKT.LeanMES.SMT.BLL.Feeder();
                SKT.LeanMES.SMT.Model.FeederInfo model = null;
                model = bllFeeder.GetInfo(FeederID);
                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private FeederInfo PageData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtSerialNumbe.Text = Resources.Buttons.COM_Copy + " - " + value.SerialNumber;
                }
                else
                {
                    this.txtSerialNumbe.Text = value.SerialNumber;
                }
                this.txtDescription.Text = Convert.ToString(value.Description);
                this.txtFeederType.Text = Convert.ToString(value.FeederType);
                this.txtModelName.Text = Convert.ToString(value.ModelName);
                this.ddlFeederCategory.Text = Convert.ToString(value.FeederCategoryID);
                this.ddlStatus.Text = Convert.ToString(value.StatusID);
                this.txtFeederTypeID.Value = Convert.ToString(value.FeederTypeID);
                this.txtMaxPickUp.Text = Convert.ToString(value.MaxPickUp);
                this.txtMaxPickUpErr.Text = Convert.ToString(value.MaxPickUpErr);
                this.txtMaxPickUpErrRatio.Text = Convert.ToString(value.PickUpErrRatio);
                this.txtMaxUnuseDuration.Text = Convert.ToString(value.MaxUnuseDuration);
                this.txtMaxUseDuration.Text = Convert.ToString(value.MaxUseDuration);
                this.txtModelID.Value = Convert.ToString(value.MachineModelID);
            }
        }

        /// <summary>
        /// 下拉框绑定
        /// </summary>
        /// <param name="Value">查询字段值</param>
        /// <param name="DDList">下拉框</param>
        private void Bind(string Value, DropDownList DDList, string DataValueField)
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("Name", Value);
            SKT.LeanMES.SerialNumber.BLL.Dictionary Dictionaty = new SKT.LeanMES.SerialNumber.BLL.Dictionary();
            List<SKT.LeanMES.SerialNumber.Model.DictionaryInfo> dInfos = Dictionaty.GetAll(0, 100, "DicProperty", searchSettings);
            DDList.DataSource = dInfos;
            DDList.DataTextField = "Value";
            DDList.DataValueField = DataValueField;
            DDList.DataBind();
        }
    }
}