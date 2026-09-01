using AjaxPro;
using Newtonsoft.Json;
using SKT.Common.Model;
using SKT.LeanMES.Labels.BLL;
using SKT.LeanMES.Labels.Model;
using SKT.LeanMES.Labels.Pdf;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.SerialNumber.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxPrint
    {
        /// <summary>
        /// 获取返回的ZPL内容
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public String returnZplContent(Int32 labelDocumentId, String SN, Int32 stationId, Int32 resId, Int32 lineId, Int32 itemId, Int32 woId)
        {
            String labelContent = "";
            int count = 0;
            try
            {
                string[] rs = new SKT.LeanMES.Labels.BLL.LabelPrint().returnLabelContent(labelDocumentId, SN, stationId, resId, lineId, itemId, woId);
                labelContent = rs[0];
                count = Convert.ToInt32(rs[1]);
                labelContent = new SKT.LeanMES.Print.BLL.LabelConvertCH().ConvertCH(labelContent, count);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return labelContent;
        }

        /// <summary>
        /// 根据对应数据返回 标签的Lab信息。
        /// </summary>
        /// <returns>ZPL标签内容和Lab文件路径。</returns>
        [AjaxMethod]
        public List<LabelDocumentInfo> returnLabelInfoForLab(Int32 lableDocumentId, String SN, Int32 stationId, Int32 resId, Int32 lineId, Int32 itemId, Int32 woId)
        {
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();

            try
            {
                list = new SKT.LeanMES.Labels.BLL.LabelPrint().returnLabelInfoForLab(lableDocumentId, SN, stationId, resId, lineId, itemId, woId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return list;
        }
        /// <summary>
        /// 根据对应数据返回 标签的Lab信息。
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string returnLabelInfo(Int32 lableDocumentId, List<string> sn, Int32 stationId, Int32 resId, Int32 lineId, Int32 itemId, Int32 woId)
        {
            try
            {
                Guid guid = Guid.NewGuid();
                List<LabelDocumentInfo> list = new SKT.LeanMES.Labels.BLL.LabelPrint().returnLabelInfo(lableDocumentId, sn, stationId, resId, lineId, itemId, woId);

                if (list == null)
                    return "";
                List<PrintDataInfo> pd = new List<PrintDataInfo>();
                //int index = 0;
                //PrintDataInfo info = null;
                //foreach (var item in list)
                //{
                //    if (index < item.ProdOrderId)
                //    {
                //        index++;
                //        info = new PrintDataInfo() { LabelContent = new List<PrintKeyValue>() };
                //        pd.Add(info);
                //    }
                //    info.LabelContent.Add(new PrintKeyValue { name = item.LabelName, value = item.LabelValue });
                //}
                //修复序号不连续可能导致的BUG modify by xiongyz 2023-04-20
                var listGroup = from a in list
                                group a by a.ProdOrderId into newGroup
                                orderby newGroup.Key
                                select newGroup;
                foreach (var group in listGroup)
                {
                    var info = new PrintDataInfo() { LabelContent = new List<PrintKeyValue>() };
                    foreach (var item in group)
                    {
                        info.LabelContent.Add(new PrintKeyValue { name = item.LabelName, value = item.LabelValue });
                    }
                    pd.Add(info);

                }
                if (pd.Count == 0)
                {
                    //说明没有设置key
                    sn.ForEach(a =>
                    {
                        //添加页，但是不添加key value
                        pd.Add(new PrintDataInfo() { LabelContent = new List<PrintKeyValue>() });
                    });
                }
                new PrintTemplate().AddPrintData(guid, lableDocumentId, Newtonsoft.Json.JsonConvert.SerializeObject(pd));
                //调试日志
                //检测数据错误
                if (pd.Count > 0)
                {
                    int filedCount = pd.First().LabelContent.Count;
                    int index = 1;
                    bool isError = false;
                    pd.ForEach(p =>
                    {
                        if (filedCount != p.LabelContent.Count)
                        {
                            Log4Helper.Info($"List<PrintDataInfo> 检测到数据错误，错误数据下标为{index}");
                            isError = true;
                        }
                        index++;
                    });
                    if (isError)
                    {
                        Log4Helper.Info($"List<LabelDocumentInfo>：{JsonConvert.SerializeObject(list)}");
                        Log4Helper.Info($"List<PrintDataInfo>：{JsonConvert.SerializeObject(pd)}");
                    }
                }
                return guid.ToString() + "," + HttpContext.Current.Session.SessionID;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return "";
        }
        /// <summary>
        ///获取documentid,连板数量,打印机名称 
        /// </summary>
        [AjaxMethod]
        public LabelDocumentInfo GetLabelDocumentInfo(Int32 itemId, Int32 stationId, Int32 typeId, Int32 sequence)
        {
            LabelDocumentInfo entity = null;
            try
            {
                entity = new SKT.LeanMES.Labels.BLL.LabelPrint().GetLabelDocumentInfo(itemId, stationId, typeId, sequence);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }
        /// <summary>
        /// 根据名称获取标签文档集合
        /// </summary>
        /// <param name="tempName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<LabelDocumentInfo> GetLabelDocumentListByName(string name)
        {
            List<LabelDocumentInfo> list = null;
            try
            {
                SearchSettings searchSettings = new SearchSettings();
                if (!string.IsNullOrWhiteSpace(name))
                {
                    searchSettings.AddCondition("DocumentName", name);
                }
                list = new LabelDocument().GetAll(0, -1, "", searchSettings);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        ///获取documentid,连板数量,打印机名称 
        /// </summary>
        [AjaxMethod]
        public List<LabelDocumentInfo> GetLabelDocumentInfo2(Int32 itemId, Int32 stationId, Int32 typeId, Int32 sequence)
        {
            List<LabelDocumentInfo> entity = null;
            try
            {
                entity = new SKT.LeanMES.Labels.BLL.LabelPrint().GetLabelDocumentInfo2(itemId, stationId, typeId, sequence);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        ///获取documentid,连板数量
        /// </summary>
        [AjaxMethod]
        public int GetPrintTemplateGroup(int documentId)
        {
            int group = 1;
            try
            {
                LabelDocumentInfo label = new LabelDocument().GetInfo(documentId);
                PrintTemplateInfo en = new PrintTemplate().GetEnityByTempId(label.TemplateID);
                List<PrintTemplateDtl> templist = Newtonsoft.Json.JsonConvert.DeserializeObject<List<PrintTemplateDtl>>(en.TempSet);
                group = templist.Max(item => item.group);
                if (group <= 0)
                    group = 1;
            }
            catch (Exception)
            {

            }
            return group;
        }
        /// <summary>
        ///获取documentid,连板数量,打印机名称 
        /// </summary>
        [AjaxMethod]
        public List<LabelDocumentInfo> GetPackLabelDocumentInfo(string packSN)
        {
            List<LabelDocumentInfo> list = null;
            try
            {
                list = new SKT.LeanMES.Labels.BLL.LabelPrint().GetLabelDocumentInfo(packSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public List<LabelDocumentInfo> GetLabelDocumentInfoBySn(string sn, Int32 stationId, Int32 typeId, Int32 sequence)
        {
            List<LabelDocumentInfo> list = null;
            try
            {
                var itemId = new Order.BLL.ShopOrder().GetInfoBySerialNumber(sn).ItemId;
                list = new SKT.LeanMES.Labels.BLL.LabelPrint().GetLabelDocumentInfo2(itemId, stationId, typeId, sequence);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 调用存储过程
        /// </summary>
        /// <param name="strSpName">存储过程</param>
        /// <param name="strJson">参数Json字串</param>
        /// <returns>strJson</returns>
        [AjaxMethod]
        public string ExecuteSpc(String strSpcName, string strJson)
        {
            //解密存储过程名称
            return (new PubItems.BLL.PubItems()).ExecSpc(strSpcName, strJson);
        }

        /// <summary>
        /// 保存打印记录
        /// </summary>
        /// <param name="entity">打印记录</param>
        [AjaxMethod]
        public void RecodePrint(PrintRecordInfo entity)
        {
            try
            {
                PrintRecord bll = new PrintRecord();
                entity.PrintUser = AccountController.GetCurrentUser().UserName;
                entity.PrintTime = DateTime.Now;
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
         

        [AjaxMethod]
        public int GetTempCount(int LabelDocumentId)
        {
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();
            try
            {
                return new SKT.LeanMES.Labels.BLL.LabelPrint().GetTempCount(LabelDocumentId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return 0;

        }
        #region 根据路由和工位获取是否需要自动打印条码
        /// <summary>
        /// 根据路由和工位获取是否需要自动打印条码
        /// </summary>
        /// <param name="routerId">路由IF</param>
        /// <param name="operationId">工位ID</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<LabelDocumentInfo> GetPrintDocumentList(int stationId, string scanSN, bool isCheckRouter,int labelType)
        {
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();
            try
            {
                list = new SKT.LeanMES.Labels.BLL.LabelPrint().GetPrintDocumentList(stationId, scanSN, isCheckRouter, labelType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

    }
}