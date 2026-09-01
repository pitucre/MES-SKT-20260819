using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Product.Model;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialRequestEdit: BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
           
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                this.ddlPrioritys.Items.Add(new ListItem(Resources.lang.High,"1"));
                this.ddlPrioritys.Items.Add(new ListItem(Resources.lang.Middle,"2"));
                this.ddlPrioritys.Items.Add(new ListItem(Resources.lang.Low,"3"));
                this.ddlPrioritys.SelectedValue = "3";
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    int id = Convert.ToInt32(idString);
                    this.PageData = (new MaterialRequest()).GetInfo(id);

                }
                else
                {
                    this.txtFormNO.Text = Resources.lang.SystemCreate;
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private MaterialRequestInfo PageData
        {
            set
            {
                this.txtFormNO.Text = value.FormNO;
                this.hfDepartId.Value = Convert.ToString(value.DepartId);
                this.hfRequestUserId.Value = Convert.ToString(value.RequestUserId);
                this.hfWOId.Value = Convert.ToString(value.WOId);
                this.txtUserDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.UserDate);

                SKT.Common.Organization.BLL.Organization org = new SKT.Common.Organization.BLL.Organization();
                SKT.Common.Organization.Model.OrganizationInfo depInfo = org.GetInfo(value.DepartId);
                if (depInfo != null)
                {
                    txtDepartment.Text = depInfo.DepartName;
                }

                SKT.Common.Account.BLL.Users userBll = new SKT.Common.Account.BLL.Users();
                SKT.Common.Account.Model.MembershipInfo membershipInfo =  userBll.GetInfo(value.RequestUserId);
                if (membershipInfo != null)
                {
                    this.txtRequestUser.Text = membershipInfo.UserName;
                }

                this.ddlPrioritys.SelectedValue = value.Prioritys.ToString() ;

                //SKT.LeanMES.ProcessForm.BLL.ProcessForm proBll = new LeanMES.ProcessForm.BLL.ProcessForm();
                //SKT.LeanMES.ProcessForm.Model.ProcessFormInfo processFormInfo = proBll.GetInfo(value.WOId);
                //if(processFormInfo!=null)
                //{
                //    this.txtWONumber.Text = processFormInfo.FormNO;           
                //}
            }
        }
    }

    public class MaterialRequestMemberEntity
    {
        public int MaterialRequestId { get; set; }

        public string MaterialRequestMemberIdS { get; set; }
        public int MaterialRequestMemberId { get; set; }

        public string ItemIdS { get; set; }
        public int ItemId { get; set; }

        public string ItemName { get; set; }

        public string RequestQtyS { get; set; }
        public decimal RequestQty { get; set; }

        public string RemarkS { get; set; }
        public string Remark { get; set; }

        public string IteRev { get; set; }
        public string Unit { get; set; }

        public string ItemDesc { get; set; }
    }
}