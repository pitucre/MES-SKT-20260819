using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MoldComponentEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new MoldComponent()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }
       
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private MoldComponentInfo PageData
        {
            set
            {
                txtComponentName.Text = value.ComponentName;
                txtSafeStock.Text = value.SafeStock==0?"":value.SafeStock.ToString();
                txtRemark.Text = value.Remark;

            }
        }
    }
}