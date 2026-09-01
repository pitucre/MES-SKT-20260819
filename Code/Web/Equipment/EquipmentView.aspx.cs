using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Supplier.BLL;
using SKT.Common.Model;
using SKT.LeanMES.Maintenance.BLL;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxBaseExt));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaintenancRelation));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(EquipmentView));
            if (int.TryParse(IdStr, out Id) && Id > 0)
            {
                Equipments bll = new Equipments();
                EquipmentsInfo model = new EquipmentsInfo();
                model = bll.GetViewInfo(Convert.ToInt32(Id));
                if (model != null)
                {
                    GetPartInfo(model.EquipmentCode);
                    GetRepairInfo(model.EquipmentCode);
                    GetMaintenanceInfo(model.EquipmentCode);
                    GetItemCodeInfo(model.EquipmentCode);
                    GetFileInfo(model.EquipmentCode);
                    GetCheckRecordInfo(model.EquipmentCode);  //校验记录信息
                    GetMaintenanceplanInfo(model.EquipmentCode);  //保养计划
                    GetTestPlanInfo(model.EquipmentCode); //校验计划
                    //GetChildEquipment(model.EquipmentCode); //校验计划
                    this.PageData = model;
                }
            }

        }

        #region 相关文件
        /// <summary>
        /// 相关文件
        /// </summary>
        /// <param name="Code"></param>
        public void GetFileInfo(string Code)
        {
            var i = 1;
            EquipmentFileManage p = new EquipmentFileManage();
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("EqCode", Code);
            var list = p.GetAll(0, 10000, "", searchSettings);
            string htmlstr = "<table class='ListTable' width='100%'><tr class='ListTableHeader'><th>序号</th>"
                    + "<th>文件名</th>"
                    + "<th>创建人</th>"
                    + "<th>创建时间</th>"
                    + "<th>下载</th></tr>";
            foreach (var item in list)
            {
                if (i % 2 == 0)
                {
                    htmlstr += "<tr class='ListTableEvenRow'>";
                }
                else
                {
                    htmlstr += "<tr class='ListTableOddRow'>";
                }
                htmlstr += "<td style='text-align:center;'>" + i + "</td>"
                + "<td style='text-align:center;'>" + item.FileName + "</td><td style='text-align:center;'>" + item.CreateBy + "</td>"
                + "<td style='text-align:center;'>" + item.CreateDateTime + "</td><td style='text-align:center;'><a href=# onclick='Down(this)'>下载</a></td>";
                i++;
            }
            if (list.Count == 0)
            {
                htmlstr += "<tr class='ListTableOddRow'><td colspan='5' style='text-align: center;'>未查询到数据</td></tr>";
            }
            FileInfo.InnerHtml = htmlstr + "</table>";
        }
        #endregion

        #region 适用机种
        /// <summary>
        /// 设备与物料关系信息（适用机种）
        /// </summary>
        public void GetItemCodeInfo(string Code)
        {
            var i = 1;
            EquipmentItemRelation p = new EquipmentItemRelation();
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("EqCode", Code);
            var list = p.GetAll(0, 10000, "", searchSettings);
            string htmlstr = "<table class='ListTable' width='100%'><tr class='ListTableHeader'><th>序号</th>"
                    + "<th>产品编码</th>"
                    + "<th>产品规格</th>"
                    + "<th>创建人</th>"
                    + "<th>创建时间</th></tr>";
            foreach (var item in list)
            {
                if (i % 2 == 0)
                {
                    htmlstr += "<tr class='ListTableEvenRow'>";
                }
                else
                {
                    htmlstr += "<tr class='ListTableOddRow'>";
                }
                htmlstr += "<td style='text-align:center;'>" + i + "</td>"
                + "<td style='text-align:center;'>" + item.ItemCode + "</td><td style='text-align:center;'>" + item.ItemSpec + "</td>"
                + "<td style='text-align:center;'>" + item.CreateBy + "</td><td style='text-align:center;'>" + item.CreateDateTime + "</td>";
                i++;
            }
            if (list.Count == 0)
            {
                htmlstr += "<tr class='ListTableOddRow'><td colspan='5' style='text-align: center;'>未查询到数据</td></tr>";
            }
            ItemCodeInfo.InnerHtml = htmlstr + "</table>";
        }
        #endregion

        #region 维修列表 
        /// <summary>
        /// 维修信息
        /// </summary>
        /// <param name="Code"></param>
        public void GetRepairInfo(string Code)
        {
            var i = 1;
            EquipmentRepair p = new EquipmentRepair();
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("A.EquipmentCode", Code);
            var list = p.GetAllEquiment(0, 10000, "", searchSettings);
            string htmlstr = "<table class='ListTable' width='100%'><tr class='ListTableHeader'><th>序号</th>"
                    + "<th>状态</th>"
                    + "<th>维修单号</th>"
                    + "<th>设备编码</th>"
                    + "<th>设备名称</th>"
                    + "<th>保管部门</th>"
                    + "<th>送修时间</th>"
                    + "<th>送修人</th>"
                    + "<th>故障描述</th>"
                    + "<th>维修开始时间</th>"
                    + "<th>维修结束时间</th>"
                    + "<th>维修人</th>"
                    + "<th>故障分析及处理</th>"
                    + "<th>更换配件</th></tr>";
            foreach (var item in list)
            {
                if (i % 2 == 0)
                {
                    htmlstr += "<tr class='ListTableEvenRow'>";
                }
                else
                {
                    htmlstr += "<tr class='ListTableOddRow'>";
                }
                htmlstr += "<td style='text-align:center;'>" + i + "</td>"
                + "<td style='text-align:center;'>" + item.StatusName + "</td><td style='text-align:center;'>" + item.RepairNo + "</td><td style='text-align:center;'>" + item.EqCode + "</td>"
                + "<td style='text-align:center;'>" + item.EquipmentName + "</td><td style='text-align:center;'>" + item.DepositoryDep + "</td>"
                + "<td style='text-align:center;'>" + item.CreateDateTime + "</td><td style='text-align:center;'>" + item.CreateBy + "</td><td style='text-align:center;'>" + item.RepairDesc + "</td>"
                + "<td style='text-align:center;'>" + item.RepairSTime + "</td><td style='text-align:center;'>" + item.RepairETime + "</td><td style='text-align:center;'>" + item.RepairBy + "</td>"
                + "<td style='text-align:center;'>" + item.HandleContent + "</td>"
                + "<td style='text-align:center;'>" + item.PartContent + "</td></tr>";
                i++;
            }
            if (list.Count == 0)
            {
                htmlstr += "<tr class='ListTableOddRow'><td colspan='14' style='text-align: center;'>未查询到数据</td></tr>";
            }
            RepairInfo.InnerHtml = htmlstr + "</table>";
        }
        #endregion

        #region 备件列表
        /// <summary>
        /// 获取备件列表
        /// </summary>
        /// <param name="Code"></param>
        private void GetPartInfo(string Code)
        {
            var i = 1;
            Part p = new Part();
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("EquipmentCode", Code);
            var list = p.GetAllPartEquNew(0, 10000, "", searchSettings);
            string htmlstr = "<table class='ListTable' width='100%'><tr class='ListTableHeader'><th>序号</th>"
                    + "<th>备件编码</th>"
                    + "<th>备件名称</th>"
                    + "<th>规格</th>"
                    + "<th>生产厂商</th>"
                    + "<th>使用数量</th>"
                    + "<th>最小库存</th>"
                    + "<th>最大库存</th>"
                    + "<th>当前库存</th>"
                    + "<th>存放位置</th></tr>";

            foreach (var item in list)
            {

                if (i % 2 == 0)
                {
                    htmlstr += "<tr class='ListTableEvenRow'>";
                }
                else
                {
                    htmlstr += "<tr class='ListTableOddRow'>";
                }
                htmlstr += "<td style='text-align:center;'>" + i + "</td>"
                    + "<td style='text-align:center;'>" + item.PartCode + "</td><td style='text-align:center;'>" + item.PartName + "</td>"
                    + "<td style='text-align:center;'>" + item.PartStand + "</td><td style='text-align:center;'>" + item.FactoryName + "</td>"
                    + "<td style='text-align:center;'>" + item.UseStock + "</td><td style='text-align:center;'>" + item.MinStock + "</td>"
                     + "<td style='text-align:center;'>" + item.MaxStock + "</td><td style='text-align:center;'>" + item.CurrentStock + "</td>"
                    + "<td style='text-align:center;'>" + item.PositionName + "</td>"
                    + "</tr>";
                i++;
            }
            if (list.Count == 0)
            {
                htmlstr += "<tr class='ListTableOddRow'><td colspan='6' style='text-align: center;'>未查询到数据</td></tr>";
            }

            PartInfo.InnerHtml = htmlstr + "</table>";
        }
        #endregion

        #region 保养记录
        /// <summary>
        /// 保养记录
        /// </summary>
        public void GetMaintenanceInfo(string Code)
        {
            var i = 1;
            MaintenanceRecord p = new MaintenanceRecord();
            SearchSettings searchSettings = new SearchSettings();

            var list = p.GetAllMaintenanceHistory(2, Code);
            string htmlstr = "<table class='ListTable' width='100%'><tr class='ListTableHeader'><th>序号</th>"
                    + "<th>保养计划</th>"
                    + "<th>保养项目</th>"
                    + "<th>作业项名称</th>"
                    + "<th>保养人</th>"
                    + "<th>保养结果</th>"
                    + "<th>保养日期</th>"
                    + "<th>备注</th></tr>";
            foreach (var item in list)
            {
                if (i % 2 == 0)
                {
                    htmlstr += "<tr class='ListTableEvenRow'>";
                }
                else
                {
                    htmlstr += "<tr class='ListTableOddRow'>";
                }
                htmlstr += "<td style='text-align:center;'>" + i + "</td>"
                + "<td style='text-align:center;'>" + item.PlanName + "</td><td style='text-align:center;'>" + item.DemoName + "</td>"
                + "<td style='text-align:center;'>" + item.DemoSubName + "</td><td style='text-align:center;'>" + item.CreateBy + "</td>"
                + "<td style='text-align:center;'>已保养</td><td style='text-align:center;'>" + item.OperateTime + "</td><td style='text-align:center;'>" + item.SubRemark + "</td>";
                i++;
            }
            if (list.Count == 0)
            {
                htmlstr += "<tr class='ListTableOddRow'><td colspan='7' style='text-align: center;'>未查询到数据</td></tr>";
            }
            MaintenanceInfo.InnerHtml = htmlstr + "</table>";
        }
        #endregion

        #region 获取保养计划信息
        /// <summary>
        /// 获取保养计划信息
        /// </summary>
        /// <param name="Code"></param>
        private void GetMaintenanceplanInfo(string Code)
        {
            var i = 1;
            MaintenancePlan p = new MaintenancePlan();
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("EquipmentCode", Code);
            var list = p.GetEquimentAll(0, 10000, "", searchSettings);
            string htmlstr = "<table class='ListTable' width='100%'><tr class='ListTableHeader'><th>序号</th>"
                    + "<th>状态</th>"
                    + "<th>保养项目</th>"
                    + "<th>下次保养时间</th>"
                    + "<th>上次保养时间</th>"
                    + "<th>周期类型</th>"
                    + "<th>周期间隔</th>"
                    + "<th>保养人</th>"
                    + "<th>备注</th></tr>";

            var statusVal = "";
            foreach (var item in list)
            {

                if (i % 2 == 0)
                {
                    htmlstr += "<tr class='ListTableEvenRow'>";
                }
                else
                {
                    htmlstr += "<tr class='ListTableOddRow'>";
                }

                statusVal = item.Status == 0 ? "未保养" : "已保养";

                htmlstr += "<td style='text-align:center;'>" + i + "</td>"
                    + "<td style='text-align:center;'>" + statusVal + "</td><td style='text-align:center;'><a href='javascript: GetDemoListByPlanId(" + item.MaintenancePlanId + "); '>查看</a></td>"
                    + "<td style='text-align:center;'>" + item.FinisheDateTime + "</td><td style='text-align:center;'>" + item.LastMaintainTime + "</td>"
                    + "<td style='text-align:center;'>" + item.CycleTypeStr + "</td><td style='text-align:center;'>" + item.CycleTime + "</td>"
                     + "<td style='text-align:center;'>" + item.CreateBy + "</td><td style='text-align:center;'>" + item.Remark + "</td>"

                    + "</tr>";
                i++;
            }
            if (list.Count == 0)
            {
                htmlstr += "<tr class='ListTableOddRow'><td colspan='9' style='text-align: center;'>未查询到数据</td></tr>";
            }
            MaintenanceplanInfo.InnerHtml = htmlstr + "</table>";
        }
        #endregion

        #region 获取校验记录信息
        /// <summary>
        /// 获取验记录信息
        /// </summary>
        /// <param name="Code"></param>
        private void GetCheckRecordInfo(string Code)
        {
            var i = 1;
            EquipmentCheckOutHistory p = new EquipmentCheckOutHistory();
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition(" EqCode", Code);
            var list = p.GetAll(0, 10000, "", searchSettings);
            string htmlstr = "<table class='ListTable' width='100%'><tr class='ListTableHeader'><th>序号</th>"
                    + "<th>送检日期</th>"
                    + "<th>送检人</th>"
                    + "<th>验证方式</th>"
                    + "<th>校验项目</th>"
                    + "<th>校验结果</th>"
                    + "<th>证书编码</th>"
                    + "<th>备注</th></tr>";

            foreach (var item in list)
            {
                if (i % 2 == 0)
                {
                    htmlstr += "<tr class='ListTableEvenRow'>";
                }
                else
                {
                    htmlstr += "<tr class='ListTableOddRow'>";
                }
                htmlstr += "<td style='text-align:center;'>" + i + "</td>"
                    + "<td style='text-align:center;'>" + item.InspectionTime + "</td><td style='text-align:center;'>" + item.CreateBy + "</td>"
                    + "<td style='text-align:center;'>" + item.CheckTypeName + "</td><td style='text-align:center;'>" + item.CheckProjectName + "</td>"
                    + "<td style='text-align:center;'>" + item.StatusNmae + "</td><td style='text-align:center;'>" + item.CertificateNo + "</td>"
                     + "<td style='text-align:center;'>" + item.Remark + "</td></tr>";
                i++;
            }
            if (list.Count == 0)
            {
                htmlstr += "<tr class='ListTableOddRow'><td colspan='10' style='text-align: center;'>未查询到数据</td></tr>";
            }
            CheckRecordInfo.InnerHtml = htmlstr + "</table>";
        }
        #endregion

        #region 获取校验计划信息
        /// <summary>
        /// 获取校验计划信息
        /// </summary>
        /// <param name="Code"></param>
        private void GetTestPlanInfo(string Code)
        {
            var i = 1;
            EquipmentCheckOutPlan p = new EquipmentCheckOutPlan();
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition(" EqCode", Code);
            var list = p.GetAll(0, 1000, "", searchSettings);
            string htmlstr = "<table class='ListTable' width='100%'><tr class='ListTableHeader'><th>序号</th>"
                    + "<th>验证方式</th>"
                    + "<th>校验项目</th>"
                    + "<th>周期类型</th>"
                    + "<th>周期间隔</th>"
                    + "<th>上次校验时间</th>"
                    + "<th>下次校验时间</th></tr>";

            foreach (var item in list)
            {

                if (i % 2 == 0)
                {
                    htmlstr += "<tr class='ListTableEvenRow'>";
                }
                else
                {
                    htmlstr += "<tr class='ListTableOddRow'>";
                }
                htmlstr += "<td style='text-align:center;'>" + i + "</td>"
                    + "<td style='text-align:center;'>" + item.CheckTypeName + "</td><td style='text-align:center;'>" + item.CheckProjectName + "</td>"
                    + "<td style='text-align:center;'>" + item.CycleTypeName + "</td><td style='text-align:center;'>" + item.Cycle + "</td>"
                    + "<td style='text-align:center;'>" + item.LastTime + "</td><td style='text-align:center;'>" + item.NextTime + "</td>"
                    + "</tr>";
                i++;
            }
            if (list.Count == 0)
            {
                htmlstr += "<tr class='ListTableOddRow'><td colspan='7' style='text-align: center;'>未查询到数据</td></tr>";
            }
            TestPlanInfo.InnerHtml = htmlstr + "</table>";
        }
        #endregion


        //#region 获取子设备列表
        ///// <summary>
        ///// 获取子设备列表
        ///// </summary>
        ///// <param name="Code"></param>
        //private void GetChildEquipment(string Code)
        //{
        //    var i = 1;
        //    EquipmentChild p = new EquipmentChild();
        //    SearchSettings searchSettings = new SearchSettings();
        //    searchSettings.AddCondition(" EquipmentCode", Code);
        //    var list = p.GetAll(0, 10000, "", searchSettings);
        //    string htmlstr = "<table class='ListTable' width='100%'><tr class='ListTableHeader'><th>序号</th>"
        //            + "<th>设备编码</th>"
        //            + "<th>设备名称</th>"
        //            + "<th>规格型号</th>"
        //            + "<th>创建时间</th></tr>";

        //    foreach (var item in list)
        //    {

        //        if (i % 2 == 0)
        //        {
        //            htmlstr += "<tr class='ListTableEvenRow'>";
        //        }
        //        else
        //        {
        //            htmlstr += "<tr class='ListTableOddRow'>";
        //        }
        //        htmlstr += "<td style='text-align:center;'>" + i + "</td>"
        //            + "<td style='text-align:center;'>" + item.EquipmentCodeChild + "</td><td style='text-align:center;'>" + item.EquipmentNameChild + "</td>"
        //            + "<td style='text-align:center;'>" + item.TypeSpec + "</td><td style='text-align:center;'>" + item.CreateDateTime + "</td>"

        //            + "</tr>";
        //        i++;
        //    }
        //    if (list.Count == 0)
        //    {
        //        htmlstr += "<tr class='ListTableOddRow'><td colspan='7' style='text-align: center;'>未查询到数据</td></tr>";
        //    }
        //    divEquipmentChild.InnerHtml = htmlstr + "</table>";
        //}
        //#endregion
        [AjaxMethod]
        public void EquimentParentChild(int parentEqumentId, int childEquimentId)
        {
            try
            {
                EquipmentChild bll = new EquipmentChild();
                bll.EquimentParentChild(parentEqumentId, childEquimentId);
            }
            catch (Exception exception)
            {

                throw;
            }

        }

        [AjaxMethod]
        public void EquimentParentChildDelete(int parentEqumentId, int childEquimentId)
        {
            try
            {
                var userName = AccountController.GetCurrentUserInfo().UserName;
                EquipmentChild bll = new EquipmentChild();
                bll.Delete(parentEqumentId, childEquimentId, userName);
            }
            catch (Exception exception)
            {

                throw;
            }

        }

        [AjaxMethod]
        public List<EquipmentChildInfo> GetChildEquimentList(string parentEqumentId)
        {
            try
            {

                EquipmentChild bll = new EquipmentChild();
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.AddCondition("ParentEquimentId", parentEqumentId.ToString());
                return bll.GetAll(0, 1000, "", searchSettings);
            }
            catch (Exception exception)
            {

                throw;
            }

        }

        AjaxEsop aEsop = new AjaxEsop();
        string filePath = string.Empty;
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentsInfo PageData
        {
            set
            {
                lblEquipmentCode.Text = value.EquipmentCode;
                lblEquipmentName.Text = value.EquipmentName;
                lblEquipmentTypeName.Text = value.EquipmentTypeName;
                lblEquipmentModels.Text = value.EquipmentModel;
                lblSupplier.Text = value.SupplierName;
                lblLineName.Text = value.LineName;
                lblStatus.Text = value.StatusDesc;

                txtSequenceNo.Text = value.SequenceNo.ToString();

                //lblVenCode.Text = value.VendorName;//修改成手动输入编号，取消查询关联名称 by beichang.zhong 2020.1.6
                lblVenCode.Text = value.VenCode;
                lblFactoryDate.Text = value.FactoryDate.ToString();
                ddPurchase.Text = value.Purchase == 0 ? "购买" : (value.Purchase == 1 ? "租凭" : (value.Purchase == 2 ? "赠送" : "借用"));
                txtUnitname.Text = value.UnitName;
                txtDep.Text = value.DepartName;
                txtBy.Text = value.CareBy;
                txtUseCount.Text = value.UseCount.ToString();
                txtRemark.Text = value.Remark;
                lblLocation.Text = value.PositionName;

                if (value.PictureName != "")
                {
                    filePath = aEsop.LocalFileExists(value.PictureName, "FileUploadEquiment");
                    if (filePath != "")
                    {
                        this.txtimg.ImageUrl = filePath;
                    }
                    else
                    {
                        this.txtimg.ImageUrl = SKT.LeanMES.Web.WebHelper.WebRoot + "/ESOP/DownLoad.aspx?Action=FileUploadEquiment&fileName=" + value.PictureName;
                    }


                }
                lbFileReady.Value = value.PictureName;
                txtGuaranteeDay.Text = value.GuaranteeDay.ToString();
                txtOverGuaranteeTime.Text = value.OverGuaranteeTime.ToString("yyy-MM-dd");
                txtAssetNumber.Text = value.AssetNumber;
            }

        }
    }
}