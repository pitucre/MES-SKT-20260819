using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.CommonDataSource.Model;

namespace SKT.LeanMES.Web.CommonDataSource
{
    public partial class CommonDataSourceView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            LeanMES.CommonDataSource.BLL.DataSource bll = new LeanMES.CommonDataSource.BLL.DataSource();

            CommonDataSourceInfo model = bll.GetInfo(Convert.ToInt32(idString));
            this.lblDataSourceName.Text = model.DataSourceName;
            this.lblDataSourceDesc.Text = model.DataSourceDesc;
            this.lblDataSourceType.Text = model.DataSourceType;
            this.lblSQLType.Text = model.SQLType;
            this.lblSQLInfo.Text = model.SQLInfo;
            this.lblParamters.Text = model.Paramters;
            this.lblTabColumn.Text = model.TabColumn;
            this.lblUseType.Text = model.UseType;
            this.lblCreateBy.Text = model.CreateBy;
            this.lblCreateTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(model.CreateTime);
            this.lblModifyBy.Text = model.ModifyBy;
            this.lblModifyTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(model.ModifyTime);
        }
    }
}