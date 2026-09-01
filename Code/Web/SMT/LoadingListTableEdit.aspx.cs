using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.SMT.BLL;

namespace SKT.LeanMES.Web.SMT
{
    public partial class LoadingListTableEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxServicesLoadingList));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new LoadingListTable()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private LoadingListTableInfo PageData
        {
            set
            {
                this.txtTableName.Text = value.TableName;
                this.txtTableDesc.Text = value.TableDesc;
                this.txtRemark.Text = value.Remark;
                this.ddlIsActive.SelectedValue = value.EnableFlag.ToString();
            }
        }
    }
}