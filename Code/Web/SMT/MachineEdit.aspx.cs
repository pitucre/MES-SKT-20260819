using System;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SMT
{
    public partial class MachineEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceMachine));
            
            if (!this.IsPostBack)
            {
                Int32 MachineID = Convert.ToInt32(Request.QueryString["ID"]);


                if (MachineID != -1)
                {
                    SKT.LeanMES.SMT.BLL.Machine bllMachine = new SKT.LeanMES.SMT.BLL.Machine();
                    SKT.LeanMES.SMT.Model.MachineInfo model = null;
                    model = bllMachine.GetInfo(MachineID);
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
        private MachineInfo PageData
        {
            set
            {
                //this.txtLineName.Text = value.LineName;
                //this.txtModelName.Text = value.ModelName;
                //this.txtLineID.Value = Convert.ToString(value.LineID);
                //this.txtModelID.Value = Convert.ToString(value.MachineModelID);

            }
        }
    }
}