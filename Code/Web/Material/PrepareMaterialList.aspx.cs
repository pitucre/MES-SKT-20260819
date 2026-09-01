using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.Material
{
    public partial class PrepareMaterialList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "TransferId";
            this.Master.DefaultSortExpression = "CreateDateTime DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            //string TransferNumber = this.txtTransferNumber.Value;
            //searchSettings.AddCondition("TransferOrder", TransferNumber);

            //string txtDateFrom = this.txtDateFrom.Value.Trim();
            // string txtDateTo = this.txtDateTo.Value.Trim();
            //string dateFrom = "";
            //string dateTo = "";

            //dateFrom = txtDateFrom;
            //dateTo = txtDateTo;
            //this.txtDateFrom.Value = dateFrom;
            //this.txtDateTo.Value = dateTo;
            //DateTime tmFrom;
            //DateTime tmTo;
            //if (txtDateFrom != "" && txtDateTo == "")
            //{
            //    if (!DateTime.TryParse(txtDateFrom, out tmFrom))
            //    {
            //        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
            //    }
            //    else
            //    {
            //        searchSettings.ExtensionCondition += "( CreateDateTime > '" + Convert.ToDateTime(dateFrom).AddDays(1) + "')";
            //    }
            //}
            //else if (txtDateTo != "" && txtDateFrom == "")
            //{
            //    if (!DateTime.TryParse(txtDateTo, out tmTo))
            //    {
            //        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
            //    }
            //    else
            //    {
            //        searchSettings.ExtensionCondition += "(CreateDateTime <= '" + Convert.ToDateTime(dateTo).AddDays(1) + "')";
            //    }
            //}
            //else if (txtDateFrom != "" && txtDateTo != "")
            //{
            //    //判断日期
            //    if (!DateTime.TryParse(txtDateFrom, out tmFrom) || !DateTime.TryParse(txtDateTo, out tmTo))
            //    {
            //        ClientScript.RegisterStartupScript(this.GetType(), "", "<script> alert('请输入正确的时间格式（yyyy-MM-dd）')</script>");
            //    }
            //    else
            //    {
            //        //判断日期
            //        searchSettings.ExtensionCondition += " CreateDateTime between '" + Convert.ToDateTime(dateFrom).AddDays(1) + "' and '" + Convert.ToDateTime(dateTo).AddDays(1) + "' ";
            //    }
            //}
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "PMID";
            this.Master.DefaultSortExpression = "PMID DESC"; //也可不赋值
            string sourceCode = "001";
            searchSettings.AddCondition("SourceCode", sourceCode);
            string strWhere = "";

            string FromNo = this.txtPrepareForm.Text;
            string DepartName = this.txtDeptName.Text;
            string CWhName = this.txtWhName.Text;
            string CreateBy = this.txtCreateBy.Text;
            string ProductOrder = this.txtProductOrdeNo.Text;
            int processId =-1;
            if(Request.Form["hdnPrepareListId"]!=null)
            {
                processId=Convert.ToInt32(Request.Form["hdnPrepareListId"].ToString());
            }             
            if (processId != -1 || this.txtPrepareForm.Text != "" || this.txtDeptName.Text != "" || this.txtWhName.Text != "" || this.txtCreateBy.Text != "" || this.txtProductOrdeNo.Text != "")
            {
                if (processId != -1)
                {
                    strWhere = " PrepareMatFormId =" + processId;
                }
                if (FromNo == "*")
                {
                    searchSettings.AddCondition("FormNo", FromNo);
                }
                else
                {
                    if (FromNo != "")
                    {
                        strWhere += String.IsNullOrEmpty(strWhere) ? " FormNo like '%" + FromNo + "%'" : " and  FormNo like '%" + FromNo + "%'";
                    }
                }
                if (DepartName == "*")
                {
                    searchSettings.AddCondition("DepartName", DepartName);
                }
                else
                {
                    if (!string.IsNullOrEmpty(DepartName))
                    {
                        strWhere += String.IsNullOrEmpty(strWhere) ? " DepartName like '%" + DepartName + "%'" : " and  DepartName like '%" + DepartName + "%'";
                    }
                }

                if (ProductOrder == "*")
                {
                    searchSettings.AddCondition("MoCode", ProductOrder);
                }
                else
                {
                    if (!string.IsNullOrEmpty(ProductOrder))
                    {
                        strWhere += String.IsNullOrEmpty(strWhere) ? " MoCode like '%" + ProductOrder + "%'" : " and  MoCode like '%" + ProductOrder + "%'";
                    }
                }
                if (CWhName == "*")
                {
                    searchSettings.AddCondition("CWhName", CWhName);
                }
                else
                {
                    if (!string.IsNullOrEmpty(CWhName))
                    {
                        strWhere += String.IsNullOrEmpty(strWhere) ? " CWhName like '%" + CWhName + "%'" : " and  CWhName like '%" + CWhName + "%'";
                    }
                }
                if (CreateBy == "*")
                {
                    searchSettings.AddCondition("CreateBy", CreateBy);
                }
                else
                {
                    if (!string.IsNullOrEmpty(CreateBy))
                    {
                        strWhere += String.IsNullOrEmpty(strWhere) ? " CreateBy like '%" + CreateBy + "%'" : " and  CreateBy like '%" + CreateBy + "%'";
                    }
                }
                this.Master.SearchSettings = searchSettings;
                this.GridView1.PageIndex = 0;
            }

        }
    }
}