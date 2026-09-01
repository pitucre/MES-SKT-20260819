using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class SetOfBooksAdd : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxOrganization));

            if (!IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    txtDepartCode.Enabled = false;
                    SKT.LeanMES.DBservice.BLL.DbService bll = new DBservice.BLL.DbService();
                    Dictionary<string, object> Params = new Dictionary<string, object>();
                    Params["ID"] = idString;
                    DataSet ds =  bll.GetListDs("uspGetDataDistributionInfo", Newtonsoft.Json.JsonConvert.SerializeObject(Params));

                    if (ds != null && ds.Tables.Count>0 && ds.Tables[0].Rows.Count>0)
                    {
                        txtDepartCode.Text = ds.Tables[0].Rows[0]["DepartCode"].ToString();
                        txtDepartName.Text = ds.Tables[0].Rows[0]["DepartName"].ToString();
                        txtMesUrl.Text = ds.Tables[0].Rows[0]["MesUrl"].ToString();
                        txtDataBaseName.Text = ds.Tables[0].Rows[0]["DataBaseName"].ToString();
                        txtDBLinkName.Text = ds.Tables[0].Rows[0]["DBLinkName"].ToString();
                        this.ckIsEnabled.Checked =Convert.ToBoolean(ds.Tables[0].Rows[0]["IsEnabled"]);
                    }
                }
                else
                {
                    
                }
            }            
        }
    }
}