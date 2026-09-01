using System;
using SKT.LeanMES.Factory.BLL;
using SKT.LeanMES.Factory.Model;

namespace SKT.LeanMES.Web.Factory
{
public partial class FactoryView : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String idString = Request.QueryString["ID"];
        FactoryInfo factoryInfo = (new SKT.LeanMES.Factory.BLL.Factory()).GetInfo(Convert.ToInt32(idString));
        this.lblFactoryName.Text = factoryInfo.FactoryName;
        this.lblFactoryCode.Text = factoryInfo.FactoryCode;
        this.lblRemark.Text = factoryInfo.Remark;
    }
  }
}