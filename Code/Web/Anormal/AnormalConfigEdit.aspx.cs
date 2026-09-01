using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.ProdAnormal.BLL;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.ProdAnormal.Model;

namespace SKT.LeanMES.Web.Anormal
{
    public partial class AnormalConfigEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxAnormalConfig));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxProdAnormal));
            string ID = Request.QueryString["ID"].ToString();
            if (ID != null && Convert.ToInt32(ID) > 0)
            {
                AnormalConfig anormalConfig = new AnormalConfig();
                AnormalConfigInfo model = null;
                model = anormalConfig.GetInfo(Convert.ToInt32(ID));
                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private AnormalConfigInfo PageData
        {
            set
            {
                this.txtAnormalTypeName.Text = value.AnormalTypeName.ToString();
                this.hdAnormalTypeId.Value = value.AnormalTypeId.ToString();
                this.hdReceiver.Value = value.Receiver.ToString();
                this.txtReceiverName.Text = value.ReceiverName.ToString();
                this.ddlSendWay.SelectedValue = value.SendWay.ToString();
            }
        }
    }
}