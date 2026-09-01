using SKT.Common.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Reflection;

namespace SKT.LeanMES.Web.Material
{
    public partial class CPExpiredDateList : BasePage
    {
        int i = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxReinspection));


            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ProdOrderID";
            this.Master.DefaultSortExpression = "ProdOrderID DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
           

            string strWhere = "";
            if (!string.IsNullOrEmpty(txtItemCode.Text))
            {
                strWhere = "ItemCode like '%" + txtItemCode.Text + "%'";
            }
            if (!string.IsNullOrEmpty(txtCBarCode.Text))
            {
                strWhere = "CBarCode like '%" + txtCBarCode.Text + "%'";
            }
            if (!string.IsNullOrEmpty(txtWarehouse.Text))
            {
                strWhere = "CWhCode like '%" + txtWarehouse.Text + "%'";
            }
            if (!string.IsNullOrEmpty(txtOrderNo.Text))
            {
                strWhere = "OrderNo like '%" + txtOrderNo.Text + "%'";
            }
            if (!string.IsNullOrEmpty(txtItemName.Text))
            {
                strWhere = "ItemName like '%" + txtItemName.Text + "%'";
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
            dt = ListToDataTable(bll.GetAllByListCP(0, 100000, "", searchSettings));
            DataTable dt1 = new DataTable();
            DataColumn dc = new DataColumn();
            dt1.Columns.Add("工单号", typeof(string));
            dt1.Columns.Add("产品编码", typeof(string));
            dt1.Columns.Add("产品名称", typeof(string));
            dt1.Columns.Add("重检数量", typeof(string));
            dt1.Columns.Add("仓库编码", typeof(string));
            dt1.Columns.Add("库位条码", typeof(string));
            dt1.Columns.Add("入库日期", typeof(string));
            dt1.Columns.Add("过期时间", typeof(string)); 
            dt1.Columns.Add("已过期(天)", typeof(string));
            dt1.Columns.Add("重检次数", typeof(string));
            

            DataRow dr;
            for (int i = 0, j = dt.Rows.Count; i < j; i++)
            {
                dr = dt1.NewRow();
                dr[0] = dt.Rows[i]["OrderNO"].ToString();
                dr[1] = dt.Rows[i]["ItemCode"].ToString();
                dr[2] = dt.Rows[i]["ItemName"].ToString();
                dr[3] = dt.Rows[i]["BalanceQty"].ToString();
                dr[4] = dt.Rows[i]["CWhCode"].ToString();
                dr[5] = dt.Rows[i]["CBarCode"].ToString();
                dr[6] = dt.Rows[i]["DateCode"].ToString();
                dr[7] = dt.Rows[i]["ExpiredDate"].ToString();
                dr[8] = dt.Rows[i]["SurplusExpiredDate"].ToString();
                dr[9] = dt.Rows[i]["CheckNumber"].ToString();

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

        }
    }
}