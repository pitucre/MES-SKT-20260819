using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.MaterialDelivery.Model;
using SKT.LeanMES.Resource.Model;

namespace SKT.LeanMES.Web.MaterialDelivery
{
    public partial class LineEdgeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEdgeLine));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.MaterialDelivery.BLL.EdgeLine()).GetInfo(Convert.ToInt32(idString));
                }
                else
                {
                    SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                    SKT.LeanMES.Station.BLL.Line bll = new LeanMES.Station.BLL.Line();
                    List<SKT.LeanMES.Station.Model.LineInfo> listInfo = new List<SKT.LeanMES.Station.Model.LineInfo>();
                    listInfo = bll.GetAllLine();
                    if (listInfo != null)
                    {
                        lbLeft.DataValueField = "LineId";
                        lbLeft.DataTextField = "LineName";
                        lbLeft.DataSource = listInfo;
                        lbLeft.DataBind();
                    }
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EdgeLineInfo PageData
        {
            set
            {
                this.txtEdgeName.Text = value.EdgeName;
                this.txtEdgeName.Enabled = false;
                SKT.LeanMES.Station.BLL.Line line = new LeanMES.Station.BLL.Line();
                string lineIdStr = value.LineIdStr;
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
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}