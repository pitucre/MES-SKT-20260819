using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Jig.Model;

namespace SKT.LeanMES.Web.Jig
{
    public partial class JigTypeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxJigType));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    try
                    {
                        this.PageData = (new SKT.LeanMES.Jig.BLL.JigType()).GetInfo(Convert.ToInt32(idString));
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(ex);
                    }
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private JigTypeInfo PageData
        {
            set
            {
                this.txtTypeName.Text = value.TypeName;
                this.txtTypeCode.Text = value.TypeCode;
                this.txtTypeCode.Enabled = false;
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}