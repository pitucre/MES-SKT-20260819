using System;
using SKT.LeanMES.Station.BLL;
using SKT.LeanMES.Station.Model;
using SKT.LeanMES.Web.AjaxServices;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Station
{
    public partial class StationEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStation));
            if (!IsPostBack)
            {
                string opeIdStr = Request.QueryString["ID"];
                int opeId = Convert.ToInt32(opeIdStr);
                BindOperationStatus();
                BindListBoxByOpeId(1, opeId);
                BindListBoxByOpeId(2, opeId);
                //绑定工序信息
                GetStationByTypeId(1, -1);
                txtVersion.Text = "1.0";
                if (opeId > -1)
                { 
                    GetStationByTypeId(2, opeId);
                    SKT.LeanMES.Station.Model.StationInfo model = new SKT.LeanMES.Station.BLL.Station().GetInfo(opeId);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }
        protected void BindOperationStatus()
        {
            this.ddlOpeStatus.DataSource = SKT.LeanMES.Web.Utility.EnumHelper.ParseEnumToList(typeof(SKT.LeanMES.Station.Model.EnumOperationStatus));
            this.ddlOpeStatus.DataTextField = "text";
            this.ddlOpeStatus.DataValueField = "value";
            this.ddlOpeStatus.DataBind();
        }

        protected void BindListBoxByOpeId(int flage, int opeId)
        {
            List<SKT.LeanMES.Station.Model.CertificationInfo> certification = new SKT.LeanMES.Station.BLL.Certification().GetStationCertMember(flage, opeId);
            if (flage == 1)
            {
                BindListBox(certification, this.lbAvilableCerList, "Certification", "CertificationId");
            }
            else if (flage == 2)
            {
                BindListBox(certification, this.lbAssignCerList, "Certification", "CertificationId");
            }
        }

        protected void GetStationByTypeId(int flage, int stationTypeId)
        {
            List<SKT.LeanMES.Station.Model.StationInfo> resourceType = new SKT.LeanMES.Station.BLL.Station().GetChildStationInfo(flage, stationTypeId);
            if (flage == 1)
            {
                BindListBox(resourceType, this.lbAvilableOperation, "Station", "StationId");
            }
            else if (flage == 2)
            {
                BindListBox(resourceType, this.lbAssignOperation, "Station", "StationId");
            }
        }

        protected void BindListBox(Object obj, ListBox listBox, string textField, string valueField)
        {
            listBox.DataSource = obj;
            listBox.DataTextField = textField;
            listBox.DataValueField = valueField;
            listBox.DataBind();
        }

        protected SKT.LeanMES.Station.Model.StationInfo PageData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtOperation.Text = Resources.Buttons.COM_Copy + " - " + value.Station;
                    this.txtShortLetter.Text = "";
                }
                else
                {
                    this.txtOperation.Text = value.Station;
                    this.txtOperation.Enabled = false;
                    this.txtShortLetter.Text = value.ShortLetter.ToString();
                }
                this.txtDescription.Text = value.StationDesc;
                this.ddlOpeStatus.SelectedValue = value.StationStatus.ToString();

                this.txtOpeType.Text = value.OpeType;
                this.hdnOpeTypeId.Value = value.StationTypeId.ToString();

                this.txtResType.Text = value.ResTypeName;
                this.hdnResTypeId.Value = value.StationResTypeId.ToString();

                this.txtResDefault.Text = value.ResName;
                this.hdnResId.Value = value.StationDefaultResId.ToString();

                this.txtVersion.Text = value.StationRevision;
                this.chkIsCurrent.Checked = value.StationIsCurrentRev;

                //this.hdnTemplateId.Value = value.TmplID.ToString();
                //this.txtOperationUITemp.Text = value.TempName.ToString();

                this.chkIsCollectStation.Checked = value.IsCollectStation.ToString() == "1" ? true : false;

                
            }
        }
    }
}
