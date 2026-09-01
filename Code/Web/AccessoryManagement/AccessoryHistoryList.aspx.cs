using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.AccessoryManagement
{
    public partial class AccessoryHistoryList : BasePage
    {
        SKT.Common.Model.SearchSettings searchSettings;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "AccessoryId";
            this.Master.DefaultSortExpression = "CreateTime DESC"; //也可不赋值

            searchSettings = new SKT.Common.Model.SearchSettings();
            if (!string.IsNullOrEmpty(txtAccessoryHistoryNO2.Text))
            {
                searchSettings.AddCondition("AccessoryCodoe", txtAccessoryHistoryNO2.Text);
            }
            if (!string.IsNullOrEmpty(txtSN.Text))
            {
                searchSettings.AddCondition("SerialNumber", txtSN.Text);
            }
            if (dlltype.SelectedValue != "-1")
            {
                searchSettings.AddCondition("OpType", dlltype.SelectedValue);
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            var dt = GetDgvToTable(searchSettings);
            if (dt == null)
            {
                Response.Write("<script>alert('没有任何数据!')</script>");
                return;
            }
            AppCode.Utility.ExcelHelper.ExportToExcel(dt, "辅料操作记录报表_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
        }
        private DataTable GetDgvToTable(SKT.Common.Model.SearchSettings searchSettings)
        {
            DataTable dt = new DataTable();

            SKT.LeanMES.AccessoryManagement.BLL.AccessoryHistory bll = new LeanMES.AccessoryManagement.BLL.AccessoryHistory();
            var list = bll.GetAll(0, 100000, "", searchSettings);
            if (list.Count <= 0)
            {
                return null;
            }
            dt = ListToDataTable(list);
            DataTable dt1 = new DataTable();
            DataColumn dc = new DataColumn();
            dt1.Columns.Add("序列号", typeof(string));
            dt1.Columns.Add("辅料编码", typeof(string));
            dt1.Columns.Add("辅料名称", typeof(string));
            dt1.Columns.Add("操作类型", typeof(string));
            dt1.Columns.Add("创建人", typeof(string));
            dt1.Columns.Add("创建时间", typeof(string));
            DataRow dr;
            for (int i = 0, j = dt.Rows.Count; i < j; i++)
            {
                dr = dt1.NewRow();
                dr[0] = dt.Rows[i]["SerialNumber"].ToString();
                dr[1] = dt.Rows[i]["AccessoryCodoe"].ToString();
                dr[2] = dt.Rows[i]["AccessoryName"].ToString();
                dr[3] = dt.Rows[i]["OpTypeName"].ToString();
                dr[4] = dt.Rows[i]["CreateBy"].ToString();
                dr[5] = dt.Rows[i]["CreateTime"].ToString();
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