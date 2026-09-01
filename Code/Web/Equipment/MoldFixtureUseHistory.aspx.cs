using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MoldFixtureUseHistory : BasePage
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
            this.Master.RecordIDField = "EquipmentUseHistoryId";
            this.Master.DefaultSortExpression = "EquipmentUseHistoryId DESC"; //也可不赋值

            if (!IsPostBack)
            {
                this.txtDateFrom.Value = DateTime.Now.AddDays(-60).ToString("yyyy-MM-dd hh:mm:ss");
                this.txtDateTo.Value = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
            }

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
            string orderNo = txtOrderNo.Text.Trim();
            //string parentEquipmentType = ddlParentEquipmentType.SelectedValue;

            searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition += " 1=1  ";
            if (!string.IsNullOrEmpty(this.txtEquipmentName.Text))
            {
                searchSettings.AddCondition("EquipmentName", this.txtEquipmentName.Text);
            }
            if (!string.IsNullOrEmpty(this.txtEquipmentCode.Text))
            {
                searchSettings.AddCondition("EquipmentCode", this.txtEquipmentCode.Text);
            }
            if (!String.IsNullOrEmpty(ddlTxnCode.SelectedValue) && ddlTxnCode.SelectedValue != "-1")
            {
                searchSettings.AddCondition("TxnCode", ddlTxnCode.SelectedValue);
            }

            if (txtDateFrom != "" && txtDateTo == "")
            {
                if (!DateTime.TryParse(txtDateFrom, out tmFrom))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " and ( OperatorTime > '" + Convert.ToDateTime(dateFrom).AddDays(1).ToString("yyyy-MM-dd HH:mm:ss") + "')";
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
                    searchSettings.ExtensionCondition += " and ( OperatorTime <= '" + Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy-MM-dd HH:mm:ss") + "')";
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
                    searchSettings.ExtensionCondition += " and ( OperatorTime >= '" + Convert.ToDateTime(dateFrom).ToString("yyyy-MM-dd HH:mm:ss") + "'  and  OperatorTime < '" + Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy-MM-dd HH:mm:ss") + "') ";
                }
            }
            //工单号
            if (!string.IsNullOrEmpty(orderNo))
            {
                searchSettings.AddCondition("OrderNO", orderNo);
            }
            //上级设备类型
            //if (!string.IsNullOrEmpty(parentEquipmentType))
            //{
            //    searchSettings.ExtensionCondition += " AND EquipmentTypeNametwo='" + parentEquipmentType + "'";

            //}
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
            AppCode.Utility.ExcelHelper.ExportToExcel(dt, "钢网刮刀操作记录报表_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
        }
        private DataTable GetDgvToTable(SKT.Common.Model.SearchSettings searchSettings)
        {
            DataTable dt = new DataTable();

            var bll = new SKT.LeanMES.Equipment.BLL.MoldFixture();
            var list = bll.GetAll(0, 100000, "", searchSettings);
            if (list.Count <= 0)
            {
                return null;
            }
            dt = ListToDataTable(list);
            DataTable dt1 = new DataTable();
            DataColumn dc = new DataColumn();
            dt1.Columns.Add("治具名称", typeof(string));
            dt1.Columns.Add("治具编号", typeof(string));
            dt1.Columns.Add("操作类型", typeof(string));
            dt1.Columns.Add("操作前状态", typeof(string));
            dt1.Columns.Add("操作后状态", typeof(string));
            dt1.Columns.Add("工单号", typeof(string));
            dt1.Columns.Add("操作用户", typeof(string));
            dt1.Columns.Add("操作时间", typeof(string));
            DataRow dr;
            for (int i = 0, j = dt.Rows.Count; i < j; i++)
            {
                dr = dt1.NewRow();
                dr[0] = dt.Rows[i]["EquipmentName"].ToString();
                dr[1] = dt.Rows[i]["EquipmentCode"].ToString();
                dr[2] = dt.Rows[i]["TxnCode"].ToString();
                dr[3] = dt.Rows[i]["Status"].ToString();
                dr[4] = dt.Rows[i]["Status_TO"].ToString();
                dr[5] = dt.Rows[i]["OrderNO"].ToString();
                dr[6] = dt.Rows[i]["Operator"].ToString();
                dr[7] = dt.Rows[i]["OperatorTime"].ToString();
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
            //if (e.Row.RowIndex != -1)
            //{
            //    if (e.Row.Cells[9].Text == "0")
            //    {
            //        e.Row.Cells[9].Text = "";
            //    }
            //}
        }
    }
}