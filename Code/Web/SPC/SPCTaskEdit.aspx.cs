using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SPC.Model;
using SKT.LeanMES.SPC.BLL;

namespace SKT.LeanMES.Web.SPC
{
    public partial class SPCTaskEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSPC));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new SPCTask()).GetInfo(Convert.ToInt32(idString));
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
        private SPCTaskInfo PageData
        {
            set
            {
                this.txtSPCProjectId.Text = value.ProjectName;
                this.hidSPCProjectId.Value = Convert.ToString(value.SPCProjectId);
                this.txtTaskName.Text = value.TaskName;
                this.txtTaskDesc.Text = value.TaskDesc;
                this.hidItemId.Value = Convert.ToString(value.ItemId);
                this.hidLineId.Value = Convert.ToString(value.LineId);
                this.hidStationId.Value = Convert.ToString(value.StationId);
                this.txtItemId.Text = Convert.ToString(value.ItemCode);
                this.txtLineId.Text = Convert.ToString(value.LineName);
                this.txtStationId.Text = Convert.ToString(value.Station);
                this.chkIsRefeshData.Checked = value.IsRefeshData;
                this.txtRefeshInterval.Text = Convert.ToString(value.RefeshInterval);
                this.txtUSL.Text = Convert.ToString(value.USL);
                this.txtLSL.Text = Convert.ToString(value.LSL);
                this.txtSPCGetDataProc.Text = value.SPCGetDataProc;
                this.txtSPCActionProc.Text = value.SPCActionProc;
                this.txtSPCAGraphProc.Text = value.SPCAGraphProc;
                this.lblGraphType.Text = value.GraphType;
                this.hdnUnitId.Value = value.UnitId.ToString();
                this.txtUnit.Text = value.Unit;
                this.chkIsCurve.Checked = value.IsCurve;
            }
        }
    }
}