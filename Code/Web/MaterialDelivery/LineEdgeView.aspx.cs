using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.MaterialDelivery.Model;
using SKT.LeanMES.MaterialDelivery.BLL;

namespace SKT.LeanMES.Web.MaterialDelivery
{
    public partial class LineEdgeView :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            EdgeLineInfo edgeLineInfo = (new EdgeLine()).GetInfo(Convert.ToInt32(idString));
            SKT.LeanMES.Station.BLL.Line line = new LeanMES.Station.BLL.Line();
            string lineIdStr = edgeLineInfo.LineIdStr;
            List<SKT.LeanMES.Station.Model.LineInfo> info = line.GetLineByIdStr(lineIdStr);
            if (info != null)
            {
                lbRight.DataValueField = "LineId";
                lbRight.DataTextField = "LineName";
                lbRight.DataSource = info;
                lbRight.DataBind();
            }
            List<SKT.LeanMES.Station.Model.LineInfo> myInfo = line.GetLineByIdString(lineIdStr);
            if (myInfo != null)
            {
                lbLeft.DataValueField = "LineId";
                lbLeft.DataTextField = "LineName";
                lbLeft.DataSource = myInfo;
                lbLeft.DataBind();
            }

            this.lblEdgeName.Text = edgeLineInfo.EdgeName;
            this.lbLeft.Enabled = false;
            this.lbRight.Enabled = false;
            this.lblRemark.Text = edgeLineInfo.Remark;
        }
    }
}