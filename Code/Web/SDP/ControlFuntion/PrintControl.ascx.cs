using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SDP.ControlFuntion
{
    public partial class PrintControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {            
            BindSerialNumberType();
            //BindLabelDocument();            
        }

        /// <summary>
        /// 绑定序列号规则类型
        /// </summary>
        protected void BindSerialNumberType()
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            this.ddlType.DataSource = new SKT.LeanMES.SerialNumber.BLL.SerialNumberType().GetAll(0, 100, "SerialNumberTypeId", searchSettings);
            this.ddlType.DataTextField = "SerialNumberType";
            this.ddlType.DataValueField = "SerialNumberTypeId";
            this.ddlType.DataBind();
            this.ddlType.Items.Insert(0, new ListItem(Resources.lang.Choose, ""));
        }

        //protected void BindLabelDocument()
        //{
        //    SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
        //    this.ddlDoc.DataSource = (new SKT.LeanMES.Labels.BLL.LabelDocument()).GetAll(0, 100, "LabelDocumentId", searchSettings);
        //    this.ddlDoc.DataTextField = "DocumentName";
        //    this.ddlDoc.DataValueField = "LabelDocumentId";
        //    this.ddlDoc.DataBind();
        //    this.ddlDoc.Items.Insert(0, new ListItem(Resources.lang.Choose, ""));
        //}
    }
}