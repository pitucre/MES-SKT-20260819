using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using AjaxPro;
using SKT.LeanMES.Anormal.Model;
using SKT.LeanMES.Anormal.BLL;
using SKT.Common.Model;
using SKT.LeanMES.ProdAnormal.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxAnormal
    {
        /// <summary>
        /// 编辑类型分组
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditAnormalGroup(AnormalGroupInfo entity)
        {
            try
            {
                AnormalGroup anormalGroup = new AnormalGroup();
                if (entity.AnormalGroupId == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                    entity.Remark = "";
                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                    entity.Remark = "";
                }
                anormalGroup.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 编辑类型
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditAnormalType(AnormalTypeInfo entity)
        {
            try
            {
                AnormalType anormalType = new AnormalType();
                if (entity.AnormalTypeId == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                    entity.Remark = "";
                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                    entity.Remark = "";
                }
                anormalType.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取异常处理人员信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public AnormalProcessConfigInfo GetAnormalProcessConfig(AnormalProcessConfigInfo entity)
        {
            try
            {
                var bll = new ProdAnormal.BLL.Anormal();
                return bll.GetAnormalProcessConfig(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 异常处理人员列表-新增、编辑
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public void AnormalProcessConfigEdit(AnormalProcessConfigInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;

                var bll = new ProdAnormal.BLL.Anormal();
                bll.AnormalProcessConfigEdit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        ///// <summary>
        ///// 获取预警等级列表
        ///// </summary>
        ///// <returns></returns>
        //[AjaxMethod]
        //public List<AnormalWarningLevelInfo> GetAnormalWarningLevelList()
        //{
        //    try
        //    {
        //        var bll = new SKT.LeanMES.Anormal.BLL.Anormal();
        //        return bll.GetAnormalWarningLevelList();
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //        return null;
        //    }
        //}
    }
}