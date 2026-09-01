using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.Controls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.Common.Model;
using SKT.LeanMES.Order.BLL;
using SKT.LeanMES.Web;
using SKT.LeanMES.Order.Model;
using SKT.LeanMES.PubItems.BLL;
using SKT.LeanMES.PubItems.Model;
using SDYC.Data;

namespace SKT.MES.Web.Material
{
    public partial class FormChangeList : BasePage
    {
        public int IsFirstLoad = 0;//标记是否初次加载
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(PageSQLService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "FormChangeId";
            this.Master.DefaultSortExpression = "FormChangeId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
          

            if (!string.IsNullOrWhiteSpace(txtFormChangeNo.Text))
            {
                searchSettings.AddCondition("FormChangeNo", txtFormChangeNo.Text);
            }
            if (!string.IsNullOrWhiteSpace(txtProject.Text))
            {
                searchSettings.AddCondition("Project", txtProject.Text);
            }
            if (!string.IsNullOrWhiteSpace(txtWarehouseName.Text))
            {
                searchSettings.AddCondition("WarehouseName", txtWarehouseName.Text);
            }

            if (!string.IsNullOrWhiteSpace(txtOrganization.Text))
            {
                searchSettings.AddCondition("Organization", txtOrganization.Text);
            }
            if (!string.IsNullOrWhiteSpace(txtDocumentType.Text))
            {
                searchSettings.AddCondition("DocumentType", txtDocumentType.Text);
            }

            string strWhere = "";

            string createDateTimeStart = this.txtCreateDateTimeStart.Text.Trim();
            string createDateTimeEnd = this.txtCreateDateTimeEnd.Text.Trim();

            if (createDateTimeStart != "" && createDateTimeEnd != "")
            {
                try
                {
                    if (DateTime.Parse(createDateTimeStart) > DateTime.Parse(createDateTimeEnd))
                    {
                        WebHelper.ShowMessage("开始时间不可大于结束时间！");
                        return;

                    }
                }
                catch (Exception ex)
                {
                    WebHelper.ShowMessage("请输入正确的时间！");
                }
            }
            if (createDateTimeStart != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " FormChangeDate >= '" + createDateTimeStart + "'" : " and FormChangeDate >= '" + createDateTimeStart + "'";
            }
            if (createDateTimeEnd != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " FormChangeDate <= '" + createDateTimeEnd + "'" : " and FormChangeDate <= '" + createDateTimeEnd + "'";
            }

            searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? strWhere : " and " + strWhere;






            this.Master.SearchSettings = searchSettings;
           

          


        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
           

        }
    }
}