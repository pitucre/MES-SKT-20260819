using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using SKT.LeanMES.Plan.BLL;
using SKT.LeanMES.Plan.Model;

namespace SKT.LeanMES.Web.Plan
{
    public partial class WorkTimeSetEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(WorkTimeSetEdit));
          
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new WorkTimeSet()).GetInfo(Convert.ToInt32(idString));
                }
            } 
        }

        [AjaxMethod]
        public void Edit(WorkTimeSetInfo entity)
        {
            try
            {
                entity.CreateBy = AccountController.GetCurrentUserInfo().UserName;
                new WorkTimeSet().Edit(entity);
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private WorkTimeSetInfo PageData
        {
            set
            {
                this.hdnLineId.Value = value.LineId.ToString();
                this.txtLineName.Text = value.LineName;
                //this.hdnResourceId.Value = value.ResourceId.ToString();
                //this.txtResName.Text = value.ResName;
                this.txtSetDate.Text = value.SetDate.ToString();
                this.txtName.Text = value.Name;
                this.txtTimes.Text = value.Times.ToString();
              
               
            }
        }

     
    }
}