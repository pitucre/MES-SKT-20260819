using Newtonsoft.Json;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Material.BLL;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionFileManage : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                GetFileType();
            }
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "CreateDateTime desc"; //也可不赋值
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ItemCode", this.txtitemcode.Text);
            searchSettings.AddCondition("SupplierName", this.txtsuppliername.Text);
            if (ddlltype.SelectedIndex != 0)
            {
                searchSettings.AddCondition("FileType", ddlltype.Text);
            }


            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                string userName = AccountController.GetCurrentUser().UserName;
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string saveFileName = this.hidFileSaveName.Value.Trim();
                    string dataSource = this.hidDataSource.Value.Trim();
                    try
                    {
                        string ids = Request.Form["hdnIdString"].ToString();
                        MaterialIQC bll = new MaterialIQC();
                        if (string.Equals(dataSource, "0"))
                        {
                            //删除 检验文档管理—载入 的数据
                            bll.DeleteFile(ids, AccountController.GetCurrentUser().UserName);
                        }
                        else
                        {
                            //删除 IQC检验单 中的上传的数据
                            bll.DeleteSysUpLoadFileFile(ids, AccountController.GetCurrentUser().UserName);
                        }
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                        return;
                    }
                    string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/Inspection");
                    string filePath = path + "/" + saveFileName; //Request.Form["filename"];
                    File.Delete(filePath);
                }
            }
        }

        public void GetFileType()
        {
            MaterialIQC bll = new MaterialIQC();
            var list = bll.GetFileInfo(0, 200, "", null);
            var q = from p in list

                    group p by p.FileType into g

                    select g;

            ddlltype.DataSource = q.ToList();
            ddlltype.DataTextField = "key";

            ddlltype.DataBind();
            ddlltype.Items.Insert(0, new ListItem("请选择", "0"));

        }
    }
}