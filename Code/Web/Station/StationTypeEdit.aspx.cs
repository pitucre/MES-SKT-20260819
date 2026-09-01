using System;
using SKT.LeanMES.Station.BLL;
using SKT.LeanMES.Station.Model;
using SKT.LeanMES.Web.AjaxServices;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Station
{
    public partial class StationTypeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStation));
            if (!IsPostBack)
            {
                string opeTypeIdStr = Request.QueryString["ID"];

                int OpeTypeId = Convert.ToInt32(opeTypeIdStr);
                GetStationByTypeId(1, -1);
                if (Request.QueryString["Action"] == "Copy")
                {
                    GetStationByTypeId(2, -1);
                }
                else
                {
                    GetStationByTypeId(2, OpeTypeId);
                }

                if (OpeTypeId > -1)
                {
                    SKT.LeanMES.Station.Model.StationTypeInfo model = new SKT.LeanMES.Station.BLL.StationType().GetInfo(OpeTypeId);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }
        protected void GetStationByTypeId(int flage, int stationTypeId)
        {
            List<SKT.LeanMES.Station.Model.StationInfo> resourceType = new SKT.LeanMES.Station.BLL.Station().GetStationInfoByStationId(flage, stationTypeId);
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

        protected SKT.LeanMES.Station.Model.StationTypeInfo PageData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtOpeType.Text = Resources.Buttons.COM_Copy + " - " + value.StationType;
                }
                else
                {
                    this.txtOpeType.Text = value.StationType;
                    this.txtOpeType.Enabled = false;
                }
                this.txtDescription.Text = value.StationDesc;
                this.hdnTemplateId.Value = value.TempId.ToString();
                this.txtOperationUITemp.Text = value.TempName;
            }
        }
    }
}