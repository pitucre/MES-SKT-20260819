using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Equipment.Model;
using System.IO;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentEdit : BasePage
    {
        AjaxEsop aEsop = new AjaxEsop();
        string filePath = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxBaseExt));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxEquipment));

            if (!this.IsPostBack)
            {
                Bind();

                string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
                int Id;

                if (int.TryParse(IdStr, out Id) && Id > 0)
                {
                    txtEquipmentCode.Enabled = false;
                    Equipments bll = new Equipments();
                    EquipmentsInfo model = null;
                    model = bll.GetInfo(Convert.ToString(Id));
                    if (model != null)
                    {
                        this.PageData = model;
                    }

                    //ddlEquipmentType.Items[0].Text = "--未知--";
                    ddlLine.Items[0].Text = "--未知--";
                    //ddlStation.Items[0].Text = "--未知--";
                }
            }

        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentsInfo PageData
        {
            set
            {
                txtPosition.Text = value.PositionName;
                HiddenPosition.Value = value.Position;

                this.txtEquipmentCode.Text = value.EquipmentCode;
                this.txtEquipmentName.Text = value.EquipmentName;
                HiddenEquipmentTypeId.Value = value.EquipmentTypeId.ToString();
                ddlEquipmentType.Text = value.EquipmentTypeName.ToString();
                this.txtEquipmentModel.Text = value.EquipmentModel;
                this.hdnVendorCode.Value = value.VenCode;
                this.txtVerdorName.Text = value.VenCode;
                //this.txtVerdorName.Text = value.VendorName;

                this.txtStation.Text = value.StationName;
                this.HiddenStation.Value = value.StationId.ToString();
                this.hdnSupplierCode.Value = value.SupplierCode;
                this.txtSupplierName.Text = value.SupplierName;

                //this.txtPrudctDate.Text = value.ProduceDate.ToString("yyy-MM-dd");
                this.ddlStatus.SelectedValue = value.Status.ToString();

                // BUG: 设备列表新增跟修改设备信息的购置方式，保存后再次点击编辑还是显示为购买 禅道ID: 1211 by: zaiqing.Li
                this.ddPurchase.SelectedValue = value.Purchase.ToString();

                this.ddlLine.SelectedValue = value.LineId.ToString();
                txtUnitname.Text = value.UnitName;
                txtDep.Text = value.DepartName;
                HiddDep.Value = value.CareDepNo;
                txtBy.Text = value.CareBy;
                txtUseCount.Text = value.UseCount.ToString();
                if (value.SequenceNo != -1)
                {
                    this.txtSequenceNo.Text = value.SequenceNo.ToString();
                }
                this.txtFactortTime.Text = value.FactoryDate.ToString("yyy-MM-dd");
                this.txtRemark.Text = value.Remark;

                if (value.PictureName != "")
                {
                    filePath = aEsop.LocalFileExists(value.PictureName, "FileUploadEquiment");
                    if (filePath != "")
                    {
                        this.image1.ImageUrl = filePath;
                    }
                    else
                    {
                        this.image1.ImageUrl = SKT.LeanMES.Web.WebHelper.WebRoot + "/ESOP/DownLoad.aspx?Action=FileUploadEquiment&fileName=" + value.PictureName;
                    }
                    
                   
                   
                }
                lbFileReady.Text = value.PictureName;
                txtGuaranteeDay.Text = value.GuaranteeDay.ToString();
                txtOverGuaranteeTime.Text = value.OverGuaranteeTime.ToString("yyy-MM-dd");
                txtAssetNumber.Text = value.AssetNumber;
                this.txtEquipmentIP.Text = value.EquipmentIP;
                this.txtEquipmentPort.Text = value.EquipmentPort;
            }
        }

        /// <summary>
        /// 下拉框绑定
        /// </summary>
        /// <param name="Value">查询字段值</param>
        /// <param name="DDList">下拉框</param>
        private void Bind()
        {
            SKT.Common.Model.SearchSettings searchSetting1 = new SKT.Common.Model.SearchSettings();
            searchSetting1.ExtensionCondition = " EquipmentTypeId not in (-3,-2) ";
            EquipmentType Dictionaty = new EquipmentType();
            List<EquipmentTypeInfo> dInfos = Dictionaty.GetAll(0, 100, "EquipmentTypeId", searchSetting1);
            //ddlEquipmentType.DataSource = dInfos;
            //ddlEquipmentType.DataTextField = "EquipmentTypeName";
            //ddlEquipmentType.DataValueField = "EquipmentTypeId";
            //ddlEquipmentType.DataBind();
            //ddlEquipmentType.Items.Insert(0, new ListItem("选择设备类型", "-1"));

            /***获取产线名称***/
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            SKT.LeanMES.Station.BLL.Line line = new SKT.LeanMES.Station.BLL.Line();
            List<SKT.LeanMES.Station.Model.LineInfo> lineInfo = line.GetAll(0, -1, "LineId", searchSettings);
            ddlLine.DataSource = lineInfo;
            ddlLine.DataTextField = "LineName";
            ddlLine.DataValueField = "LineId";
            ddlLine.DataBind();
            ddlLine.Items.Insert(0, new ListItem("选择产线", "-1"));

            /***获取工位名称***/
            //SKT.LeanMES.Station.BLL.Station oper = new SKT.LeanMES.Station.BLL.Station();
            //List<SKT.LeanMES.Station.Model.StationInfo> operInfo = oper.GetAll(0, 100, "StationId", searchSettings);
            //ddlStation.DataSource = operInfo;
            //ddlStation.DataTextField = "Station";
            //ddlStation.DataValueField = "StationId";
            //ddlStation.DataBind();
            //ddlStation.Items.Insert(0, new ListItem("选择工位", "-1"));
        }

        protected void linkUploadFile_Click(object sender, EventArgs e)
        {
            //string filePath = "";
            //if (!fuLoadingList.HasFile)
            //{
            //    WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty.ToString());
            //    return;
            //}

            //string fileExtension = System.IO.Path.GetExtension(fuLoadingList.PostedFile.FileName).ToLower();
            //string allowExtension = ".jpg";
            //string allowTwoExtension = ".png";
            //string allowExtension_3 = ".gif";
            //if (fileExtension != allowExtension
            //    && fileExtension != allowTwoExtension
            //    && fileExtension != allowExtension_3)
            //{
            //    WebHelper.ShowMessage(Resources.Messages.FileTypeError.ToString());
            //    return;
            //}

            //string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/EQPicture");

            //if (!Directory.Exists(path))
            //{
            //    Directory.CreateDirectory(path);
            //}
            //try
            //{
            //    filePath = path + "/" + fuLoadingList.FileName;
            //    lbFileReady.Text = fuLoadingList.FileName;
            //    Label1.Text = filePath;
            //    this.filepaths.Value = filePath;
            //    this.fuLoadingList.PostedFile.SaveAs(filePath);
            //}
            //catch (Exception)
            //{

            //    throw;
            //}
            //finally
            //{
            //    fuLoadingList.PostedFile.InputStream.Close();
            //    fuLoadingList.PostedFile.InputStream.Dispose();
            //}
            //this.filepaths.Value = filePath;
        }
    }
}