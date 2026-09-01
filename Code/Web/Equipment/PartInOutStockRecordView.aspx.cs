using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class PartInOutStockRecordView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            PartInfo partInfo = (new Part()).GetInOutStockInfo(Convert.ToInt32(idString));

            this.lblPartName.Text = partInfo.PartName;
            this.lblPartCode.Text = partInfo.PartCode;

            this.lblCreateBy.Text = partInfo.CreateBy;
            this.lblOptType.Text=partInfo.OperationType;

            this.lblQty.Text = partInfo.Qty.ToString();
            this.lblCreateTime.Text = partInfo.CreateDateTime.ToString();
            this.lblRemark.Text = partInfo.Remark;
        }
    }
}