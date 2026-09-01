using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.SMT
{
    public partial class LoadingType : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxServicesLoadingList));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new LeanMES.SMT.BLL.LoadingType()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private LoadingTypeInfo PageData
        {
            set
            {
                //this.txtLoadingTypeID.Text = Convert.ToString(value.LoadingTypeID);
                this.txtTypeName.Text = value.TypeName;
                this.txtBeginRow.Text = Convert.ToString(value.BeginRow);
                this.txtPositon.Text = Convert.ToString(value.ColPosition);
                this.txtPartNum.Text = Convert.ToString(value.ColPartNum);
                this.txtSurface.Text = value.ColTable.ToString();
                this.txtNum.Text = Convert.ToString(value.ColNum);
                this.txtPoint.Text = Convert.ToString(value.ColPoint);
                this.txtRemark.Text = value.Remark;

                this.txtLocation.Text = Convert.ToString(value.ColLocationType);
                this.txtFeederType.Text = Convert.ToString(value.ColFeederType);
                this.txtReplaceNum.Text = Convert.ToString(value.ColReplaceNum);
                txtPositionP2.Text = Convert.ToString(value.ColPosition_2);
                txtArea.Text = Convert.ToString(value.ColArea);
                txtElementDescription.Text = Convert.ToString(value.ElementDescription);

            }
        }
    }
}