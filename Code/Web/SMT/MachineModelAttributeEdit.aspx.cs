using System;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SMT
{
    public partial class MachineModelAttributeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceMachineModel));

            if (!this.IsPostBack)
            {
                Int32 ModelAttrID = Convert.ToInt32(Request.QueryString["ID"]);

                //绑定下拉框
                Bind("MachineStatus", this.ddlStatus, "Value");
                Bind("TableType", this.ddlMachineTableType, "DictionaryDataID");
 
                if (ModelAttrID != -1)
                {
                    SKT.LeanMES.SMT.BLL.MachineModelAttribute bllMachineModelAttribute = new SKT.LeanMES.SMT.BLL.MachineModelAttribute();
                    SKT.LeanMES.SMT.Model.MachineModelAttributeInfo model = null;
                    model = bllMachineModelAttribute.GetInfo(ModelAttrID);
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
        private MachineModelAttributeInfo PageData
        {
            set
            {
                this.txtMachineModelName.Text = value.MachineModelName;
                this.txtMachineModelID.Value = Convert.ToString(value.MachineModelID);
                this.txtTablePosition.Text = Convert.ToString(value.TablePosition);
                this.ddlMachineTableType.Text = Convert.ToString(value.MachineTableType);
                this.txtStartSlotPosition.Text = Convert.ToString(value.StartSlotPosition);
                this.txtEndSlotPosition.Text = Convert.ToString(value.EndSlotPosition);
                this.ddlStatus.Text = value.Status;
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