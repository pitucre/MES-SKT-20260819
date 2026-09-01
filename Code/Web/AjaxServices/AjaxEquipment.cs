using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.SteelMesh.BLL;
using SKT.LeanMES.Lookup.Model;
using SKT.LeanMES.Sparepart.Model;
using System.Data;
using Newtonsoft.Json;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Http;
using System.Threading.Tasks;
using System.IO;
using System.Text;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Warehouse.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEquipment
    {
        /// <summary>
        /// 编辑设备类型
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditEquipmentType(EquipmentTypeInfo entity)
        {
            try
            {
                EquipmentType bll = new EquipmentType();

                if (entity.EquipmentTypeId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }

                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 通过设备编号获取产线名和工位名
        /// </summary>
        [AjaxMethod]
        public String[] GetLineStationName(String equiCode)
        {
            String[] arr = new String[2];
            try
            {
                Equipments bll = new Equipments();

                arr = bll.GetLineAndStation(equiCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return arr;
        }


        /// <summary>
        /// 编辑设备信息
        /// </summary>
        /// <param name="entity">设备信息实体</param>
        /// <param name="factoryTime">入厂日期</param>
        /// <param name="overGuaranteeTime">入厂日期</param>

        [AjaxMethod]
        public void EditEquipment(EquipmentsInfo entity, string factoryTime, string overGuaranteeTime)
        {
            Equipments bll = new Equipments();

            try
            {
                if (entity.EquipmentId == -1)
                {
                    if (string.IsNullOrEmpty(factoryTime))
                    {
                        factoryTime = DateTime.Now.ToString("yyyy-MM-dd");
                    }
                    if (string.IsNullOrEmpty(overGuaranteeTime))
                    {
                        overGuaranteeTime = DateTime.Now.ToString("yyyy-MM-dd");
                    }
                    entity.FactoryDate = Convert.ToDateTime(factoryTime);
                    entity.OverGuaranteeTime = Convert.ToDateTime(overGuaranteeTime);
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    if (string.IsNullOrEmpty(factoryTime))
                    {
                        factoryTime = DateTime.Now.ToString("yyyy-MM-dd");
                    }
                    if (string.IsNullOrEmpty(overGuaranteeTime))
                    {
                        overGuaranteeTime = DateTime.Now.ToString("yyyy-MM-dd");
                    }
                    entity.FactoryDate = Convert.ToDateTime(factoryTime);
                    entity.OverGuaranteeTime = Convert.ToDateTime(overGuaranteeTime);
                    entity.CreateBy = "";
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                }

                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public int EquipmentEdit(EquipmentsInfo info)
        {
            int EquipmentId = -1;
            Equipments bll = new Equipments();

            if (info.ProduceDate == null)
            {
                info.ProduceDate = DateTime.Now;
            }
            if (info.FactoryDate == null)
            {
                info.FactoryDate = DateTime.Now;
            }

            try
            {

                if (info.EquipmentId == -1)
                {
                    info.CreateBy = AccountController.GetCurrentUser().UserName;
                    info.ModifyBy = AccountController.GetCurrentUser().UserName;
                }
                else
                {
                    info.CreateBy = "";
                    info.ModifyBy = AccountController.GetCurrentUser().UserName;
                }

                EquipmentId = bll.Edit(info);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return EquipmentId;
        }
        [AjaxMethod]
        public int EquipmentEditNew(EquipmentsInfo info)
        {
            int EquipmentId = -1;
            Equipments bll = new Equipments();

            if (info.ProduceDate == null)
            {
                info.ProduceDate = DateTime.Now;
            }
            if (info.FactoryDate == null)
            {
                info.FactoryDate = DateTime.Now;
            }

            try
            {

                if (info.EquipmentId == -1)
                {
                    info.CreateBy = AccountController.GetCurrentUser().UserName;
                    info.ModifyBy = AccountController.GetCurrentUser().UserName;
                }
                else
                {
                    info.CreateBy = "";
                    info.ModifyBy = AccountController.GetCurrentUser().UserName;
                }

                EquipmentId = bll.EditNew(info);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return EquipmentId;
        }
        [AjaxMethod]
        public void EquipmentDelete(int id)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            new EquipmentType().Delete(id + "", userName);
        }
        /// <summary>
        /// 增加钢网刮刀的产品ID
        /// </summary>
        /// <param name="equipmentId"></param>
        /// <param name="itemId"></param>
        /// <param name="layout"></param>
        [AjaxMethod]
        public void AddSteelItem(int equipmentId, int itemId, string layout, string OptionType)
        {
            try
            {
                SteelItem.BLL.SteelItem bll = new SteelItem.BLL.SteelItem();
                bll.InsertItemSteelInfo(itemId, equipmentId, layout, OptionType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 删除钢网刮刀对应产品的ID
        /// </summary>
        /// <param name="steelItemId"></param>
        [AjaxMethod]
        public void DeleteItemSteel(String steelItemId)
        {
            try
            {
                SKT.LeanMES.SteelItem.BLL.SteelItem bll = new SteelItem.BLL.SteelItem();
                bll.DeleteItemSteelInfo(steelItemId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 删除钢网刮刀对应产品的ID
        /// </summary>
        /// <param name="steelItemId"></param>
        [AjaxMethod]
        public void DeleteItemSpareInfo(String steelItemId)
        {
            try
            {
                SKT.LeanMES.SteelItem.BLL.SteelItem bll = new SteelItem.BLL.SteelItem();
                bll.DeleteItemSpareInfo(steelItemId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 钢网刮刀入库
        /// </summary>
        /// <param name="equipmentId"></param>
        [AjaxMethod]
        public void EquiepmentInStock(int equipmentId)
        {
            try
            {
                SKT.LeanMES.Equipment.BLL.Equipments bll = new SKT.LeanMES.Equipment.BLL.Equipments();
                bll.EquiepmentInStock(equipmentId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 钢网刮刀入库
        /// </summary>
        /// <param name="equipmentId"></param>
        [AjaxMethod]
        public void EquiepmentInStockNew(int equipmentId)
        {
            try
            {
                SKT.LeanMES.Equipment.BLL.Equipments bll = new SKT.LeanMES.Equipment.BLL.Equipments();
                bll.EquiepmentInStockNew(equipmentId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 钢网刮刀出库
        /// </summary>
        /// <param name="equipmentId"></param>
        [AjaxMethod]
        public void EquiepmentOutStock(int equipmentId)
        {
            try
            {
                SKT.LeanMES.Equipment.BLL.Equipments bll = new SKT.LeanMES.Equipment.BLL.Equipments();
                bll.EquiepmentOutStock(equipmentId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 钢网刮刀出库
        /// </summary>
        /// <param name="equipmentId"></param>
        [AjaxMethod]
        public void EquiepmentOutStockNew(int equipmentId)
        {
            try
            {
                SKT.LeanMES.Equipment.BLL.Equipments bll = new SKT.LeanMES.Equipment.BLL.Equipments();
                bll.EquiepmentOutStockNew(equipmentId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public string EquipmentEarlyWarning()
        {
            try
            {
                return new Equipments().Search();
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        /// <summary>
        /// 删除 检验项目
        /// </summary>
        /// <param name="id"></param>
        [AjaxMethod]
        public void DeleteSteelMeshInspectionProject(String id)
        {
            try
            {
                new SteelMeshInspectionProjecLogic().DeleteSteelMeshInspectionProject(id, AccountController.GetCurrentUser().UserName.ToString());
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 保存 检验项目
        /// </summary>
        /// <param name="id"></param>
        [AjaxMethod]
        public void SaveSteelMeshInspectionProject(SKT.LeanMES.SteelMesh.Model.SteelMeshInspectionProject m)
        {
            try
            {
                m.SMIPUserName = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
                m.SMIPUpdateUserName = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
                new SteelMeshInspectionProjecLogic().SaveSteelMeshInspectionProject(m);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 编辑模具构件
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditMoldComponent(MoldComponentInfo entity)
        {
            MoldComponent bll = new MoldComponent();
            try
            {
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public List<EquipmentsInfo> GetMouldInfoList(string searchCondition)
        {
            List<EquipmentsInfo> modelInfo = new List<EquipmentsInfo>();
            try
            {
                Equipments bll = new Equipments();
                SearchSettings serSettings = new SearchSettings();
                serSettings.ExtensionCondition = searchCondition;
                modelInfo = bll.GetAll(0, 100, "", serSettings);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return modelInfo;
        }

        /// <summary>
        /// 更新是否在库
        /// </summary>
        /// <param name="mouldIdArr"></param>
        /// <param name="isStock"></param>
        /// <param name="warehouseLocationId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void UpdateStock(string mouldIdArr, int isStock, int warehouseLocationId, string stockType, int SupplierId)
        {

            try
            {
                if (mouldIdArr != "")
                {
                    string createBy = AccountController.GetCurrentUser().UserName;
                    Equipments bll = new Equipments();

                    bll.UpdateStock(mouldIdArr, isStock, createBy, warehouseLocationId, stockType, SupplierId);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        /// <summary>
        /// 根据模具ID数组获取历史库位列表信息
        /// </summary>
        /// <param name="mouldIdArr"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<string> GetMouldHistoryOutStockRecord(string mouldIdArr)
        {

            try
            {
                if (mouldIdArr != "")
                {

                    Equipments bll = new Equipments();

                    return bll.GetMouldHistoryOutStockRecord(mouldIdArr);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        /// <summary>
        /// 获取钢网刮刀数据配置
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public LookupInfo GetSteelConfig(LookupInfo entity)
        {
            try
            {
                SKT.LeanMES.Lookup.BLL.Lookup bll = new SKT.LeanMES.Lookup.BLL.Lookup();
                return bll.GetSteelConfig(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// PDA设备保修—获取设备编码
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="type">0：扫描 1：选择单据</param>
        /// <param name="page">0：设备报修 1：设备维修 2：设备验收 3：ESOP -1或者其他值：其他页面</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<EquipmentsInfo> GetEquipmentList(EquipmentsInfo entity, int type, int page)
        {
            try
            {
                Equipments bll = new Equipments();
                SearchSettings ss = new SearchSettings();
                var where = " 1 = 1 ";
                if (!string.IsNullOrEmpty(entity.EquipmentCode))
                {
                    entity.EquipmentCode = entity.EquipmentCode.Replace("'", string.Empty);
                    if (type == 0)
                    {
                        where += " AND EquipmentCode = '" + entity.EquipmentCode + "'";
                    }
                    else
                    {
                        where += " AND EquipmentCode LIKE '%" + entity.EquipmentCode + "%'";
                    }
                }
                //if (page == 0)
                //{
                //    //设备报修，过滤维修中、已完成、或者未验收的设备信息
                //    where += " AND NOT EXISTS(SELECT 1 FROM Basal_EquipmentRepair_JXN ber WHERE ber.EquipmentCode = vwEquipment.EquipmentCode AND ber.Status IN (0,1,3))";
                //}
                //else
                
                if (page == 1)
                {
                    //设备维修，获取可维修的设备信息
                    where += " AND EXISTS(SELECT 1 FROM Basal_EquipmentRepair_JXN ber WHERE ber.EquipmentCode = vwEquipment.EquipmentCode AND ber.Status IN (0,1,3))";
                }
                else if (page == 2)
                {
                    //设备验收，获取维修完成的设备信息
                    where += " AND EXISTS(SELECT 1 FROM Basal_EquipmentRepair_JXN ber WHERE ber.EquipmentCode = vwEquipment.EquipmentCode AND ber.Status = 4)";
                }
                else if (page == 3)
                {
                    //ESOP
                    where += " AND EXISTS(SELECT 1 FROM dbo.Prod_ESOPFile pe WHERE pe.EquipmentCode = vwEquipment.EquipmentCode)";
                }

                ss.ExtensionCondition = where;
                return bll.GetAll(int.MinValue, 10, string.Empty, ss);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// PDA设备验收—根据设备编码获取维修完成但未验收的信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public EquipmentRepairInfo_JXN GetEquipmentRepairWaitAccept(EquipmentRepairInfo_JXN entity)
        {
            try
            {
                EquipmentRepair bll = new EquipmentRepair();
                return bll.GetEquipmentRepairWaitAccept(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// PDA设备报修列表
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="type">0：扫描 1：选择单据</param>
        [AjaxMethod]
        public List<EquipmentRepairInfo_JXN> GetEquipmentSendRepairList()
        {
            try
            {
                SearchSettings ss = new SearchSettings();
                ss.ExtensionCondition = " Status = 0 ";
                var list = new EquipmentRepair().GetRepairAll(0, int.MaxValue, "EquipmentRepairId DESC", ss);
                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// PDA设备维修—开始维修/报废/外修/维修完成
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EquipmentRepairFunctionEdit(EquipmentRepairInfo_JXN entity)
        {
            try
            {
                EquipmentRepair bll = new EquipmentRepair();
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                bll.EquipmentRepairFunctionEdit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        ///// <summary>
        ///// PDA设备报修—获取维修工序
        ///// </summary>
        ///// <param name="entity"></param>
        ///// <param name="type">0：扫描 1：选择单据</param>
        //[AjaxMethod]
        //public List<StationEquipmentInfo> GetRepairStationList(StationEquipmentInfo entity, int type)
        //{
        //    try
        //    {
        //        entity.EquipmentCode = entity.EquipmentCode == null ? string.Empty : entity.EquipmentCode.Replace("'", string.Empty).Trim();
        //        if (string.IsNullOrEmpty(entity.EquipmentCode))
        //        {
        //            WebHelper.ShowMessage("请先选择设备编码");
        //            return null;
        //        }

        //        StationEquipment bll = new StationEquipment();
        //        SearchSettings ss = new SearchSettings();
        //        var where = " EquipmentCode = '" + entity.EquipmentCode + "' ";
        //        if (!string.IsNullOrEmpty(entity.Station))
        //        {
        //            entity.Station = entity.Station.Replace("'", string.Empty);
        //            if (type == 0)
        //            {
        //                where += " AND Station = '" + entity.Station + "'";
        //            }
        //            else
        //            {
        //                where += " AND Station LIKE '%" + entity.Station + "%'";
        //            }
        //        }
        //        ss.ExtensionCondition = where;
        //        return bll.GetAll(0, 50, string.Empty, ss);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //        return null;
        //    }
        //}


        /// <summary>
        /// 新增/编辑设备维修人员
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EquipmentRepairUserEdit(EquipmentRepairUserInfo entity)
        {
            try
            {
                EquipmentRepairUser bll = new SKT.LeanMES.Equipment.BLL.EquipmentRepairUser();
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 根据EquipmentRepairUserId获取工序信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<EquipmentRepairUserStationInfo> GetEquipmentRepairUserStationList(EquipmentRepairUserStationInfo entity)
        {
            try
            {
                EquipmentRepairUser bll = new SKT.LeanMES.Equipment.BLL.EquipmentRepairUser();
                return bll.GetEquipmentRepairUserStationList(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// PDA设备保修—保存
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public List<EquipmentRepairInfo_JXN> EquipmentRepairEdit(EquipmentRepairInfo_JXN entity)
        {
            try
            {
                EquipmentRepair bll = new EquipmentRepair();
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                return bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// PDA设备维修—根据设备编码获取维修中但未验收的信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public EquipmentRepairInfo_JXN GetEquipmentRepair(EquipmentRepairInfo_JXN entity)
        {
            try
            {
                EquipmentRepair bll = new EquipmentRepair();
                return bll.GetEquipmentRepair(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// PDA设备维修—开始维修/报废/外修/维修完成
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EquipmentRepairOperate(EquipmentRepairInfo_JXN entity)
        {
            try
            {
                EquipmentRepair bll = new EquipmentRepair();
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                bll.EquipmentRepairOperate(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// PDA设备维修—获取有库存的备件条码
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="type">0：扫描 1：选择单据</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<PartInfo> GetPartList(SparepartInfo entity, int type)
        {
            try
            {
                var bll =new SKT.LeanMES.Equipment.BLL.Part();
                SearchSettings ss = new SearchSettings();
                var where = " CurrentStock > 0 ";
                if (!string.IsNullOrEmpty(entity.PartNO))
                {
                    entity.PartNO = entity.PartNO.Replace("'", string.Empty);
                    if (type == 0)
                    {
                        where += " AND PartCode = '" + entity.PartNO + "'";
                    }
                    else
                    {
                        where += " AND PartCode LIKE '%" + entity.PartNO + "%'";
                    }
                }
                ss.ExtensionCondition = where;
                return bll.GetAll(0, 50, string.Empty, ss);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        ///  PDA设备维修—获取设备有库存的备件条码
        /// </summary>
        /// <param name="equipmentCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<PartInfo> GetEquipmentPartList(string equipmentCode)
        {
            try
            {
                var bll = new SKT.LeanMES.Equipment.BLL.Part();
                SearchSettings ss = new SearchSettings();
                var where = $" EquipmentCode='{equipmentCode}' ";
               
                ss.ExtensionCondition = where;
                return bll.GetAllPartEquNew(0, 50, string.Empty, ss);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// 设备绑定关系备件
        /// </summary>
        /// <param name="partNo"></param>
        [AjaxMethod]
        public void IsBind( string partNo,string EquipmentCode)
        {
            try
            {
                EquipmentRepair bll = new EquipmentRepair();
                bll.IsBind(partNo, EquipmentCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
              
            }
        }
        ///// <summary>
        ///// 编辑设备信息
        ///// </summary>
        ///// <param name="entity">设备信息实体</param>
        ///// <param name="factoryTime">入厂日期</param>

        //[AjaxMethod]
        //public void EditEquipment(EquipmentsInfo entity, string factoryTime)
        //{
        //    Equipments bll = new Equipments();

        //    try
        //    {
        //        if (entity.EquipmentId == -1)
        //        {
        //            entity.FactoryDate = Convert.ToDateTime(factoryTime);
        //            entity.CreateBy = AccountController.GetCurrentUser().UserName;
        //            entity.ModifyBy = "";
        //        }
        //        else
        //        {
        //            entity.FactoryDate = Convert.ToDateTime(factoryTime);
        //            entity.CreateBy = "";
        //            entity.ModifyBy = AccountController.GetCurrentUser().UserName;
        //        }

        //        bll.Edit(entity);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //}

        /// <summary>
        /// 根据设备编码获取设备信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public EquipmentsInfo GetEquipmentInfo(EquipmentsInfo entity)
        {
            try
            {
                Equipments bll = new Equipments();
                return bll.GetInfo(entity.EquipmentCode, false);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 获取设备维修履历
        /// </summary>
        /// <param name="equipmentCode">设备编码</param>
        [AjaxMethod]
        public List<EquipmentRepairInfo_JXN> GetMaintenanceHistory(string equipmentCode)
        {
            List<EquipmentRepairInfo_JXN> models = null;
            var bll = new EquipmentRepair();
            try
            {
                models = bll.GetMaintenanceHistory(equipmentCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return models;
        }


        /// <summary>
        /// 获取注塑控制台工艺参数
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public DataTable GetOpcPointData(string LinePlanCode)
        {
            return new Equipments().GetOpcPointData(LinePlanCode);
        }


        #region  AGV信息处理   

        static void Writelog(string logContent)
        {
            StreamWriter stream;
            //写入日志内容
            string path = AppDomain.CurrentDomain.BaseDirectory + "//cjzzLogs";
            //检查物理路径是否存在，不存在则创建路径
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            stream = new StreamWriter(path + $"\\log{DateTime.Now.ToString("yyyyMMdd")}.txt", true, Encoding.Default);
            stream.Write(DateTime.Now.ToString() + ":" + logContent);
            stream.Write("\r\n");//追加写入
            stream.Flush();
            stream.Close();//一定要关闭流
        }
        private static Queue<string> userQueue = new Queue<string>();


        [AjaxMethod]
        ///shippingType =运送类型
        ///
        public async Task<string> SendAgv(SendAgvInfo req, string reqUrl, string materialList="",string shippingType="",string CheckType="",string transportType="")
        {
            //从配置文件里获取
            var cfgUrl = ConfigurationManager.AppSettings["AgvUrl"].ToString();
            if (string.IsNullOrWhiteSpace(reqUrl))
            {
                cfgUrl = reqUrl;
            }
            string currUser = AccountController.GetCurrentUser().UserName;
            userQueue.Enqueue(currUser);

            await System.Threading.Tasks.Task.Run(async () =>
            {
                using (HttpClient client = new HttpClient())
                {
                    try
                    {
                        //req.reqTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                        var str = JsonConvert.SerializeObject(req);
                        HttpContent content = new StringContent(str);
                        content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");
                        HttpResponseMessage response = await client.PostAsync(cfgUrl, content);//改成自己的
                        response.EnsureSuccessStatusCode();//用来抛异常的
                        string responseBody = await response.Content.ReadAsStringAsync();
                        Writelog(responseBody);
                        var res = JsonConvert.DeserializeObject<SendAgvRes>(responseBody);
                        if (res.errCode == "0")
                        {
                            Writelog("响应的code是0：" + res.errCode);
                            currUser = userQueue.Dequeue();
                            //taskInfo.TaskNo = "AGVNO" + DateTime.Now.ToString("yyyyMMddHHmmss") + new Random().Next(1000).ToString("000");
                            
                            Writelog("任务单：" + req.taskID);
                            //记录
                            string cmdStr = "INSERT dbo.Prod_AgvTack(TaskNo,ShippingType,CheckType,TransportType,AgvStartCode,AgvEndCode,CreateBy,DetailJson) " +
                            "VALUES(@TaskNo,@ShippingType,@CheckType,@TransportType,@AgvStartCode,@AgvEndCode,@CreateBy,@DetailJson)";
                            Writelog("sql：" + cmdStr);

                            SqlParameter[] parameters = new SqlParameter[]
                            {
                                new SqlParameter("@TaskNo",req.taskID),
                                new SqlParameter("@ShippingType",shippingType),
                                new SqlParameter("@CheckType",CheckType),
                                new SqlParameter("@TransportType",transportType),
                                new SqlParameter("@AgvStartCode",req.taskStart),
                                new SqlParameter("@AgvEndCode",req.taskEnd),
                                new SqlParameter("@CreateBy",currUser),
                                new SqlParameter("@DetailJson",materialList),
                               
                            };
                            var exeRes = SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, cmdStr, parameters);
                            Writelog("exeRes:" + exeRes);

                         
                            string cmdStr1 = "UPDATE Basal_WarehouseAGVMark SET Statues = 1 WHERE AGVLandMarkCode  = @AGVLandMarkCode";
                            SqlParameter[] parameters1 = new SqlParameter[]
                            {
                                new SqlParameter("@AGVLandMarkCode",req.taskEnd)
                            };
                            var exeRes1 = SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, cmdStr1, parameters1);
                            Writelog("更新地标点【"+ req.taskEnd + "】状态：" + exeRes1);
                            return "AGV调用返回成功";
                        }
                        else
                        {
                            Writelog("响应的errCode不是0：" + res.errCode);
                            return "AGV调用返回失败";
                        }
                    }
                    catch (Exception ex)
                    {
                        Writelog("异常：" + ex.Message);
                        throw ex;
                    }
                }
            });

            return "AGV调用成功";
        }


        [AjaxMethod]
        /// <summary>
        /// 取消Task任务
        /// </summary>
        /// <param name="req"></param>
        /// <param name="reqUrl"></param>
        /// <returns></returns>
        public async Task<string> CancelAgvTask(SendAgvInfo req, string reqUrl)
        {
            //从配置文件里获取
            var cfgUrl = ConfigurationManager.AppSettings["AgvUrl"].ToString();
            if (string.IsNullOrWhiteSpace(reqUrl))
            {
                cfgUrl = reqUrl;
            }
            string currUser = AccountController.GetCurrentUser().UserName;
            userQueue.Enqueue(currUser);

            await System.Threading.Tasks.Task.Run(async () =>
            {
                using (HttpClient client = new HttpClient())
                {
                    try
                    {
                        //req.reqTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                        var str = JsonConvert.SerializeObject(req);
                        HttpContent content = new StringContent(str);
                        content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");
                        HttpResponseMessage response = await client.PostAsync(cfgUrl, content);//改成自己的
                        response.EnsureSuccessStatusCode();//用来抛异常的
                        string responseBody = await response.Content.ReadAsStringAsync();
                        Writelog(responseBody);
                        var res = JsonConvert.DeserializeObject<SendAgvRes>(responseBody);
                        if (res.errCode == "0")
                        {
                            Writelog("响应的code是0：" + res.errCode);
                            currUser = userQueue.Dequeue();
                            //taskInfo.TaskNo = "AGVNO" + DateTime.Now.ToString("yyyyMMddHHmmss") + new Random().Next(1000).ToString("000");
                            Writelog("任务单：" + req.taskID);
                            //记录
                            string cmdStr = "uspCancelAgvTask";
                            Writelog("sql：" + cmdStr);

                            SqlParameter[] parameters = new SqlParameter[]
                            {
                                new SqlParameter("@TaskNo",req.taskID),
                                new SqlParameter("@CreateBy",currUser)
                            };
                            var exeRes = SQLHelper.ExecuteScalarStoredProcedure(SQLHelper.MESConnString, cmdStr, parameters);
                            Writelog("exeRes:" + exeRes);
                            return "AGV任务取消成功";
                        }
                        else
                        {
                            Writelog("响应的errCode不是0：" + res.errCode);
                            return "AGV任务取消失败";
                        }
                    }
                    catch (Exception ex)
                    {
                        Writelog("异常：" + ex.Message);
                        throw ex;
                    }
                }
            });

            return "AGV调用成功";
        }


        public class SendAgvRes
        {
            public string errCode { get; set; }
            public string errMsg { get; set; }
           
        }


        public class SendAgvInfo
        {
            public string msgType { get; set; }
            public string taskEnd { get; set; }
            public string taskID { get; set; }
            public string taskStart { get; set; }

        }

        public class SendAgvReq
        {
            public string modelProcessCode { get; set; }
            public int priority { get; set; }
            public string fromSystem { get; set; }
            public string orderId { get; set; }
            public SendAgvReqObj[] taskOrderDetail { get; set; }

        }

        public class SendAgvReqObj
        {
            public string taskPath { get; set; }
            public string shelfNums { get; set; }
        }


        [AjaxMethod]
        public async Task<string> SendAgvCancelTask(string taskNo)
        {
            //获取地址
            var cancelTaskUrl = ConfigurationManager.AppSettings["CancelAgvUrl"].ToString();
            if (string.IsNullOrWhiteSpace(cancelTaskUrl))
            {
                throw new Exception("空的cancelTask路径");
            }

            //调用地址
            string currUser = AccountController.GetCurrentUser().UserName;
            var req = new
            {
                //不传就不写属性，而不是传空字符串
                //ReqCode = "",
                //ReqTime = "",
                //ClientCode = "",
                //TokenCode = "",
                //ForceCancel = 0,
                //MatterArea = "",
                //AgvCode = "",
                orderId = taskNo
            };

            using (HttpClient client = new HttpClient())
            {
                var str = JsonConvert.SerializeObject(req);
                HttpContent content = new StringContent(str);
                content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");
                Writelog($"[{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}] agv取消任务请求：" + str);
                HttpResponseMessage response = await client.PostAsync(cancelTaskUrl, content);
                response.EnsureSuccessStatusCode();
                string responseBody = await response.Content.ReadAsStringAsync();
                Writelog($"[{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}] agv取消任务响应：" + responseBody);
                var res = JsonConvert.DeserializeObject<SendAgvRes>(responseBody);
                if (res.errCode == "0")
                {
                    Writelog($"[{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}] agv取消任务响应：" + "code是0");
                }
            }
            return "AGV取消任务成功";
        }


        /// <summary>
        /// 托盘入库暂存区条码解除
        /// </summary>
        /// <param name="AGVLandMarkCode"></param>
        [AjaxMethod]
        public void WarehouseAGVMarkUnbind(string AGVLandMarkCode)
        {

            try
            {
                    string createBy = AccountController.GetCurrentUser().UserName;
                    SqlParameter[] array = new SqlParameter[]
                    {
                        new SqlParameter("@AGVLandMarkCode", SqlDbType.NVarChar),
                        new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                    };
                    array[0].Value = AGVLandMarkCode;
                    array[1].Value = createBy;
                    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspWarehouseAGVMarkUnbind", array);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        [AjaxMethod]
        public DataTable GetEquipmentStatus()
        {

            try
            {
               
              return    SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, "uspGetEquipmentStatusList", null);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }
        #endregion
    }
}