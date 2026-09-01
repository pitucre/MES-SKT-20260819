using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.DIPPackaging
{
    public partial class DIPPackagingPlanList : BasePage
    {
        private int columnIndex_ModifyDateTime = -1;
        SKT.Common.Model.SearchSettings searchSettings;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "DPPId";
            this.Master.DefaultSortExpression = "DPPId DESC"; //也可不赋值

            searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ItemCode", txtItemCode.Text);
            searchSettings.AddCondition("LineName", txtLineName.Text);
            searchSettings.AddCondition("OrderNO", txtOrderNO.Text);
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Container.BLL.DIPPackagingPlan bll = new SKT.LeanMES.Container.BLL.DIPPackagingPlan();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //12改为columnIndex_ModifyDateTime
                if (e.Row.Cells[columnIndex_ModifyDateTime].Text == "9999/12/31 0:00:00" || e.Row.Cells[columnIndex_ModifyDateTime].Text == "0001/1/1 0:00:00")
                {
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
                }

            }
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            var dt = GetDgvToTable(searchSettings);
            if (dt == null)
            {
                Response.Write("<script>alert('没有任何数据!')</script>");
                return;
            }
            AppCode.Utility.ExcelHelper.ExportToExcel(dt, "DIP包装计划信息_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
        }
        private DataTable GetDgvToTable(SKT.Common.Model.SearchSettings searchSettings)
        {
            DataTable dt = new DataTable();

            SKT.LeanMES.Container.BLL.DIPPackagingPlan bll = new SKT.LeanMES.Container.BLL.DIPPackagingPlan();
            var list = bll.GetAll(0, 100000, "", searchSettings);
            if (list.Count <= 0)
            {
                return null;
            }
            dt = ListToDataTable(list);
            DataTable dt1 = new DataTable();
            DataColumn dc = new DataColumn();
            dt1.Columns.Add("楼层", typeof(string));
            dt1.Columns.Add("线别", typeof(string));
            dt1.Columns.Add("工单号", typeof(string));
            dt1.Columns.Add("料号", typeof(string));
            dt1.Columns.Add("料名称", typeof(string));
            dt1.Columns.Add("产品描述", typeof(string));
            dt1.Columns.Add("计划生产数量", typeof(string));
            dt1.Columns.Add("计划时间", typeof(string));
            dt1.Columns.Add("创建时间", typeof(string));
            dt1.Columns.Add("备注", typeof(string));
            DataRow dr;
            int k = 0;
            for (int i = 0, j = dt.Rows.Count; i < j; i++)
            {
                k = -1;
                dr = dt1.NewRow();
                dr[++k] = dt.Rows[i]["FName"].ToString();
                dr[++k] = dt.Rows[i]["LineName"].ToString();
                dr[++k] = dt.Rows[i]["OrderNO"].ToString();
                dr[++k] = dt.Rows[i]["ItemCode"].ToString();
                dr[++k] = dt.Rows[i]["ItemName"].ToString();
                dr[++k] = dt.Rows[i]["ItemDes"].ToString();
                dr[++k] = dt.Rows[i]["PlanQty"].ToString();
                dr[++k] = DateTime.Parse(dt.Rows[i]["PlanDatiTime"].ToString()).ToString("yyyy-MM-dd");
                dr[++k] = dt.Rows[i]["CreateDateTime"].ToString();
                dr[++k] = dt.Rows[i]["Remark"].ToString();
                dt1.Rows.Add(dr);
            }
            return dt1;
        }
        public DataTable ListToDataTable<T>(List<T> entitys)
        {
            //检查实体集合不能为空
            if (entitys == null || entitys.Count < 1)
            {
                throw new Exception("需转换的集合为空");
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
    }
}