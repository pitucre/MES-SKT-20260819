using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.ProductionCollection.Client;
using System.Data;
using SKT.LeanMES.ProductionCollection.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    /******************************************************************************************
     * 类名：AjaxAssemble      
     * 功能描述：此类主要应用于开发内置UI类型为【组装】的Ajax方法
     * 创建人：zhiman.yuan
     * 创建时间：2017-7-3
     * 修改人：
     * 修改时间：
     ******************************************************************************************/
    public class AjaxAssemble
    {
        #region 自制部件组装

        /// <summary>
        /// 组装在线SN(自制产品)及GRN
        /// </summary>
        /// <param name="sn">部件条码</param>
        /// <param name="mainSN">主件条码</param>
        /// <param name="userId">用户ID</param>
        /// <param name="stationId">工序ID</param>
        /// <param name="resId">资源ID</param>
        [AjaxMethod]
        public void AssyDataActivity(string sn, string mainSN, int stationId, int resId)
        {
            ProdCollectionAssemble assembleBll = new ProdCollectionAssemble();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                assembleBll.AssyDataActivity(sn, mainSN, stationId, resId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取当前SerialNumber对应的当前站位的装配信息列表及当前应扫描的信息提醒
        /// </summary>
        /// <param name="serialNumber"></param>
        /// <param name="stationId">当前站位id</param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetAssembleList(string serialNumber, int stationId)
        {
            ProdCollectionAssemble assembleBll = new ProdCollectionAssemble();
            DataTable dtpcb = assembleBll.GetAssembleList(serialNumber, stationId);
            DataTable offlineDt = assembleBll.GetOfflineSNList(serialNumber, stationId);

            if (offlineDt.Rows.Count > 0)
            {
                dtpcb.Merge(offlineDt);
            }

            DataTable dt = new DataTable();
            dt.Columns.Add("id", typeof(string));
            dt.Columns.Add("text", typeof(string));
            dt.Columns.Add("hasChildren", typeof(string));
            dt.Columns.Add("isexpand", typeof(string));
            dt.Columns.Add("ChildNodes", typeof(string));

            //dt.Columns.Add("value", typeof(string));
            string currScanTips = "";
            string mainInfo = "";
            for (int i = 0; i < dtpcb.Rows.Count; i++)
            {
                if (i == 0)
                {
                    //设置tree head信息
                    mainInfo = dtpcb.Rows[i]["MainItemCode"].ToString();// +","
                    // + dtpcb.Rows[i]["MainItemName"].ToString();
                }
                DataRow dr = dt.NewRow();
                dr["id"] = dtpcb.Rows[i]["AssSequence"].ToString();
                dr["hasChildren"] = "true";
                dr["isexpand"] = "true";
                if (Convert.ToDecimal(dtpcb.Rows[i]["HasCompCount"]) < Convert.ToDecimal(dtpcb.Rows[i]["CompCount"]))
                {
                    dr["text"] = "<b><font color=red>" + dtpcb.Rows[i]["ItemCode"].ToString() //+ ","
                                                                                              // + dtpcb.Rows[i]["ItemName"].ToString()
                            + "(" + dtpcb.Rows[i]["HasCompCount"].ToString() + " of " + Math.Round(Convert.ToDecimal(dtpcb.Rows[i]["CompCount"]), 0, MidpointRounding.AwayFromZero) + ")</font></b>";
                }
                else
                {
                    dr["text"] = "<b><font color=green>" + dtpcb.Rows[i]["ItemCode"].ToString()
                            + "(" + dtpcb.Rows[i]["HasCompCount"].ToString() + " of " + Math.Round(Convert.ToDecimal(dtpcb.Rows[i]["CompCount"]), 0, MidpointRounding.AwayFromZero) + ")</font></b>";
                }


                var childStr = "[";

                if (dtpcb.Rows[i]["FieldValue"].ToString().Length > 0)
                {
                    //显示已扫描进入的sn，逗号分隔符
                    string[] fileValueList = dtpcb.Rows[i]["FieldValue"].ToString().Split(',');
                    for (int j = 0; j < fileValueList.Length; j++)
                    {
                        if (fileValueList[j].Trim().Length > 0)//防止显示空值
                        {
                            childStr += @"{""id"":""0" + j + "" + '"' + @",""text"":""<font color=green>" + fileValueList[j] + "</font>\"" + "},";
                        }
                    }
                    childStr = childStr.Substring(0, childStr.Length - 1);
                }

                childStr += "]";
                dr["ChildNodes"] = childStr;
                dt.Rows.Add(dr);
                //判断当前用户应该扫描的信息
                if (currScanTips.Length == 0)
                {
                    if (Convert.ToDecimal(dtpcb.Rows[i]["HasCompCount"].ToString()) < Convert.ToDecimal(dtpcb.Rows[i]["CompCount"].ToString()))
                    {
                        //currScanTips = "请扫描物料" + dtpcb.Rows[i]["ItemCode"].ToString() + ","
                        //    + dtpcb.Rows[i]["ItemName"].ToString() + "的条码";
                        currScanTips = "请扫描条码";
                    }
                }

            }

            string json = "[]";
            if (dt.Rows.Count > 0)
            {
                json = AppCode.Utility.ConvertJson.ToJson(dt);
            }
            return new string[] { json, currScanTips, mainInfo };

        }

        /// <summary>
        /// 根据主件条码获取子件相关信息
        /// </summary>
        /// <param name="mainSN">主件条码</param>
        /// <returns>子件列表信息</returns>
        List<AssyDataPartInfo> partList = new List<AssyDataPartInfo>();

        [AjaxMethod]
        public List<AssyDataPartInfo> GetAssyDataPartInfo(string mainSN, int stationId)
        {
            List<AssyDataPartInfo> subList = new List<AssyDataPartInfo>();
            try
            {
                subList = GetSubAssyDataPartInfo(mainSN, stationId);
                if (subList != null && subList.Count > 0)//兼容维修时可以替换下级工单的部件信息
                {
                    if (stationId == 0)
                    {
                        partList.AddRange(subList);
                        List<AssyDataPartInfo> list = new List<AssyDataPartInfo>();
                        for (int i = 0; i < subList.Count; i++)
                        {
                            if (subList[i].IsOffline == 0)
                            {
                                list = GetAssyDataPartInfo(subList[i].SN, 0);
                                if (list.Count > partList.Count)//有下级组装信息
                                {
                                    partList.AddRange(list);
                                }
                            }
                        }
                    }
                    else
                    {
                        partList.AddRange(subList);
                    }
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return partList;
        }

        /// <summary>
        /// 组装替换
        /// </summary>
        /// <param name="mainSN"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        private List<AssyDataPartInfo> GetSubAssyDataPartInfo(string mainSN, int stationId)
        {
            ProdCollectionAssemble assembleBll = new ProdCollectionAssemble();
            List<AssyDataPartInfo> subList = new List<AssyDataPartInfo>();
            subList = assembleBll.GetAssyDataInfoBySN(mainSN, stationId);
            return subList;
        }
        /// <summary>
        /// 装配解绑
        /// </summary>
        /// <param name="unitAssyDataIds"></param>
        /// <param name="unBindType"></param>
        /// <param name="sn"></param>
        /// <param name="userId"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        [AjaxMethod]
        public void UnBindAssyData(string unitAssyDataIds, int unBindType, string sn, int userId, int opeId, int resId, string isOffline, int ncDataId)
        {
            ProdCollectionAssemble assembleBll = new ProdCollectionAssemble();
            try
            {
                assembleBll.UnBindAssyDataInfo(unitAssyDataIds, unBindType, sn, userId, opeId, resId, isOffline, ncDataId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 根据部件条码获取需要收集的数据信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<AssyDataDetailInfo> GetAssyDataDetailInfo(string sn, string mainSN)
        {
            ProdCollectionAssemble assembleBll = new ProdCollectionAssemble();
            List<AssyDataDetailInfo> list = new List<AssyDataDetailInfo>();
            try
            {
                list = assembleBll.GetAssyDataDetailInfo(sn, mainSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 数据采集详情新增、修改
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="AssyXml"></param>
        [AjaxMethod]
        public void AssyDataDetailEdit(string sn, string AssyXml)
        {
            ProdCollectionAssemble assembleBll = new ProdCollectionAssemble();
            try
            {
                assembleBll.AssyDataDetailEdit(sn, AssyXml);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #endregion

        #region 外购部件组装

        /// <summary>
        /// 获取离线条码采集配置信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<OfflineSNConfigInfo> GetOfflineSNConfig(string sn, int stationId)
        {
            ProdCollectionAssemble assembleBll = new ProdCollectionAssemble();
            List<OfflineSNConfigInfo> list = new List<OfflineSNConfigInfo>();
            try
            {
                list = assembleBll.GetOfflineSNConfig(sn, stationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 检测离线条码是否被组装
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public bool CheckOfflineSNIsAssy(string offlineSN)
        {
            bool flag = false;
            ProdCollectionAssemble assembleBll = new ProdCollectionAssemble();
            try
            {
                flag = assembleBll.CheckOfflineSNIsAssy(offlineSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return flag;
        }
        /// <summary>
        /// 添加离线条码详情信息
        /// </summary>
        /// <param name="offlineSNConfigId"></param>
        /// <param name="mainSN"></param>
        /// <param name="partItemId"></param>
        /// <param name="partSN"></param>
        /// <param name="stationId"></param>
        /// <param name="user"></param>
        [AjaxMethod]
        public void OfflineSNDetailEdit(string mainSN, int stationId, int resId, List<OfflineSNConfigInfo> list)
        {
            ProdCollectionAssemble assembleBll = new ProdCollectionAssemble();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                if (list.Count > 0)
                {
                    var partItemId = "";
                    var partSN = "";
                    var offlineSNConfigId = "";
                    var assyStationId = "";
                    for (int i = 0; i < list.Count; i++)
                    {
                        partItemId += list[i].PartItemId.ToString() + ",";
                        partSN += list[i].PartSN + ",";
                        offlineSNConfigId += list[i].OfflineSNConfigId.ToString() + ",";
                        assyStationId += list[i].StationId.ToString() + ",";
                    }

                    offlineSNConfigId = offlineSNConfigId.Substring(0, offlineSNConfigId.Length - 1);
                    partItemId = partItemId.Substring(0, partItemId.Length - 1);
                    partSN = partSN.Substring(0, partSN.Length - 1);
                    assembleBll.OfflineSNDetailEdit(offlineSNConfigId, mainSN, partItemId, partSN, assyStationId, userName, resId, userId, stationId);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        /// <summary>
        /// 添加离线条码详情信息--组装UI使用
        /// </summary>
        /// <param name="mainSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void OfflineSNDetailEditAssy(string mainSN, int stationId, int resId, OfflineSNConfigInfo entity)
        {
            ProdCollectionAssemble assembleBll = new ProdCollectionAssemble();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                assembleBll.OfflineSNDetailEditAssy(entity.OfflineSNConfigId, mainSN, entity.PartItemId, entity.PartSN, entity.StationId, userName, resId, userId, stationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 烽火投入

        /// <summary>
        ///获取烽火投入 离线条码采集配置信息   
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<OfflineSNConfigInfo> GetInputOfflineSNConfig(string mainSN, int stationId, int resouceId, int prodOrderId)
        {
            ProdCollectionAssemble assembleBll = new ProdCollectionAssemble();
            List<OfflineSNConfigInfo> list = new List<OfflineSNConfigInfo>();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                list = assembleBll.GetInputOfflineSNConfig(mainSN, stationId, resouceId, prodOrderId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 检验烽火投入的离线条码信息
        /// </summary>
        /// <param name="mainSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="userId"></param>
        /// <param name="partType"></param>
        [AjaxMethod]
        public void CheckInputOfflineSN(string mainSN, int stationId, int resouceId, int prodOrderId, string partType, string firstScanSN)
        {
            ProdCollectionAssemble assembleBll = new ProdCollectionAssemble();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                assembleBll.CheckInputOfflineSN(mainSN, stationId, resouceId, prodOrderId, userId,partType, firstScanSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion
    }
}