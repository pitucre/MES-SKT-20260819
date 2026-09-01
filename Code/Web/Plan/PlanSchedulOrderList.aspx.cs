using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Plan
{
    public partial class PlanSchedulOrderList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            //if (IsPostBack)
            //{
            //    if (Request.Form["hdnOperate"].ToLower() == "Excel")
            //    {
            //        try
            //        {
            //            ExportToExcel();
            //            WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
            //        }
            //        catch (Exception ex)
            //        {
            //            WebHelper.HandleException(String.Empty, ex, true);
            //        }
            //    }
            //}
        }
        public void ExportToExcel()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(SKT.Common.DAL.Marshal.SQLHelper.MESConnString))
                {
                    if (sqlcon.State != ConnectionState.Open)
                        sqlcon.Open();

                    SqlCommand sqlcom = new SqlCommand();
                    sqlcom.Connection = sqlcon;
                    sqlcom.CommandType = CommandType.StoredProcedure;
                    sqlcom.CommandText = "uspGetOrderGanttData";

                    sqlcom.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = "@ProdOrderId",
                        SqlDbType = SqlDbType.Int,
                        Value = -1
                    });
                    sqlcom.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = "@OrderNo",
                        SqlDbType = SqlDbType.VarChar,
                        Value = ""
                    });
                    DataSet ds = new DataSet();
                    using (SqlDataAdapter sda = new SqlDataAdapter(sqlcom))
                    {
                        sda.Fill(ds);
                    }



                    if (ds != null && ds.Tables.Count == 1)
                    {
                        ExcelHelper.ExportToExcel(ds.Tables[0], "工单计划图" + DateTime.Now.ToString("yyyyMMdd") + ".xls", "UTF-8");

                    }
                }
              
              
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, true);
            }
        }
    }

    
}