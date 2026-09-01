using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Web.Utility;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.SteelMesh.BLL;
using SKT.LeanMES.Lookup.Model;
using SKT.LeanMES.Sparepart.Model;
using System.Data;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEquipmentInspectionItem
    {
        [AjaxMethod]
        public void GetInspectionItemDelete(int id)
        {
            string userName = AccountController.GetCurrentUser().UserName.ToString();
            new LeanMES.Equipment.BLL.EquipmentInspectionItem().Delete(id + "", userName);
        }


        [AjaxMethod]
        public void EquipmentInspectionItemEdit(EquipmentInspectionItemInfo info)
        {
            try
            {
                info.Creater = AccountController.GetCurrentUser().UserName;
                info.CreateTime = DateTime.Now;
                new LeanMES.Equipment.BLL.EquipmentInspectionItem().Edit(info);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void EquipmentInspectionTypeEdit(string strJson)
        {
            try
            {
                new LeanMES.Equipment.BLL.EquipmentInspectionType().Edit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void EquipmentInspectionTemplateEdit(string strJson)
        {
            try
            {
                new LeanMES.Equipment.BLL.EquipmentInspectionTemplate().EditJW(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void EquipmentExceptionReportingEdit(string strJson)
        {
            try
            {
                new LeanMES.Equipment.BLL.EquipmentExceptionReporting().Edit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void EquipmentInspectionTemplateItemEdit(string strJson)
        {
            try
            {
                new LeanMES.Equipment.BLL.EquipmentInspectionTemplateItem().Edit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public List<EquipmentInspectionTemplateMemberInfo> GetInspectionTemplateMemberByTempId(Int32 InspectionTemplateId)
        {
            List<EquipmentInspectionTemplateMemberInfo> list = new List<EquipmentInspectionTemplateMemberInfo>();
            try
            {
                EquipmentInspectionTemplateMember bll = new EquipmentInspectionTemplateMember();
                SearchSettings search = new SearchSettings();
                search.ExtensionCondition = "a.[InspectionTemplateId] = " + InspectionTemplateId;
                list = bll.GetAllJW(0, int.MaxValue, " a.[InspectionItemId] asc ", search);
                //  list = bll.GetAll(0, int.MaxValue, "", search);
                list = list.OrderBy(r => r.OpenID).ToList();

                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public List<EquipmentExceptionReportingMemberInfo> GetEquipmentExceptionReportingMemberInfo(Int32 InspectionTemplateId)
        {
            List<EquipmentExceptionReportingMemberInfo> list = new List<EquipmentExceptionReportingMemberInfo>();
            try
            {
                EquipmentExceptionReporting bll = new EquipmentExceptionReporting();
                SearchSettings search = new SearchSettings();
                search.ExtensionCondition = "[ExceptionReportingId] = " + InspectionTemplateId;
                list = bll.GetAllMember(0, int.MaxValue, " [ExceptionReportingMemberId] asc ", search);
                //  list = bll.GetAll(0, int.MaxValue, "", search);
                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 设备保养—获取提交给OA的信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public EquipmentInspectionInfo GetEquipmentMaintenanceInfo(EquipmentInspectionInfo entity)
        {
            try
            {
                return new EquipmentInspectionTemplateItem().GetEquipmentMaintenanceInfo(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 根据检验单Id获取检验项信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<EquipmentInspectionTemplateDetailInfo> GetEquipmentInspectionTemplateDetail(EquipmentInspectionTemplateDetailInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                return new EquipmentInspectionTemplateItem().GetEquipmentInspectionTemplateDetail(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 更新检验项检验结果
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public EquipmentInspectionTemplateDetailInfo UpdateInspectionItemResult(EquipmentInspectionTemplateDetailInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                return new EquipmentInspectionTemplateItem().UpdateInspectionItemResult(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }



        /// <summary>
        /// 设备保养—保养完成 或 设备停机，无需保养
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="flag">0:设备停机，无需保养 1：保养完成</param>
        [AjaxMethod]
        public void InspectionEquipmentComplete(EquipmentInspectionInfo entity, int flag)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                new EquipmentInspectionTemplateItem().InspectionEquipmentComplete(entity, flag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 设备保养—设备停机，无需保养
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void InspectionEquipmentNoMaintenance(string ids, int inspectionType)
        {
            try
            {
                var entity = new EquipmentInspectionInfo
                {
                    ModifyBy = AccountController.GetCurrentUser().UserName
                };
                new EquipmentInspectionTemplateItem().InspectionEquipmentNoMaintenance(entity, ids);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 更改备注检验项状态
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void UpdateInspectionItemRemark(EquipmentInspectionTemplateDetailInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                new EquipmentInspectionTemplateItem().UpdateInspectionItemRemark(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 更改设备保养检验项备注
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void UpdateMaintenanceDemoSubDesc(EquipmentInspectionTemplateDetailInfo entity)
        {
            try
            {
                //entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                new EquipmentInspectionTemplateItem().UpdateMaintenanceDemoSubDesc(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 更改设备保养判定结果
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void UpdateMaintenanceDemoSubIsDone(EquipmentInspectionTemplateDetailInfo entity)
        {
            try
            {
                //entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                new EquipmentInspectionTemplateItem().UpdateMaintenanceDemoSubIsDone(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 设备点检—结果录入—获取检验单检验项信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public EquipmentInspectionTemplateDetailInfo GetInspectionOrderOATemplateDetailInfo(EquipmentInspectionTemplateDetailInfo entity)
        {
            try
            {
                return new EquipmentInspectionTemplateItem().GetInspectionOrderOATemplateDetailInfo(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 设备保养计划—结果录入—获取检验单检验项信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public EquipmentInspectionTemplateDetailInfo GetMintenanceOATemplateDetailInfo(EquipmentInspectionTemplateDetailInfo entity)
        {
            try
            {
                return new EquipmentInspectionTemplateItem().GetMintenanceOATemplateDetailInfo(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// 设备保养—结果录入—获取保养单检验项已检验的SN信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public List<InspectionOrderSNInfo> GetMintenanceOrderSN(EquipmentInspectionTemplateDetailInfo entity)
        {
            try
            {
                return new EquipmentInspectionTemplateItem().GetMintenanceOrderSN(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 设备保养—结果录入—保存GRN检验记录
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="json"></param>
        [AjaxMethod]
        public void SaveMintenanceGRN(EquipmentInspectionTemplateDetailInfo entity, string json)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                DataTable dt = JsonHelper.JsonToDataTable(json);
                new EquipmentInspectionTemplateItem().SaveMintenanceGRN(entity, dt);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 设备点检—结果录入—获取检验单检验项已检验的SN信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public List<InspectionOrderSNInfo> GetInspectionOrderSN(EquipmentInspectionTemplateDetailInfo entity)
        {
            try
            {
                return new EquipmentInspectionTemplateItem().GetInspectionOrderSN(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 设备点检—结果录入—保存GRN检验记录
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="json"></param>
        [AjaxMethod]
        public void SaveInspectionGRN(EquipmentInspectionTemplateDetailInfo entity, string json)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                DataTable dt = JsonHelper.JsonToDataTable(json);
                new EquipmentInspectionTemplateItem().SaveInspectionGRN(entity, dt);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 设备点检—结果录入—清除GRN检验记录
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void DeleteInspectionGRN(EquipmentInspectionTemplateDetailInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                new EquipmentInspectionTemplateItem().DeleteInspectionGRN(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


    }
}