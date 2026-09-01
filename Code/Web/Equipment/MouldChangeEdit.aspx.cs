using System;
using System.Collections.Generic;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.Common.Account.Model;
using System.Linq;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldChangeEdit : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldChangeApplyEdit));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldChangeEdit));
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
                    this.lblChangeNo.Text = equimentRepair.GetEquipmentRepairNo(-20);
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


        [AjaxMethod]
        public List<EquimentMouldBomChild> GetEquimentMouldBomChildList(int equimentId)
        {
            List<EquimentMouldBomChild> list = new List<EquimentMouldBomChild>();
            try
            {
                var bll = new MoludApply();
                list = bll.GetEquimentMouldBomChildList(equimentId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

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
                searchSettings.ExtensionCondition += "Cid="+cid+ " and ReplaceMouldType="+equimentType;
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
                //searchSettings.ExtensionCondition += " EquimentId="+equimentId+ " and MouldType="+equimentType;
                searchSettings.ExtensionCondition += " EquimentId=" + equimentId;
                list = bll.GetEquimentMouldAll(0, Int32.MaxValue, "", searchSettings);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

            }
            return list;
        }



        [AjaxMethod]
        public int EditChange(MoludApplyInfo entity)
        {
            var result = -1;
            try
            {
                entity.CreateBy = AccountController.GetCurrentUserInfo().UserName;
                var bll = new MoludApply();

                result = bll.EditChange(entity);
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
               
                this.hdnEquimentId.Value = value.EquimentId.ToString();
                this.lblEquimentName.Text = value.EquipmentName;
                this.lblChangeNo.Text = value.ApplyNo;
                this.lblEquimentCode.Text = value.EquipmentCode;
                this.lblItemName.Text = value.ItemName;
                this.txtActualFinish.Text = value.ActualFinish.ToString("yyyy-MM-dd")=="1971-01-01"?"": value.ActualFinish.ToString();
                //换模人
                this.txtOperator.Text = GetCNameByUserNames(value.Operator);
                this.hdOperator.Value = value.Operator;
                this.txtActualStartTime.Text = value.ActualStartTime.ToString("yyyy-MM-dd")== "1971-01-01" ? "" : value.ActualStartTime.ToString();
                this.txtChangeoverPlanTime.Text = value.ChangeoverPlanTime.ToString("yyyy-MM-dd") == "1971-01-01" ? "" : value.ChangeoverPlanTime.ToString();
                this.txtRemark.Text = value.ChangeOverRemark;
                this.hdnItemId.Value = value.ItemId.ToString();
                //this.hdStatus.Value = value.Status.ToString();
                this.txtInitialPress.Text = value.InitialPress.ToString();
                this.txtCurrentPress.Text = value.CurrentPress.ToString();
                chkMouldUnload.Checked = value.IsMouldUnload;
                if (this.hdOperator.Value == "")
                {
                    this.txtOperator.Text = AccountController.GetCurrentUserInfo().EmployeeCName;
                    this.hdOperator.Value = AccountController.GetCurrentUserInfo().UserName;
                }


            }
        }

        /// <summary>
        /// 通过用户名获取中文名
        /// </summary>
        /// <param name="userNames">用户名长串（逗号拼接）</param>
        /// <returns></returns>
        private string GetCNameByUserNames(string userNames)
        {
            string userCNames = string.Empty;
            
            if (!string.IsNullOrEmpty(userNames))
            {
                SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
                var listUserName = new List<string>();
                var listUserCName = new List<string>();
                listUserName = userNames.Split(new char[] { ',' }).ToList();
                foreach (var item in listUserName)
                {
                    MembershipInfo userInfo = user.GetInfo(item);
                    listUserCName.Add((userInfo == null) ? "" : userInfo.EmployeeCName);
                }
                userCNames = string.Join(",", listUserCName);
            }
            return userCNames;
        }
    }
}