using System;
using AjaxPro;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.SampleNumberManagement.BLL;
using SKT.LeanMES.SampleNumberManagement.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSampleNumber
    {
        [AjaxMethod]
        public List<SampleNumberMainSubInfo> GetInfo(SampleNumberMainSubInfo entity)
        {
            try
            {
                return new SampleNumber().GetInfo(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 样品序号列表—新增、编辑、导入
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="json"></param>
        /// <param name="flag">类型：1、新增 2：编辑 3：导入</param>
        [AjaxMethod]
        public void SampleNumberEdit(SampleNumberMainSubInfo entity, string json, int flag)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                new SampleNumber().SampleNumberEdit(entity, json, flag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}