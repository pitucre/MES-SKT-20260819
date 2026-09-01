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
    public partial class EquimentPartView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            PartInfo partInfo = (new Part()).GetPartEquInfo(Convert.ToInt32(idString));

            this.lblPartName.Text = partInfo.PartName;
            this.lblPartCode.Text = partInfo.PartCode;

            this.lblEquimentName.Text = partInfo.EquimentName;
            this.lblEquimentCode.Text=partInfo.EquimentCode;

            this.lblCreateTime.Text = partInfo.CreateDateTime.ToString();
        }
    }
}