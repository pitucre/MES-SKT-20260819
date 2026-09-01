using SKT.LeanMES.MaterialConfig.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialIQCReturnForm : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));
            SKT.LeanMES.MaterialConfig.BLL.MaterialSysConfig sysConfig = new LeanMES.MaterialConfig.BLL.MaterialSysConfig();
            MaterialSysConfigInfo model = sysConfig.GetInfo("10"); //获取当前不良仓
            if (model != null)
            {
                lbNgWarehouse.Text = model.ConfigDesc;
                hdNgWarehouse.Value = model.ConfigResult;
            }else
            {
                lbNgWarehouse.Text = "请配置不良仓";
                lbNgWarehouse.ForeColor = System.Drawing.Color.Red;
            }


        }
    }
}