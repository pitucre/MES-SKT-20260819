using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;

namespace SKT.LeanMES.Web.SMT
{
    public partial class LoadingLitDetailEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxServicesLoadingList));

            int groudId = Convert.ToInt32(Request.QueryString["ID"]);
            if (groudId > -1)
            {
                LoadingList_DetailInfo model = null;
                SKT.LeanMES.SMT.BLL.LoadingList_DETAIL bll = new SKT.LeanMES.SMT.BLL.LoadingList_DETAIL();
                model = bll.GetInfo(groudId);
                if (model != null)
                {
                    this.PageData = model;
                }
            }

        }



        private LoadingList_DetailInfo PageData
        {
            set
            {
                this.txtPosition.Text = value.Position;
                this.txtItemName.Text = value.ItemCode;
                this.hdnItemId.Value = Convert.ToString(value.ItemId);
                this.txtSmtNum.Text = Convert.ToString(value.SmtNum);
                this.txtFeederType.Text = value.FeederType;
                this.txtLocationType.Text = value.LocationType;
                this.txtPoint.Text = value.Point;
                this.txtReplaceNum.Text = value.ReplaceNum;
                txtArea.Text = value.Area;
            }
        }
    }
}