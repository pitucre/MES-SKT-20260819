using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Warning.Model;
using SKT.LeanMES.Warning.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxWarning
    {
        [AjaxMethod]
        public void WarningEdit(WarningInfo entity)
        {
            try
            {
                SKT.LeanMES.Warning.BLL.Warning bll = new SKT.LeanMES.Warning.BLL.Warning();
                if (entity.WarningId == -1)
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

        [AjaxMethod]
        public void SaveOneSolve(int warninghistoryId, string txtOneSolve)
        {
            try
            {
                SKT.LeanMES.Warning.BLL.WarningHistory bll = new SKT.LeanMES.Warning.BLL.WarningHistory();
                string userName = AccountController.GetCurrentUser().UserName;
                bll.SaveOneSolve(warninghistoryId, txtOneSolve, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void SaveTwoSolve(int warninghistoryId, string txtTwoSolve)
        {
            try
            {
                SKT.LeanMES.Warning.BLL.WarningHistory bll = new SKT.LeanMES.Warning.BLL.WarningHistory();
                string userName = AccountController.GetCurrentUser().UserName;
                bll.SaveTwoSolve(warninghistoryId, txtTwoSolve, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void SaveThreeSolve(int warninghistoryId, string txtThreeSolve)
        {
            try
            {
                SKT.LeanMES.Warning.BLL.WarningHistory bll = new SKT.LeanMES.Warning.BLL.WarningHistory();
                string userName = AccountController.GetCurrentUser().UserName;
                bll.SaveThreeSolve(warninghistoryId, txtThreeSolve, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public decimal GetWraningVal(int typeId)
        {
            WarningTypeInfo entity = new WarningTypeInfo();
            decimal warningVal = 0;
            entity = (new WarningType()).GetInfo(Convert.ToInt32(typeId));
            if (entity != null)
            {
                warningVal = entity.WarningTypeValue;
            }
            return warningVal;
        }

        [AjaxMethod]
        public void WarningTypeEdit(WarningTypeInfo entity)
        {
            try
            {
                WarningType bll = new WarningType();
                if (entity.WarningTypeId == -1)
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

        [AjaxMethod]
        public List<WarningTypeInfo> GetWarningTypeListByGroupId(int groupId)
        {
            try
            {
                WarningType bll = new WarningType();

                return bll.GetWarningTypeListByGroupId(groupId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
    }
}