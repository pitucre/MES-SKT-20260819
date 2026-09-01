using System;
using System.Collections.Generic;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldChangeApplyEdit : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldChangeApplyEdit));
            var bll = new MoludApply();


            var equimentRepair = new EquipmentRepair();

            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);
               
                if (id > 0)
                {

                    PageData = bll.GetInfo(id);

                }
                else
                {
                    
                    this.lblChangeNo.Text = equimentRepair.GetEquipmentRepairNo(-33);                    
                    this.hdnDeptId.Value = AccountController.GetCurrentUserInfo().DepartId.ToString();
                    this.txtDept.Text = AccountController.GetCurrentUserInfo().DepartName.ToString();                    
                }
            }
        }


        [AjaxMethod]
        public List<EquipmentTypeInfo> GetEquimentMouldTypeList(int equimentId)
        {
            List<EquipmentTypeInfo> list=new List<EquipmentTypeInfo>();
            try
            {
                var bll = new MoludApply();
                list = bll.GetEquimentMouldTypeList(equimentId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

            }
            return list;
        }

        /// <summary>
        /// 根据产品ID 获取模具名称
        /// </summary>
        /// <param name="itemId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ItemMouldRelationInfo> GetItemMouldRelations(int itemId)
        {
            List<ItemMouldRelationInfo> list = new List<ItemMouldRelationInfo>();
            try
            {
                ItemMouldRelation bll = new ItemMouldRelation();
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.ExtensionCondition = " ItemId = " + itemId;
                list = bll.GetAll(0, 10000, "", searchSettings);
            }
            catch (Exception)
            {
                throw;
            }
            return list;
        }

        [AjaxMethod]
        public List<MoludBomChildInfo> GetMouldBomChild(int bomId)
        {
            List<MoludBomChildInfo> list = new List<MoludBomChildInfo>();
            try
            {
                MoludBom bll = new MoludBom();
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.ExtensionCondition = " MouldBomId = "+ bomId;
                list = bll.GetBomChildAll(0, 10000, "", searchSettings);
            }
            catch (Exception)
            {
                throw;
            }
            return list;
        }

        [AjaxMethod]
        public List<MoludApplyDetailInfo> GetDetailAll(int equimentType, int cid)
        {
            List<MoludApplyDetailInfo> list = new List<MoludApplyDetailInfo>();
            try
            {
                var bll = new MoludApply();
                SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                searchSettings.ExtensionCondition += "Cid="+cid+ " and MouldType="+equimentType;
                list = bll.GetDetailAll(0,Int32.MaxValue, "", searchSettings);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

            }
            return list;
        }

        [AjaxMethod]
        public List<MoldFixtureUpLine> GetEquimentMouldAll(int equimentId,int equimentType)
        {
            List<MoldFixtureUpLine> list = new List<MoldFixtureUpLine>();
            try
            {
                var bll = new MoludApply();
                SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                searchSettings.ExtensionCondition += " EquimentId="+equimentId+ " and MouldType="+equimentType;
                list = bll.GetEquimentMouldAll(0, Int32.MaxValue, "", searchSettings);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

            }
            return list;
        }



        [AjaxMethod]
        public int Edit(MoludApplyInfo entity)
        {
            var result = -1;
            try
            {
                entity.CreateBy = AccountController.GetCurrentUserInfo().EmployeeCName;
                var bll = new MoludApply();

                result = bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

            }
            return result;
        }
        protected MoludApplyInfo PageData
        {
            set
            {
                this.hdnDeptId.Value = value.DeptId.ToString();
                this.hdnEquimentId.Value = value.EquimentId.ToString();
                this.txtDept.Text = value.DepartName;
                this.txtEquimentCode.Text = value.EquipmentCode;
                this.lblEquimentName.Text = value.EquipmentName;
                this.hdnItemId.Value = value.ItemId.ToString();
                this.txtItemName.Text = value.ItemName;
                this.txtRemark.Text = value.ApplyRemark;
                this.lblChangeNo.Text = value.ApplyNo;
                this.txtDemandTime.Text = value.NeedTime.ToString();
                this.hdStatus.Value = value.Status.ToString();                                
            }
        }
    }
}