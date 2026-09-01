using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.Web.AjaxServices;
using SKT.Common.Model;
using System.Web.Script.Serialization;
using SKT.LeanMES.PubItems.Model;

namespace SKT.LeanMES.Web.SMT
{
    public partial class LoadingListView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServicesLoadingList));

            int groudId = Convert.ToInt32(Request.QueryString["ID"]);
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "LoadingListDetailId";
            this.Master.DefaultSortDirection = SortDirection.Ascending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "LoadingListID =" + groudId + "";
            this.Master.SearchSettings = searchSettings;

            if (!IsPostBack)
            {

                if (groudId > -1)
                {
                    LoadinglistInfo model = null;
                    SKT.LeanMES.SMT.BLL.LoadingList bll = new SKT.LeanMES.SMT.BLL.LoadingList();
                    model = bll.GetInfo(groudId);
                    if (model != null)
                    {

                        this.PageData = model;
                    }
                }
            }
        }

        private LoadinglistInfo PageData
        {
            set
            {

                this.txtSetupName.Text = value.SetupName.ToString();
                this.txtModelName.Text = value.ItemStr.ToString();
                this.cbFullSet.Checked = value.IsFullSet;
                this.txtRev.Text = value.Revision.ToString();
                this.ddlStatus.Text = value.StatusID.ToString() == "0" ? "未使用" : "使用中";
                this.hdnCreateTime.Value = value.CreationTime.ToString();

                /*******上料清单名称********/
                SearchSettings searchLoadType = new SKT.Common.Model.SearchSettings();
                searchLoadType.AddCondition("EnableFlag", "1");
                searchLoadType.AddCondition("LoadingTypeId", value.LoadingTypeId.ToString());

                LoadingType bll = new LoadingType();
                List<LoadingTypeInfo> entity = new LeanMES.SMT.BLL.LoadingType().GetAll(0, -1, "LoadingTypeId", searchLoadType);

                if (entity.Count!= 0)
                {
                    this.ddlloadingType.Text = entity[0].TypeName;
                }
                else
                {
                    this.ddlloadingType.Text = "";
                }

                /*******线别设备类型********/
                searchLoadType = new SKT.Common.Model.SearchSettings();
                searchLoadType.AddCondition("EquipmentLineId", value.EquipmentLineId.ToString());
                this.ddlEquipmentLine.Text = (new LeanMES.SMT.BLL.LoadingList()).GetAll(0, -1, "EquipmentLineId", searchLoadType)[0].EquipmentLineType;


                this.ddlLayout.Text = value.SmtLayout.ToString();

                this.ddlSequenceNo.Text = value.SequenceNo.ToString();
            }
        }
    }
}