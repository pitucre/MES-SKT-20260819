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
    public partial class AccessoryUseTable : BasePage
    {
        SKT.Common.Model.SearchSettings searchSettings;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));


            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "AccessoryId";
            this.Master.DefaultSortExpression = "AccessoryId DESC"; //也可不赋值

            if (!IsPostBack)
            {
                this.txtDateFrom.Value = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd hh:mm:ss");
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

            searchSettings.ExtensionCondition += " OpType=4   ";

            if (!string.IsNullOrEmpty(this.txtLineName.Text))
            {
                searchSettings.AddCondition("LineName", this.txtLineName.Text);
            }
            if (!string.IsNullOrEmpty(this.txtOrderNo.Text))
            {
                searchSettings.AddCondition("OrderNo", this.txtOrderNo.Text);
            }
            if (!string.IsNullOrEmpty(this.txtSerialNumber.Text))
            {
                searchSettings.AddCondition("SerialNumber", this.txtSerialNumber.Text);
            }
            if (!string.IsNullOrEmpty(this.txtAccessoryCodoe.Text))
            {
                searchSettings.AddCondition("AccessoryCodoe", this.txtAccessoryCodoe.Text);
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
            AppCode.Utility.ExcelHelper.ExportToExcel(dt, "辅料使用记录报表_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
        }
        private DataTable GetDgvToTable(SKT.Common.Model.SearchSettings searchSettings)
        {
            DataTable dt = new DataTable();

            SKT.LeanMES.AccessoryManagement.BLL.Accessory bll = new LeanMES.AccessoryManagement.BLL.Accessory();
            var list = bll.GetUseAll(0, 100000, "", searchSettings);
            if (list.Count <= 0)
            {
                return null;
            }
            dt = ListToDataTable(list);
            DataTable dt1 = new DataTable();
            DataColumn dc = new DataColumn();
            dt1.Columns.Add("线别", typeof(string));
            dt1.Columns.Add("工序", typeof(string));
            dt1.Columns.Add("工单号", typeof(string));
            dt1.Columns.Add("辅料GRN", typeof(string));
            dt1.Columns.Add("辅料料号", typeof(string));
            dt1.Columns.Add("辅料名称", typeof(string));
            dt1.Columns.Add("辅料状态", typeof(string));
            dt1.Columns.Add("创建人", typeof(string));
            dt1.Columns.Add("创建时间", typeof(string));
            DataRow dr;
            for (int i = 0, j = dt.Rows.Count; i < j; i++)
            {
                dr = dt1.NewRow();
                dr[0] = dt.Rows[i]["LineName"].ToString();
                dr[1] = dt.Rows[i]["Station"].ToString();
                dr[2] = dt.Rows[i]["OrderNo"].ToString();
                dr[3] = dt.Rows[i]["SerialNumber"].ToString();
                dr[4] = dt.Rows[i]["AccessoryCodoe"].ToString();
                dr[5] = dt.Rows[i]["AccessoryName"].ToString();
                dr[6] = dt.Rows[i]["StatusName"].ToString();
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
    }
}