using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.SMT.BLL; 
using System.Data;
using SKT.Common.Model;
using SKT.LeanMES.Resource.BLL;
using SKT.LeanMES.Resource.Model;
using SKT.LeanMES.Web;
using SKT.LeanMES.SMT.Model;


namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// 基础数据Ajax类
    /// </summary>
    public class AjaxServicesLoadingList
    {
        /// <summary>
        /// 编辑产品组信息
        /// </summary>
        /// <param name="model"></param>
        [AjaxMethod]
        public void LoadingListEdit(LoadinglistInfo model)
        {
            try
            {
                (new LoadingList()).Edit(model, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// Get loadinglist 信息
        /// </summary>
        /// <param name="model"></param>

        [AjaxMethod]
        public List<LoadinglistInfo> GetLoadinglist(string LoadinglistID)
        {
            try
            {
                LoadingList LL = new LoadingList();
                List<LoadinglistInfo> Lsitentity = LL.GetInfo(LoadinglistID);
                return Lsitentity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public List<LoadingList_MACHINEInfo> GetLLMachine(string LLID)
        {
            try
            {
                LoadingList_MACHINE bllmachine = new LoadingList_MACHINE();
                List<LoadingList_MACHINEInfo> Lsitentity = bllmachine.GetInfo(LLID);
                return Lsitentity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public List<LoadingList_DetailInfo> GetLLDetail(string LLMID)
        {
            try
            {
                LoadingList_DETAIL bllLLDetail = new LoadingList_DETAIL();
                List<LoadingList_DetailInfo> Lsitentity = bllLLDetail.GetInfo(LLMID);
                return Lsitentity;

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// 线别验证
        /// </summary>     
        [AjaxMethod]
        //MaterialCheck(orderNo,resId,ddlLineId,loadingId)
        public void MaterialCheck(string orderNo, int resID, int lineId, int loadListId)
        {
            try
            {
                int userId = AccountController.GetCurrentUser().UserId;
                LoadingList ldl = new LoadingList();
                ldl.ValidateMaterialOperation(orderNo, resID, lineId, loadListId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 获取所有线别对应的loadinglist
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<LoadinglistInfo> GetAllLoadingListinfo(int lineId)
        {
            try
            {
                LoadingList bllLoadlist = new LoadingList();
                List<LoadinglistInfo> loadEntity = bllLoadlist.GetLoadingSetupName(lineId);
                return loadEntity;

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// 获取上一次操作LoadingList信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public LoadinglistInfo GetLastLineHistory(int lineId)
        {
            try
            {
                LoadingList bllLoadlist = new LoadingList();
                LoadinglistInfo loadEntity = bllLoadlist.GetLastLineOpreation(lineId);
                return loadEntity;

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 报警记录保存  update by weixia on 2014/12/15
        /// </summary>
        /// <param name="maintainaceId">报警记录保存</param>
        [AjaxMethod]
        public void SaveAlertHistory(int flage, string hostname, string Comment, int action, string errorCode, int status)
        {
            try
            {
                string userId = AccountController.GetCurrentUser().UserName;
                LoadingList LL = new LoadingList();
                LL.SaveAlertHistory(flage, userId, hostname, Comment, action, errorCode, status);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 根据名字查询线别
        /// </summary>
        /// <param name="maintainaceId">报警记录保存</param>
        [AjaxMethod]
        public List<LineInfo> GetLineNameByUserName(string userName)
        {
            List<LineInfo> list = new List<LineInfo>();
            try
            {

                string userId = AccountController.GetCurrentUser().UserName;
                Line ll = new Line();
                list = ll.GetLineNameByUserName(userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public void SaveLoadListDetail(LoadingList_DetailInfo entity)
        {
            try
            {
                new LoadingList_DETAIL().SaveLoadingListDetail(entity, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void SaveByUserBind(LoadinglistInfo entity)
        {
            try
            {
                (new LoadingList_DETAIL()).SaveByUserBind(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void EditLoadingType(LoadingTypeInfo entity)
        {
            try
            {
                (new LoadingType()).Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public bool LoadingListTableEdit(LoadingListTableInfo m_LoadingListTableInfo)
        {
            m_LoadingListTableInfo.ModifyBy = AccountController.GetCurrentUser().UserName;
            m_LoadingListTableInfo.ModifyDateTime = DateTime.Now;
            (new LoadingListTable()).Edit(m_LoadingListTableInfo);
            return true;
        }

        /// <summary>
        /// 获取SMT-LineType-Seq
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string GetEquipmentLineSeq(String typeId)
        {
            try
            {
                return (new LeanMES.SMT.BLL.LoadingType()).GetSMTLineSequence(typeId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }
        ///// <summary>
        ///// 获取模板表头
        ///// </summary>
        ///// <returns></returns>
        //[AjaxMethod]
        //public LoadingTypeInfo GetLoadTypeSeq(int typeId)
        //{
        //    var entity = new LoadingTypeInfo();
        //    try
        //    {
        //        entity = new LeanMES.SMT.BLL.LoadingType().GetLoadTypeSeq(typeId);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex); 
        //    }
        //    return entity;
        //}
        /// <summary>
        /// 上料清单启用方法
        /// </summary>
        [AjaxMethod]
        public void LoadingStatusStart(int id)
        {
            try
            {
                new LoadingList().LoadingStatusStart(id, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [AjaxMethod]
        public void LoadingListDetailDelete(string DetailID)
        {
            string userId = AccountController.GetCurrentUser().UserName;
            try
            {
                new LoadingList_DETAIL().Delete(DetailID, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}