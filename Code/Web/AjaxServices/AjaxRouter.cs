using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using Newtonsoft.Json;
using SKT.LeanMES.Router.BLL;
using SKT.LeanMES.Router.Model;


namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxRouter
    {
        [AjaxMethod]
        public Int32 EditRouter(RouterInfo entity, string itemIdString)
        {
            Int32 routerId = -1;
            try
            {
                if (entity.R_ID == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                routerId = new SKT.LeanMES.Router.BLL.Router().Edit(entity, itemIdString);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return routerId;
        }

        [AjaxMethod]
        public List<RouterInfo> GetItemBind(int rId)
        {
            List<RouterInfo> routerInfo = new List<RouterInfo>();
            try
            {
                routerInfo = new SKT.LeanMES.Router.BLL.Router().GetItemBindByRId(rId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return routerInfo;
        }

        /// <summary>
        /// zhibin.chen 2016-03-08 获取与此路由建立关系的工单
        /// </summary>
        /// <param name="rId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<String> GetOrderBind(int rId)
        {
            List<String> order = new List<String>();
            try
            {
                order = new SKT.LeanMES.Router.BLL.Router().GetOrderBind(rId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return order;
        }


        [AjaxMethod]
        public RouterInfo GetLayout(int rId)
        {
            RouterInfo routerInfo = new RouterInfo();
            try
            {
                routerInfo = new SKT.LeanMES.Router.BLL.Router().GetLayout(rId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return routerInfo;
        }

        [AjaxMethod]
        public void UpdateLayout(int rid, string json, string linkString)
        {
            try
            {
                new SKT.LeanMES.Router.BLL.Router().UpdateLayout(rid, json, linkString, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public void UpdateLayoutNew(int rid, string json, string linkString)
        {
            try
            {
                new SKT.LeanMES.Router.BLL.Router().UpdateLayoutNew(rid, json, linkString, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void CreateLayout(int selectR_Id, int R_id)
        {
            try
            {
                new SKT.LeanMES.Router.BLL.Router().CreateLayout(selectR_Id, R_id);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public bool OperationIsInRouter(int operationId, int routerId)
        {
            bool isInRouter = false;
            try
            {
                isInRouter = (new SKT.LeanMES.Router.BLL.Router()).OperationIsInRouter(operationId, routerId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return isInRouter;
        }

        [AjaxMethod]
        public List<ActivityInfo> LoadRouterActivity(int operationId, int routerId)
        {
            List<ActivityInfo> list = null;
            try
            {
                list = (new SKT.LeanMES.Router.BLL.Router()).GetRouterActivities(operationId, routerId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public List<ActivityInfo> GetRutActOptionsByActId(int actId, int operationId, int routerId)
        {
            List<ActivityInfo> list = null;
            try
            {
                list = (new SKT.LeanMES.Router.BLL.Router()).GetRutActOptionsByActId(actId, operationId, routerId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public void AddRouterActivity(int acId, int routerId, int operationId)
        {
            try
            {
                (new SKT.LeanMES.Router.BLL.Router()).AddRouterActivity(acId, routerId, operationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void DeleteRouterActivity(int acId, int operationId, int routerId)
        {
            try
            {
                (new SKT.LeanMES.Router.BLL.Router()).DeleteRouterActivity(acId, operationId, routerId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void SortRouterActivity(int acId, int operationId, int routerId, int up)
        {
            try
            {
                (new SKT.LeanMES.Router.BLL.Router()).SortRouterActivity(acId, operationId, routerId, up);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public bool CheckOperationPopedom(int operationId)
        {
            bool bResult = false;
            try
            {
                Common.Model.SearchSettings set = new Common.Model.SearchSettings();
                set.AddCondition("StationId", operationId.ToString());
                List<SKT.LeanMES.ClientConfig.Model.PopedomInStationInfo> popedomList = (new SKT.LeanMES.ClientConfig.BLL.PopedomInStation()).GetAll(0, 100, "PopedomInStationId", set);
                if (popedomList.Count > 0)
                {
                    bResult = true;
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return bResult;
        }

        [AjaxMethod]
        public SKT.LeanMES.ClientConfig.Model.RouteDetailSetting GetRouteOperationSetting(int routerId, int operationId)
        {
            SKT.LeanMES.ClientConfig.Model.RouteDetailSetting setting = null;
            try
            {
                setting = (new SKT.LeanMES.ClientConfig.BLL.PopedomInStation()).GetRouteOperationSetting(routerId, operationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return setting;
        }

        [AjaxMethod]
        public void SaveRouterActivityValue(string routerActIdStr, string routerActValueStr)
        {
            try
            {
                (new SKT.LeanMES.Router.BLL.Router()).SaveRouterActivityValue(routerActIdStr, routerActValueStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 删除路由前，判断该路由相关的工单是否完全释放
        /// </summary>
        /// <param name="idString">ROUTERId 字符串。</param>
        /// <returns>日志内容。</returns>
        [AjaxMethod]
        public int uspIsAllReleased(String idString)
        {
            try
            {
                return (new SKT.LeanMES.Router.BLL.Router()).uspIsAllReleased(idString);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }


        /// <summary>
        /// 删除路由前，判断该路由是否存在建立关系的产品或者工单。
        /// zhibin.chen 2016-03-08
        /// </summary>
        [AjaxMethod]
        public void CheckRouterIsBindItemOrOrder(int routerId)
        {
            try
            {
                (new SKT.LeanMES.Router.BLL.Router()).CheckRouterIsBindItemOrOrder(routerId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// zhibin.chen 2016-02-29  判断所绑定的产品中，是否存在
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="rId">路由</param>
        /// <returns></returns>
        [AjaxMethod]
        public int CheckedItemIsBindOtherRouter(Int32 itemId, Int32 rId)
        {
            try
            {
                return (new SKT.LeanMES.Router.BLL.Router()).CheckedItemIsBindOtherRouter(itemId, rId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }

        /// <summary>
        /// SMT的扣料设置
        /// </summary>
        /// <param name="rId">路由</param>
        /// <param name="stationId">工位</param>
        /// <param name="smtDeduct">扣料设置</param>
        [AjaxMethod]
        public void SetSMTDeduct(int rId, int stationId, SKT.LeanMES.ClientConfig.Model.RouteDetailSetting entity, string smtDeductFace)
        {
            try
            {
                Dictionary<string, object> dic = new Dictionary<string, object>();
                dic.Add("Alpha1", rId);
                dic.Add("Alpha2", stationId);
                Lookup.BLL.Lookup lookupBll = new Lookup.BLL.Lookup();
                List<Lookup.Model.LookupInfo> lookupInfo = lookupBll.GetLookupByCondition("SYS_RouteDetailSetting", dic);

                //空的时候新增，有了就修改
                if (lookupInfo.Count == 0)
                {
                    Lookup.Model.LookupInfo info = new Lookup.Model.LookupInfo()
                    {
                        Id = -1,
                        TabaleName = "SYS_RouteDetailSetting",
                        Alpha1 = rId.ToString(),
                        Alpha2 = stationId.ToString(),
                        Alpha3 = entity.DefualtDeduct.ToString(),
                        Alpha4 = entity.DefualtOpenLine.ToString(),
                        Alpha5 = entity.DefualtPrintCS.ToString(),
                        Alpha6 = entity.DefualtPrintPack.ToString(),
                        Alpha7 = entity.DefualtUseElecScale.ToString(),
                        Alpha8 = entity.DefualtPrintPallet.ToString(),
                        Alpha9 = entity.DefualtRepairReceive.ToString(),
                        Alpha10 = entity.DefualtSteelCheck.ToString(),
                        Alpha11 = entity.DefualtKnifeCheck.ToString(),
                        Alpha12 = entity.DefualtSplitPane.ToString(),
                        Alpha13 = entity.DefualtPickDeduct.ToString(),
                        Alpha14 = entity.DefualtInputStation.ToString(),
                        Alpha15 = entity.DefualtOutputStation.ToString(),
                        Alpha16 = entity.DefualtSMTAInputStation.ToString(),
                        Alpha17 = entity.DefualtSMTAOutputStation.ToString(),
                        Alpha18 = entity.DefualtSMTBInputStation.ToString(),
                        Alpha19 = entity.DefualtSMTBOutputStation.ToString(),
                        AlphaM21 = entity.DefualtPickOpenLine.ToString(),
                        AlphaM22 = entity.IfPrint.ToString(),
                        AlphaM23 = entity.GroupCode.ToString(),
                        AlphaM24 = entity.OSPWeldCheck.ToString(),
                        AlphaM25 = entity.OSPWaveSolderingCheck.ToString(),
                        AlphaM26 = entity.SampleExame.ToString(),
                        AlphaM27 = entity.PQCInspect.ToString(),
                        AlphaM28 = smtDeductFace,
                        AlphaM29 = entity.UpModel.ToString(),
                        Creator = AccountController.GetCurrentUser().UserName,
                        CreateDate = DateTime.Now,
                        Modifier = AccountController.GetCurrentUser().UserName,
                        ModifyDate = DateTime.Now
                    };
                    lookupBll.Edit(info);
                }
                else
                {
                    lookupInfo[0].Alpha3 = entity.DefualtDeduct.ToString();
                    lookupInfo[0].Alpha4 = entity.DefualtOpenLine.ToString();
                    lookupInfo[0].Alpha5 = entity.DefualtPrintCS.ToString();
                    lookupInfo[0].Alpha6 = entity.DefualtPrintPack.ToString();
                    lookupInfo[0].Alpha7 = entity.DefualtUseElecScale.ToString();
                    lookupInfo[0].Alpha8 = entity.DefualtPrintPallet.ToString();
                    lookupInfo[0].Alpha9 = entity.DefualtRepairReceive.ToString();
                    lookupInfo[0].Alpha10 = entity.DefualtSteelCheck.ToString();
                    lookupInfo[0].Alpha11 = entity.DefualtKnifeCheck.ToString();
                    lookupInfo[0].Alpha12 = entity.DefualtSplitPane.ToString();
                    lookupInfo[0].Alpha13 = entity.DefualtPickDeduct.ToString();
                    lookupInfo[0].Alpha14 = entity.DefualtInputStation.ToString();
                    lookupInfo[0].Alpha15 = entity.DefualtOutputStation.ToString();
                    lookupInfo[0].Alpha16 = entity.DefualtSMTAInputStation.ToString();
                    lookupInfo[0].Alpha17 = entity.DefualtSMTAOutputStation.ToString();
                    lookupInfo[0].Alpha18 = entity.DefualtSMTBInputStation.ToString();
                    lookupInfo[0].Alpha19 = entity.DefualtSMTBOutputStation.ToString();
                    lookupInfo[0].AlphaM21 = entity.DefualtPickOpenLine.ToString();
                    lookupInfo[0].AlphaM22 = entity.IfPrint.ToString();
                    lookupInfo[0].AlphaM23 = entity.GroupCode.ToString();
                    lookupInfo[0].AlphaM24 = entity.OSPWeldCheck.ToString();
                    lookupInfo[0].AlphaM25 = entity.OSPWaveSolderingCheck.ToString();
                    lookupInfo[0].AlphaM26 = entity.SampleExame.ToString();
                    lookupInfo[0].AlphaM27 = entity.PQCInspect.ToString();
                    lookupInfo[0].AlphaM28 = smtDeductFace;
                    lookupInfo[0].AlphaM29 = entity.UpModel.ToString();

                    lookupInfo[0].Modifier = AccountController.GetCurrentUser().UserName;
                    lookupInfo[0].ModifyDate = DateTime.Now;
                    lookupBll.Edit(lookupInfo[0]);
                }
                //}
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void ImportRouter(string DrawingNo, string Version, string AttributionCode, string CreateBy, string BomChildJson)
        {
            try
            {
                new SKT.LeanMES.Router.BLL.Router().ImportRouter(DrawingNo, Version, AttributionCode, CreateBy, BomChildJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public RouterInfo GetRouterInfo(int id)
        {
            return new SKT.LeanMES.Router.BLL.Router().GetInfo(id);
        }

    }
}
