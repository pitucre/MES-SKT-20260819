using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.ProductionShift.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxServicesShift
    {
        /// <summary>
        /// 根据掩码数据信息更新或新增数据
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int EditShift(ProductionShiftInfo entity)
        {
            try
            {
                SKT.LeanMES.ProductionShift.BLL.ProductionShift bllData = new SKT.LeanMES.ProductionShift.BLL.ProductionShift();
                if (entity.ShiftId == -1) //add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else // update selected record
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
        /// <summary>
        /// 根据掩码数据信息更新或新增数据
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int EditShiftChild(int memberId, string docXml)
        {
            try
            {
                SKT.LeanMES.ProductionShift.BLL.Shift_Member bllData = new SKT.LeanMES.ProductionShift.BLL.Shift_Member();

                return bllData.EditChild(memberId, docXml);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }

        /// <summary>
        /// 根据掩码数据信息更新或新增数据
        /// </summary>
        /// <param name="memberId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<Shift_MemberInfo> GetChildMemberList(int memberId)
        {
            try
            {
                SKT.LeanMES.ProductionShift.BLL.Shift_Member bllData = new SKT.LeanMES.ProductionShift.BLL.Shift_Member();
                SearchSettings searchSettings = new SearchSettings();
                //searchSettings.AddCondition("MemberId", memberId.ToString());
                searchSettings.ExtensionCondition = "MemberId = "+ memberId.ToString();
                return bllData.GetChildAll(0, 1000, "", searchSettings);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// 根据班制ID 获取班次列表信息
        /// </summary>
        /// <param name="shiftId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<Shift_MemberInfo> GetShiftList(int shiftId)
        {
            try
            {
                SKT.LeanMES.ProductionShift.BLL.Shift_Member bllData = new SKT.LeanMES.ProductionShift.BLL.Shift_Member();
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.AddCondition("ShiftId", shiftId.ToString());
                return bllData.GetAll(0, 1000, "", searchSettings);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

    }
}