using System;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Certification
{
    public partial class CertChooseList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "CertificationId";
            this.Master.DefaultSortExpression = "Certification";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("Certification", this.txtCert.Text.Trim());
            searchSettings.ExtensionCondition = "[CertificationId] NOT IN (SELECT [CertificationId] FROM [SYS_CertificationMember] WHERE [UserID] = " + Request.QueryString["ID"] + ") ";

            this.Master.SearchSettings = searchSettings;

            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}