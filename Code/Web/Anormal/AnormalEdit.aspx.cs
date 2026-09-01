using System;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Anormal
{

    public partial class AnormalEdit : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProdAnormal));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            if (!IsPostBack)
            {
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
                this.txtAnormalTypeName.Text = value.AnormalTypeName;
                this.hdAnormalTypeId.Value = Convert.ToString(value.AnormalTypeId);
                this.hdAnormalId.Value = Convert.ToString(value.AnormalNameId);
                this.txtAnormalName.Text = value.AnormalName;
                this.txtAbnormalProposer.Text = value.AbnormalProposer;
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
                this.hdnDeptId.Value = value.DeptId==null?"":value.DeptId.ToString();
                this.txtAnormalTime.Text = value.AbnormalTimeLength.ToString();
                this.txtEffectPerson.Text = Convert.ToInt32(value.EffectPerson).ToString();
                this.ckbIsLineStop.Checked = value.IsLineStop;
                this.txtAnormalDesc.Text = value.Descriptions;
                var rcca = value.RCCA;
                this.lblRCCAPath.Text = string.IsNullOrEmpty(rcca)?"":rcca.Substring(rcca.LastIndexOf("/") + 1, rcca.Length - rcca.LastIndexOf("/") - 1);
                this.hdnRCCAFilePath.Value = rcca;
                this.anormalObject.Value = value.AnormalObject;
                this.txtCauseAnalysis.Text = String.IsNullOrEmpty(value.CauseAnalysis)?"": value.CauseAnalysis.ToString();
                this.txtTempSolution.Text = String.IsNullOrEmpty(value.TempSolution) ? "" : value.TempSolution.ToString();
                this.txtPermanentSolution.Text =String.IsNullOrEmpty(value.PermanentSolution) ? "" : value.PermanentSolution.ToString();

                this.txtAbnormalDocumentNo.Text =String.IsNullOrEmpty(value.AbnormalDocumentNo) ? DateTime.Now.ToString("yyyyMMddHHmmss") : value.AbnormalDocumentNo.ToString();
                this.txtOrderQty.Text = value.OrderQty.ToString();
                this.txtPECauseAnalysisMan.Text =String.IsNullOrEmpty(value.PECauseAnalysisMan) ? "" : value.PECauseAnalysisMan.ToString();
                this.txtPECauseAnalysisTime.Text = !value.PECauseAnalysisTime.HasValue ? "" : value.PECauseAnalysisTime.Value.ToString("yyyy-MM-dd HH:mm:ss");

                if (value.TempTreatmentScheme == 1)
                {
                    this.TreatmentScheme1.Checked = true;
                    this.TreatmentScheme2.Checked = false;
                    this.TreatmentScheme3.Checked = false;
                }
                else if (value.TempTreatmentScheme == 2)
                {
                    this.TreatmentScheme1.Checked = false;
                    this.TreatmentScheme2.Checked = true;
                    this.TreatmentScheme3.Checked = false;
                }
                else if (value.TempTreatmentScheme == 3)
                {
                    this.TreatmentScheme1.Checked = false;
                    this.TreatmentScheme2.Checked = false;
                    this.TreatmentScheme3.Checked = true;
                }

                this.txtDutyMan.Text =String.IsNullOrEmpty(value.DutyMan) ? "" : value.DutyMan.ToString();
                this.txtQEConfirmer.Text =String.IsNullOrEmpty(value.QEConfirmer) ? "" : value.QEConfirmer.ToString();
                this.txtQEConfirmTime.Text = !value.QEConfirmTime.HasValue ? "" : value.QEConfirmTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
                this.txtImproveMaker.Text =String.IsNullOrEmpty(value.ImproveMaker) ? "" : value.ImproveMaker.ToString();
                this.txtImproveTime.Text = !value.ImproveTime.HasValue ? "" : value.ImproveTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
                this.txtCountermeasureTracking.Text =String.IsNullOrEmpty(value.CountermeasureTracking) ? "" : value.CountermeasureTracking.ToString();
                if (value.Closed == 1)
                {
                    this.Closed.Checked = true;
                    this.NoClosed.Checked = false;
                }
                else if (value.Closed == 2)
                {
                    this.Closed.Checked = false;
                    this.NoClosed.Checked = true;
                }

                this.txtQAFinalConfirm.Text =String.IsNullOrEmpty(value.QAFinalConfirm) ? "" : value.QAFinalConfirm.ToString();
                this.txtQAFinalConfirmTime.Text = !value.QAFinalConfirmTime.HasValue ? "" : value.QAFinalConfirmTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
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

    }
}