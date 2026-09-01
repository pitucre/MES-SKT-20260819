using System;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Quality
{
    public partial class AQLSampleEdit : BasePage
    {
        protected AQLSampleInfo PageData
        {
            set
            {
               txtAqlName.Text = value.AQLSampleName;
               //ddlAqlValue.Text = value.AQLSampleValue.ToString();
               //txtDescription.Text = value.AQLSampleDescription;
               txtHideCreateDate.Value = value.CreateDate.ToString();
               txtHideID.Value = value.AQLSampleId.ToString();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof (AjaxQuality));
            var bll = new AQLSample();
            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);
                ;
                if (id > 0)
                {
                    
                    PageData = bll.GetInfo(id);
                }
                //foreach (string str in bll.GetAqlValueList())
                //{
                //    ddlAqlValue.Items.Add(str);
                //}
            }
        }
    }
}