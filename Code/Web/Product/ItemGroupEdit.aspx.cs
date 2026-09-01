using System;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Product
{
public partial class ItemGroupEdit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                var entity = (new ItemGroup()).GetInfo(Convert.ToInt32(idString));
                if(entity !=null){
                    this.PageData = entity;
                }                
            }
        }
    }

    /// <summary>
    /// 设置页面上的数据。
    /// </summary>
    private ItemGroupInfo PageData
    {
        set
        {
            this.txtItemGroupName.Text = value.GroupName;
            this.txtItemGroupDesc.Text = value.GroupDesc;
        }
    }
  }
}