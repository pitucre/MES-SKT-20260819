using SKT.LeanMES.Molding.BLL;
using SKT.LeanMES.Molding.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class MaterialBurnView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var id = Request.QueryString["ID"];
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "BurnMemberId";
            this.Master.DefaultSortExpression = "BurnMemberId DESC"; //也可不赋值
        
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("BurnId", id);
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (!this.IsPostBack)
            {
                if (!string.IsNullOrEmpty(id) && Convert.ToInt32(id) > 0)
                {
                    this.PageData = (new MaterialBurn()).GetInfo(Convert.ToInt32(id));
                }
            }
        }

        /// <summary>
        /// 设 置页面上的数据。
        /// </summary>
        private MaterialBurnInfo PageData
        {
            set
            {
                this.ltrSoftName.Text = value.SoftName;
                this.ltrTestMachine.Text = value.TestMachine;
                this.ltrCustomer.Text = value.Customer;
                this.ltrVerifyCode.Text = value.VerifyCode;
                this.ltrReceiveDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.ReceiveDate);
                this.ltrUpdateContent.Text = value.UpdateContent;
                this.ltrSoftPath.Text = value.SoftPath;
                this.ltrDownloadDir.Text = value.DownloadDir;
                this.ltrRemark.Text = value.Remark;
                this.ltrSoftCreator.Text = value.SoftCreator;
            }
        }

    }
}