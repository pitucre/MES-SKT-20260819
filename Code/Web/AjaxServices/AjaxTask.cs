using AjaxPro;
using SKT.LeanMES.Task.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxTask
    {
        /// <summary>
        /// 编辑任务
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditTask(TaskInfo entity, string beginTime, string endTime)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                entity.StartTime = Convert.ToDateTime(beginTime);
                if (!string.IsNullOrEmpty(endTime))
                {
                    entity.EndTime = Convert.ToDateTime(endTime);
                }
                else
                {
                    entity.EndTime = DateTime.MaxValue;
                }
                new SKT.LeanMES.Task.BLL.Task().EditTask(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}