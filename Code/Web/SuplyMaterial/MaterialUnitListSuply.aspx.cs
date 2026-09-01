using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using System.Data;
using System.Reflection;
using SKT.Common.Model;
using Newtonsoft.Json;

namespace SKT.LeanMES.Web.SuplyMaterial
{
    public partial class MaterialUnitListSuply : BasePage
    {
        public int materialStatusId = -1;
        SKT.Common.Model.SearchSettings searchSettings;
        protected void Page_Load(object sender, EventArgs e)
        {

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterial));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MaterialUnitId";
            this.Master.DefaultSortExpression = "MaterialUnitId DESC";

            string staus = ddlMaterialStatus.SelectedValue;
            searchSettings = new SKT.Common.Model.SearchSettings();
            if (this.txtSerialNumber.Value != "")
            {
                searchSettings.ExtensionCondition += " and a.SerialNumber like '%" + this.txtSerialNumber.Value + "%'";
            }
            if (this.txtItem.Value != "")
            {
                searchSettings.ExtensionCondition += string.Format(" and  (b.ItemCode like '%{0}%' or  b.ItemName  like '%{1}%'  or  b.ItemSpec   like '%{2}%' )  ", this.txtItem.Value.Trim(), this.txtItem.Value.Trim(), this.txtItem.Value.Trim());
            }
            if (this.txtPOorder.Value != "")
            {
                searchSettings.ExtensionCondition += " and  F.POrder  like '" + this.txtPOorder.Value.Trim() + "%'";
            }
            if(this.DeliveryOrder.Value!="")
            {
                searchSettings.ExtensionCondition += " and  F.DeliveryOrder  like '" + this.DeliveryOrder.Value.Trim() + "%'";

            }
            if (this.txtVendorName.Value != "")
            {
                searchSettings.ExtensionCondition += " and  c.vendorname  like '" + this.txtVendorName.Value.Trim() + "%'";
            }
            if (this.txtLotCode.Value != "")
            {
                searchSettings.ExtensionCondition += " and  a.LotCode ='" + this.txtLotCode.Value.Trim() + "' ";
            }
            if (this.txtCreateBy.Value != "")
            {
                searchSettings.ExtensionCondition += " and  m1.CName ='" + this.txtCreateBy.Value.Trim() + "' ";
            }
            int userTypeId = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserType;
            //if (!IsPostBack)
            //{
            //this.txtDateFrom.Value = DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd hh:mm:ss");
            //this.txtDateTo.Value = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
            //searchSettings.ExtensionCondition += " and a.MaterialUnitId = -1 ";
            //}
            //else
            //{


            //}
            if (userTypeId != -1)
            {
                //如果是供应商查询，不能看到物料入库以后的记录-1,0,6,7,12,15
                searchSettings.ExtensionCondition += "   AND c.SupplierId =" + userTypeId + " AND A.Status IN (-1,0,6,7,12,15) ";
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
            if (staus != "-2" && !string.IsNullOrEmpty(staus))
            {
                searchSettings.ExtensionCondition += " and a.[Status] =" + Convert.ToInt32(staus) + "";
            }
            if (txtDateFrom != "" && txtDateTo == "")
            {
                if (!DateTime.TryParse(txtDateFrom, out tmFrom))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
                }
                else
                {
                    searchSettings.ExtensionCondition += " and ( a.CreateDateTime > '" + Convert.ToDateTime(dateFrom).AddDays(1) + "')";
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
                    searchSettings.ExtensionCondition += " and (a.CreateDateTime <= '" + Convert.ToDateTime(dateTo).AddDays(1) + "')";
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
                    searchSettings.ExtensionCondition += " and ( a.createdatetime >= '" + Convert.ToDateTime(dateFrom) + "'  and  a.createdatetime < '" + Convert.ToDateTime(dateTo).AddDays(1) + "') ";
                }
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (!IsPostBack)
            {
                bindDropMaterialStatus();
            }
            else
            {
                //导出
                if (Request["hdnOperate"].ToLower() == "exportexcel")
                {
                    AppCode.Utility.ExcelHelper.ExportToExcel(GetDgvToTable(searchSettings), DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    //去掉小数点
            //    e.Row.Cells[7].Text = e.Row.Cells[7].Text.ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
            //    e.Row.Cells[8].Text = e.Row.Cells[8].Text.ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
            //}
        }
        public void bindDropMaterialStatus()
        {

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            List<SKT.LeanMES.Material.Model.MaterialUnitInfo> materialUnit = new SKT.LeanMES.Material.BLL.MaterialUnit().GetMaterialAllStatus(0, -1, "", searchSettings);
            ddlMaterialStatus.DataSource = materialUnit;
            ddlMaterialStatus.DataTextField = "MaterialStatus";
            ddlMaterialStatus.DataValueField = "StatusId";
            ddlMaterialStatus.DataBind();
            this.ddlMaterialStatus.Items.Insert(0, new ListItem(Resources.lang.Choose, "-2"));
        }

        //protected void btnExport_Click(object sender, EventArgs e)
        //{
        //    AppCode.Utility.ExcelHelper.ExportToExcel(GetDgvToTable(searchSettings), DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");
        //}

        private DataTable GetDgvToTable(SearchSettings searchSettings)
        {
            DataTable dt = new DataTable();

            SKT.LeanMES.Material.BLL.MaterialUnit bll = new SKT.LeanMES.Material.BLL.MaterialUnit();
            dt = ListToDataTable(bll.GetMaterialInfoAllSuply(0, 100000, "", searchSettings));
            DataTable dt1 = new DataTable();
            DataColumn dc = new DataColumn();
            dt1.Columns.Add("采购单号", typeof(string));
            dt1.Columns.Add("送货单号", typeof(string));
            dt1.Columns.Add("物料条码", typeof(string));
            dt1.Columns.Add("物料编码", typeof(string));
            dt1.Columns.Add("物料名称", typeof(string));
            dt1.Columns.Add("物料规格", typeof(string));
            dt1.Columns.Add("批次号", typeof(string));
            dt1.Columns.Add("总数量", typeof(string));
            dt1.Columns.Add("剩余数量", typeof(string));
            dt1.Columns.Add("供应商", typeof(string));
            dt1.Columns.Add("当前状态", typeof(string));
            dt1.Columns.Add("创建人", typeof(string));
            dt1.Columns.Add("生成物料条码时间", typeof(string));
            //dt1.Columns.Add(dc);
            DataRow dr;
            for (int i = 0, j = dt.Rows.Count; i < j; i++)
            {
                dr = dt1.NewRow();
                dr[0] = dt.Rows[i]["POorder"].ToString();
                dr[1] = dt.Rows[i]["DeliveryOrder"].ToString();
                dr[2] = dt.Rows[i]["SerialNumber"].ToString();
                dr[3] = dt.Rows[i]["ItemCode"].ToString();
                dr[4] = dt.Rows[i]["ItemName"].ToString();
                dr[5] = dt.Rows[i]["ItemSpec"].ToString();
                dr[6] = dt.Rows[i]["LotCode"].ToString();
                dr[7] = dt.Rows[i]["Quantity"].ToString();
                dr[8] = dt.Rows[i]["BalanceQty"].ToString();
                dr[9] = dt.Rows[i]["VendorName"].ToString();
                dr[10] = dt.Rows[i]["Statusname"].ToString();
                dr[11] = dt.Rows[i]["CreateBy"].ToString();
                dr[12] = dt.Rows[i]["CreateDateTime"].ToString();

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