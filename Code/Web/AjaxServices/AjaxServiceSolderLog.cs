using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Accessories.Model;
using SKT.LeanMES.Accessories.BLL;
using SKT.MES.DAL.Marshal;
using System.Web.Script.Serialization;
using SKT.LeanMES.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxServiceSolderLog
    {
        /// <summary>
        /// 解冻
        /// </summary>
        [AjaxMethod]
        public void AddThawInfo(string barCode)
        {
            try
            {
                LOG log = new LOG();
                if (!string.IsNullOrEmpty(barCode))
                    log.AccessoriesThaw(barCode, AccountController.GetCurrentUser().UserId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 使用
        /// </summary>
        /// <param name="barCode"></param>
        /// <param name="usePeople">使用人</param>
        [AjaxMethod]
        public void AddUseOfInfo(string barCode, int usePeople, int line, int orderId, string useTime)
        {
            try
            {
                LOG log = new LOG();
                log.AccessoriesUseOf(barCode, usePeople, line, orderId, useTime, AccountController.GetCurrentUser().UserId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 冰冻
        /// </summary>
        /// <param name="barCode"></param>
        [AjaxMethod]
        public void AddFrostInfo(string barCode)
        {
            try
            {
                LOG log = new LOG();
                log.AccessoriesFrostOf(barCode, AccountController.GetCurrentUser().UserId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, false);
            }
        }

        /// <summary>
        /// 辅料时间管控
        /// </summary>
        /// <param name="selType"></param>
        /// <param name="minThaw"></param>
        /// <param name="maxVoID"></param>
        /// <param name="maxUse"></param>
        [AjaxMethod]
        public void AddSetTime(int selType, int minThaw, int maxVoID, int maxUse)
        {
            try
            {
                CONFIG config = new CONFIG();
                config.AccessoriesAddSetTime(selType, minThaw, maxVoID, maxUse);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public LOGInfo GetSetTimeByType(Int32 typeID)
        {
            try
            {
                LOG log = new LOG();
                return log.GetSetTimeByType(typeID);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// 获取操作信息
        /// </summary>
        /// <param name="barCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<LOGInfo> GetUseLogInfoByBarCode(string barCode)
        {
            try
            {
                LOG log = new LOG();
                return log.GetUseLogInfoByBarCode(barCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// 添加报废信息
        /// </summary>
        /// <param name="barCode"></param>
        [AjaxMethod]
        public void SetInvalidatedInfo(string barCode)
        {
            try
            {
                LOG log = new LOG();
                if (!string.IsNullOrEmpty(barCode))
                    log.SetInvidatedInfo(barCode, AccountController.GetCurrentUser().UserId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}