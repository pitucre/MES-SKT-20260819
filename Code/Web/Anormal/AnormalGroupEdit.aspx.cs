using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Anormal.BLL;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Anormal.Model;

namespace SKT.LeanMES.Web.Anormal
{
    public partial class AnormalGroupEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxAnormal));
            string UnitId = Request.QueryString["ID"].ToString();
            if (UnitId != null && Convert.ToInt32(UnitId) > 0)
            {
                AnormalGroup anormalBll = new AnormalGroup();
                AnormalGroupInfo model = null;
                model = anormalBll.GetInfo(Convert.ToInt32(UnitId));
                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private AnormalGroupInfo PageData
        {
            set
            {
                this.txtGroupName.Text = value.AnormalGroupName.ToString();
                this.txtGroupCode.Text = value.AnormalGroupCode.ToString();
            }
        }
    }
}