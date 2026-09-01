using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Schedule.Model;
using SKT.LeanMES.Schedule.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSchedule
    {
        /// <summary>
        /// 齐套检查和锁定
        /// </summary>
        [AjaxMethod]
        public void KittingCheck(int scheduleId)
        {
            try
            {
                (new Schedules()).Kitting(scheduleId);
            }
            catch(Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 取消齐套锁定
        /// </summary>
        [AjaxMethod]
        public void UnKitting(int scheduleId)
        {
            try
            {
                (new Schedules()).UnKitting(scheduleId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 排程导入的数据在APS有更新之后，此处确认并更新已经导入的排程数据。
        /// </summary>
        [AjaxMethod]
        public void ScheduleUpdateConfirm()
        {
            try
            {
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 排程发布
        /// </summary>
        [AjaxMethod]
        public void SchedulePublish(int scheduleId, string user)
        {
            try
            {
                (new Schedules()).SchedulePublish(scheduleId , user);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 对所有  排程分配记录 进行发布
        /// </summary>
        [AjaxMethod]
        public void ScheduleAllottedPublish(string user)
        {
            try
            {
                (new Schedules()).ScheduleAllottedPublish(user);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 排程立即导入
        /// </summary>
        [AjaxMethod]
        public void AtOnceImportSchedule()
        {
            try
            {
                (new Schedules()).AtOnceImportSchedule();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 排程确认更新
        /// </summary>
        [AjaxMethod]
        public void ConfirmUpdate(string moCode, string workSEQ, string pubufts, string user, int update)
        {
            try
            {
                (new ScheduleUpdate()).ConfirmUpdate(moCode, workSEQ, pubufts, user, update);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 排程分配
        /// </summary>
        [AjaxMethod]
        public void ScheduleAllot(int scheduleId, string shift, string qty, string line, string user)
        {
            try
            {
                (new Schedules()).ScheduleAllot(scheduleId , shift, qty, line, user);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取排程已分配数据
        /// </summary>
        /// <param name="scheduleId">排程Id</param>
        [AjaxMethod]
        public List<SchedulePublishToLineInfo> GetScheduleAllotList(int scheduleId)
        {
            List<SchedulePublishToLineInfo> list = new List<SchedulePublishToLineInfo>();

            try
            {
                list = (new Schedules()).GetScheduleAllotList(scheduleId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return list;
        }

        /// <summary>
        /// 排产数量变更
        /// </summary>
        /// <param name="schedulingId">排产Id</param>
        /// <param name="isGet">1 获取数量 2 确认变更</param>
        [AjaxMethod]
        public string[] SchedulingQtyChange(int schedulingId, decimal changeQty, string user, int isGet)
        {
            string[] arr = {"-1","-1"};

            try
            {
                arr = (new Scheduling()).SchedulingQtyChange(schedulingId, changeQty, user, isGet);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return arr;
        }
        
        /// <summary>
        /// 排产顺序变更
        /// </summary>
        /// <param name="schedulingId">排产Id</param>
        /// <param name="upOrDown">1 上移 2 下移</param>
        /// <param name="swopSchedulingId">参与调换的排产Id</param>
        [AjaxMethod]
        public void SchedulingSeqChange(int schedulingId, string user, int upOrDown, int swopSchedulingId)
        {

            try
            {
                (new bScheduling()).SchedulingSeqChange(schedulingId, user, upOrDown, swopSchedulingId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }



        /// <summary>
        /// 排产暂停或取消
        /// </summary>
        /// <param name="schedulingId">排产Id</param>
        /// <param name="stopOrCancel">1 暂停 2 取消</param>
        [AjaxMethod]
        public void SchedulingStopOrCancel(int schedulingId, string user, int stopOrCancel)
        {
            try
            {
                (new Scheduling()).SchedulingStopOrCancel(schedulingId, user, stopOrCancel);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }


        /// <summary>
        /// 取消排产暂停
        /// </summary>
        /// <param name="schedulingId">排产Id</param>
        [AjaxMethod]
        public void CancelStopScheduling(int schedulingId, string user)
        {
            try
            {
                (new Scheduling()).CancelStopScheduling(schedulingId, user);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }


        /// <summary>
        /// 工单BOM变更
        /// </summary>
        /// <param name="id">ERP_BOMChangeId</param>
        [AjaxMethod]
        public void BomConfirmChange(string orderNO, string pubufts, string user)
        {
            try
            {
                (new Scheduling()).BomConfirmChange(orderNO, pubufts, user);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        /// <summary>
        /// 排程分配后的记录发布(排产发布)
        /// </summary>
        /// <param name="scheduleAllotId">分配记录Id</param>
        /// <param name="user"></param>
        [AjaxMethod]
        public void ScheduleAllotPublish(int scheduleAllotId, string user)
        {
            try
            {
                (new Schedules()).ScheduleAllotPublish(scheduleAllotId, user);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}