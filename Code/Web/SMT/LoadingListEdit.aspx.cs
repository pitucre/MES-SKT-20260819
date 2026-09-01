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
    public partial class LoadingListEdit : BasePage
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
                //GetLoadingListStatus();
                GetLoadingType();
                GetEquipmentLine();
                Getlayout();

                if (groudId > -1)
                {
                    LoadinglistInfo model = null;
                    SKT.LeanMES.SMT.BLL.LoadingList bll = new SKT.LeanMES.SMT.BLL.LoadingList();
                    model = bll.GetInfo(groudId);
                    if (model != null)
                    {
                        /******zhibin.Chen Alter 2014-12-08****************************
                        *如果状态不处于活动状态时，那么状态DDL控件，只显示当前状态，不提供状态改变功能。
                        *如果处于活动状态时，那么状态DDL控件，绑定可以编辑的状态，提供状态改变功能。
                        ***************************************************************/
                        //if (model.StatusID == 1)
                        //{
                        //    GetLoadStatus();
                        //    this.ddlStatus.SelectedValue = model.StatusID.ToString();
                        //}
                        //else
                        //{
                        //    ListItem listitem = new ListItem(model.StatusStr, model.StatusID.ToString());
                        //    this.ddlStatus.Items.Add(listitem);
                        //}
                        /******zhibin.Chen Alter 2014-12-08****************************/

                        this.PageData = model;
                    }
                }
            }
        }

        private LoadinglistInfo PageData
        {
            set
            {
                this.txtModelID.Value = value.ItemId.ToString();
                this.txtSetupName.Text = value.SetupName.ToString();
                this.txtModelName.Text = value.ItemStr.ToString();
                this.cbFullSet.Checked = value.IsFullSet;
                this.txtRev.Text = value.Revision.ToString();
                this.ddlStatus.SelectedValue = value.StatusID.ToString();
                this.hdnCreateTime.Value = value.CreationTime.ToString();
                this.ddlloadingType.SelectedValue = value.LoadingTypeId.ToString();
                this.ddlEquipmentLine.SelectedValue = value.EquipmentLineId.ToString();
                this.ddlLayout.SelectedValue = value.SmtLayout.ToString();
                this.txtCLNumber.Text = value.CLNumber.ToString();

                GetEquipmentSeqNo(value.EquipmentLineId.ToString());
                this.ddlSequenceNo.SelectedValue = value.SequenceNo.ToString();
            }
        }

        /***获取状态***/
        private void GetLoadStatus()
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            SKT.LeanMES.SMT.BLL.LIST_Status status = new SKT.LeanMES.SMT.BLL.LIST_Status();
            List<SKT.LeanMES.SMT.Model.LIST_StatusInfo> statusInfo = status.GetAll(0, 100, "id", searchSettings);

            List<SKT.LeanMES.SMT.Model.LIST_StatusInfo> result = statusInfo.Where(a => a.Id == 1 || a.Id == 6).ToList();

            ddlStatus.DataSource = result;
            ddlStatus.DataTextField = "Description";
            ddlStatus.DataValueField = "id";
            ddlStatus.DataBind();
        }

        private void GetEquipmentSeqNo(string typeId)
        {
            ddlSequenceNo.DataSource = (new JavaScriptSerializer().Deserialize<List<PubItemsInfo>>((new LeanMES.SMT.BLL.LoadingType()).GetSMTLineSequence(typeId)));
            ddlSequenceNo.DataTextField = "ItemName";
            ddlSequenceNo.DataValueField = "ItemValue";
            ddlSequenceNo.DataBind();
        }

        private void GetEquipmentLine()
        {
            ddlEquipmentLine.DataSource = (new LeanMES.Equipment.BLL.EquipmentLineRelation()).GetAll(0, -1, "EquipmentLineId", null);
            ddlEquipmentLine.DataTextField = "EquipmentLineDisplayName";
            ddlEquipmentLine.DataValueField = "EquipmentLineId";
            ddlEquipmentLine.DataBind();
        }

        private void GetLoadingType()
        {
            SearchSettings searchLoadType = new SKT.Common.Model.SearchSettings();
            searchLoadType.AddCondition("EnableFlag", "1");
            ddlloadingType.DataSource = (new LeanMES.SMT.BLL.LoadingType()).GetAll(0, -1, "LoadingTypeId", searchLoadType);
            ddlloadingType.DataTextField = "TypeName";
            ddlloadingType.DataValueField = "LoadingTypeId";
            ddlloadingType.DataBind();
        }

        private void Getlayout()
        {
            ddlLayout.DataSource = (new LeanMES.SMT.BLL.LoadingListTable()).GetAll(0, -1, "LoadingListTableId", null);
            ddlLayout.DataTextField = "TableDesc";
            ddlLayout.DataValueField = "TableName";
            ddlLayout.DataBind();
        }

        //显示字段
        private void GetLoadingListStatus()
        {
            SKT.LeanMES.SMT.BLL.LIST_Status bll = new LIST_Status();
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            List<SKT.LeanMES.SMT.Model.LIST_StatusInfo> listInfo = bll.GetAll(0, -1, "", searchSettings);
            this.ddlStatus.DataSource = listInfo;
            this.ddlStatus.DataTextField = "Description";
            this.ddlStatus.DataValueField = "id";
            this.ddlStatus.DataBind();
        }
    }
}