using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.CommonDataSource.Model;

namespace SKT.LeanMES.Web.CommonDataSource
{
    public partial class ImportExcelConfigView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Int32 id = Convert.ToInt32(Request.QueryString["ID"]);
            var bll = new SKT.LeanMES.CommonDataSource.BLL.ImportDataConfig();


            if (!IsPostBack)
            {
                if (id > -1)
                {
                    ImportDataConfigInfo model = null;

                    model = bll.GetInfo(id);
                    if (model != null)
                    {
                        PageData = model;
                    }
                }
            }
        }


        private ImportDataConfigInfo PageData
        {
            set
            {
                lblIdcName.InnerText = value.IdcName;
                lblFileNames.InnerText = value.FileNames;
                lblProcName.InnerText = value.ProcName;
                lblRemark.InnerText = value.Remark;
            }
        }
    }
}