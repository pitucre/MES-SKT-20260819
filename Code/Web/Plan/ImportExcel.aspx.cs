using System;
using System.Web;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Data;
using System.IO;

namespace SKT.LeanMES.Web.Plan
{
    public partial class ImportExcel : System.Web.UI.Page
    {
        public bool IsPostBack = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request["PlanTypeID"] != null && Request["PlanTypeID"].ToString() != "")
                {
                    this.hfPlanTypeID.Value = Request["PlanTypeID"];
                }
                IsPostBack = true;
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
            string saveName = DateTime.Now.ToString("yyyy-MM-dd-HH-MM-ss") + ".xls";
            //用来保存Excel保存后的路径
            string source = "";
            try
            {
                FilesHelper.FilesUpload(this.FileUpload1, new string[] { ".xls", ".xlsx" }, 2,
                    Server.MapPath(WebHelper.TempFileRoot), saveName, out source);
            }
            catch(Exception exc)
            {
                Response.Write("<script> alert('"+exc.Message+"')</script>");
                return;
            }
            DataTable DT1 = ExcelHelper.QueryExcel(source, hfSheetName.Value, WebHelper.ExcelConnString);

            //去后Excel转成Table后面没用的字段
            for (int i = DT1.Columns.Count; i >= 0; i--)
            {
                if (DT1.Columns[i - 1].ColumnName == "F" + i)
                {
                    DT1.Columns.Remove(DT1.Columns[i - 1].ColumnName);
                }
                else
                {
                    break;
                }
            }

            //对定义的不能为空的数据进行判断-----start
            string requiredFieldStr = "";  //需要验证Excel中不能为空的数据
            if (hfPlanTypeID.Value == "1")
            {
                //获取成品需要验证Excel中不能为空的数据
                requiredFieldStr = this.hfRequiredField.Value; 
            }
            else
            {
                //获取半成品需要验证Excel中不能为空的数据
                requiredFieldStr = this.hfRequiredField_Semi_Finished.Value;
            }
            string[] requiredField = requiredFieldStr.Split(',');
            string str = "";
            if (requiredField != null && requiredField.Length > 0)
            {
                for (int i = 0; i < requiredField.Length && requiredField[i].Length>0; i++)
                {

                    if (str.Length == 0)
                    {
                        str += requiredField[i] + " is null ";
                    }
                    else
                    {
                        str += requiredField[i] + " or " + requiredField[i] + " is null ";
                    }
                }
            }
            DataView dv = new DataView(DT1);
            try
            {
                dv.RowFilter = str;
            }
            catch {
                Response.Write("<script> alert('" + Resources.Messages.FormatErrorDownloadTemplate + "')</script>");
                return;
            }
            DataTable dt_New = dv.ToTable();
            int len = 0;
            if (str.Length > 0)
            {
                len = dt_New.Rows.Count;
            }
            //对定义的不能为空的数据进行判断-----end

            if (len > 0)
            {

                Response.Write("<script> alert('" + requiredFieldStr + Resources.Messages.NotNull + "');</script>");
            }
            else
            {
                try
                {
                    int affectRow = 0;
                    if (this.hfPlanTypeID.Value == "1")//调用成品计划批量插入
                    {
                        affectRow = new SKT.LeanMES.Plan.BLL.Plan().EditFinished(DT1);
                    }
                    else//调用半成品计划批量插入
                    {
                        affectRow = new SKT.LeanMES.Plan.BLL.Plan().EditSemi_Finished(DT1);
                    }
                    SKT.LeanMES.Web.AppCode.Utility.FilesHelper.DeleteFiles(source);
                    if (affectRow > 0)
                    {
                        Response.Write("<script> parent.window.Refresh();</script>");
                    }
                }
                catch(Exception ex)
                {
                    Response.Write("<script> alert('" + Resources.Messages.FormatErrorDownloadTemplate + "');</script>");
                    return;
                }
            }
        }

        
    }
}