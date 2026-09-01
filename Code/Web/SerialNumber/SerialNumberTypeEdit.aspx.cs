using System;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.SerialNumber.Model;
using SKT.LeanMES.Web.AjaxServices;


namespace SKT.LeanMES.Web.SerialNumber
{
public partial class SerialNumberTypeEdit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSerialNumber));
        if (!this.IsPostBack)
        {
            String idString = Request.QueryString["ID"];

            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                this.PageData = (new SerialNumberType()).GetInfo(Convert.ToInt32(idString));
            }
        }
    }

    /// <summary>
    /// 设置页面上的数据。
    /// </summary>
    private SerialNumberTypeInfo PageData
    {
        set
        {
            this.txtSerialNumberType.Text = value.SerialNumberType;
            this.txtSerialNumberDesc.Text = value.SerialNumberDesc;           
        }
    }
  }
}