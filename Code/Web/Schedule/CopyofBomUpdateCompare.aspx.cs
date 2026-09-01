using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Schedule.BLL;
using SKT.LeanMES.Schedule.Model;

namespace SKT.LeanMES.Web.Schedule
{
    public partial class CopyofBomUpdateCompare : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSchedule));

            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
            {

                ERP_MOBOM_Change ubll = new ERP_MOBOM_Change();
                ERP_MOBOMInfo umodel = ubll.GetInfo(Convert.ToInt32(Id));
                if (umodel != null)
                {
                    this.PageDataNew = umodel;

                    ERP_MOBOM bll = new ERP_MOBOM();
                    ERP_MOBOMInfo model = bll.GetInfo(umodel.MoCode.ToString());
                    if (model != null)
                    {
                        this.PageDataOld = model;
                    }
                }


            }
        }

        /// <summary>
        /// 设置页面上的数据。 原内容
        /// </summary>
        private ERP_MOBOMInfo PageDataOld
        {
            set
            {
                lblOldOrderNO.InnerText = value.MoCode.ToString();
                lblOldRowNO.InnerText = value.Rowno.ToString();
                lblOldBusType.InnerText = value.BusType.ToString();
                lblOldInvCode.InnerText = value.InvCode.ToString();
                lblOldInvName.InnerText = value.InvName.ToString();
                lblOldUnit.InnerText = value.ComUnitCode.ToString();
                lblOldDepartNO.InnerText = value.MDeptCode.ToString();
                lblOldDepartName.InnerText = value.MDeptName.ToString();
                lblOldQty.InnerText = value.Qty.ToString();
                lblOldRequisitionIssQty.InnerText = value.RequisitionIssQty.ToString();
                lblOldIssQty.InnerText = value.IssQty.ToString();
                lblOldcBatch.InnerText = value.Batch.ToString();
                lblOldRSortSeq.InnerText = value.RSortSeq.ToString();
                lblOldSortSeq.InnerText = value.SortSeq.ToString();
                lblOldWhCode.InnerText = value.WhCode.ToString();
                lblOldPosition.InnerText = value.VouchCode.ToString();
            }
        }

        /// <summary>
        /// 设置页面上的数据。 新内容
        /// </summary>
        private ERP_MOBOMInfo PageDataNew
        {
            set
            {
                lblNewOrderNO.InnerText = value.MoCode.ToString();
                lblNewRowNO.InnerText = value.Rowno.ToString();
                lblNewBusType.InnerText = value.BusType.ToString();
                lblNewInvCode.InnerText = value.InvCode.ToString();
                lblNewInvName.InnerText = value.InvName.ToString();
                lblNewUnit.InnerText = value.ComUnitCode.ToString();
                lblNewDepartNO.InnerText = value.MDeptCode.ToString();
                lblNewDepartName.InnerText = value.MDeptName.ToString();
                lblNewQty.InnerText = value.Qty.ToString();
                lblNewRequisitionIssQty.InnerText = value.RequisitionIssQty.ToString();
                lblNewIssQty.InnerText = value.IssQty.ToString();
                lblNewcBatch.InnerText = value.Batch.ToString();
                lblNewRSortSeq.InnerText = value.RSortSeq.ToString();
                lblNewSortSeq.InnerText = value.SortSeq.ToString();
                lblNewWhCode.InnerText = value.WhCode.ToString();
                lblNewPosition.InnerText = value.VouchCode.ToString();
            }
        }
    }
}