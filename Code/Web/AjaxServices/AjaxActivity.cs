using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Router.BLL;
using SKT.LeanMES.Router.Model;
using SKT.LeanMES.Station.BLL;
using SKT.LeanMES.Station.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxActivity
    {
        [AjaxMethod]
        public void EditActivity(ActivityInfo entity, String aoidString, String ac_param_nameString, String ac_param_valueString, String ac_param_remarkString, String ac_sequenceString, String tabString, Int32 justEditOpeTypeACMember)
        {
            try
            {
                int acId = -1;
                acId = (new Activity()).Edit(entity, aoidString, ac_param_nameString, ac_param_valueString, ac_param_remarkString, ac_sequenceString, tabString, justEditOpeTypeACMember);
                if (entity.AC_ID == -1)
                {
                    (new Activity()).UpdateAcAttr(acId);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 保存模板
        /// </summary>
        /// <param name="tmplId"></param>
        /// <param name="tmplName"></param>
        /// <param name="tmplContent"></param>
        /// <param name="tmplDesc"></param>
        [AjaxMethod]
        public void EditTemplate(int tmplId, string tmplName, string tmplContent, string tmplDesc)
        {
            Template bll = new Template();
            TemplateInfo model = new TemplateInfo();
            model.TemplateID = tmplId;
            model.Tmpl_TemplateName = tmplName;
            model.Tmpl_TemplateValue = tmplContent;
            model.Tmpl_TemplateDesc = tmplDesc;
            model.CreateBy = AccountController.GetCurrentUser().UserName;
            model.ModifyBy = AccountController.GetCurrentUser().UserName;

            try
            {
                int templateId = -1;
                templateId = bll.Edit(model);
                if (tmplId == -1)
                {
                    (new Template()).UpdateTmpAttr(templateId);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 获取模板数据
        /// </summary>
        /// <param name="tId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int GetRtAtt(int tId)
        {
            int f = -1;
            try
            {
                f = (new Template()).GetRtAtt(tId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return f;
        }
        /// <summary>
        /// 获取Activity数据
        /// </summary>
        /// <param name="tId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int GetRtAttActivity(int ac_Id)
        {
            int f = -1;
            try
            {
                f = (new Activity()).GetRtAtt(ac_Id);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return f;
        }
        [AjaxMethod]
        public string GetFuncCode(Int32 ac_id)
        {
            string result = "";
            try
            {
                result = new Activity().GetFunctionCode(ac_id);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return result;
        }
        /// <summary>
        /// 获取工位类型
        /// </summary>
        /// <param name="AC_ID"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<StationTypeInfo> GetActivityStation(Int32 AC_ID)
        {
            List<StationTypeInfo> list = null;
            try
            {
                StationType bllStation = new StationType();
                list = bllStation.GetActivityStation(AC_ID);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        /// 根据工序类型获取对应数据
        /// </summary>
        /// <param name="stationTypeId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ActivityInfo> GetActivityStationMember(Int32 stationTypeId)
        {
            List<ActivityInfo> list = null;
            try
            {
                Activity bllActivity = new Activity();
                list = bllActivity.GetActivityStationMeber(stationTypeId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        /// 保存Configparams
        /// </summary>
        [AjaxMethod]
        public void SaveConfigparams(String aoidString, String ac_param_valueString) 
        {
            try
            {
                Activity bllActivity = new Activity();
                bllActivity.SaveConfigparams(aoidString,ac_param_valueString);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 根据id获取对应信息
        /// </summary>
        /// <param name="AC_ID"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ActivityOptionsInfo> GetActionByACID(Int32 AC_ID) 
        {
            List<ActivityOptionsInfo> list = null;
            try
            {
                ActivityOptions bllActivity = new ActivityOptions();
                list = bllActivity.GetActionByACID(AC_ID);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
    }
}