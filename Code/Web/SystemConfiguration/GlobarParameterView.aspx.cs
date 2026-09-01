using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.CommonDataSource.Model;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class GlobarParameterView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                PageData = (new LeanMES.CommonDataSource.BLL.GlobarParameter()).GetInfo(Convert.ToInt32(idString));                
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private GlobarParametersInfo PageData
        {
            set
            {
                txtHideID.Value = Convert.ToString(value.ID);
                lblParaType.InnerText = Convert.ToString(value.ParaType);
                lblParaName.InnerText = value.ParaName;
                lblParaValue.InnerText = value.ParaValue;
                lblParaDescription.InnerText = value.Paraription;
            }
        }
    }
}