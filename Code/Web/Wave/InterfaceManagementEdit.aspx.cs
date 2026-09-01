using SKT.LeanMES.Wave.BLL;
using SKT.LeanMES.Wave.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Wave
{
    public partial class InterfaceManagementEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInterfaceManagement));
            if (!this.IsPostBack)
            {
                string id = Request.QueryString["id"];
                this.hidId.Value = id ?? string.Empty;
                if (!string.IsNullOrWhiteSpace(id) && !string.Equals(id, "-1"))
                {
                    var bll = new DeviceInterface();
                    var entity = bll.Get(Convert.ToInt32(id));
                    if (entity != null)
                        this.PageData = entity;
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private DeviceInterfaceInfo PageData
        {
            set
            {
                this.hdnDeviceType.Value = value.DeviceType;
                this.hidDeviceInterfaceTypeId.Value = value.DeviceInterfaceTypeId.ToString();
                this.txtTargetFileDir.Text = value.TargetFileDir;
                this.ddlFileType.SelectedValue = value.FileType;
                //this.txtUserName.Text = value.UserName;
                //this.txtPassword.Text = value.Password;
                //this.hidPwd.Value = value.Password;
                this.txtDefaultUserName.Text = value.DefaultUserName;
                this.txtNCCode.Text = value.NCCode;
                this.hidNCCodeId.Value = value.NCCodeId.ToString();
                this.txtLineName.Text = value.LineName;
                this.hidLineId.Value = value.LineId.ToString();
                this.ddlIsCouplet.SelectedValue = value.IsCouplet.ToString();
                //this.txtSnPosition.Text = value.SnPosition;
                this.hidFileNewPath.Value = value.FileNewPath;
                this.hidTitleSplitChar.Value = value.TitleSplitChar;
                this.hidTxtSplitChar.Value = value.TxtSplitChar;
            }
        }
    }
}