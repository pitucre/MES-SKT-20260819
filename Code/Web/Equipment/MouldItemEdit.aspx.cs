using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldItemEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMoldFixtureItem));
            hdnEquipmentId.Value = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
        }
    }
}