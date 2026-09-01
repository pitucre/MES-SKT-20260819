using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using SKT.LeanMES.Resource.BLL;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.SerialNumber.Model;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.Resource.Model;
using SKT.LeanMES.Web.Utility;

namespace SKT.LeanMES.Web.Resource
{
    public partial class ResourceManageView : BasePage
    {
        public int CategoryType = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(ResourceManageEdit));
            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["ID"]);


                if (id > -1)
                {
                    SKT.LeanMES.Resource.Model.ResourceManageInfo model =
                        new LeanMES.Resource.BLL.ResourceManage().GetInfo(id);
                    if (model != null)
                    {
                        this.PageData = model;

                    }
                }
                else
                {
                    //默认值
                }
            }
        }

       
        [AjaxMethod]
        public void Edit(ResourceManageInfo entity)
        {
            try
            {
                ResourceManage bll = new ResourceManage();
                bll.Edit(entity);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        /// <summary>
        /// 设置页面数据
        /// </summary>
        protected ResourceManageInfo PageData
        {
            set
            {
                //this.ddlCategoryType.SelectedValue = value.CategoryType.ToString();
                //CategoryType = value.CategoryType;

                //产品信息
             
                this.lblItemCode.Text = value.ItemCode;
                this.lblItemName.Text = value.ItemName;
                this.lblItemSpec.Text = value.ItemSpec;

                // //工序信息
                this.lblStation.Text = value.StationName;

                // //线别信息
                // this.hdnWorkId.Value = value.WorkId.ToString();
                // this.txtWorkCode.Text = value.WorkCode;
                // this.lblWorkName.Text = value.WorkName;

                drpFrontTime.SelectedValue = value.FrontUnit;
                drpPostTime.SelectedValue = value.PostUnit;
                drpCapacity.SelectedValue = value.CapacityUnit;


                // //资源信息
                this.lblResource.Text = value.ResName;

                this.lblEfficiencyFactor.Text = value.EfficiencyFactor.ToString();
                this.lblPriority.Text = value.Priority.ToString();
                this.lblFrontTime.Text = value.FrontTime.ToString();
                this.lblPostTime.Text = value.PostTime.ToString();
                this.lblCapacity.Text = value.Capacity.ToString();
                this.lblRemark.Text = value.Remark;
                this.lblCenter.Text = value.LineName;

            }
        }


    }
}