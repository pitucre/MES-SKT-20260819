using System;
using SKT.LeanMES.DictionaryData.BLL;
using SKT.LeanMES.DictionaryData.Model;


namespace SKT.LeanMES.Web.Quality
{
public partial class InspectionmethodsEdit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxDictionaryData));

        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                this.PageData = (new SKT.LeanMES.DictionaryData.BLL.DictionaryData()).GetInfo(Convert.ToInt32(idString));
            }
        }
    }

    /// <summary>
    /// 设置页面上的数据。
    /// </summary>
    private DictionaryDataInfo PageData
    {
        set
        {;
            this.txtName.Text = value.Name;
            this.txtDescription.Text = value.Description;
            this.txtRemark.Text = value.Remark;
        }
    }
  }
}