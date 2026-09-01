using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Web.Utility;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxErrorLog
    {
        [AjaxMethod]
        public List<ErrorModel> GetAllError(string BegTime, string EndTime)
        {
            List<ErrorModel> list = null;
            if (AccountController.GetCurrentUser(true) == null)
            {
                throw new Exception("timeout");
            }
            else
            {
                try
                {
                    list = (new ErrorHelper()).GetAllError(BegTime, EndTime);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
                    throw new Exception(ex.Message);
                }
            }
            return list;
        }

        [AjaxMethod]
        public ErrorModel GetErrorDetail(string yearMonth, string occrTime)
        {
            ErrorModel entity = null;
            if (AccountController.GetCurrentUser(true) == null)
            {
                throw new Exception("timeout");
            }
            else
            {
                try
                {
                    entity = (new ErrorHelper()).GetErrorDetail(yearMonth, occrTime);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                    throw new Exception(ex.Message);
                }
            }

            return entity;
        }

        [AjaxMethod]
        public void CreateOperationLog(string LogType, string ModuleName, string PageName, string OederNo, string LogContent)
        {
            try
            {
                var en = new SystemLog.Model.AccreditLogInfo(){
                    UserName = AccountController.GetCurrentUser().UserName,
                    LogType = LogType,
                    ModuleName = ModuleName,
                    PageName = PageName,
                    OederNo = OederNo,
                    LogContent = LogContent
                };
                if (string.IsNullOrWhiteSpace(en.LogContent) || string.IsNullOrWhiteSpace(en.LogType) || string.IsNullOrWhiteSpace(en.LogContent))
                    return;

                new SystemLog.BLL.AccreditLog().CreateOperationLog(en);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
            }
        }

        [AjaxMethod]
        public void CreateMaterialHistoryLog(int LogType, string OperateOrder, string ActionDesc,string LogContent)
        {
            try
            {
                var en = new SystemLog.Model.MaterialHistoryLogInfo()
                {
                    CreateBy = AccountController.GetCurrentUser().UserName,
                    ActionType = LogType,
                    ActionDesc = ActionDesc,
                    OperateOrder = OperateOrder,
                    Description = LogContent
                };
                if (string.IsNullOrWhiteSpace(en.ActionDesc) || en.ActionType<0 || string.IsNullOrWhiteSpace(en.Description))
                    return;

                new SystemLog.BLL.AccreditLog().CreateMaterialHistoryLog(en);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
            }
        }

    }
}