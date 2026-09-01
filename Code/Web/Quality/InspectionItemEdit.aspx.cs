using System;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionItemEdit : BasePage
    {


        public int parentId = -1;
        public string parentName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof (AjaxQuality));
            var bll = new InspectionItem();
            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);
                if (id == -1)
                {
                    parentName = Request["parentName"];
                    parentId = Convert.ToInt32(Request["parentId"]);
                }
                if (id > 0)
                {
                    PageData = bll.GetInfo(id);
                }
            }
        }
        protected InspectionItemInfo PageData
        {
            set
            {
                txtHideInspectionItemId.Value = value.InspectionItemId.ToString();
                txtHideCreateTime.Value = value.CreateTime.ToString();
                txtHideCreater.Value = value.Creater;
                txtDescription.Text = value.Description;
                txtInspectionItemName.Text = value.InspectionItemName;
                ddlStatus.SelectedIndex = value.Status ? 0 : 1;
                methodType.SelectedValue = value.InspectionMethodId.ToString();
                parentId = value.ParentId;
                parentName = value.ParentName;
                Sorting.Text = value.Sorting + "";
                txtUnit.Text = value.UnitName;
                txtInpsectionmethods.Text = value.Inpsectionmethods;
            }
        }
    }
}