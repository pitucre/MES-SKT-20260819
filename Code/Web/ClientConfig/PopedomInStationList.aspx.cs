using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.ClientConfig
{
    public partial class PopedomInStationList : BasePage
    {
        private int columnIndex_PopedomName = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_PopedomName = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "PopedomName")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxClientConfig));

            try
            {
                this.Master.PageGridView = this.GridView1;
                this.Master.PageObjectDataSource = this.ObjectDataSource1;
                this.Master.RecordIDField = "PopedomInStationId";
                this.Master.DefaultSortExpression = "PopedomInStationId DESC";

                SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                if (txtStationTypeName.Text.Trim().Length > 0)
                {
                    searchSettings.AddCondition("StationTypeName", txtStationTypeName.Text.Trim().Replace("'", "''"));
                }
                if (txtStation.Text.Trim().Length > 0)
                {
                    searchSettings.AddCondition("StationName", txtStation.Text.Trim().Replace("'", "''"));
                }
                if (txtTemplateName.Text.Trim().Length > 0)
                {
                    searchSettings.AddCondition("Popedom", this.hdnNewTemplate.Value);
                }
                this.Master.SearchSettings = searchSettings;
                this.GridView1.PageIndex = 0;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.ClientConfig.BLL.PopedomInStation bll = new SKT.LeanMES.ClientConfig.BLL.PopedomInStation();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //3改为columnIndex_PopedomName
                //7改为columnIndex_ModifyDateTime
                e.Row.Cells[columnIndex_PopedomName].Text = GetResourceString("Popedom", e.Row.Cells[columnIndex_PopedomName].Text);
                if (e.Row.Cells[columnIndex_ModifyDateTime].Text== "0001-01-01 00:00:00") {
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
                }
            }
        }

        /// <summary>
        /// 获取资源
        /// </summary>
        /// <param name="resClass"></param>
        /// <param name="resKey"></param>
        /// <returns></returns>
        private String GetResourceString(string resClass, string resKey)
        {
            string str = "";

            HttpCookie cookie = HttpContext.Current.Request.Cookies["lang"];
            string lang = cookie == null ? "zh-cn" : cookie.Value;
            Object resource = HttpContext.GetGlobalResourceObject(resClass, resKey, new System.Globalization.CultureInfo(lang));
            if (resource != null)
            {
                str = resource.ToString();
            }
            else
            {
                str = resKey;
            }
            return str;
        }

    }
}