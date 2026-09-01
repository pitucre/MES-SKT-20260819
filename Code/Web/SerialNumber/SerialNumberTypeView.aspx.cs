using System;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.SerialNumber.Model;

namespace SKT.LeanMES.Web.SerialNumber
{
public partial class SerialNumberTypeView : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
       /* Response.Write(idString);
        SKT.LeanMES.SerialNumber.Model.SerialNumberTypeInfo serialNumberTypeInfo = new SerialNumberType().GetInfo(Convert.ToInt32(idString));
        this.lblSerialNumberType.Text = serialNumberTypeInfo.SerialNumberType.ToString();
        this.lblSerialNumberDesc.Text = serialNumberTypeInfo.SerialNumberDesc.ToString();*/
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
            this.lblSerialNumberType.Text = value.SerialNumberType;
            this.lblSerialNumberDesc.Text = value.SerialNumberDesc;
        }
    }
  }
}