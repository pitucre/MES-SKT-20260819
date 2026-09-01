using SKT.LeanMES.Container.BLL;
using SKT.LeanMES.Container.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.DIPPackaging
{
    public partial class FloorLineInfoEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxDIPPackaging));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new FloorLineInfo()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private FloorLineInfoInfo PageData
        {
            set
            {
                this.txtFid.Value = Convert.ToString(value.Fid);
                this.txtLineId.Value = Convert.ToString(value.LineId);
                this.txtFName.Text = value.FName;
                this.txtLineName.Text = value.LineName;
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}