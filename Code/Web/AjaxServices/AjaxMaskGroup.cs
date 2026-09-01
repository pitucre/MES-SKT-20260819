using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.MaskGroup.Model;
using SKT.LeanMES.MaskGroup.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMaskGroup
    {
        /// <summary>
        /// 根据掩码数据信息更新或新增数据
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int EditMaskGroup(MaskGroupInfo entity, string action, Int32 oldRecordId)
        {
            try
            {
                SKT.LeanMES.MaskGroup.BLL.MaskGroup bllData = new SKT.LeanMES.MaskGroup.BLL.MaskGroup();
                return bllData.Edit(entity, action, oldRecordId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(entity.CreateBy, ex);
                return 0;
            }
        }

        /// <summary>
        /// 修改mask group memeber
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int MaintenanceMaskGroupMember(MaskGroupMemberInfo entity, string dtFrom, string dtTo)
        {
            string regExp = entity.DisplayMask;
            try
            {

                SKT.LeanMES.MaskGroup.BLL.MaskGroupMember bllMember = new SKT.LeanMES.MaskGroup.BLL.MaskGroupMember();
                entity.ValidFrom = (dtFrom == "") ? DateTime.Today : Convert.ToDateTime(dtFrom);
                entity.ValidTo = (dtTo == "") ? Convert.ToDateTime("9999-12-31") : Convert.ToDateTime(dtTo);
                if (entity.MaskType.Substring(0, 1) != "R")
                {
                    regExp = SKT.LeanMES.Web.Utility.MaskHelper.BuildRegularExpression(entity.DisplayMask);
                }
                entity.RegularExpression = regExp;
                return bllMember.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
                return 0;
            }
        }
    }
}