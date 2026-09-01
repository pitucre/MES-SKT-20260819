using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.SPC.Model;
using SKT.LeanMES.SPC.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{     
    public class AjaxSPC
    {
        /// <summary>
        /// 编辑SPC项目
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void SPCProjectEdit(SPCProjectInfo entity)
        {
            SPCProject bll = new SPCProject();
            try
            {
                if (entity.SPCProjectId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.CreateBy = "";
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                }

                bll.Edit(entity);
            }
            catch (Exception ex)
            {
               WebHelper.HandleException(ex);                
            }
        }

        /// <summary>
        /// 编辑SPC任务信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void SPCTaskEdit(SPCTaskInfo entity)
        {
            SPCTask bll = new SPCTask();
            try
            {
                if (entity.SPCTaskId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.CreateBy = "";
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                }

                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取任务、项目信息
        /// </summary>
        /// <param name="spcTaskId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public SPCGraphInfo GetGraphInfo(int spcTaskId)
        {
            SPCGraphInfo entity =  new SPCGraphInfo();
            SPCGraph bll = new SPCGraph();
            try
            {
                entity = bll.GetGraphInfo(spcTaskId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 返回XbarR图表数据
        /// </summary>
        /// <param name="spcTaskId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetXbarRGraphData(int spcTaskId, int spliceQty)
        {
            SPCGraph bll = new SPCGraph();
            try
            {
                return bll.GetXbarRGraphData(spcTaskId, spliceQty);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="spcTaskId"></param>
        /// <param name="spcWarnMsg"></param>
        /// <param name="warnProc"></param>
        [AjaxMethod]
        public void XbarRGraphWarn(int spcTaskId, string spcWarnMsg, string warnProc)
        {
            SPCGraph bll = new SPCGraph();
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                bll.XbarRGraphWarn(spcTaskId, spcWarnMsg, warnProc, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取PChart数据源
        /// </summary>
        /// <param name="spcTaskId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SPCPChartInfo> GetNPChartGraphData(int spcTaskId)
        {
            List<SPCPChartInfo> list = new List<SPCPChartInfo>();
            SPCGraph bll = new SPCGraph();
            try
            {
                list = bll.GetNPChartGraphData(spcTaskId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取UChart数据源
        /// </summary>
        /// <param name="spcTaskId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SPCPChartInfo> GetUChartGraphData(int spcTaskId)
        {
            List<SPCPChartInfo> list = new List<SPCPChartInfo>();
            SPCGraph bll = new SPCGraph();
            try
            {
                list = bll.GetUChartGraphData(spcTaskId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 编辑预警信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void SPCWarnEdit(SPCWarnInfo entity)
        {
            SPCWarn bll = new SPCWarn();
            try
            {
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #region SPC测试录入数据
        /// <summary>
        /// 保存SPC测试录入数据信息
        /// add by peter on 2018-10-8 ,用于SPC取数
        /// </summary>
        [AjaxMethod]
        public string SaveSpcTestData(string OrderNo, string ItemCode, string TaskName, string txtRemark, int TestWay,
            string userName, string TestValue, string TestResult, int sampleGroupNum)
        {
            string strValue = "";
            SPCTask bll = new SPCTask();
            try
            {
                strValue = bll.SaveSpcTestData(OrderNo, ItemCode, TaskName,
                    txtRemark, TestWay, userName, TestValue, TestResult, sampleGroupNum);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strValue;
        }

        /// <summary>
        /// 显示SPC录入的数据信息
        /// </summary>
        /// <param name="IqcNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SPCTaskInfo> GetSpcTestDataList(string ItemCode, string txtTaskName)
        {
            SPCTask bll = new SPCTask();
            List<SPCTaskInfo> list = new List<SPCTaskInfo>();
            try
            {
                list = bll.GetSpcTestDataList(ItemCode, txtTaskName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 删除SPC信息
        /// </summary>
        /// <param name="id"></param>
        [AjaxMethod]
        public void DelSpcById(int id)
        {
            SPCTask bll = new SPCTask();
            try
            {
                bll.DelSpcById(id);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 通过验证输入的的不良代码，并返回启不良ID
        /// </summary>
        /// <param name="nccode">不良代码</param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetNcCodeId(string nccode)
        {
            string str = "";
            SPCTask bll = new SPCTask();
            try
            {
                str = bll.GetNcCodeId(nccode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        ///  //获取当前已扫描的样本数
        /// </summary>
        /// <param name="nccode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int GetScanGroupNum(string ItemCode, string taskName, string sampleGroup)
        {
            int num = 0;
            SPCTask bll = new SPCTask();
            try
            {
                num = bll.GetScanGroupNum(ItemCode, taskName, sampleGroup);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return num;
        }
        #endregion
    }
}