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
    public partial class AccessoryChambrierenRecord : BasePage
    {
        private int columnIndex_ACRStopTime = -1;
        SKT.Common.Model.SearchSettings searchSettings;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ACRStopTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ACRStopTime")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));


            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ACRId";
            this.Master.DefaultSortExpression = "ACRId DESC"; //也可不赋值

            if (!IsPostBack)
            {
                this.txtDateFrom.Value = DateTime.Now.AddDays(-180).ToString("yyyy-MM-dd hh:mm:ss");
                this.txtDateTo.Value = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
            }

            searchSettings = new SKT.Common.Model.SearchSettings();

            string txtDateFrom = this.txtDateFrom.Value.Trim();
            string txtDateTo = this.txtDateTo.Value.Trim();
            string dateFrom = "";
            string dateTo = "";
            dateFrom = txtDateFrom;
            dateTo = txtDateTo;
            this.txtDateFrom.Value = dateFrom;
            this.txtDateTo.Value = dateTo;
            DateTime tmFrom;
            DateTime tmTo;

            searchSettings.ExtensionCondition += " 1=1   ";

            if (!string.IsNullOrEmpty(this.txtACRSerialNumber.Text))
            {
                searchSettings.AddCondition("ACRSerialNumber", this.txtACRSerialNumber.Text);
            }
            if (!string.IsNullOrEmpty(this.txtItemCode.Text))
            {
                searchSettings.AddCondition("ItemCode", this.txtItemCode.Text);
            }

            if (txtDateFrom != "" && txtDateTo == "")
            {
                if (!DateTime.TryParse(txtDateFrom, out tmFrom))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " and ( CreateTime > '" + Convert.ToDateTime(dateFrom).AddDays(1).ToString("yyyy-MM-dd") + "')";
                }
            }
            else if (txtDateTo != "" && txtDateFrom == "")
            {
                if (!DateTime.TryParse(txtDateTo, out tmTo))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " and ( CreateTime <= '" + Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy-MM-dd") + "')";
                }
            }
            else if (txtDateFrom != "" && txtDateTo != "")
            {
                //判断日期
                if (!DateTime.TryParse(txtDateFrom, out tmFrom) || !DateTime.TryParse(txtDateTo, out tmTo))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " and ( CreateTime >= '" + Convert.ToDateTime(dateFrom).ToString("yyyy-MM-dd") + "'  and  CreateTime < '" + Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy-MM-dd") + "') ";
                }
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
            AppCode.Utility.ExcelHelper.ExportToExcel(dt, "辅料解冻记录报表_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
        }
        private DataTable GetDgvToTable(SKT.Common.Model.SearchSettings searchSettings)
        {
            DataTable dt = new DataTable();

            SKT.LeanMES.AccessoryManagement.BLL.AccessoryChambrierenRecordLogic bll = new LeanMES.AccessoryManagement.BLL.AccessoryChambrierenRecordLogic();
            var list = bll.GetAll(0, 100000, "", searchSettings);
            if (list.Count <= 0)
            {
                return null;
            }
            dt = ListToDataTable(list);
            DataTable dt1 = new DataTable();
            DataColumn dc = new DataColumn();
            dt1.Columns.Add("辅料物料条码", typeof(string));
            dt1.Columns.Add("辅料物料料号", typeof(string));
            dt1.Columns.Add("辅料物料名称", typeof(string));
            dt1.Columns.Add("开始解冻时间", typeof(string));
            dt1.Columns.Add("结束解冻时间", typeof(string));
            dt1.Columns.Add("解冻次数", typeof(string));
            dt1.Columns.Add("解冻状态", typeof(string));
            dt1.Columns.Add("记录人", typeof(string));
            dt1.Columns.Add("记录时间", typeof(string));
            DataRow dr;
            for (int i = 0, j = dt.Rows.Count; i < j; i++)
            {
                dr = dt1.NewRow();
                dr[0] = dt.Rows[i]["ACRSerialNumber"].ToString();
                dr[1] = dt.Rows[i]["ItemCode"].ToString();
                dr[2] = dt.Rows[i]["ItemName"].ToString();
                dr[3] = dt.Rows[i]["ACRStartTime"].ToString();
                dr[4] = dt.Rows[i]["ACRStopTime"].ToString() == "9999/12/31 0:00:00" ? "" : dt.Rows[i]["ACRStopTime"].ToString();
                dr[5] = dt.Rows[i]["ACRCountString"].ToString();
                dr[6] = dt.Rows[i]["ACRStatusString"].ToString();
                dr[7] = dt.Rows[i]["CreateBy"].ToString();
                dr[8] = dt.Rows[i]["CreateTime"].ToString();
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
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //5改为columnIndex_ACRStopTime
                if (e.Row.Cells[columnIndex_ACRStopTime].Text == "9999/12/31 0:00:00")
                {
                    e.Row.Cells[columnIndex_ACRStopTime].Text = "无";
                }
            }
        }
    }
}