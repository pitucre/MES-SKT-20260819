using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SPC.BLL;
using SKT.LeanMES.SPC.Model;

namespace SKT.LeanMES.Web.SPC
{
    public partial class SPCProjectEdit : BasePage
    {
        public string codeIds = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSPC));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new SPCProject()).GetInfo(Convert.ToInt32(idString));
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }

                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SPCProjectInfo PageData
        {
            set
            {
                this.txtProjectName.Text = value.ProjectName;
                this.txtProjectDesc.Text = value.ProjectDesc;
                this.ddlGraphType.SelectedValue = value.GraphType;
                this.txtSampleQty.Text = Convert.ToString(value.SampleQty);
                this.txtGroupQty.Text = Convert.ToString(value.GroupQty);
                this.txtSampleDecimalPoint.Text = Convert.ToString(value.SampleDecimalPoint);
                this.chkIsShowCP.Checked = value.IsShowCP;
                this.chkIsShowCPK.Checked = value.IsShowCPK;
                this.chkIsShowPP.Checked = value.IsShowPP;
                this.chkIsShowPPK.Checked = value.IsShowPPK;
                this.hidNCGroupId.Value = Convert.ToString(value.NCGroupId);
                if (value.NCGroupId > 0)
                {
                    var ncgroupEntity = new SKT.LeanMES.NCCode.BLL.NCGroup().GetInfo(value.NCGroupId);
                    if (ncgroupEntity != null)
                    {
                        this.txtNCGroupId.Text = ncgroupEntity.NCGroupName;
                    }
                }
                var nccodeEntity = new SKT.LeanMES.NCCode.Model.NCCodeInfo();

                this.hidNCCodeIdA.Value = Convert.ToString(value.NCCodeIdA);
                if (value.NCCodeIdA > 0)
                {
                    nccodeEntity = new SKT.LeanMES.NCCode.BLL.NCCode().GetInfo(value.NCCodeIdA);
                    if (nccodeEntity != null)
                    {
                        this.txtNCCodeIdA.Text = nccodeEntity.NCCode;
                    }
                }
                this.hidNCCodeIdB.Value = Convert.ToString(value.NCCodeIdB);
                if (value.NCCodeIdB > 0)
                {
                    nccodeEntity = new SKT.LeanMES.NCCode.BLL.NCCode().GetInfo(value.NCCodeIdB);
                    if (nccodeEntity != null)
                    {
                        this.txtNCCodeIdB.Text = nccodeEntity.NCCode;
                    }
                }
                this.hidNCCodeIdC.Value = Convert.ToString(value.NCCodeIdC);
                if (value.NCCodeIdC > 0)
                {
                    nccodeEntity = new SKT.LeanMES.NCCode.BLL.NCCode().GetInfo(value.NCCodeIdC);
                    if (nccodeEntity != null)
                    {
                        this.txtNCCodeIdC.Text = nccodeEntity.NCCode;
                    }
                }
                this.hidNCCodeIdD.Value = Convert.ToString(value.NCCodeIdD);
                if (value.NCCodeIdA > 0)
                {
                    nccodeEntity = new SKT.LeanMES.NCCode.BLL.NCCode().GetInfo(value.NCCodeIdD);
                    if (nccodeEntity != null)
                    {
                        this.txtNCCodeIdD.Text = nccodeEntity.NCCode;
                    }
                }
                this.hidNCCodeIdE.Value = Convert.ToString(value.NCCodeIdE);
                if (value.NCCodeIdE > 0)
                {
                    nccodeEntity = new SKT.LeanMES.NCCode.BLL.NCCode().GetInfo(value.NCCodeIdE);
                    if (nccodeEntity != null)
                    {
                        this.txtNCCodeIdE.Text = nccodeEntity.NCCode;
                    }
                }
                codeIds = value.NCCodeIdA + "," + value.NCCodeIdB + "," + value.NCCodeIdC + "," + value.NCCodeIdD + "," + value.NCCodeIdE;
                this.chkIsWarnA.Checked = value.IsWarnA;
                this.chkIsWarnB.Checked = value.IsWarnB;
                this.chkIsWarnC.Checked = value.IsWarnC;
                this.txtWarnCVal.Text = value.WarnCVal == 0 ? "" : Convert.ToString(value.WarnCVal);
                this.chkIsWarnD.Checked = value.IsWarnD;
                this.txtWarnDVal.Text = value.WarnDVal == 0 ? "" : Convert.ToString(value.WarnDVal);
                this.chkIsWarnE.Checked = value.IsWarnE;
                this.txtWarnEVal.Text = value.WarnEVal == 0 ? "" : Convert.ToString(value.WarnEVal);
            }
        }
    }
}