using System;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Supplier.BLL;
using SKT.LeanMES.Supplier.Model;

namespace SKT.LeanMES.Web.Equipment
{
public partial class PartView : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String idString = Request.QueryString["ID"];
        PartInfo partInfo = (new Part()).GetInfo(Convert.ToInt32(idString));

        this.lblPartName.Text = partInfo.PartName;
        this.lblPartCode.Text = partInfo.PartCode;
        this.lblEquipmentType.Text = partInfo.EquipmentTypeName;
        this.lblPartStand.Text = partInfo.PartStand;

        this.lblFactoryName.Text = partInfo.FactoryName;
        //供应商
        this.lblPartSupplierName.Text = partInfo.SupplierName;
        this.lblPosition.Text = partInfo.PositionName;
        this.lblPartLive.Text = (partInfo.PartLive == "" ? "" : partInfo.PartLive.Replace(',',' '));

        this.lblMinStock.Text = partInfo.MinStock.ToString();
        this.lblMaxStock.Text = partInfo.MaxStock.ToString();
        this.lblCuStock.Text = partInfo.CurrentStock.ToString();
        this.lblUnitname.Text = partInfo.UnitName;
           
        this.lblRemark.Text = partInfo.Remark;
            //状态
            //Int32 Num = 0;
            //Num = partInfo.PartStatus;
            //String numStr = "";
            //switch (Num)
            //{
            //    case 0:
            //        numStr = "新购买";
            //        break;
            //    case 1:
            //        numStr = "维修中";
            //        break;
            //    case 2:
            //        numStr = "保养中";
            //        break;
            //    case 3:
            //        numStr = "故障中";
            //        break;
            //    case 4:
            //        numStr = "报废";
            //        break;
            //    default:
            //        numStr = "";
            //        break;
            //}
            //this.lblPartStatus.Text = numStr.ToString();

            //设备


        }
  }
}