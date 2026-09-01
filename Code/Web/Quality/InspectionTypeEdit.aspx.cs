using System;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.SerialNumber.BLL;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionTypeEdit : BasePage
    {
        protected InspectionTypeInfo PageData
        {
            set
            {
               txtHideCreateTime.Value = value.CreateTime.ToString();             
               ddlStatus.SelectedIndex = value.Status ? 0 : 1;
               txtDescription.Text = value.Description;
               txtInspectionName.Text = value.InspectionTypeName;
               ddlSystemType.SelectedValue = value.SystemType.ToString();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof (AjaxQuality));
            var bll = new InspectionType();
            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);
                ;
                if (id > 0)
                {
                    PageData = bll.GetInfo(id);
                }
                //BindNextNumberType();
            }
        }

        ///// <summary>
        ///// 绑定产生序列号事件
        ///// </summary>
        //protected void BindNextNumberType()
        //{
        //    //this.ddlNextType.DataSource = SKT.LeanMES.Web.Utility.EnumHelper.ParseEnumToList(typeof(SKT.LeanMES.SerialNumber.Model.EnumNextNumberType));
        //    SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
        //    this.ddlNextType.DataSource = new SerialNumberType().GetAll(0, 100, "SerialNumberTypeId", searchSettings);
        //    this.ddlNextType.DataTextField = "SerialNumberType";
        //    this.ddlNextType.DataValueField = "SerialNumberTypeId";
        //    this.ddlNextType.DataBind();
        //}
    }
}