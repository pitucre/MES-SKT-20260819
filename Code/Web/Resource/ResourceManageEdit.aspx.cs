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
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.Web.Utility;

namespace SKT.LeanMES.Web.Resource
{
    public partial class ResourceManageEdit : BasePage
    {
        public int CategoryType = 1; 
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(ResourceManageEdit));
            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["ID"]);

                LoadLayout();
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
                    this.txtPriority.Text = "100";  
                    this.txtEfficiencyFactor.Text = "100";
                }
            }
        }

        /// <summary>
        /// 获取线
        /// </summary>
        /// <returns></returns>
        protected string GetConditions()
        {
            //Modify By Alen 2016-06-18 线别过滤由于原来的前端JS中判断，改到在后台服务器上判断，在维护资源信息选择线别时根据License线别数量过滤，线别按ID由大到小取
            if (Convert.ToInt32(Application["LineQty"].ToString()) > 0)
            {
                return "&SearchCondition=" + Server.UrlEncode("LineId IN(SELECT TOP " + Application["LineQty"].ToString() + " LineId FROM Basal_Line WHERE LineId <> -1 ORDER BY LineId)");
            }
            else
            {
                return "";
            }
        }
        [AjaxMethod]
        public void Edit(ResourceManageInfo entity)
        {
            try
            {
                ResourceManage bll=new ResourceManage();
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
                this.hdnItemId.Value = value.ItemId.ToString();
                this.txtItemCode.Text = value.ItemCode;
                this.lblItemName.Text = value.ItemName;
                this.lblItemSpec.Text = value.ItemSpec;

                // //工序信息
                //this.txtStation.Text = value.StationName;
                //this.hdnStationId.Value = value.StationId.ToString();

                // //线别信息
                // this.hdnWorkId.Value = value.WorkId.ToString();
                // this.txtWorkCode.Text = value.WorkCode;
                // this.lblWorkName.Text = value.WorkName;

                drpFrontTime.SelectedValue = value.FrontUnit;
                drpPostTime.SelectedValue = value.PostUnit;
                drpCapacity.SelectedValue = value.CapacityUnit;
                drpActiveState.SelectedValue = value.ActiveState.ToString();
                ////线别信息
                //this.hdnLineId.Value = value.LineId.ToString();
                //this.txtLineName.Text = value.LineName;

                // //资源信息
                this.hdnResourceId.Value = value.ResourceId.ToString();
                this.txtResName.Text = value.ResName;
                this.lblIsSmt.Text = value.IsSmt == 1 ? "是" : "否";
                //if (value.IsSmt == 1)
                //{
                //    this.chkIsSMT.Checked = true;
                //}
               
                this.txtEfficiencyFactor.Text = value.EfficiencyFactor.ToString();
                this.txtFrontTime.Text = value.FrontTime.ToString();
                this.txtPostTime.Text = value.PostTime.ToString();
                this.txtCapacity.Text = value.Capacity.ToString();
                this.txtPriority.Text = value.Priority.ToString();
                this.txtRemark.Text = value.Remark;
                this.ddlLayout.SelectedValue = value.Face.ToString();

            }
        }
        /// <summary>
        /// 获取面别
        /// </summary>
        private void LoadLayout()
        {
            LoadingListTable bll = new LoadingListTable();

            Common.Model.SearchSettings search = new Common.Model.SearchSettings();
            List<LoadingListTableInfo> infos = bll.GetAll(0, 100, "LoadingListTableId", search);
            int checkResId = Convert.ToInt32(Request.QueryString["ID"].ToString());

            ddlLayout.DataSource = infos;
            ddlLayout.DataTextField = "TableDesc";
            ddlLayout.DataValueField = "TableName";
            ddlLayout.DataBind();
            //ddlLayout.Items.Insert(0, new ListItem("请选择", ""));
        }

    }
}