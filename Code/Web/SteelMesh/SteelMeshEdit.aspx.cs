using System;
using SKT.LeanMES.Supplier.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Equipment.BLL;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelMeshEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipment));
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            this.txtCurPosition.Enabled = false;

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SteelItemId";
            this.Master.DefaultSortExpression = "SteelItemId ";

            string EquipmentId = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
            searchSettings.ExtensionCondition += " EquipmentId = " + EquipmentId;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            LoadEquipment();//绑定设备类型

            String idString = Request.QueryString["ID"];
            if (idString != null && Convert.ToInt32(idString) > 0)
            {
                try
                {
                    this.PageData = (new SKT.LeanMES.Equipment.BLL.Equipments()).GetInfo(Convert.ToString(idString));
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                }
                //编辑
                this.txtEquipmentName.Enabled = false;
                this.txtEquipmentCode.Enabled = false;
                this.ddlEquipmentType.Enabled = false;
                //this.ddlEquipmentType.BackColor = System.Drawing.Color.LightGray;
                this.txtEquipmentModel.Enabled = false;
                this.ddlStatus.Enabled = false;
                this.txtVendorName.Enabled = false;
                this.txtVendorName.Enabled = false;
                this.ddlAttribute.Enabled = false;
                this.txtFactoryDate.Enabled = false;
                this.txtProduceDate.Enabled = false;
            }
            //检查是否隐藏产品
            DisplaySteelItem();

            if (!this.IsPostBack)
            {
                //默认入厂时间
                this.txtFactoryDate.Text = txtFactoryDate.Text == "" ? DateTime.Now.ToString("yyyy-MM-dd") : txtFactoryDate.Text;
                this.txtProduceDate.Text = txtProduceDate.Text == "" ? DateTime.Now.ToString("yyyy-MM-dd") : txtProduceDate.Text;
            }
        }

        ///检查是否隐藏产品
        private void DisplaySteelItem()
        {
            bool isneedAdd = true;
            string Addtype = Request.QueryString["Type"] == null ? "" : Request.QueryString["Type"].ToString();
            if (this.ParentTypeId == -3 || Addtype == "Knife")
            {
                Lookup.BLL.Lookup bll = new Lookup.BLL.Lookup();
                Dictionary<string, object> dic = new Dictionary<string, object>();
                dic.Add("Alpha2", "IsDrawKnifeJoinProd");
                List<Lookup.Model.LookupInfo> lookList = bll.GetLookupByCondition("SYS_SteelConfig", dic);
                if (lookList.Count > 0)
                {
                    if (lookList[0].Alpha3 == "0")
                    {
                        plContent2.Visible = false;
                        isneedAdd = false;
                    }
                }
            }

            int idString = Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"]);
            if (idString == -1 && isneedAdd)
            {
                hdnIsNeedAdd.Value = "1";
            }
        }

        private Int32 ParentTypeId;
        private void LoadEquipment()
        {
            string Addtype = Request.QueryString["Type"] == null ? "" : Request.QueryString["Type"].ToString();
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            EquipmentType Dictionaty = new EquipmentType();
            if (Addtype == "Steel")
            {
                searchSettings.AddCondition("PID", "-2");
                //searchSettings.AddCondition("EquipmentTypeId", "-2");
            }
            else if (Addtype == "Knife")
            {
                searchSettings.AddCondition("PID", "-3");
                //searchSettings.AddCondition("EquipmentTypeId", "-3");
            }
            List<EquipmentTypeInfo> dInfos = Dictionaty.GetAll(0, 100, "EquipmentTypeId", searchSettings);
            ddlEquipmentType.DataSource = dInfos;
            ddlEquipmentType.DataTextField = "EquipmentTypeName";
            ddlEquipmentType.DataValueField = "EquipmentTypeId";
            ddlEquipmentType.DataBind();
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentsInfo PageData
        {
            set
            {
                txtPosition.Text = value.PositionName;
                HiddenPosition.Value = value.Position;
                this.txtEquipmentName.Text = value.EquipmentName;
                this.txtEquipmentCode.Text = value.EquipmentCode;
                //this.txtEquipmentCode.Enabled = false;
                this.txtEquipmentModel.Text = value.EquipmentModel;
                this.ddlEquipmentType.SelectedValue = value.EquipmentTypeId.ToString();

                this.txtRemark.Text = value.Remark;
                this.ddlStatus.SelectedValue = value.Status.ToString();
                this.txtThick.Text = String.Format("{0:N2}", value.Thick);
                this.txtVendorName.Text = value.VendorName;
                this.hdnVendorCode.Value = value.VenCode;
                this.txtVendorBarcodeNum.Text = value.VendorBarcode;
                this.txtFactoryDate.Text = value.FactoryDate.ToString("yyyy-MM-dd");
                this.txtProduceDate.Text = value.ProduceDate.ToString("yyyy-MM-dd");
                this.hdLineId.Value = value.LineId.ToString();
                this.txtlineName.Text = value.LineName.ToString();
                this.txtStandarLive.Text = value.StandarLive.ToString("N0");
                this.lblUseCount.Text = value.UseCount.ToString("N0");
                this.txtWarningCount.Text = value.WarningCount.ToString("N0");
                this.txtCurPosition.Text = value.CurPosition;
                this.ddlInOrOut.SelectedValue = value.InOrOut.ToString();
                this.ddlIsClear.SelectedValue = value.IsClear.ToString();
                this.txtMKTechnologyAsk.Text = value.MKTechnologyAsk.ToString();
                this.txtMKUsingType.Text = value.MKUsingType.ToString();
                this.txtMKUsingTechnology.Text = value.MKUsingTechnology.ToString();
                this.txtPCBModel.Text = value.PCBModel.ToString();
                this.txtMKLand.Text = value.MKLand.ToString();
                this.ddlNoodles.SelectedValue = value.EquNoodles;
                ParentTypeId = value.ParentTypeId;
                this.ddlAttribute.SelectedValue = value.Attribute;
            }
        }
    }
}