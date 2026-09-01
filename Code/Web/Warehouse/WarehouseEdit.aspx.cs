using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouse));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SKT.LeanMES.Warehouse.BLL.Warehouse house = new LeanMES.Warehouse.BLL.Warehouse();
                    this.PageData = house.GetInfo(Convert.ToInt32(idString));
                    txtWareHouseCode.Enabled = false;
                    txtWareHouseCode.ReadOnly = true;
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private WarehouseInfo PageData
        {
            set
            {
                this.txtWareHouseCode.Text = value.CWhCode.ToString();
                this.txtWareHouseCode.Enabled = false;
                this.txtWhName.Text = value.CWhName.ToString();
                this.hdnSelectPersonId.Value = value.CWhPerson.ToString();
                this.txtAddress.Text = value.CWhAddress.ToString();
                this.hdnWhType.Value = value.IWHProperty;
                this.hdnStorageValue.Value = (value.BWhPos == true) ? "1" : "0";
                this.hdnDepCode.Value = value.CDepCode.ToString();
                this.txtPhone.Text = value.CcWhPhone;
                this.txtDescription.Text = value.CWhMemo.ToString();

                SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
                if (Int32.Parse(value.CWhPerson) != -1)
                {
                    MembershipInfo userInfo = user.GetInfo(Convert.ToInt32(value.CWhPerson));
                    this.txtWhPerson.Text = (userInfo == null) ? "" : userInfo.EmployeeCName + "|" + userInfo.EmployeeEName + "(" + userInfo.EmployeeNo + ")";
                }
                else
                {
                    this.txtWhPerson.Text = "";
                }
                //部门
                if (Int32.Parse(value.CDepCode) != -1)
                {
                    SKT.Common.Organization.BLL.Organization org = new Common.Organization.BLL.Organization();
                    SKT.Common.Organization.Model.OrganizationInfo orginfo = org.GetInfo(Convert.ToInt32(value.CDepCode));
                    this.txtDepCode.Text = (orginfo == null) ? "" : orginfo.DepartName + "|" + "(" + orginfo.DepartNo + ")";
                }
                else
                {
                    this.txtDepCode.Text = "";
                }
                //仓库类型
                if (value.IWHProperty != "-1")
                {
                    SKT.LeanMES.Warehouse.Model.WarehouseTypeInfo whTypeInfo = (new SKT.LeanMES.Warehouse.BLL.WarehouseType()).GetInfo(Convert.ToInt32(value.IWHProperty));
                    this.txtWhType.Text = (whTypeInfo == null) ? "" : whTypeInfo.WarehouseType + "|" + whTypeInfo.WarehouseTypeId;
                }
            }
        }
    }
}