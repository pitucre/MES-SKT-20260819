using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.SDP.BLL;
using SKT.LeanMES.SDP.Model;
using AjaxPro;
using System.Data;
using System.Transactions;
using SKT.Common.Model;
using SKT.Common.Framework.Model;
using SKT.LeanMES.Web.AppCode;
using SKT.LeanMES.Lookup.Model;
using System.Text;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSDP
    {
        /// <summary>
        /// 根据公共数据源ID获取公共数据源内容
        /// </summary>
        /// <param name="DataSourceId"></param>
        /// <returns></returns>
        [AjaxPro.AjaxMethod]
        public DataSourceInfo GetSourceBySourceId(string DataSourceId)
        {
            return new DataSource().GetInfo(Convert.ToInt32(DataSourceId));
        }

        /// <summary>
        /// 根据路由明细的数据源获取公共数据信息
        /// </summary>
        /// <param name="RDDataSourceId"></param>
        /// <returns></returns>
        [AjaxPro.AjaxMethod]
        public DataSourceInfo GetSourceByRDSourceId(string RDDataSourceId)
        {
            return new DataSource().GetInfoByRdSourceId(Convert.ToInt32(RDDataSourceId));
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="DataSourceId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetParamterBySourceId(string DataSourceId)
        {
            string paramter = "";
            DataSourceInfo info = new DataSource().GetInfo(Convert.ToInt32(DataSourceId));
            if (info != null)
            {
                paramter = string.Join(",", info.Paramters.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries));
            }
            return paramter;
        }

        /// <summary>
        /// 保存数据源
        /// </summary>
        /// <param name="rdId"></param>
        /// <param name="sourceId"></param>
        /// <param name="paraminfo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string SaveRouteSource(string rdId, string sourceId, string paraminfo)
        {
            Int32 RrouteDetailDatasourceId = -1;
            DataTable dtRouteDetail = new Activity().GetRouteDetailByrdId(Convert.ToInt32(rdId));
            if (dtRouteDetail.Rows.Count <= 0)
            {
                return "{\"result\": \"False\", \"message\": \"路由节点ID不存在，请在数据库查询是否已删除\" }";
            }

            DataSourceInfo sourceEntity = new DataSource().GetInfo(Convert.ToInt32(sourceId));
            if (sourceEntity == null)
            {
                return "{\"result\": \"False\", \"message\": \"数据源ID不存在，请在数据库查询是否已删除\" }";
            }

            string[] paramArr = paraminfo.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            List<RouteDetailDataSourceParamInfo> paraminfoEntityList = new List<RouteDetailDataSourceParamInfo>();
            foreach (string param in paramArr)
            {
                string paramterName = param.Substring(0, param.IndexOf("("));
                //var temp = param.Replace(paramterName, "").Replace("(", "").Replace(")", "").Split(new char[] { '/' });
                var temp = param.Substring(paramterName.Length).Replace("(", "").Replace(")", "").Split(new char[] { '/' });
                if (temp.Length == 2)
                {
                    RouteDetailDataSourceParamInfo paraminfoEntity = new RouteDetailDataSourceParamInfo();
                    paraminfoEntity.RouteDetailDataSourceParamID = -1;
                    paraminfoEntity.ControlId = temp[0];
                    paraminfoEntity.ParamValue = temp[1];
                    paraminfoEntity.ParamName = paramterName;
                    paraminfoEntity.ParamType = !string.IsNullOrEmpty(temp[0]) ? "FromUI" : "DefualtValue";
                    paraminfoEntityList.Add(paraminfoEntity);
                }
                else
                {
                    return "{\"result\": \"False\", \"message\": \"保存失败,请关闭浏览器重新操作!\" }";
                }
            }

            RouteDetailDataSourceInfo RDsourceEntity = new RouteDetailDataSourceInfo();
            RDsourceEntity.RouteDetailDataSourceID = -1;
            RDsourceEntity.DataSourceID = sourceEntity.DataSourceID;
            RDsourceEntity.RouteDetailDataSourceName = sourceEntity.DataSourceName;
            RDsourceEntity.RouteId = Convert.ToInt32(dtRouteDetail.Rows[0]["R_ID"]);
            RDsourceEntity.StationId = Convert.ToInt32(dtRouteDetail.Rows[0]["StationId"]);
            RDsourceEntity.RDId = Convert.ToInt32(rdId);

            using (TransactionScope ts = new TransactionScope())
            {
                RrouteDetailDatasourceId = new RouteDetailDataSource().Edit(RDsourceEntity);
                if (RrouteDetailDatasourceId < 0)
                {
                    return "{\"result\": \"False\", \"message\": \"保存失败,请关闭浏览器重新操作!\" }";
                }

                foreach (var paraminfoEntity in paraminfoEntityList)
                {
                    paraminfoEntity.RouteDetailDataSourceID = RrouteDetailDatasourceId;
                    new RouteDetailDataSourceParam().Edit(paraminfoEntity);
                }

                ts.Complete();
            }

            return "{\"result\": \"True\", \"message\": \"保存成功!\",\"RrouteDetailDatasourceId\":\"" + RrouteDetailDatasourceId + "\" }";
        }


        /// <summary>
        /// 获取节点的数据源
        /// </summary>
        /// <param name="rdId"></param>
        /// <returns></returns>
        [AjaxPro.AjaxMethod]
        public DataTable GetRouteDetailParamList(string rdId)
        {
            DataTable dtRouteDetail = new Activity().GetRouteDetailByrdId(Convert.ToInt32(rdId));
            if (dtRouteDetail.Rows.Count <= 0)
            {
                throw new Exception("{\"result\": \"False\", \"message\": \"路由节点ID不存在，请在数据库查询是否已删除\" }");
            }

            DataTable dtRDSource = new RouteDetailDataSource().GetRDSourceByrdId(Convert.ToInt32(dtRouteDetail.Rows[0]["StationId"]), Convert.ToInt32(dtRouteDetail.Rows[0]["R_ID"]));
            DataColumn dc = new DataColumn("Paramter");
            dtRDSource.Columns.Add(dc);

            List<int> RDSourceIDLst = new List<int>();
            for (int i = 0; i < dtRDSource.Rows.Count; i++)
            {
                int RDSourceID = Convert.ToInt32(dtRDSource.Rows[i]["RouteDetailDataSourceID"]);
                if (!RDSourceIDLst.Contains(RDSourceID))
                {
                    RDSourceIDLst.Add(RDSourceID);
                }
            }

            if (RDSourceIDLst.Count > 0)
            {
                DataTable dt = new RouteDetailDataSourceParam().GetRDParamSourceByrdId(RDSourceIDLst);
                for (int k = 0; k < dt.Rows.Count; k++)
                {
                    DataRow[] drArr = dtRDSource.Select("RouteDetailDataSourceID = '" + dt.Rows[k]["RouteDetailDataSourceID"] + "'");
                    if (drArr.Length > 0)
                    {
                        drArr[0]["Paramter"] += (drArr[0]["Paramter"].ToString() != "" ? "," : "") + dt.Rows[k]["ParamName"] + "/" + dt.Rows[k]["ControlId"] + "/" + dt.Rows[k]["ParamValue"];
                    }
                }
            }

            return dtRDSource;
        }

        /// <summary>
        /// 删除路由节点的数据源
        /// </summary>
        /// <param name="RDSourceId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string DeleteRouteDetailSource(int RDSourceId)
        {
            List<FunctionExecStepInfo> FunExecLst = new FunctionExecStep().GetInfoByDataSourceId(RDSourceId);
            if (FunExecLst.Count > 0)
            {
                return "{\"result\": \"False\", \"message\": \"当前数据源已经被步骤使用,不能删除\" }";
            }

            using (TransactionScope ts = new TransactionScope())
            {
                new RouteDetailDataSourceParam().Delete(RDSourceId.ToString());//删除参数

                new RouteDetailDataSource().Delete(RDSourceId.ToString(), AccountController.GetCurrentUser().UserName);

                ts.Complete();
            }
            return "{\"result\": \"True\", \"message\": \"\" }";
        }

        /// <summary>
        ///  保存控件事件和第一个步骤
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string SaveActivity(string rdID, string controlName, string controlId, string controlType, string eventType, string stepName, string datasourceId,
            string StepType, string sourceCotrolId, string stepXml)
        {
            DataTable dtRouteDetail = new Activity().GetRouteDetailByrdId(Convert.ToInt32(rdID));
            if (dtRouteDetail.Rows.Count <= 0)
            {
                return "{\"result\": \"False\", \"message\": \"路由节点ID不存在，请在数据库查询是否已删除\" }";
            }

            ActivityInfo acinfo = new ActivityInfo();
            acinfo.Id = -1;
            acinfo.RouteId = dtRouteDetail.Rows[0]["R_ID"].ToString();
            acinfo.StationId = dtRouteDetail.Rows[0]["StationId"].ToString();
            acinfo.ControlId = controlId;
            acinfo.ControlName = controlName;
            acinfo.ControlType = controlType;
            acinfo.EventType = eventType;
            acinfo.EventName = eventType;
            acinfo.SortNo = "0";
            acinfo.CreateBy = AccountController.GetCurrentUser().UserName;
            acinfo.CreateDateTime = DateTime.Now;

            FunctionExecStepInfo stepinfo = new FunctionExecStepInfo();
            stepinfo.LogicID = -1;
            stepinfo.PreLogicID = 0;
            stepinfo.StepName = stepName;
            stepinfo.StepType = StepType;
            stepinfo.StepXml = stepXml;
            stepinfo.DataSourceControlId = sourceCotrolId;
            stepinfo.DataSourceId = datasourceId;

            int acid = -1;
            int stepId = -1;
            using (TransactionScope ts = new TransactionScope())
            {
                acid = new Activity().Edit(acinfo);

                stepinfo.AC_ID = acid;
                stepId = new FunctionExecStep().Edit(stepinfo);
                ts.Complete();
            }
            return "{\"result\": \"True\", \"message\": \"\",\"AC_ID\":\"" + acid + "\",\"Step_ID\":\"" + stepId + "\" }";
        }

        /// <summary>
        /// 通过路由明细线的ID，获取路由工序上的所有事件
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<ActivityInfo> GetActivityInfo(int rdId)
        {
            DataTable dtRouteDetail = new Activity().GetRouteDetailByrdId(rdId);
            if (dtRouteDetail.Rows.Count <= 0)
            {
                throw new Exception("路由节点ID不存在，请在数据库查询是否已删除");
            }

            string routeId = dtRouteDetail.Rows[0]["R_ID"].ToString();
            string stationId = dtRouteDetail.Rows[0]["StationId"].ToString();

            return new Activity().GetInfo(Convert.ToInt32(routeId), Convert.ToInt32(stationId));
        }

        /// <summary>
        /// 通过事件ID获取步骤内容
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<FunctionExecStepInfo> GetStepInfo(string acId)
        {
            List<string> acIdArr = acId.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();

            return new FunctionExecStep().GetInfo(acIdArr);
        }

        /// <summary>
        /// 单独保存步骤
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string SaveStepInfo(int rdId, string controlid, string eventType, string stepName,
            string datasourceId, string stepType, string sourceCotrolId, string stepXml)
        {
            ActivityInfo entity = new Activity().GetActivityInfo(rdId, controlid, eventType);
            if (entity == null)
            {
                return "{\"result\": \"False\", \"message\": \"添加失败,状态发生变化,请刷新再添加\" }";
            }

            FunctionExecStepInfo stepinfo = new FunctionExecStepInfo();
            stepinfo.LogicID = -1;
            stepinfo.AC_ID = entity.Id;
            stepinfo.PreLogicID = 0;
            stepinfo.StepName = stepName;
            stepinfo.StepType = stepType;
            stepinfo.StepXml = stepXml;
            stepinfo.DataSourceControlId = sourceCotrolId;
            stepinfo.DataSourceId = datasourceId;

            int stepId = new FunctionExecStep().Edit(stepinfo);
            return "{\"result\": \"True\", \"message\": \"\",\"StepId\":\"" + stepId + "\" }";
        }

        /// <summary>
        /// 删除事件
        /// </summary>
        /// <param name="activityId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string DeleteActivity(string activityId)
        {
            using (TransactionScope ts = new TransactionScope())
            {
                new Activity().Delete(activityId, AccountController.GetCurrentUser().UserName);
                ts.Complete();
            }
            return "{\"result\": \"True\", \"message\": \"\" }";
        }

        /// <summary>
        /// 删除步骤
        /// </summary>
        /// <param name="stepId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string DeleteStep(string stepId)
        {
            FunctionExecStepInfo info = new FunctionExecStep().GetInfo(Convert.ToInt32(stepId));
            if (info != null)
            {
                using (TransactionScope ts = new TransactionScope())
                {
                    new FunctionExecStep().Delete(stepId, AccountController.GetCurrentUser().UserName);

                    ActivityInfo entity = new Activity().GetInfo(info.AC_ID);
                    if (entity != null)
                    {
                        if (new FunctionExecStep().GetInfo(new List<string>() { info.AC_ID.ToString() }).Count == 0)
                        {
                            new Activity().Delete(info.AC_ID.ToString(), AccountController.GetCurrentUser().UserName);
                        }
                    }
                    ts.Complete();
                }
            }
            return "{\"result\": \"True\", \"message\": \"\" }";
        }

        /// <summary>
        /// 获取指定类型控件上的事件
        /// </summary>
        /// <param name="controlsType"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetControlActivity(string controlsType)
        {
            //绑定控件的方法
            SKT.LeanMES.Lookup.BLL.Lookup lookupBll = new SKT.LeanMES.Lookup.BLL.Lookup();
            Dictionary<string, object> condition = new Dictionary<string, object>();
            condition.Add("Alpha1", controlsType);
            List<LookupInfo> lookupInfos = lookupBll.GetLookupByCondition(LookupTableName.SYS_ControlSetting, condition);
            if (lookupInfos != null && lookupInfos.Count > 0)
            {
                return lookupInfos[0].Alpha3;
            }
            return "";
        }

        /// <summary>
        /// 获取所有通用的参数
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string GetDefualtParamters()
        {
            SKT.LeanMES.Lookup.BLL.Lookup lookupBll = new SKT.LeanMES.Lookup.BLL.Lookup();
            List<LookupInfo> lookupInfos = lookupBll.GetLookupByCondition(LookupTableName.SYS_DefualtParamters);
            StringBuilder sbXml = new StringBuilder("<defualts>");
            foreach (LookupInfo lookup in lookupInfos)
            {
                sbXml.AppendLine(string.Format("<defualt Text='{0}' Value='{1}'></defualt>", lookup.Alpha2, lookup.Alpha1));
            }
            sbXml.AppendLine("</defualts>");
            return sbXml.ToString();
        }

        /// <summary>
        /// 转换步骤的排序
        /// </summary>
        /// <param name="stepId"></param>
        /// <param name="OrderType"></param>
        [AjaxMethod]
        public bool ChangeOrderId(int stepId, string OrderType)
        {
            FunctionExecStep stepBLL = new FunctionExecStep();
            stepBLL.ChangeOrderId(stepId, OrderType);
            return true;
        }

        /// <summary>
        /// 检查工序有没有配置模板
        /// </summary>
        /// <param name="operationId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string CheckStationHasModel(Int64 operationId)
        {
            SearchSettings s = new SearchSettings();
            s.AddCondition("StationId", operationId.ToString());
            s.IsMatchWholeWord = true;
            List<SKT.LeanMES.ClientConfig.Model.PopedomInStationInfo> ss = (new SKT.LeanMES.ClientConfig.BLL.PopedomInStation()).GetAll(0, 10, "PopedomInStationId", s);
                        
            if (ss.Count > 0)
            {
                if (ss[0].Popedom < 80010000)
                {
                    UIModel uiModel = new UIModel();
                    UIModelInfo entity = uiModel.GetInfo(ss[0].Popedom);
                    
                    if (entity.ModelType == 2)
                    {
                        return "Defualt";
                    }
                    else
                    {
                        return "UserSetting";
                    }                     
                }
                else
                {                     
                    return "Defualt";   
                }
            }
            else
            {
                return "False";
            }
        }

        /// <summary>
        /// 检查模型是否被使用
        /// </summary>
        /// <param name="modelId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public bool CheckModelIsUsed(int modelId)
        {
            SearchSettings s = new SearchSettings();
            s.AddCondition("Popedom", modelId.ToString());
            s.IsMatchWholeWord = true;
            List<SKT.LeanMES.ClientConfig.Model.PopedomInStationInfo> ss = (new SKT.LeanMES.ClientConfig.BLL.PopedomInStation()).GetAll(0, 10, "PopedomInStationId", s);
            if (ss.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }


        int icount = 0;
        /// <summary>
        /// 用于ChoosePage选择model，不需要AjaxMethod标识
        /// </summary>
        /// <returns>结果包含用户创建的model和内置的UI模板</returns>
        public List<UIModelInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            UIModel model = new UIModel();
            List<UIModelInfo> tempmodelList = model.GetAll();
            tempmodelList.ForEach(k =>
            {
                k.Content = "自定义";
            });

            SKT.Common.Framework.BLL.Page bll = new Common.Framework.BLL.Page();
            List<PageInfo> models = bll.GetPagesByModule("Product_CollectionTemplate", false);
            try
            {
                foreach (PageInfo item in models)
                {
                    UIModelInfo uimodel = new UIModelInfo() { Content = "系统内置", ModelId = item.Popedom };
                    if (HttpContext.GetGlobalResourceObject("Popedom", item.Name) == null)
                    {
                        uimodel.ModelName = item.Name;
                    }
                    else
                    {
                        uimodel.ModelName = HttpContext.GetGlobalResourceObject("Popedom", item.Name).ToString();
                    }
                    tempmodelList.Insert(0, uimodel);
                }
            }
            catch (Exception ex) { return null; }
            List<UIModelInfo> modelList = tempmodelList;
            string[] modelName = searchSettings.ExtensionCondition.Split(new char[] { '%' });

            if (modelName.Length == 3)
            {
                modelList = tempmodelList.Where(kk => kk.ModelName.Contains(modelName[1])).ToList();
            }
            icount = modelList.Count;

            modelList = modelList.Skip(startRow).Take(maxRows).ToList();
            return modelList;
        }

        public List<UIModelInfo> GetPDAAllModel(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            UIModel model = new UIModel();
            List<UIModelInfo> tempmodelList = model.GetAllTempModel();

            icount = tempmodelList.Count;

            tempmodelList = tempmodelList.Skip(startRow).Take(maxRows).ToList();
            return tempmodelList;
        }

        [AjaxMethod]
        public Int64 SavePDAPreview(string Content)
        {
            UIModel model = new UIModel();
            return model.SavePDAPreview(Content);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return icount;
        }

        #region 用户自定义HTML二次开发

        /// <summary>
        /// 获取模板信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [AjaxMethod]
        public UIModelInfo GetUIModel(int id)
        {
            UIModelInfo entity = new UIModelInfo();
            try
            {
                UIModel uiBll = new UIModel();
                entity = uiBll.GetInfo(id);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 保存用户自定义HTML代码
        /// </summary>
        /// <param name="id"></param>
        /// <param name="uiName"></param>
        /// <param name="template"></param>
        /// <param name="stationId"></param>
        [AjaxMethod]
        public void UDFSave(int id, string uiName, string template, string className, int stationId,int popedomId)
        {
            UIModel uiBll = new UIModel();
            var createBy = AccountController.GetCurrentUser().UserName;
            try
            {               
                uiBll.UDFSave(id, uiName, template, className, stationId, createBy,popedomId);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public UIModelInfo GetModelTempInfo(int TempId )
        {
            UIModel uiBll = new UIModel();
            UIModelInfo info = uiBll.GetModelTempInfo(TempId);
            info.Content = info.Content;
            return info;
        }

        /// <summary>
        /// 执行存储过程 获取Output参数返回值
        /// </summary>
        /// <param name="procName"></param>
        /// <param name="jsonParams"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<string> ExecUDFProc(string procName,string jsonParams)
        {
            List<string> list = new List<string>();
            UIModel uiBll = new UIModel();
            try
            {
                list = uiBll.ExecProc(procName, jsonParams);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// UI调用查询并返回JSON字符串结果
        /// </summary>
        /// <param name="procName">表/视图/存储过程的名称</param>
        /// <param name="fieldStr">对表/视图有效</param>
        /// <param name="conditionStr">对表/视图有效</param>
        /// <param name="jsonParams">对存储过程有效</param>
        /// <returns></returns>
        [AjaxMethod]
        public string Search(string procName, string fieldStr, string conditionStr, string jsonParams)
        {
            UIModel uiBll = new UIModel();
            string reslut = "";
            try
            {
                reslut = uiBll.Search(procName,fieldStr,conditionStr,jsonParams);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return reslut;
        }
        
        /// <summary>
        /// 获取内置UI的地址
        /// </summary>
        /// <param name="popedom"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetTemplateUrl(string popedom)
        {
            UIModel uiBll = new UIModel();
            string url = "";
            try
            {
                url = uiBll.GetTemplateUrl(popedom);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return url;
        }
        #endregion

        /// <summary>
        /// 执行SQL语句
        /// </summary>
        /// <param name="sql"></param>
        [AjaxMethod]
        public void ExecuteSql(string sql)
        {
            try
            {
                SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, sql, null);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 执行SQL语句
        /// </summary>
        /// <param name="sql"></param>
        [AjaxMethod]
        public string ExecuteSqlSearch(string sql)
        {
            string json = "";
            try
            {
                DataTable dt = CommonHelper.BLL.ComMethod.GetListDataSetBySql(sql, null).Tables[0];
                if (dt.Rows.Count > 0)
                {
                    json = UIModel.ToJson(dt);
                }
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return json;
        }

        [AjaxMethod]
        public DataTable GetTable(string procName, string xml)
        {
            try
            {
                return new UIModel().GetTable(procName, xml);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        [AjaxMethod]
        public string Edit(string procName, string setXml, string whereXml)
        {
            try
            {
                return new UIModel().Edit(procName, setXml, whereXml);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// 获取内置UI的地址
        /// </summary>
        /// <param name="popedom"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetTemplateContent(string id)
        {
            try
            {
                SearchSettings ss = new SearchSettings();
                ss.AddCondition("ModelId", id);
                List<UIModelInfo> list = new UIModel().GetAll(0, Int32.MaxValue, "ModelId", ss);
                if (list == null || list.Count == 0)
                    return "";
                return list[0].Content;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return "";
        }

    }
}