using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MSD
{
    public partial class MslEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMSD));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) != 0)
                {
                    var entity = (new SKT.LeanMES.MSD.BLL.Msl()).GetInfo(Convert.ToInt32(idString));
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }

                }
            }
        }

        private SKT.LeanMES.MSD.Model.MslInfo PageData
        {
            set
            {
                this.txtMSL.Text = value.MSL;
                if (value.MslId < 0)
                {
                    this.txtMSL.Enabled = false;
                }               
                this.txtFloorLife.Text = value.FloorLife.ToString();
                //this.txtShelfLife.Text = value.ShelfLife.ToString();
                this.txtBakeCount.Text = value.BakeCount.ToString();
            }
        }
    }
}