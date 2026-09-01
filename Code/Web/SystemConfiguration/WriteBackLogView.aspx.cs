using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Reflection;
using System.Data.Common;
using System.Collections;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Net.Security;
using System.Web.Script.Serialization;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web;
using SKT.LeanMES.CommonDataSource.Model;
using SKT.LeanMES.CommonDataSource.BLL;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class WriteBackLogView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = false;

            //GridView1
            this.GridView1.EmptyDataText = Resources.Messages.EmptyDataText;
            this.GridView1.EmptyDataRowStyle.CssClass = "ListTableEmptyDataRow";
            this.GridView1.CssClass = "ListTable";
            this.GridView1.HeaderStyle.CssClass = "ListTableHeader";
            this.GridView1.RowStyle.CssClass = "ListTableOddRow";
            this.GridView1.AlternatingRowStyle.CssClass = "ListTableEvenRow";
            this.GridView1.SelectedRowStyle.CssClass = "ListTableSelectedRow";
            this.GridView1.PagerStyle.CssClass = "ListTablePager";

            var id = Convert.ToInt32(Request.QueryString["ID"]);//从主页面中传递过来的ID

            if (id != -1)
            {
                ERPWriteBackLogInfo model = new ERPWriteBackLog().GetInfo(new ERPWriteBackLogInfo { WriteBackLogId = id });
                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }

        /// <summary>
        /// 编辑状态下获得对应CertID的数据
        /// </summary>
        protected ERPWriteBackLogInfo PageData
        {
            set
            {
                this.WriteBackCode.Text = value.WriteBackCode;
                this.WriteBackName.Text = value.WriteBackName;
                this.ERPResultName.Text = value.ERPResultName;
                this.ERPMsg.Text = value.ERPMsg;
                this.MESMsg.Text = value.MESMsg;
                this.MESBillNo.Text = value.MESBillNo;
                this.CreateBy.Text = value.CreateBy;
                this.CreateDateTime.Text = value.CreateDateTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
                if (!string.IsNullOrEmpty(value.WriteBackData))
                {
                    this.WriteBackData.Text = value.WriteBackData.Replace("<", "&lt").Replace(">", "&gt");
                }
                if (!string.IsNullOrEmpty(value.ReceiveData))
                {
                    this.ReceiveData.Text = value.ReceiveData.Replace("<", "&lt").Replace(">", "&gt");
                }
                try
                {
                    if (value.WriteBackDataJSON != "")
                    {
                        var dt = JsonHelper.JsonToDataTable(value.WriteBackDataJSON);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                int id = e.Row.RowIndex + 1;
                e.Row.Cells[0].Text = id.ToString();
            }
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                int id = e.Row.RowIndex + 1;
                e.Row.Cells[0].Text = id.ToString();
            }
        }
    }
}