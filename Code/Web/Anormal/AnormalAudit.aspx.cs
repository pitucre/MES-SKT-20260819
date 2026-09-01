using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Anormal
{
    public partial class AnormalAudit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProdAnormal));
            if (!IsPostBack)
            {
                BindAnormalType();
                BindShift();
            }
            var id = Request.QueryString["ID"];
            if (!string.IsNullOrEmpty(id))
            {
                ProdAnormal.BLL.Anormal bll = new ProdAnormal.BLL.Anormal();
                ProdAnormal.Model.AnormalInfo2 model = bll.GetInfo(Convert.ToInt32(id));

                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }


        protected ProdAnormal.Model.AnormalInfo2 PageData
        {
            set
            {
                this.txtOrderNo.Text = "";
                this.hdnOrderId.Value = "-1";
                this.txtItemCode.Text = "";
                this.hdnItemId.Value = "-1";
                this.txtLineName.Text = value.LineName;
                this.hdnLineId.Value = value.LineId.ToString();
                this.ddlShift.SelectedValue = value.Shift.ToString();
                this.txtStation.Text = value.Station;
                this.hdnStationId.Value = value.OpeId.ToString();
                this.txtDeptName.Text = value.DeptName;
                this.hdnDeptId.Value = value.DeptId.ToString();
                this.txtAnormalOwner.Text = value.Owner;
                this.hdnAnormalOwnerId.Value = "-1";
                this.txtAnormalTime.Text = value.AbnormalTimeLength.ToString();
                this.txtEffectPerson.Text = Convert.ToInt32(value.EffectPerson).ToString();
                this.ckbIsLineStop.Checked = value.IsLineStop;
                this.txtAnormalDesc.Text = value.Descriptions;
                this.ddlAnormalType.SelectedValue = value.AnormalTypeId.ToString();
                this.txtActionPerson.Text = value.ActionPerson;
                this.txtAnormalSolution.Text = value.Solution;
                var rcca = value.RCCA;
                var rccaFileName = rcca.Substring(rcca.LastIndexOf("/") + 1, rcca.Length - rcca.LastIndexOf("/") - 1);
                this.lblRCCAPath.Text = "<a href='" + rcca + "' target='_blank'>" + rccaFileName + "</a>";
                this.anormalObject.Value = value.AnormalObject;

            }
        }

        protected void BindShift()
        {
            SKT.LeanMES.ProductionShift.BLL.ProductionShift bll = new LeanMES.ProductionShift.BLL.ProductionShift();
            this.ddlShift.DataSource = bll.GetAll(0, -1, "", null);
            this.ddlShift.DataTextField = "ShiftName";
            this.ddlShift.DataValueField = "ShiftId";
            this.ddlShift.DataBind();
        }

        protected void BindAnormalType()
        {
            SKT.LeanMES.Anormal.BLL.AnormalGroup bll = new LeanMES.Anormal.BLL.AnormalGroup();
            this.ddlAnormalType.DataSource = bll.GetAll(0, -1, "", null);
            this.ddlAnormalType.DataTextField = "AnormalGroupName";
            this.ddlAnormalType.DataValueField = "AnormalGroupId";
            this.ddlAnormalType.DataBind();
            this.ddlAnormalType.Items.Insert(0, (new ListItem("", "-1")));
        }
    }
}