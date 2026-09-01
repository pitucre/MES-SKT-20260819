using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Navigation.BLL;
using SKT.LeanMES.Navigation.Model;

namespace SKT.LeanMES.Web.Navigation
{
    public partial class NavigationItemEdit : BasePage
    {

        //private string numbertype = "";
        //private int NextID = 0;
        public Int32 NavigationId;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxNavigation));
                if (!this.IsPostBack)
                {
                    BindNavigationgpName();

                }
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SKT.LeanMES.Navigation.BLL.Navigationitem bll = new SKT.LeanMES.Navigation.BLL.Navigationitem();
                    NavigationitemInfo model = bll.GetInfo(Convert.ToInt32(idString));

                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
            catch(Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            
        }

        private NavigationitemInfo PageData
        {
            set
            {               
                //this.ddlNavigationgpName.SelectedValue =
                if(ddlNavigationgpName.Items.FindByText(value.NavigationgpName) != null)
                {
                    ddlNavigationgpName.Items.FindByText(value.NavigationgpName).Selected = true;
                }
                this.txtNavigationName.Text = value.NavigationName.ToString();                
                this.txtSequence.Text = value.Sequence.ToString();
                this.txtUrl.Text = value.Url.ToString();
                this.ddlTarget.SelectedValue = value.Target.ToString();
            }
        }

        protected void BindNavigationgpName()
        {
            SKT.LeanMES.Navigation.BLL.Navigation bll = new LeanMES.Navigation.BLL.Navigation();
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            //this.ddlNavigationgpName.DataSource = new SKT.LeanMES.Navigation.BLL.Navigation().GetAll(0, 100, "ID", searchSettings);
            var list = bll.GetAll(0, 100, "ID", searchSettings);
            this.ddlNavigationgpName.DataSource = list;
            this.ddlNavigationgpName.DataTextField = "NavigationgpName";
            this.ddlNavigationgpName.DataValueField = "ID";        
            this.ddlNavigationgpName.DataBind();           
            this.ddlNavigationgpName.Items.Insert(0,new ListItem(Resources.lang.Choose, ""));
            
            //if (ddlNavigationgpName.Items.FindByValue(numbertype) != null)
            //{
            //    this.ddlNavigationgpName.SelectedValue = numbertype;
            //    if (NextID > 0)
            //    {
            //        this.ddlNavigationgpName.Enabled = false;
            //    }
            //}
        }     

    }
}