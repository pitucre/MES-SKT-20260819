using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.BasalData
{
    public partial class MaskMemberEdit : BasePage
    {
        #region protected mumbers
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaskGroup));
            Int32 ID = Convert.ToInt32(Request.QueryString["ID"]);
            if (!this.IsPostBack)
            {
                if (ID != -1)
                {
                    SKT.LeanMES.MaskGroup.BLL.MaskGroupMember bllMember = new SKT.LeanMES.MaskGroup.BLL.MaskGroupMember();
                    SKT.LeanMES.MaskGroup.Model.MaskGroupMemberInfo model = null;
                    model = bllMember.GetInfo(ID);
                    if (model != null)
                    {
                        this.MemberData = model;
                    }
                }
            }
        }

        /// <summary>
        /// 编辑状态下获得对应CertID的数据
        /// </summary>
        protected SKT.LeanMES.MaskGroup.Model.MaskGroupMemberInfo MemberData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtSeq.Text = "";
                    this.txtDisplay.Text = Resources.Buttons.COM_Copy + " - " + value.DisplayMask;
                }
                else
                {
                    this.txtSeq.Text = value.Sequence.ToString();
                    this.txtDisplay.Text = value.DisplayMask;
                }
                for (int i = 0; i < ddlType.Items.Count; i++) //取得下拉列表的值
                {
                    if (ddlType.Items[i].Value.Length > 0 && ddlType.Items[i].Value.Substring(0, 1) == value.MaskType)
                    {
                        ddlType.SelectedIndex = i;
                        break;
                    }
                }
                this.txtMin.Text = value.MinLength.ToString();
                this.txtMax.Text = value.MaxLength.ToString();
                if (value.ValidTo.ToString("yyyy-MM-dd") == "9999-12-31")
                {                    
                    this.txtTo.Text = "";
                    this.txtFrom.Text = value.ValidFrom.ToString("yyyy-MM-dd");
                }
                else
                {
                    this.txtFrom.Text = value.ValidFrom.ToString("yyyy-MM-dd");
                    this.txtTo.Text = value.ValidTo.ToString("yyyy-MM-dd");
                }
            }
        }
        #endregion
    }
}