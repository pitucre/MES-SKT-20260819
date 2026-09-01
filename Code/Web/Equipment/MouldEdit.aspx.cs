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
using SKT.Common.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldEdit : BasePage
    {
        AjaxEsop aEsop = new AjaxEsop();
        string filePath = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMoldFixtureItem));

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MoldFixtureId";
            this.Master.DefaultSortExpression = "MoldFixtureId";

            string EquipmentId = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
            searchSettings.ExtensionCondition += " EquipmentId = " + EquipmentId;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //if (!this.IsPostBack)
            {
                Bind();

                string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
                int Id;

                if (int.TryParse(IdStr, out Id) && Id > 0)
                {
                    txtEquipmentCode.Enabled = false;
                    Equipments bll = new Equipments();
                    EquipmentsInfo model = null;
                    model = bll.GetInfo(IdStr);
                    if (model != null)
                    {
                        this.PageData = model;
                    }

                    //ddlEquipmentType.Items[0].Text = "--未知--";
                    // ddlLine.Items[0].Text = "--未知--";
                    //ddlStation.Items[0].Text = "--未知--";
                }
                else
                {
                    this.txtFactortTime.Text = DateTime.Now.ToString("yyyy-MM-dd");
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
                txtPosition.Text = value.cBarCode;
                HiddenPosition.Value = value.WarehouseLocationId.ToString();

                this.txtEquipmentCode.Text = value.EquipmentCode;
                this.txtEquipmentName.Text = value.EquipmentName;
                //HiddenComponentId.Value = value.ComponentId.ToString();
                //txtComponentName.Text = value.ComponentName.ToString();
                //this.hdnMouldBomId.Value = value.MouldBomId.ToString();
                //this.txtEquipmentModel.Text = value.EquipmentModel;
                //this.hdnVendorCode.Value = value.VenCode;
                //this.txtVerdorName.Text = value.VendorName;

                this.hdnItemId.Value = value.ItemId.ToString();
                //this.txtItemCode.Text = value.ItemCode;
                this.hdnSupplierCode.Value = value.SupplierCode;
                this.txtSupplierName.Text = value.SupplierName;

                this.txtFactortTime.Text = value.FactoryDate.ToString("yyy-MM-dd");
                //this.ddlStatus.SelectedValue = value.Status.ToString();
                //this.ddlLine.SelectedValue = value.LineId.ToString();
                //txtUnitname.Text = value.UnitName;
                //txtDep.Text = value.DepartName;
                //HiddDep.Value= value.CareDepNo;
                //this.txtCustomerName.Text = value.CustomerName;
                //this.hdnCustomerId.Value = value.CustomerId.ToString();
                this.txtStandardLife.Text = value.StandarLive.ToString();
                txtServiceLife.Text = value.UseCount.ToString();
                //if (value.SequenceNo != -1)
                //{
                //    this.txtSequenceNo.Text = value.SequenceNo.ToString();
                //}        
                //this.txtFactortTime.Text = value.FactoryDate.ToString("yyy-MM-dd");
                this.txtRemark.Text = value.Remark;
                
                if (value.PictureName != "")
                {
                    filePath = aEsop.LocalFileExists(value.PictureName, "MouldAnormal");
                    if (filePath != "")
                    {
                        this.image1.ImageUrl = filePath;
                    }
                    else
                    {
                        if (value.PictureName == "未载入")
                        {
                            this.image1.ImageUrl = string.Empty;
                        }
                        else
                        {
                            this.image1.ImageUrl = SKT.LeanMES.Web.WebHelper.WebRoot + "/ESOP/DownLoad.aspx?Action=MouldAnormal&fileName=" + value.PictureName;
                        }
                    }
                }
                lbFileReady.Text = value.PictureName;
                txtCompanyName.Text = value.CompanyName;
                hiddenCompanyCode.Value = value.Company;
                //this.txtPrice.Text = value.Price.ToString();
                //this.txtConsignee.Text = value.Consignee;

                this.txtCustomName.Text = value.CustomName;
                this.txtModel.Text = value.Model;
                this.txtMachineTonnage.Text = value.MachineTonnage;
                this.txtMoldTonnage.Text = value.MoldTonnage;
                this.txtSize.Text = value.Size;
                this.txtMatrix.Text = value.Matrix;
                this.txtCavity.Text = value.Cavity.ToString();
                this.txtMoldTimes.Text = value.MoldTimes;

                this.txtFactoryMouldCode.Text = value.FactoryMouldCode.ToString();
                this.txtFactoryMouldName.Text = value.FactoryMouldName.ToString();
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
            //SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            //SKT.LeanMES.Station.BLL.Line line = new SKT.LeanMES.Station.BLL.Line();
            //List<SKT.LeanMES.Station.Model.LineInfo> lineInfo = line.GetAll(0, 100, "LineId", searchSettings);
            //ddlLine.DataSource = lineInfo;
            //ddlLine.DataTextField = "LineName";
            //ddlLine.DataValueField = "LineId";
            //ddlLine.DataBind();
            //ddlLine.Items.Insert(0, new ListItem("选择产线", "-1"));

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