using System;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Data;
using System.IO;
namespace SKT.LeanMES.Web.Plan
{
    public partial class Prompt_Semi_Finished : System.Web.UI.Page
    {
        public bool IsPostBack = false;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (IsPostBack)
            {
                IsPostBack = true;
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string saveName = DateTime.Now.ToString("yyyy-MM-dd-HH-MM-ss") + ".xls";
            string source = "";

            FilesHelper.FilesUpload(this.FileUpload1, new string[] { ".xls", ".xlsx" }, 2, Server.MapPath(WebHelper.TempFileRoot), saveName, out source);

            DataTable DT1 = ExcelHelper.QueryExcel(source, 1, WebHelper.ExcelConnString);

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
            string requiredFieldStr = hfRequiredField.Value;
            string[] requiredField = requiredFieldStr.Split(',');
            string str = "";
            if (requiredField != null && requiredField.Length > 0)
            {
                for (int i = 0; i < requiredField.Length; i++)
                {

                    if (str.Length == 0)
                    {
                        str += requiredField[i] + " is null ";
                    }
                    else
                    {
                        str += requiredField[i] + " or 物料编码 is null ";
                    }
                }
            }
            DataView dv = new DataView(DT1);
            dv.RowFilter = str;
            DataTable dt_New = dv.ToTable();
            int len = dt_New.Rows.Count;
            //对定义的不能为空的数据进行判断-----end

            if (len > 0)
            {

                Response.Write("<script> alert('" + requiredFieldStr + "不能为空数据');</script>");
            }
            else
            {
                int affectRow = new SKT.LeanMES.Plan.BLL.Plan().EditSemi_Finished(DT1);
                File.Delete(saveName);
                if (affectRow > 0)
                {
                    Response.Write("<script> parent.window.refresh();</script>");
                }
            }

        }
    }
}