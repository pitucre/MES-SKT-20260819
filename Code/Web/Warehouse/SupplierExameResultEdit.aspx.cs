using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class SupplierExameResultEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSupplierExame));

            int Year = DateTime.Now.Year;
            for (int i = 0; i < 5; i++)
            {
                ddlYear.Items.Add(new ListItem((Year - i).ToString() + "年", (Year - i).ToString()));
            }

            if (this.IsPostBack)
            {
                try
                {
                    //导出
                    if (this.hdnOperate.Value.ToLower() == "exportexcel")
                    {
                        string examType = hdnDataString.Value.Split(',')[0];
                        string examData = hdnDataString.Value.Split(',')[1];

                        SupplierExameResult bll = new SupplierExameResult();
                        List<SupplierExameContentResultInfo> info = bll.SearchExamData(examType, examData, true);
                        
                        CommonMethod.ExportToSpreadsheet(ToDataTableTow(info), "供应商考核成绩" + DateTime.Now.ToString("yyyyMMddhhmmss"));
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                }
            
            }
        }

        public  DataTable ToDataTableTow(IList list)
        {
            DataTable result = new DataTable();
            if (list.Count > 0)
            {
                PropertyInfo[] propertys = list[0].GetType().GetProperties();

                foreach (PropertyInfo pi in propertys)
                {
                    result.Columns.Add(pi.Name, pi.PropertyType);
                }
                for (int i = 0; i < list.Count; i++)
                {
                    ArrayList tempList = new ArrayList();
                    foreach (PropertyInfo pi in propertys)
                    {
                        object obj = pi.GetValue(list[i], null);
                        tempList.Add(obj);
                    }
                    object[] array = tempList.ToArray();
                    result.LoadDataRow(array, true);
                }
            }
            return result;
        }
        
    }
}