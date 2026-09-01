using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Router.BLL;
using SKT.LeanMES.Router.Model;
using System.Text;
using System.Data;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemEdit : BasePage
    {
        public Int32 ItemId;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxBaseExt));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMSD));
            if (!this.IsPostBack)
            {
                string idStr = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
                int.TryParse(idStr, out ItemId);

                BindItemGroup();
                BindItemType();
                BindItemStatus();
                BindIQCType();

                BindAvilableCert();
                BindAvilableDoc();
                BindCertification(ItemId);
                BindPrintDocument(ItemId);

                BindMSL();
                /********************************
                 * zhibin.chen 2016-1-21 此处屏蔽打印文档
             
                ********************************/

                if (ItemId != -1)
                {
                    ItemInfo model = (new Item()).GetInfo(ItemId);
                    this.PageData = model;
                    if (model.RouterID != -1)
                    {
                        BindStation(model);
                    }
                }
            }
        }
        /// <summary>
        /// 绑定产品组
        /// </summary>
        public void BindItemGroup()
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            ItemGroup Dictionary = new ItemGroup();
            List<ItemGroupInfo> dInfos = Dictionary.GetAll(0, 100, "ItemGroupId", searchSettings);
            ddlItemGroup.DataSource = dInfos;
            ddlItemGroup.DataTextField = "GroupName";
            ddlItemGroup.DataValueField = "ItemGroupId";
            ddlItemGroup.DataBind();

            ddlItemGroup.Items.Insert(0, new ListItem("", "-1"));
        }
        /// <summary>
        /// 绑定产品状态
        /// </summary>
        protected void BindItemStatus()
        {
            this.ddlItemStatus.DataSource = SKT.LeanMES.Web.Utility.EnumHelper.ParseEnumToList(typeof(SKT.LeanMES.Station.Model.EnumOperationStatus));
            this.ddlItemStatus.DataTextField = "text";
            this.ddlItemStatus.DataValueField = "value";
            this.ddlItemStatus.DataBind();
        }
        /// <summary>
        /// 绑定产品类型
        /// </summary>
        protected void BindItemType()
        {
            this.ddlItemType.DataSource = SKT.LeanMES.Web.Utility.EnumHelper.ParseEnumToList(typeof(SKT.LeanMES.Product.Model.EnumItemType));
            this.ddlItemType.DataTextField = "text";
            this.ddlItemType.DataValueField = "value";
            this.ddlItemType.DataBind();
        }

        public void BindIQCType()
        {
            this.ddlIQCType.Items.Add(new ListItem(Resources.lang.FullInspection, "1"));
            this.ddlIQCType.Items.Add(new ListItem(Resources.lang.SamplingInspection, "2"));
            this.ddlIQCType.Items.Add(new ListItem(Resources.lang.InspectionExemption, "3"));
        }

        /// <summary>
        /// 绑定湿度等级信息
        /// </summary>
        protected void BindMSL()
        {
            SKT.LeanMES.MSD.BLL.Msl bll = new LeanMES.MSD.BLL.Msl();
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            var list = bll.GetAll(0, 100, "MslId", searchSettings);

            this.ddlMSL.DataSource = list;
            this.ddlMSL.DataTextField = "MSL";
            this.ddlMSL.DataValueField = "MslId";

            this.ddlMSL.DataBind();

            ddlMSL.Items.Insert(0, new ListItem(Resources.lang.Choose, "-1"));

        }
        /// <summary>
        /// 绑定所需证书
        /// </summary>
        protected void BindCertification(int itemId)
        {
            this.lbAssignCerList.DataSource = new SKT.LeanMES.Product.BLL.Item().GetQualCertByItemID(itemId);
            this.lbAssignCerList.DataTextField = "Certification";
            this.lbAssignCerList.DataValueField = "CertificationId";
            this.lbAssignCerList.DataBind();
        }
        /// <summary>
        /// 绑定所需打印文档
        /// </summary>
        protected void BindPrintDocument(int itemId)
        {
            this.lbPrintDocList.DataSource = new SKT.LeanMES.Product.BLL.Item().GetPrintDocByItemID(itemId);
            this.lbPrintDocList.DataTextField = "DocumentName";
            this.lbPrintDocList.DataValueField = "LabelDocumentId";
            this.lbPrintDocList.DataBind();
        }

        /// <summary>
        /// 绑定可选证书
        /// </summary>
        protected void BindAvilableCert()
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            List<SKT.LeanMES.Station.Model.CertificationInfo> certification = null;
            if (ItemId != -1)
            {
                certification = new SKT.LeanMES.Station.BLL.Certification().GetListCertByItemId(1, ItemId);
            }
            else
            {
                certification = new SKT.LeanMES.Station.BLL.Certification().GetListCertByItemId(2, ItemId);
            }
            this.lbAvilableCerList.DataSource = certification;
            this.lbAvilableCerList.DataTextField = "Certification";
            this.lbAvilableCerList.DataValueField = "CertificationId";
            this.lbAvilableCerList.DataBind();
        }
        /// <summary>
        /// 绑定可选打印文档
        /// </summary>
        protected void BindAvilableDoc()
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (ItemId != -1)
            {
                List<SKT.LeanMES.Labels.Model.LabelDocumentInfo> document = new SKT.LeanMES.Labels.BLL.LabelDocument().GetDocumentByItemId(ItemId);
                this.lbAvailableDocList.DataSource = document;
                this.lbAvailableDocList.DataTextField = "DocumentName";
                this.lbAvailableDocList.DataValueField = "LabelDocumentId";
                this.lbAvailableDocList.DataBind();
            }
            else
            {
                searchSettings = null;
                this.lbAvailableDocList.DataSource = new SKT.LeanMES.Labels.BLL.LabelDocument().GetAll(0, -1, "DocumentName", searchSettings);
                this.lbAvailableDocList.DataTextField = "DocumentName";
                this.lbAvailableDocList.DataValueField = "LabelDocumentId";
                this.lbAvailableDocList.DataBind();
            }
        }

        /// <summary>
        /// 绑定投入产出站，投入站与产出站的绑定需要根据产品的所绑定的路由来
        /// </summary>
        protected void BindStation(ItemInfo itemModel)
        {

            int routerId = itemModel.RouterID;
            int putStation = itemModel.PutStation;//投入站
            int yieldSatation = itemModel.YieldStation;//产出站
            SKT.LeanMES.Router.BLL.Router bll = new LeanMES.Router.BLL.Router();
            SKT.LeanMES.Router.Model.RouterInfo model = new RouterInfo();
            model = bll.GetLayout(routerId);
            DataTable dt = new DataTable();
            if (model != null && model.R_JSON.Trim() != "")
            {
                dt = bll.JsonToDataTable(model.R_JSON);
                DataTable dtN = dt.Clone();
                DataRow rowN = dtN.NewRow();
                rowN[0] = "-1";
                rowN[1] = "=请选择=";
                dtN.Rows.Add(rowN);

                foreach (DataRow row in dt.Rows)
                {
                    if (row[0].ToString() != "-10" && row[0].ToString() != "-20")
                    {
                        rowN = dtN.NewRow();
                        rowN[0] = row[0].ToString().Replace("'", "");
                        rowN[1] = row[1].ToString().Replace("'", "");
                        dtN.Rows.Add(rowN);
                    }
                }
                this.InputStationDrop.DataSource = dtN;
                this.InputStationDrop.DataTextField = dtN.Columns[1].ColumnName;
                this.InputStationDrop.DataValueField = dtN.Columns[0].ColumnName;
                this.InputStationDrop.DataBind();
                this.InputStationDrop.SelectedValue = putStation.ToString();

                this.YieldStationDrop.DataSource = dtN;
                this.YieldStationDrop.DataTextField = dtN.Columns[1].ColumnName;
                this.YieldStationDrop.DataValueField = dtN.Columns[0].ColumnName;
                this.YieldStationDrop.DataBind();
                this.YieldStationDrop.SelectedValue = yieldSatation.ToString();
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ItemInfo PageData
        {
            set
            {
                this.txtItemCode.Text = value.ItemCode;
                //if (value.IsMESadd !="ERP")
                //{
                //    this.txtItemCode.Enabled = false;
                //}
                this.txtItemCode.Enabled = false;
                this.txtItemsName.Text = value.ItemName;
                this.txtItemsName.Enabled = false;
                this.txtVersion.Text = value.ItemRev;
                this.ddlItemGroup.SelectedValue = value.ItemGroupID.ToString();
                this.txtProject.Text = value.ProjectName;
                this.hdnProjectId.Value = value.ProjectID.ToString();
                this.txtCustomer.Text = value.CustomerName;
                this.hdnCustomerId.Value = value.CustomerID.ToString();
                this.txtCPN.Text = value.CPN;
                this.txtCPR.Text = value.CPR;
                this.ddlItemStatus.SelectedValue = value.Status.ToString();
                this.ddlItemType.SelectedValue = value.ItemType.ToString();
                this.hdnRouterId.Value = value.RouterID.ToString();
                this.txtRouter.Text = value.RouterName;
                this.txtItemBom.Text = value.BomName;
                this.hdnBomId.Value = value.BomId.ToString();
                this.txtLotSize.Text = value.LotSize.ToString();
                this.ckbCurrentVer.Checked = value.IsCurrentRev;
                this.txtDataType.Text = value.DataTypeName;
                this.hdnDataTypeID.Value = value.DCOAssembly.ToString();
                this.txtItemDesc.Text = value.Description;
                this.ddlIQCType.SelectedValue = value.IQCType.ToString();
                this.txtUnits.Text = value.Units;
                this.txtMinPackQty.Text = Convert.ToInt32(value.MinPackQty).ToString();
                this.qcMinNum.Text = Convert.ToInt32(value.QcMinNum).ToString();
                this.txtLabelItemModel.Text = value.ItemModel;
                this.txtLabelFirmware.Text = value.LabelFirmware;
                this.txtCategoryOne.Text = value.CategoryOne;
                this.txtCategoryTwo.Text = value.CategoryTwo;
                this.txtCategoryThree.Text = value.CategoryThree;

                this.chkIsMSD.Checked = value.IsMSD == true ? true : false;
                if (ddlMSL.Items.FindByText(value.MSL) != null)
                {
                    ddlMSL.Items.FindByText(value.MSL).Selected = true;
                }
                this.txtFloorLife.Text = value.FloorLife.ToString();
                this.txtBakeCount.Text = value.BakeCount.ToString();
                this.txtShelfLife.Text = value.ShelfLife.ToString();

                this.labBakeCount.Text = value.BakeCount.ToString();
                this.labFloorLife.Text = value.FloorLife.ToString();

                if (value.IsPanel)
                {
                    this.chkIsPanel.Checked = true;
                    this.txtChildQty.Text = value.ChildrenNumber.ToString();
                    this.txtPanelQty.Text = value.ParentNumber.ToString();
                }
                if (value.IsItemOver)
                {
                    this.chbIsItemOver.Checked = true;
                }
                if (value.IsMESadd != "MES")
                {
                    DisenableEdit();
                }
                //增加工厂的显示
                hdnSite.Value = value.Site;
                txtFactoryName.Text = value.FactoryName;
                this.txtMaskID.Value = value.MaskId.ToString();
                this.txtMask.Text = value.MaskGroupName;
                this.txtAgeingType.SelectedValue = value.AgeingType.ToString();
                this.txtAgeingTime.Text = value.AgeingTime.ToString();
                this.ddlItemABC.SelectedValue = value.ABCClass;
                txtItemExpirationDate.Text = value.ExpirationDateName;
                HiddenExpirationDate.Value = value.ExpirationDateId.ToString();
                this.ddlIssueWay.SelectedValue = value.IssueWay.ToString();
                this.ddlProductionFace.SelectedValue = value.ProductionFace.ToString();
                if (value.IsPanelPrint)
                {
                    this.chkPrintPanelSN.Checked = true;
                }
                this.txtPriority.Text = value.Priority.ToString();
                this.cbIsUpTestExport.Checked = value.IsUpTestExport;
                this.cbIsShipmentReport.Checked = value.IsShipmentReport;
                this.chkIsSMT.Checked = value.IsSmt;
                this.ddlAcquisitionMode.SelectedValue = value.AcquisitionMode.ToString();
                this.ddlIsSeniorBatch.SelectedValue = value.IsSeniorBatch.ToString();
                this.txtColor.Text = value.Colour.ToString();
                this.txtTextureOfMaterial.Text = value.TextureOfMaterial.ToString();
                this.txtFlameRetardantLevel.Text = value.FlameRetardantLevel.ToString();
                this.ddlOverFinshType.SelectedValue = value.OverFinshType.ToString();
                this.txtOverQty.Text = value.OverQty.ToString();
                this.txtOverRate.Text = value.OverRate.ToString();
                this.txtMaterialPartNumber.Text = value.MaterialPartNumberCode.ToString();
                this.txtMaterialHandleNumber.Text = value.MaterialHandleNumberCode.ToString();
                this.txtScrapMaterialNumber.Text = value.ScrapMaterialNumberCode.ToString();

                if (value.IsMaterialHandle)
                {
                    this.chbIsMaterialHandle.Checked = true;
                }
            }
        }
        /// <summary>
        /// 使某些项不能修改
        /// </summary>
        private void DisenableEdit()
        {
            this.txtItemBom.Enabled = false;
            //this.txtItemCode.Enabled = false;
            this.txtVersion.Enabled = false;
            this.ddlItemStatus.Enabled = false;
            //this.chkIsPanel.Enabled = false;
            this.ckbCurrentVer.Enabled = false;
            //this.btnSelectItemBom.Disabled = true;
        }
    }
}