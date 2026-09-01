using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.ExtensionTables.Model;
using SKT.LeanMES.ExtensionTables.BLL;

namespace SKT.LeanMES.Web.ExtensionTables
{
    public partial class ExtensionFieldsEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxExtensionFields));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new ExtensionFields()).GetInfo(Convert.ToInt32(idString));
                }
                else
                {
                    this.extensionFieldsId.Value = idString;
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ExtensionFieldsInfo PageData
        {
            set
            {
                this.extensionFieldsId.Value = value.ExtensionFieldsId.ToString();
                this.txtTableName.Text = value.TableName;
                this.txtExtensionFieldName.Text = value.ExtensionFieldName;
                this.txtExtensionFieldDescription.Text = value.ExtensionFieldDescription;
                this.ddlExtensionFieldType.Text = value.ExtensionFieldType;
                this.chkExtensionFieldIsAllowNull.Checked = value.ExtensionFieldIsAllowNull;
                this.txtSequence.Text = Convert.ToString(value.Sequence);
                this.txtRemark.Text = value.Remark;

                SKT.LeanMES.ExtensionTables.Model.ExtensionFieldsInfo o = new SKT.LeanMES.ExtensionTables.BLL.ExtensionFields().GetInfo(value.TableName);
                if (o != null)
                {
                    this.txtTableName.Text = o.TableName;
                    this.hidTableName.Value = o.TableName;
                }
            }
        }
    }
}