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
    public partial class MouldView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMouldOperateRecord));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));

            if (!this.IsPostBack)
            {
                Bind();

                string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
                int Id;

                if (int.TryParse(IdStr, out Id) && Id > 0)
                {
                    lblEquipmentCode.Enabled = false;
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
            }

        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentsInfo PageData
        {
            set
            {
                lblPosition.Text = value.StoreName;
               

                this.lblEquipmentCode.Text = value.EquipmentCode;
                this.lblEquipmentName.Text = value.EquipmentName;
              
                //this.lblEquipmentModel.Text = value.EquipmentModel;
             
                //this.lblVerdorName.Text = value.VendorName;

                this.lblEquipmentType.Text = value.ComponentName;
                //this.lblItemCode.Text = value.ItemCode;
         
                this.lblSupplierName.Text = value.SupplierName;

                this.lblFactortTime.Text = value.FactoryDate.ToString("yyy-MM-dd");
                //this.ddlStatus.SelectedValue = value.Status.ToString();
                //this.ddlLine.SelectedValue = value.LineId.ToString();
                //lblUnitname.Text = value.UnitName;
                //lblDep.Text = value.DepartName;
                //HiddDep.Value= value.CareDepNo;

                this.lblStandardLife.Text = value.StandarLive.ToString();
                lblServiceLife.Text = value.UseCount.ToString();
                //if (value.SequenceNo != -1)
                //{
                //    this.lblSequenceNo.Text = value.SequenceNo.ToString();
                //}        
                //this.lblFactortTime.Text = value.FactoryDate.ToString("yyy-MM-dd");
                this.txtRemark.Text = value.Remark;

                if (value.PictureName!="")
                {
                    this.txtimg.ImageUrl = SKT.LeanMES.Web.WebHelper.EQPictureFileRoot + "/" + value.PictureName;
                }
                this.lbFileReady.Value = value.PictureName;
                lblCompany.Text = value.CompanyName;
                lblPrice.Text = value.Price.ToString();
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
          
        }

     
    }
}