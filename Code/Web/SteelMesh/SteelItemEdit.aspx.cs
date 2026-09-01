using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelItemEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));
            hdnEquipmentId.Value = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
            hdnOptionType.Value = Request.QueryString["name"] == null ? "null" : Request.QueryString["name"].ToString();
            if (!IsPostBack)
            {
                LoadLayout();
            }
        }

        private void LoadLayout()
        {
            LoadingListTable bll = new LoadingListTable();

            Common.Model.SearchSettings search = new Common.Model.SearchSettings();
            List<LoadingListTableInfo> infos = bll.GetAll(0, 100, "LoadingListTableId", search);

            ddlLayout.DataSource = infos;
            ddlLayout.DataTextField = "TableDesc";
            ddlLayout.DataValueField = "TableName";
            ddlLayout.DataBind();
        }
    }
}