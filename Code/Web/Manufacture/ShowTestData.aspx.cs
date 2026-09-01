using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Manufacture.BLL;

namespace SKT.LeanMES.Web.Manufacture
{
    public partial class ShowTestData : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string recordID = Request.QueryString["RecordID"].ToString();
            InfoCenter infocenter = new InfoCenter();
            string root = Request.Url.ToString().Substring(0, Request.Url.ToString().IndexOf(Request.Path)) + Request.ApplicationPath;            

            try
            {
                string xmlData = infocenter.GetTextDataXMLByID(recordID);
                Response.Write(xmlData);
                Response.End();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
                Response.Write(ex.InnerException != null ? ex.InnerException.Message : "");
                Response.End();
            }
        }
    }
}