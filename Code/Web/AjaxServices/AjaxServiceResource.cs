using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Resource.Model;
using SKT.LeanMES.Resource.BLL;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxServiceResource
    {
        /// <summary>
        /// 更新或者增加ResourceType
        /// </summary>
        /// <param name="entity">ResourceType实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public void EditResourceType(ResourceTypeInfo entity)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                (new ResourceType()).Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(userName, ex);
            }
        }

        [AjaxMethod]
        public void EditResource(ResourceInfo entity, string resCertIDString, string resResTypeString, string itemIdString, string verString, string startTime, string endTime,string Face)
        {
            try
            {
                if (entity.ResourceId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                new SKT.LeanMES.Resource.BLL.Resource().Edit(entity, resCertIDString, resResTypeString, itemIdString, verString, startTime, endTime, Face);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public List<ResourceInfo> GetItemOnHold(int resId)
        {
            List<ResourceInfo> resourceInfo = new List<ResourceInfo>();
            try
            {
                resourceInfo = new SKT.LeanMES.Resource.BLL.Resource().GetItemOnHoldByResId(resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return resourceInfo;
        }

        [AjaxMethod]
        public void EditLine(SKT.LeanMES.Resource.Model.LineInfo entity, string resIdString, string dateTimeStr,string agvStr)
        {
            try
            {
                int appLineNum = Convert.ToInt32(HttpContext.Current.Application["LineQty"]);
                string[] datatimes = dateTimeStr.Split('|');
                string startDate = "";
                string endDate = "";
                if (datatimes.Length >= 2)
                {
                    startDate = datatimes[0];
                    endDate = datatimes[1];
                }
                (new Line()).Edit(entity, resIdString, appLineNum, startDate, endDate, agvStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
            }
        }

        [AjaxMethod]
        public void LineSetEdit(SKT.LeanMES.Resource.Model.LineSetInfo entity)
        {
            try
            {
                (new LineSet()).Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
            }
        }

        /// <summary>
        /// 通过line获取产别时段
        /// </summary>
        /// <param name="ItemCode">物料编码</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<LineTimePeriodInfo> GetLineTimePeriod(string lineId)
        {
            try
            {
                LineTimePeriod lt = new LineTimePeriod();
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.ExtensionCondition = " lineId = " + lineId;
                return lt.GetAll(0, int.MaxValue, "TimePeriodId", searchSettings);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
            }
            return null;
        }

        /// <summary>
        /// 通过line获取产别时段
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public DataTable GetLineProdDateList(int lineId)
        {
            try
            {
                LineProdDatePeriod lt = new LineProdDatePeriod();
                return lt.GetLineProdDateList(lineId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
            }
            return null;
        }

        /// <summary>
        /// 获取产别时段和AGV
        /// </summary>
        /// <param name="lineId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public DataSet GetLineProdList(int lineId)
        {
            try
            {
                LineProdDatePeriod lt = new LineProdDatePeriod();
                return lt.GetLineProdList(lineId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
            }
            return null;
        }

        /// <summary>
        /// 判断线别是否超过限制数量 
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public bool LineIsLimited()
        {
            //try
            //{
            //    int appLineNum = Convert.ToInt32(HttpContext.Current.Application["LineQty"]);
            //    return (new Line()).AddLineIsLimited(appLineNum);
            //}
            //catch (Exception ex)
            //{
            //    WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
            //}
            return false;
        }
        [AjaxMethod]
        public void CheckLineMachineTypeRelation(string EquipmentLineDisplayName, int LineId)
        {
            try
            {
                new Line().CheckLineMachineTypeRelation(EquipmentLineDisplayName, LineId);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 获取不良描述
        /// </summary>
        /// <param name="nccode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int GetLineInfo(string LineName)
        {
            int LineId = -1;

            try
            {
                LineId = new Line().GetLineInfo(LineName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return LineId;
        }
    }
}