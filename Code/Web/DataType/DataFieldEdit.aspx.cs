using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.DataType.BLL;
using SKT.LeanMES.DataType.Model;
using SKT.LeanMES.MaskGroup.BLL;
using SKT.LeanMES.MaskGroup.Model;
using SKT.LeanMES.Web;

namespace SKT.MES.Web.BasalData
{
    public partial class DataFieldEdit : BasePage
    {
        #region protected mumbers
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxDataType));
            Int32 FID = Convert.ToInt32(Request.QueryString["ID"]);
            if (!this.IsPostBack)
            {
                if (FID != -1)
                {
                    DataField bllDict = new DataField();
                    DataFieldInfo model = null;
                    model = bllDict.GetInfo(FID);
                    if (model != null)
                    {
                        this.FieldData = model;
                        if (Request.QueryString["Action"] != "Copy")
                        {
                            this.txtSeq.Enabled = false;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// 编辑状态下获得对应CertID的数据
        /// </summary>
        protected DataFieldInfo FieldData
        {
            set
            {
                try
                {
                    Int32 intSystemDataField = 0;
                    DataField bllField = new DataField();
                    intSystemDataField = bllField.IsSystemDataField(value.DataField, 0);
                    if (Request.QueryString["Action"] == "Copy")
                    {
                        this.txtSeq.Text = "";
                    }
                    else
                    {
                        this.txtSeq.Text = value.Sequence.ToString();
                    }
                    this.txtField.Text = value.DataField;
                    if (intSystemDataField == 1)
                    {
                        this.txtField.Enabled = false;
                    }
                    this.txtTag.Text = value.DataTag;
                    this.ddlType.SelectedValue = value.DataType;
                    MaskGroup mask = new MaskGroup();
                    MaskGroupInfo maskmodel = mask.GetInfo(Convert.ToInt32(value.MaskGroup));
                    this.txtMask.Text = maskmodel == null ? "" : maskmodel.MaskGroup;
                    this.txtMaskID.Value = maskmodel == null ? "-1" : maskmodel.MaskID.ToString();
                    this.chkRequired.Checked = value.Required;
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
                }
            }
        }
        #endregion
 
    }
}