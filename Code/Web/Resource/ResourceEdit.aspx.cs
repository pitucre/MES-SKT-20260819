using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.SerialNumber.Model;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.Resource.Model;
using SKT.LeanMES.Web.Utility;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;

namespace SKT.LeanMES.Web.Resource
{
    public partial class ResourceEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceResource));
            if (!IsPostBack)
            {
                //获取面别
                LoadLayout();
                string resIdStr = Request.QueryString["ID"];
                int resId = Convert.ToInt32(resIdStr);
                BindResourceStatus();
                BindResNameByResId(2, resId);
                BindCertiByResId(1, resId);
                BindCertiByResId(2, resId);

                if (resId > -1)
                {
                    SKT.LeanMES.Resource.Model.ResourceInfo model = new LeanMES.Resource.BLL.Resource().GetInfo(resId);
                    if (model != null)
                    {
                        this.PageData = model;
                        //Add By Alen 2016-06-18 复制的时候资源名称可编辑
                        if (Request.QueryString["Action"] != "Copy")
                        {
                            //add by weixia on 2015/3/2  设置资源名称不可编辑
                            this.txtResName.Enabled = false;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// 绑定资源状态
        /// </summary>
        protected void BindResourceStatus()
        {
            List<ListItem> list = EnumHelper.ParseEnumToList(typeof(SKT.LeanMES.Resource.Model.EnumResourceStatus));
            List<ListItem> list2 = new List<ListItem>();
            for (int i = 0, j = list.Count; i < j; i++)
            {
                if (list[i].Value == "1" || list[i].Value == "2")
                {
                    list2.Add(list[i]);
                }
            }
            this.ddlResourceStatus.DataSource = list2;
            this.ddlResourceStatus.DataTextField = "text";
            this.ddlResourceStatus.DataValueField = "value";
            this.ddlResourceStatus.DataBind();
        }

        /// <summary>
        /// 根据falge返回不同的数据
        /// </summary>
        protected void BindResNameByResId(int type, int resId)
        {
            List<SKT.LeanMES.Resource.Model.ResourceTypeInfo> resourceType = new SKT.LeanMES.Resource.BLL.ResourceType().GetInfoByResId(type, resId);
            //Modify By Alen 2016-06-18 由于资源类型已修改为只选择一个资源类型，所以此处去其它情况，只绑定一种资源类型
            if (type == 2)
            {
                if (resourceType != null && resourceType.Count > 0)
                {
                    this.hdnResTypeId.Value = resourceType[0].ResourceTypeId.ToString();
                    this.txtResType.Text = resourceType[0].ResTypeName;
                }
                else
                {
                    this.hdnResTypeId.Value = "-1";
                    this.txtResType.Text = "";
                }
            }
        }

        /// <summary>
        /// 绑定资源证书
        /// </summary>
        /// <param name="flage"></param>
        /// <param name="resId"></param>
        protected void BindCertiByResId(int flage, int resId)
        {
            List<SKT.LeanMES.Station.Model.CertificationInfo> resourceType = new SKT.LeanMES.Station.BLL.Certification().GetInfoByResId(flage, resId);
            if (flage == 1)
            {
                BindListBox(resourceType, this.lbAvilableCerList, "Certification", "CertificationId");
            }
            else if (flage == 2)
            {
                BindListBox(resourceType, this.lbAssignCerList, "Certification", "CertificationId");
            }
        }

        /// <summary>
        /// 绑定ListBox数据
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="listBox"></param>
        /// <param name="textField"></param>
        /// <param name="valueField"></param>
        protected void BindListBox(Object obj, ListBox listBox, string textField, string valueField)
        {
            listBox.DataSource = obj;
            listBox.DataTextField = textField;
            listBox.DataValueField = valueField;
            listBox.DataBind();
        }

        /// <summary>
        /// 设置页面数据
        /// </summary>
        protected ResourceInfo PageData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtResName.Text = Resources.Buttons.COM_Copy + "-" + value.ResName;
                }
                else
                {
                    this.txtResName.Text = value.ResName;
                }
                this.txtDescription.Text = value.ResDescription;
                this.ddlResourceStatus.SelectedValue = value.ResStatus.ToString();
                this.txtLineName.Text = value.LineName;
                this.hdnLineId.Value = value.LineId.ToString();
                this.txtEquipmentName.Text = value.EquipmentName;
                this.hdEquipmentCode.Value = value.EquipmentCode;
                this.txtValidStartTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.ValidStartTime);
                this.txtValidEndTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.ValidEndTime);
                this.ddlResourceStatus.SelectedValue = value.ResStatus.ToString();
                this.ddlLayout.SelectedValue = value.Face.ToString();
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
            ddlLayout.Items.Insert(0, new ListItem("请选择", "-1"));
        }
    }
}