using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.ExtensionTables.BLL;
using SKT.LeanMES.ExtensionTables.Model;

namespace SKT.LeanMES.Web.ExtensionTables
{
    public partial class ExtensionFieldsView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
            {
                ExtensionFields bll = new ExtensionFields();
                ExtensionFieldsInfo model = null;
                model = bll.GetInfo(Convert.ToInt32(Id));
                if (model != null)
                {
                    this.PageData = model;
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
                this.lblTableName.Text = value.TableName;
                this.lblExtensionFieldName.Text = value.ExtensionFieldName;
                this.lblExtensionFieldDescription.Text = value.ExtensionFieldDescription;
                this.lblExtensionFieldType.Text = value.ExtensionFieldType;
                this.lblExtensionFieldIsAllowNull.Text = value.ExtensionFieldIsAllowNull ? "是" : "否";
                this.lblSequence.Text = value.Sequence.ToString();
                this.lblRemark.Text = value.Remark;
            }
        }
    }
}