using System;
using System.Collections.Generic;
using AjaxPro;
using SKT.LeanMES.SMT.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxPreAssemblySetting
    {
        /// <summary>
        /// 新建或编辑PreAssemblySetting
        /// </summary>
        [AjaxMethod]
        public void PreAssemblySettingEdit(LeanMES.SMT.Model.PreAssemblySettingInfo info)
        {
            try
            {
               var bll = new LeanMES.SMT.BLL.PreAssemblySetting();
                bll.Edit(info);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void EditAll(List<PreAssemblySettingInfo> infos)
        {
            foreach (PreAssemblySettingInfo info in infos)
            {
                PreAssemblySettingEdit(info);
            }
        }

        [AjaxMethod]
        public List<PreAssemblySettingInfo> GetSubList(int modelid, string modelno)
        {
            List<PreAssemblySettingInfo> list = new List<PreAssemblySettingInfo>();
            try
            {
                var bll = new LeanMES.SMT.BLL.PreAssemblySetting();
                list = bll.GetSubInfoList(modelid, modelno);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
    }
}