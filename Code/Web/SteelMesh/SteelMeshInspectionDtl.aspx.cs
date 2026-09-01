using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelMeshInspectionDtl : BasePage
    {
        private int columnIndex_SMIDDateTime = -1;
        private int columnIndex_SMIDUpdateDateTime = -1;
        SKT.Common.Model.SearchSettings searchSettings;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_SMIDDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "SMIDDateTime")) + 1;
            columnIndex_SMIDUpdateDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "SMIDUpdateDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));

            String idString = Request.QueryString["ID"];

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SMIDId";
            this.Master.DefaultSortExpression = "SMIDId DESC"; //也可不赋值



            searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition += " SMIDSMIId="+ idString + "  ";
            if (!string.IsNullOrEmpty(this.txtSMIPCode.Text))
            {
                searchSettings.AddCondition("SMIPCode", this.txtSMIPCode.Text);
            }
            if (!string.IsNullOrEmpty(this.txtSMIPName.Text))
            {
                searchSettings.AddCondition("SMIPName", this.txtSMIPName.Text);
            }
   


            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            this.GridView1.PageSize = 20;
        }


        protected void btnExport_Click(object sender, EventArgs e)
        {
            var dt = GetDgvToTable(searchSettings);
            if (dt == null)
            {
                Response.Write("<script>alert('没有任何数据!')</script>");
                return;
            }
            AppCode.Utility.ExcelHelper.ExportToExcel(dt, "钢网刮刀检验报告检验项目报表_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
        }
        private DataTable GetDgvToTable(SKT.Common.Model.SearchSettings searchSettings)
        {
            DataTable dt = new DataTable();

            SKT.LeanMES.SteelMesh.BLL.SteelMeshInspectionLogic bll = new SKT.LeanMES.SteelMesh.BLL.SteelMeshInspectionLogic();
            var list = bll.GetAllSteelMeshInspectionDtl(0, 100000, "", searchSettings);
            if (list.Count <= 0)
            {
                return null;
            }
            dt = ListToDataTable(list);
            DataTable dt1 = new DataTable();
            DataColumn dc = new DataColumn();
            dt1.Columns.Add("治具编号", typeof(string));
            dt1.Columns.Add("治具名称", typeof(string));
            dt1.Columns.Add("检验项目代码", typeof(string));
            dt1.Columns.Add("检验项目名称", typeof(string));
            dt1.Columns.Add("录入方式", typeof(string));
            dt1.Columns.Add("判定标准", typeof(string));
            dt1.Columns.Add("单位", typeof(string));
            dt1.Columns.Add("检验结果", typeof(string));
            dt1.Columns.Add("检验人", typeof(string));
            dt1.Columns.Add("检验时间", typeof(string));
            dt1.Columns.Add("创建人", typeof(string));
            dt1.Columns.Add("创建时间", typeof(string));
            dt1.Columns.Add("更新人", typeof(string));
            dt1.Columns.Add("更新时间", typeof(string));
            dt1.Columns.Add("备注", typeof(string));
            DataRow dr;
            for (int i = 0, j = dt.Rows.Count; i < j; i++)
            {
                dr = dt1.NewRow();
                dr[0] = dt.Rows[i]["EquipmentCode"].ToString();
                dr[1] = dt.Rows[i]["EquipmentName"].ToString();
                dr[2] = dt.Rows[i]["SMIPCode"].ToString();
                dr[3] = dt.Rows[i]["SMIPName"].ToString();
                dr[4] = dt.Rows[i]["SMIPEntryMode"].ToString();
                dr[5] = dt.Rows[i]["SMIPCriterion"].ToString();
                dr[6] = dt.Rows[i]["SMIPUnit"].ToString();
                dr[7] = dt.Rows[i]["SMIDResult"].ToString();
                dr[8] = dt.Rows[i]["SMIDUserName"].ToString();
                dr[9] = dt.Rows[i]["SMIDDateTime"].ToString();
                dr[10] = dt.Rows[i]["SMIDAddUserName"].ToString();
                dr[11] = dt.Rows[i]["SMIDAddDateTime"].ToString();
                dr[12] = dt.Rows[i]["SMIDUpdateUserName"].ToString();
                dr[13] = dt.Rows[i]["SMIDUpdateDateTime"].ToString();
                dr[14] = dt.Rows[i]["SMIDRem"].ToString();
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
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //10改为columnIndex_SMIDDateTime
                //14改为columnIndex_SMIDUpdateDateTime
                if (e.Row.Cells[columnIndex_SMIDDateTime].Text == "9999/12/31 0:00:00")
                {
                    e.Row.Cells[columnIndex_SMIDDateTime].Text = "";
                }
                if (e.Row.Cells[columnIndex_SMIDUpdateDateTime].Text == "9999/12/31 0:00:00")
                {
                    e.Row.Cells[columnIndex_SMIDUpdateDateTime].Text = "";
                }
            }
        }
    }
}