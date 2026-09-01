using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.ProductionShift.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxShiftMember
    {
        /// <summary>
        /// 保存班次子表信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public Int32 EditShiftMember(Shift_MemberInfo entity)
        {
            try
            {
                SKT.LeanMES.ProductionShift.BLL.Shift_Member bllData = new SKT.LeanMES.ProductionShift.BLL.Shift_Member();
                if (entity.MemberId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else 
                {
                    entity.CreateBy = "";
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                }
                return bllData.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }
    }
}