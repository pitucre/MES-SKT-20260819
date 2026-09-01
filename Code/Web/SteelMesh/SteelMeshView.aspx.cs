using System;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.SteelMesh.BLL;
using SKT.LeanMES.SteelMesh.Model;
using SKT.LeanMES.Supplier.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelMeshView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipment));
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            String idString = Request.QueryString["ID"];


            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SteelItemId";
            this.Master.DefaultSortExpression = "SteelItemId ";

           
            searchSettings.ExtensionCondition += " EquipmentId = " + idString;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;


            try
            {
                this.PageData = (new SKT.LeanMES.Equipment.BLL.Equipments()).GetInfo(Convert.ToString(idString));
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        private EquipmentsInfo PageData
        {
            set
            {
                this.lblEquipmentName.Text = value.EquipmentName;
                this.lblEquipmentCode.Text = value.EquipmentCode;
                this.lblEquipmentModel.Text = value.EquipmentModel;
                this.lblEquipmentType.Text = value.EquipmentTypeName.ToString();
                this.lblPosition.Text = value.PositionName;
                this.lblRemark.Text = value.Remark;
                this.lblStatus.Text = GetSattus(value.Status);
                this.lblThick.Text =value.MKLand;
                this.lblVendorName.Text = value.VendorName;
                this.lblVendorBarcodeNum.Text = value.VendorBarcode;
                this.lblFactoryDate.Text = value.FactoryDate.ToString("yyyy-MM-dd");
                this.lblProduceDate.Text = value.ProduceDate.ToString("yyyy-MM-dd");
                this.lbllineName.Text = value.LineName.ToString();
                this.lblStandarLive.Text = value.StandarLive.ToString("N0");
                this.lblUseCount.Text = value.UseCount.ToString("N0");
                this.lblWarningCount.Text = value.WarningCount.ToString("N0");
                this.lblCurPosition.Text = value.CurPosition;
                this.lblInOrOut.Text = value.InOrOut == 0 ? "在产线" : "已入库";
                this.lblIsClear.Text = value.IsClear == 0 ? "未清洗" : "已清洗";
            }
        }
        /// <summary>
        /// 获取状态
        /// </summary>
        /// <param name="status"></param>
        /// <returns></returns>
        private string  GetSattus(int status)
        {
            string statusName;
            switch (status)
            {
                case 0:
                    statusName = "暂存";
                    break;
                case 1:
                    statusName = "检验合格";
                    break;
                case 2:
                    statusName = "检验不合格";
                    break;
                case 3:
                    statusName = "在库";
                    break;
                case 4:
                    statusName = "在产线";
                    break;
                case 5:
                    statusName = "已上线";
                    break;
                case 6:
                    statusName = "已下线";
                    break;
                case 7:
                    statusName = "已清洗";
                    break;
                case 8:
                    statusName = "已报废";
                    break;
                default:
                    statusName = string.Empty;
                    break;
            }
            return statusName;
        }
    }
}