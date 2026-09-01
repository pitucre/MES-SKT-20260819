using System;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data;
using System.Reflection;
using SKT.Common.Model;
using System.Web.UI;
using System.Linq;

namespace SKT.LeanMES.Web.Anormal
{
    public partial class AnormalList : BasePage
    {
        private int columnIndex_Status = -1;
        private int columnIndex_IsLineStop = -1;

        SKT.Common.Model.SearchSettings searchSettings;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Status = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Status")) + 1;
            columnIndex_IsLineStop = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "IsLineStop")) + 1;

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "AnormalId";
            this.Master.DefaultSortExpression = "AnormalId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            searchSettings = new SKT.Common.Model.SearchSettings();

            var txtAnormalNo = Server.HtmlEncode(this.txtAnormalNo.Text);
            var txtAnormalTypeName = Server.HtmlEncode(this.txtAnormalTypeName.Text);
            var txtAnormalName = Server.HtmlEncode(this.txtAnormalName.Text);
            var txtLineName = Server.HtmlEncode(this.txtLineName.Text);
            var ddlStatus = this.ddlStatus.SelectedValue.ToString();
            var ckbIsLineStopped = (this.ckbIsLineStopped.SelectedValue.ToString() == "-1") ? "" : this.ckbIsLineStopped.SelectedValue.ToString();
            var txtStartTime = Server.HtmlEncode(this.txtStartTime.Text);
            var txtEndTime = Server.HtmlEncode(this.txtEndTime.Text);

            var strWhere = " 1=1 ";
            if (!string.IsNullOrEmpty(txtAnormalTypeName))
            {
                strWhere += " and [AnormalTypeName] like '" + txtAnormalTypeName + "%'";
            }

            if (!string.IsNullOrEmpty(txtAnormalNo))
            {
                strWhere += " and [AbnormalDocumentNo] like '" + txtAnormalNo + "%'";
            }

            if (!string.IsNullOrEmpty(txtAnormalName))
            {
                strWhere += " and [AnormalName] like '" + txtAnormalName + "%'";
            }
            if (!string.IsNullOrEmpty(txtLineName))
            {
                strWhere += " and [LineName] like '" + txtLineName + "%'";
            }

            if (!string.IsNullOrEmpty(ddlStatus) && ddlStatus != "-1")
            {
                strWhere += " and [Status] = " + ddlStatus;
            }

            if (!string.IsNullOrEmpty(txtStartTime))
            {
                strWhere += " and CreateDateTime >= cast('" + txtStartTime + "' as datetime)";
            }

            if (!string.IsNullOrEmpty(txtEndTime))
            {
                strWhere += " and CreateDateTime < cast('" + txtEndTime + "' as datetime) + 1";
            }

            if (!string.IsNullOrEmpty(ckbIsLineStopped))
            {
                if (ckbIsLineStopped == "0")
                {
                    strWhere += " and [IsLineStop] = 0";
                }
                else
                {
                    strWhere += " and [IsLineStop] = 1";
                }
            }

            if (!string.IsNullOrEmpty(strWhere))
                searchSettings.ExtensionCondition = strWhere;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {
                var userName = AccountController.GetCurrentUser().UserName;
                try
                {
                    if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
                    {
                        ProdAnormal.BLL.Anormal bll = new ProdAnormal.BLL.Anormal();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "exportexcel")
                    {
                        AppCode.Utility.ExcelHelper.ExportToExcel(GetDgvToTable(searchSettings), DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(userName, ex, true);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //9改为columnIndex_IsLineStop
                //11改为columnIndex_Status
                //是否停线
                e.Row.Cells[columnIndex_IsLineStop].Text = Convert.ToBoolean(e.Row.Cells[columnIndex_IsLineStop].Text) ? "已停线" : "未停线";
                //状态
                var status = e.Row.Cells[columnIndex_Status].Text;
                switch (status)
                {
                    case "1":
                        e.Row.Cells[columnIndex_Status].Text = "已建立";
                        break;
                    case "2":
                        e.Row.Cells[columnIndex_Status].Text = "已关闭";
                        break;
                    default:
                        e.Row.Cells[columnIndex_Status].Text = "";
                        break;
                }
            }
        }

        private DataTable GetDgvToTable(SearchSettings searchSettings)
        {
            DataTable dt = new DataTable();

            ProdAnormal.BLL.Anormal bll = new ProdAnormal.BLL.Anormal();
            var listProdAnormal = bll.GetAll(0, -1, "", searchSettings);
            if (listProdAnormal != null && listProdAnormal.Count > 0)
            {
                dt = ListToDataTable(listProdAnormal);
            }
            DataTable dt1 = new DataTable();
            DataColumn dc = new DataColumn();
            dt1.Columns.Add("异常单号", typeof(string));
            dt1.Columns.Add("线别", typeof(string));
            dt1.Columns.Add("异常类型", typeof(string));
            dt1.Columns.Add("异常名称", typeof(string));
            dt1.Columns.Add("工位", typeof(string));
            dt1.Columns.Add("异常录入人", typeof(string));
            dt1.Columns.Add("异常录入时间", typeof(string));
            dt1.Columns.Add("异常部门", typeof(string));
            dt1.Columns.Add("状态", typeof(string));
            dt1.Columns.Add("异常描述", typeof(string));
            dt1.Columns.Add("是否停线", typeof(string));
            dt1.Columns.Add("时长", typeof(string));
            dt1.Columns.Add("时长单位", typeof(string));
            dt1.Columns.Add("影响人数", typeof(string));
            dt1.Columns.Add("修改人", typeof(string));
            dt1.Columns.Add("修改时间", typeof(string));
            //dt1.Columns.Add(dc);
            DataRow dr;
            for (int i = 0, j = dt.Rows.Count; i < j; i++)
            {
                dr = dt1.NewRow();

                dr[0] = dt.Rows[i]["AbnormalDocumentNo"].ToString();
                dr[1] = dt.Rows[i]["LineName"].ToString();
                dr[2] = dt.Rows[i]["AnormalTypeName"].ToString();
                List<AnormalObject> list = JsonConvert.DeserializeObject<List<AnormalObject>>("[" + dt.Rows[i]["AnormalObject"].ToString() + "]");
                dr[3] = list[0].anormalname;
                dr[4] = dt.Rows[i]["Station"].ToString();
                dr[5] = dt.Rows[i]["CreateBy"].ToString();
                dr[6] = dt.Rows[i]["CreateDateTime"].ToString();
                dr[7] = dt.Rows[i]["DeptName"].ToString();
                dr[8] = (dt.Rows[i]["Status"].ToString() == "2") ? "已关闭" : "已建立";
                dr[9] = dt.Rows[i]["Descriptions"].ToString();
                dr[10] = (dt.Rows[i]["IsLineStop"].ToString().ToLower()=="true")?"已停线":"未停线";
                dr[11] = dt.Rows[i]["AbnormalTimeLength"].ToString();
                dr[12] = dt.Rows[i]["AbnormalUnit"].ToString();
                dr[13] = dt.Rows[i]["EffectPerson"].ToString();
                dr[14] = dt.Rows[i]["ModifyBy"].ToString();
                dr[15] = dt.Rows[i]["ModifyDateTime"].ToString();

                dt1.Rows.Add(dr);                
            } 
            return dt1;
        }

        public DataTable ListToDataTable<T>(List<T> entitys)
        {
            //检查实体集合不能为空
            if (entitys == null || entitys.Count < 1)
            {
                throw new Exception("列表暂无数据！");
            }
            //取出第一个实体的所有Propertie
            Type entityType = entitys[0].GetType();
            PropertyInfo[] entityProperties = entityType.GetProperties();

            //生成DataTable的structure
            //生产代码中，应将生成的DataTable结构Cache起来，此处略
            DataTable dt = new DataTable();
            for (int i = 0; i < entityProperties.Length; i++)
            {
                //dt.Columns.Add(entityProperties[i].Name, entityProperties[i].PropertyType);
                dt.Columns.Add(entityProperties[i].Name);
            }
            //将所有entity添加到DataTable中
            foreach (object entity in entitys)
            {
                //检查所有的的实体都为同一类型
                if (entity.GetType() != entityType)
                {
                    throw new Exception("要转换的集合元素类型不一致");
                }
                object[] entityValues = new object[entityProperties.Length];
                for (int i = 0; i < entityProperties.Length; i++)
                {
                    entityValues[i] = entityProperties[i].GetValue(entity, null);
                }
                dt.Rows.Add(entityValues);
            }
            return dt;
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            
        }
    }

    [Serializable]
    public class AnormalObject
    {
        //{"order":"SR16080598","orderid":210,"itemcode":"61.02.415000-001","itemid":-1,"anormalid":-1}
        public string order { get; set; }
        public string orderid { get; set; }
        public string itemcode { get; set; }
        public string itemid { get; set; }
        public string anormalid { get; set; }
        public string anormalname { get; set; }
    }
}