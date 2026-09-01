using System;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Data;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemView : BasePage
    {
        public Int32 ItemId;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxBaseExt));
            if (!this.IsPostBack)
            {
                string idStr = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
                int.TryParse(idStr, out ItemId);
                BindCertification(ItemId);

                if (ItemId != -1)
                {
                    this.PageData = (new Item()).GetInfo(ItemId);
                }

            }
        }

        /// <summary>
        /// 绑定所需证书
        /// </summary>
        protected void BindCertification(int itemId)
        {
            DataTable dt = new SKT.LeanMES.Product.BLL.Item().GetQualCertByItemID(itemId);

            string shtml = "<table class='ListTable' width='100%'>";
            shtml += "<tr class='ListTableHeader'>";
            shtml += "<th>产品证书</th>";
            shtml += "<th width='120px'>证书类型</th>";
            shtml += "</tr>";
            if (dt.Rows.Count == 0)
            {
                shtml += "<tr class='ListTableEmptyDataRow'><td colspan='2'>" + Resources.Messages.EmptyDataText + "</td></tr>";
            }

            for (int i = 0, j = dt.Rows.Count; i < j; i++)
            {
                if (i % 2 == 0)
                {
                    shtml += "<tr class='ListTableOddRow'>";
                }
                else
                {
                    shtml += "<tr class='ListTableEvenRow'>";
                }
                shtml += "<td>" + dt.Rows[i]["Certification"] + "</td>";
                shtml += "<td>" + dt.Rows[i]["Description"] + "</td></tr>";
            }
            shtml += "</table>";
            this.llCerList.Text = shtml;
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ItemInfo PageData
        {
            set
            {
                this.lblItemCode.Text = value.ItemCode;
                this.txtItemsName.Text = value.ItemName;
                this.txtItemsName.Enabled = false;
                this.txtVersion.Text = value.ItemRev;
                var entity = (new ItemGroup()).GetInfo(value.ItemGroupID);
                this.ddlItemGroup.Text = entity == null ? value.ItemGroupID.ToString() : entity.GroupName;
                this.txtProject.Text = value.ProjectName;
                this.txtCustomer.Text = value.CustomerName;
                this.txtCPN.Text = value.CPN;
                this.txtCPR.Text = value.CPR;
                this.ddlItemStatus.Text = Enum.GetName(typeof(SKT.LeanMES.Station.Model.EnumOperationStatus), value.Status) == null ? string.Empty : (String)GetGlobalResourceObject("Enum", Enum.GetName(typeof(SKT.LeanMES.Station.Model.EnumOperationStatus), value.Status));
                this.ddlItemType.Text = Enum.GetName(typeof(EnumItemType), value.ItemType) == null ? string.Empty : (String)GetGlobalResourceObject("Enum", Enum.GetName(typeof(EnumItemType), value.ItemType));
                this.txtRouter.Text = value.RouterName;
                this.txtItemBom.Text = value.BomName;
                this.txtLotSize.Text = value.LotSize.ToString();
                this.ckbCurrentVer.Text = (value.IsCurrentRev) ? (String)GetGlobalResourceObject("Common", "Yes") : (String)GetGlobalResourceObject("Common", "No");
                this.txtDataType.Text = value.DataTypeName;
                this.txtItemDesc.Text = value.Description;
                this.ddlIQCType.Text = value.IQCType.ToString();
                this.txtUnits.Text = value.Units;
                this.minPackQty.Text = value.MinPackQty.ToString();
                this.trIsPanel.Visible = value.IsPanel;
                this.lblChildQty.Text = value.ChildrenNumber.ToString();
                this.lblPanelQty.Text = value.ParentNumber.ToString();
                this.lblFactoryName.Text = value.FactoryName.ToString();
                this.ddlAcquisitionMode.Text = value.AcquisitionModeName;
                //新增两个字段
                if (value.IsNeedPrint == 1)
                {
                    this.chbIsNeedPrint.Text = (value.IsCurrentRev) ? (String)GetGlobalResourceObject("Common", "Yes") : (String)GetGlobalResourceObject("Common", "No"); ;
                }
                if (value.IsItemOver == true)
                {
                    this.chbIsVendorPrint.Text = (value.IsCurrentRev) ? (String)GetGlobalResourceObject("Common", "Yes") : (String)GetGlobalResourceObject("Common", "No"); ;
                }
                this.lblOverQty.Text = value.OverQty.ToString();
                this.lblOverRate.Text = value.OverRate.ToString("P2");
                string overType = value.OverFinshType.ToString();
                if (overType == "0")
                {
                    this.lblOverFinshType.Text = "不可超量";
                }
                else if (overType == "1")
                {
                    this.lblOverFinshType.Text = "固定数量";
                }
                else if (overType == "2")
                {
                    this.lblOverFinshType.Text = "比例";
                }
            }
        }
    }
}