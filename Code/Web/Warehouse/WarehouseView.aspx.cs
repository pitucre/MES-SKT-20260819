using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            SKT.LeanMES.Warehouse.BLL.Warehouse house = new LeanMES.Warehouse.BLL.Warehouse();
            WarehouseInfo warehouseInfo = house.GetInfo(Convert.ToInt32(idString));

            this.lblCWhCode.Text = warehouseInfo.CWhCode;
            this.lblCWhName.Text = warehouseInfo.CWhName;
            //  this.lblCWhType.Text = warehouseInfo.IWHProperty;
            //仓库类型
            if (warehouseInfo.IWHProperty != "-1")
            {
                SKT.LeanMES.Warehouse.Model.WarehouseTypeInfo whTypeInfo = (new SKT.LeanMES.Warehouse.BLL.WarehouseType()).GetInfo(Convert.ToInt32(warehouseInfo.IWHProperty));
                this.lblCWhType.Text = (whTypeInfo == null) ? "" : whTypeInfo.WarehouseType + "|" + whTypeInfo.WarehouseTypeId;
            }
            //    this.lblCDepCode.Text = warehouseInfo.CDepCode;
            if (Int32.Parse(warehouseInfo.CDepCode) != -1)
            {
                SKT.Common.Organization.BLL.Organization org = new Common.Organization.BLL.Organization();
                SKT.Common.Organization.Model.OrganizationInfo orginfo = org.GetInfo(Convert.ToInt32(warehouseInfo.CDepCode));
                this.lblCDepCode.Text = (orginfo == null) ? "" : orginfo.DepartName + "|" + "(" + orginfo.DepartNo + ")";
            }
            else
            {
                this.lblCDepCode.Text = "";
            }
            this.lblCWhAddress.Text = warehouseInfo.CWhAddress;
            this.lblCcWhPhone.Text = warehouseInfo.CcWhPhone;
            // this.lblCWhPerson.Text = warehouseInfo.CWhPerson;
            SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
            if (Int32.Parse(warehouseInfo.CWhPerson) != -1)
            {
                MembershipInfo userInfo = user.GetInfo(Convert.ToInt32(warehouseInfo.CWhPerson));
                this.lblCWhPerson.Text = (userInfo == null) ? "" : userInfo.EmployeeCName + "|" + userInfo.EmployeeEName + "(" + userInfo.EmployeeNo + ")";
            }
            else
            {
                this.lblCWhPerson.Text = "";
            }
            this.cbStorage.Text = (warehouseInfo.BWhPos) ? (String)GetGlobalResourceObject("Common", "Yes") : (String)GetGlobalResourceObject("Common", "No");
            this.lblDescription.Text = warehouseInfo.CWhMemo;
        }
    }
}