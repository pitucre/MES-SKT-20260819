using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.Labels
{
	public partial class LabelPrint : BasePage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            AjaxPro.Utility.RegisterTypeForAjax(typeof(LabelPrint));
            this.txtZPLValue.Text = @"^XA
^PRA 
^LH0,0^FS
^LL152
^MD0
^MNY
^LH0,0^FS
^BY2,3.0^FO60,46^BCN,100,N,N,N
^FR
^FD%SN%^FS
^FT60,190
^A0N,44,46^FD%SN%
^FS
^PQ1,0,0,N
^XZ";
		}

        [AjaxPro.AjaxMethod]
        public DataTable GetPrintDocs()
        {
            string cmdTxt = " select DocumentName, LabelDocumentId,Print_Qty, TemplateName from dbo.Basal_LabelDocument order by DocumentName ";
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
            return dt;
        }

        [AjaxPro.AjaxMethod]
        public string GetPrintTemplate(string printTemplateName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@PrintTemplateName",SqlDbType.NVarChar,-1)
            };

            parms[0].Value = printTemplateName;
            parms[0].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetPrintTemplateByName", parms);
            return Convert.ToString(parms[0].Value);
        }
	}
}