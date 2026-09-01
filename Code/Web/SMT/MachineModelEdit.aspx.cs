using System;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SMT
{
    public partial class MachineModelEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceMachineModel));

            if (!this.IsPostBack)
            {
                Int32 ModelID = Convert.ToInt32(Request.QueryString["ID"]);

                //绑定下拉框ddlStatus、ddlCategory
                Bind("MachineStatus", this.ddlStatus);
                Bind("MachineType", this.ddlMachineType);

                if (ModelID != -1)
                {
                    SKT.LeanMES.SMT.BLL.MachineModel bllMachineModel = new SKT.LeanMES.SMT.BLL.MachineModel();
                    SKT.LeanMES.SMT.Model.MachineModelInfo model = null;
                    model = bllMachineModel.GetInfo(ModelID);
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
        private MachineModelInfo PageData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtModelName.Text = Resources.Buttons.COM_Copy + " - " + value.ModelName;
                }
                else
                {
                    this.txtModelName.Text = value.ModelName;
                }
                this.txtDescription.Text = value.Description;
                this.txtModelFamilyName.Text = value.ModelFamilyName;
                this.txtModelFamilyID.Value = Convert.ToString(value.MachineModelFamilyID);
                this.ddlMachineType.Text = value.MachineType;
                this.txtVendor.Text = value.Vendor;
                this.ddlStatus.Text = value.Status;
            }
        }

        /// <summary>
        /// 下拉框绑定
        /// </summary>
        /// <param name="Value">查询字段值</param>
        /// <param name="DDList">下拉框</param>
        private void Bind(string Value, DropDownList DDList)
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("Name", Value);
            // SKT.LeanMES.SYS.BLL.DICTIONARY Dictionaty = new SKT.MES.SYS.BLL.DICTIONARY();
            SKT.LeanMES.SerialNumber.BLL.Dictionary Dictionaty = new SKT.LeanMES.SerialNumber.BLL.Dictionary();
            List<SKT.LeanMES.SerialNumber.Model.DictionaryInfo> dInfos = Dictionaty.GetAll(0, 100, "DicProperty", searchSettings);
            DDList.DataSource = dInfos;
            DDList.DataTextField = "Value";
            DDList.DataValueField = "Value";
            DDList.DataBind();
        }
    }
}