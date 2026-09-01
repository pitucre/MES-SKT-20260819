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
    public partial class LineChangingTimeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(LineChangingTimeEdit));
          
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new LineChangingTime()).GetInfo(Convert.ToInt32(idString));
                }
            } 
        }

        [AjaxMethod]
        public void Edit(LineChangingTimeInfo entity)
        {
            try
            {
                entity.CreateBy = AccountController.GetCurrentUserInfo().UserName;
                new LineChangingTime().Edit(entity);
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private LineChangingTimeInfo PageData
        {
            set
            {
                this.hdnLineId.Value = value.LineId.ToString();
                this.txtLineName.Text = value.LineName;

                this.hdnResourceId.Value = value.ResourceId.ToString();
                this.txtResName.Text = value.ResName;

                this.hdnItemOneId.Value = value.ItemOneId.ToString();
                this.txtItemOneCode.Text = value.ItemOneCode;

                this.hdnItemTwoId.Value = value.ItemTwoId.ToString();
                this.txtItemTwoCode.Text = value.ItemTwoCode;

                this.txtLineChangingTime.Text = value.LineChangingTime.ToString();
                this.txtRemark.Text = value.Remark;
               
            }
        }

     
    }
}