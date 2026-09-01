using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace SKT.LeanMES.Web.Product
{
    public partial class BurnSoftList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "BurnId";
            this.Master.DefaultSortExpression = "BurnId desc";
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("SoftName", this.txtSoftName.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Material.BLL.BurnSoft bll = new SKT.LeanMES.Material.BLL.BurnSoft();
                    //bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
                if (Request.Form["UrlString"] != null)
                {
                    DownShoft(Request.Form["UrlString"]);
                }
            }
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取,页面未调用此方法，不做修改
                string url = e.Row.Cells[9].Text.Trim();
                url = url.Replace("E:\\dev-unitstrong2\\UniStrong\\Code\\Web\\TempFile\\", "Http://");
                e.Row.Cells[9].Text = url;
            }
        }

        public void DownShoft(string url)
        {
            string fileName = url.Substring(url.LastIndexOf('\\') + 1); //客户端保存的文件名  
            string filePath = url;// Server.MapPath(url);//路径  
            FileInfo fileInfo = new FileInfo(filePath);
            Response.Clear();
            Response.ClearContent();
            Response.ClearHeaders();
            Response.AddHeader("Content-Disposition", "attachment;filename=\"" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8) + "\"");
            Response.AddHeader("Content-Length", fileInfo.Length.ToString());
            Response.AddHeader("Content-Transfer-Encoding", "binary");
            Response.ContentType = "application/octet-stream";
            Response.WriteFile(fileInfo.FullName);
            Response.Flush();
            Response.End();
        }
    }
}