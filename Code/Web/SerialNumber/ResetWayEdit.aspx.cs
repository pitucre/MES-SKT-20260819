using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.SerialNumber.Model;

namespace SKT.LeanMES.Web.SerialNumber
{
    public partial class ResetWayEdit : BasePage
    {
        ResetWay bll = new ResetWay();
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSerialNumber));

            if (!this.IsPostBack)
            {
                BindResetWayProc();

                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = bll.GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        private void BindResetWayProc()
        {
            var list = bll.GetResetWayFunc();

            foreach (string item in list)
            {
                ddlRestWayFunc.Items.Add(new ListItem(item, item));
            }
            ddlRestWayFunc.Items.Insert(0, new ListItem("=请选择=", ""));
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ResetWayInfo PageData
        {
            set
            {
                this.txtResetWay.Text = value.ResetWay;               
                this.txtResetWayDesc.Text = value.ResetWayDesc;
                this.ddlRestWayFunc.SelectedValue = value.RelationFunc;
            }
        }
    }
}