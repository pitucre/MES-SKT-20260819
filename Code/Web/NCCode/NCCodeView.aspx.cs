using System;
using SKT.LeanMES.NCCode.BLL;
using SKT.LeanMES.NCCode.Model;

namespace SKT.LeanMES.Web.NCCode
{
    public partial class NCCodeView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            SKT.LeanMES.NCCode.BLL.NCCode code = new LeanMES.NCCode.BLL.NCCode();
            NCCodeInfo nCCodeInfo = code.GetInfo(Convert.ToInt32(idString));

            if (nCCodeInfo != null)
            {
                var category = "";
                switch (nCCodeInfo.Category)
                {
                    case "失败品":
                        category = "不良现象";
                        break;
                    case "缺陷品":
                        category = "不良原因";
                        break;
                    case "返修品":
                        category = "维修方法";
                        break;
                }
                this.lblNCCodeType.Text = nCCodeInfo.NCCodeTypeName;
                this.lblNCCode.Text = nCCodeInfo.NCCode;
                this.lblDataType.Text = nCCodeInfo.DataType;
                this.lblStatus.Text = nCCodeInfo.Status;
                this.lblCategory.Text = category;
                this.lblDescription.Text = nCCodeInfo.Description;
            }
        }
    }
}