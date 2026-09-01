using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Material.BLL;
using System.Data;
using SKT.LeanMES.Web.AppCode.Utility;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Web.Material
{
    public partial class PrepareMaterialEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterial));
            Int32 preprareMatId = Convert.ToInt32(Request.QueryString["ID"]);
            if (preprareMatId > 0)
            {
                this.PageData = (new PrepareMatForm()).ShowPrepareMatFormInfo(preprareMatId);
            }
            if (this.IsPostBack)
            {
                string procName = Request.Form["hdnOperation"];
                if (procName != "")
                {
                    //获取对应参数
                    string param = Request.Form["hdnPararms"];              //获取参数
                    string paramValue = Request.Form["hdnPararmValue"];     //获取参数值
                    string filename = Request.Form["hdnFileName"];
                    this.ExportToExcel(param, paramValue, procName, filename);
                }
            }
        }

        //导出EXCEL
        public void ExportToExcel(string parmsStr, string parmsValueStr, string procName, string filename)
        {
            try
            {
                //DataTable dt = (new SKT.MES.Report.BLL.Report()).DataTableToExcel(parmsStr, parmsValueStr, procName);
                //   ExcelHelper.ExportToSpreadsheet(dt, "Report_" + DateTime.Now.ToString("yyyyMMdd")+".xls");
                //ExcelHelper.ExportToExcel(dt, filename + DateTime.Now.ToString("yyyyMMdd") + ".xls", "UTF-8");
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, true);
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private PrepareMatFormInfo PageData
        {
            set
            {
                this.hdnFormSource.Value = "001";
                this.txtDeptCode.Text = value.DepCode;
                this.txtWhCode.Text = value.WhCode;
                this.txtUserDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.PMDate);
                this.txtMoCode.Text = value.MOCode;
                this.hdnDeptCode.Value = value.DepCode;
                this.hdnWhCode.Value = value.WhCode;
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}