using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxPickList
    {
        [AjaxMethod]
        public List<PickListDetailInfo> GetPickListDetailInfo(Int32 pickListId)
        {
            List<PickListDetailInfo> list = null;
            try
            {
                PickListDetail bll = new PickListDetail();
                list = bll.GetPickListDetailInfo(pickListId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// PickList编辑
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void pickListEdit(PickListInfo entity)
        {
            try
            {
                new PickList().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void pickListDetailEdit(PickListDetailInfo entity)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                new PickListDetail().Edit(entity,userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 删除数据
        /// </summary>
        [AjaxMethod]
        public void deletePickList(int pickListId, int flage, string pickListIdString)
        {
            try
            {
                new PickList().Delete(pickListId, flage, pickListIdString, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public List<PickListDetailInfo> GetOrderBomInfo(string orderNo)
        {
            List<PickListDetailInfo> list = null;
            try
            {
                PickListDetail bll = new PickListDetail();
                list = bll.GetOrderBomInfo(orderNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public void CollectOrderPickList(string OrderNo, string PickListName, string Rev, string Remark, string DeatailJSON)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                PickListDetail bll = new PickListDetail();
                bll.CollectOrderPickList(OrderNo, PickListName, Rev, Remark, DeatailJSON,userName,userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 批次上料清单—启用
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void PickLoadingStart(PickListInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                new PickList().PickLoadingStart(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}