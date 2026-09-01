using SKT.Common.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class ReinspectionHistory : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxReinspection));


            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ReinspectionDtlId";
            this.Master.DefaultSortExpression = "ReinspectionDtlId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            //searchSettings.AddCondition("Status", "2");

            string strWhere = " 1=1 ";
            if (!string.IsNullOrEmpty(txtCheckNo.Text))
            {
                strWhere += " AND ReinspectionNo like '%" + txtCheckNo.Text + "%'";
            }
            if (!string.IsNullOrEmpty(txtItemName.Text))
            {
                strWhere += " AND ItemCode like '%" + txtItemName.Text + "%'";
            }
            if (dllStatus.SelectedValue != "-1")
            {
                strWhere += " AND CheckResult like " + dllStatus.SelectedValue + "";
            }
            if (!string.IsNullOrEmpty(txtCheckUserName.Text))
            {
                strWhere += " AND UserName like '%" + txtCheckUserName.Text + "%'";
            }
            if (!string.IsNullOrEmpty(txtVendorName.Text))
            {
                strWhere += " AND VendorName like '%" + txtVendorName.Text + "%'";
            }

            searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? strWhere : " and  " + strWhere;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (IsPostBack)
            {
                //导出
                if (Request["hdnOperate"].ToLower() == "exportexcel")
                {
                    AppCode.Utility.ExcelHelper.ExportToExcel(GetDgvToTable(searchSettings), DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
                }
            }
        }

        private DataTable GetDgvToTable(SearchSettings searchSettings)
        {
            DataTable dt = new DataTable();

            SKT.LeanMES.Material.BLL.Reinspection bll = new SKT.LeanMES.Material.BLL.Reinspection();
            dt = ListToDataTable(bll.GetReinspections(0, 100000, "", searchSettings));
            DataTable dt1 = new DataTable();
            DataColumn dc = new DataColumn();
            dt1.Columns.Add("重检单号", typeof(string));
            dt1.Columns.Add("物料条码", typeof(string));
            dt1.Columns.Add("产品编码", typeof(string));
            dt1.Columns.Add("重检数量", typeof(string));
            dt1.Columns.Add("仓库编码", typeof(string));
            dt1.Columns.Add("库位条码", typeof(string));
            dt1.Columns.Add("检验结果", typeof(string));
            dt1.Columns.Add("检验人", typeof(string));
            dt1.Columns.Add("重检时间", typeof(string));
            dt1.Columns.Add("重检次数", typeof(string));
            dt1.Columns.Add("修改人", typeof(string));
            dt1.Columns.Add("修改时间", typeof(string));
            dt1.Columns.Add("供应商名称", typeof(string));
            dt1.Columns.Add("备注", typeof(string));

            DataRow dr;
            for (int i = 0, j = dt.Rows.Count; i < j; i++)
            {
                dr = dt1.NewRow();
                dr[0] = dt.Rows[i]["ReinspectionNo"].ToString();
                dr[1] = dt.Rows[i]["SerialNumber"].ToString();
                dr[2] = dt.Rows[i]["ItemCode"].ToString();
                dr[3] = dt.Rows[i]["Quantity"].ToString();
                dr[4] = dt.Rows[i]["CWhCode"].ToString();
                dr[5] = dt.Rows[i]["CBarCode"].ToString();
                dr[6] = dt.Rows[i]["CheckResultName"].ToString();
                dr[7] = dt.Rows[i]["UserName"].ToString();
                dr[8] = dt.Rows[i]["CreateDateTime"].ToString();
                dr[9] = dt.Rows[i]["CheckNumber"].ToString();
                dr[10] = dt.Rows[i]["FinishBy"].ToString();
                dr[11] = dt.Rows[i]["FinishDateTime"].ToString();
                dr[12] = dt.Rows[i]["VendorName"].ToString();
                dr[13] = dt.Rows[i]["Remark"].ToString();

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

        protected void GridView1_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            //if (e.Row.RowIndex != -1)
            //{
            //    e.Row.Cells[2].Text = e.Row.Cells[2].Text == "0" ? "待送检 " : (e.Row.Cells[2].Text == "1" ? "待检验" : "已检验");
            //    e.Row.Cells[6].Text = e.Row.Cells[6].Text == "9999/12/31 0:00:00" ? "" : e.Row.Cells[6].Text;
            //    e.Row.Cells[8].Text = e.Row.Cells[8].Text == "9999/12/31 0:00:00" ? "" : e.Row.Cells[8].Text;
            //}   
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //11改为columnIndex_ModifyBy
                //12改为columnIndex_ModifyTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyTime].Text = "";
            }
        }
    }
}