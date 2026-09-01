using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.ProductionCollection.Client;
using System.Data;
using SKT.LeanMES.ProductionCollection.Model;
using SKT.LeanMES.ProdUnit.Model;
using SKT.LeanMES.ProdUnit.BLL;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.AjaxServices
{
    /******************************************************************************************
     * 类名：AjaxPacking      
     * 功能描述：此类主要应用于开发内置UI类型为【包装】的Ajax方法
     * 创建人：zhiman.yuan
     * 创建时间：2017-7-3
     * 修改人：
     * 修改时间：
     ******************************************************************************************/
    public class AjaxPacking
    {
        #region SMT装箱

        /// <summary>
        /// 
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetSMTPackInfo(string sn)
        {
            string[] smtPackArr = new string[4];
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            try
            {
                smtPackArr = packingBll.GetSMTPackInfo(sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return smtPackArr;
        }

        /// <summary>
        /// 采集SMT包装箱信息
        ///以单个SN过站操作，有拼板的以拼板过站
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="packSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] CollectSMTPackInfo(string sn, string packSN, int stationId, int resId)
        {
            string[] smtPackArr = new string[2];
            int userId = AccountController.GetCurrentUser().UserId;
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            try
            {
                smtPackArr = packingBll.CollectSMTPackInfo(sn, packSN, stationId, resId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return smtPackArr;
        }

        /// <summary>
        ///  修改SMT包装箱状态,解绑包装箱信息
        /// </summary>
        /// <param name="packSN"></param>
        /// <param name="opeType"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        [AjaxMethod]
        public void ChangeSMTPackStatus(string packSN, int opeType, int stationId, int resId)
        {
            int userId = AccountController.GetCurrentUser().UserId;
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            try
            {
                packingBll.ChangeSMTPackStatus(packSN, opeType, stationId, resId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 采集SMT包装箱的不良信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="ncCode"></param>
        [AjaxMethod]
        public void CollectSMTPackNCCode(string sn, int stationId, int resId, string ncCode, bool isPassStation)
        {
            int userId = AccountController.GetCurrentUser().UserId;
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            try
            {
                packingBll.CollectSMTPackNCCode(sn, ncCode, stationId, resId, userId, isPassStation);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 查询拼板是否在当前工序已经采集过不良信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public bool GetSMTPackPanelCollectNCCode(string sn, int stationId)
        {
            bool isPassStation = true;
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            try
            {
                isPassStation = packingBll.GetSMTPackPanelCollectNCCode(sn, stationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return isPassStation;
        }
        /// <summary>
        /// 查询当前包装箱内的产品是否都已完成生产路由，存在未完成的都不可以清空包装箱
        /// </summary>
        /// <param name="packSN"></param>
        [AjaxMethod]
        public void CheckIsSMTPackUnBind(string packSN)
        {
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            try
            {
                packingBll.CheckIsSMTPackUnBind(packSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 清空包装箱
        /// </summary>
        /// <param name="packSN"></param>
        [AjaxMethod]
        public void SMTPackUnBind(string packSN, int stationId, int resourceId)
        {
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                packingBll.SMTPackUnBind(packSN, stationId, resourceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 包装中箱
        /// <summary>
        /// 检查是否需要包装中箱
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public bool GetIsBoxPack(string sn)
        {
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            bool isBoxPack = false;
            try
            {
                isBoxPack = packingBll.GetIsBoxPack(sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return isBoxPack;
        }

        #region 在线打印包装

        /// <summary>
        ///  通过扫描的SN获取包装箱号
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetBoxNumberBySN(string sn, string packSN, int stationId, int resourceId)
        {
            string[] packArr = new string[4];
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                packArr = packingBll.GetBoxNumberBySN(sn, packSN, stationId, resourceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return packArr;
        }

        /// <summary>
        /// 包装产品SN到包装箱内
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="packSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] CollectBoxSN(string sn, string packSN, int stationId, int resourceId)
        {
            string[] packArr = new string[3];
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                packArr = packingBll.CollectBoxSN(sn, packSN, stationId, resourceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return packArr;
        }

        #endregion

        #region 离线打印包装（先打印后包装）

        /// <summary>
        /// 包装产品SN到包装箱内
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="packSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] CollectOfflinePackSN(string sn, string boxSN, string packSN, int stationId, int resourceId)
        {
            string[] packArr = new string[3];
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                packArr = packingBll.CollectOfflinePackSN(sn, boxSN, packSN, stationId, resourceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return packArr;
        }
        #endregion


        #endregion

        #region 包装箱

        /// <summary>
        /// 检验扫描SN顺序
        /// </summary>
        /// <param name="lastSN"></param>
        /// <param name="currentSN"></param>
        [AjaxMethod]
        public void CheckBoxSeq(string lastSN, string currentSN,string packSN)
        {
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            try
            {
                packingBll.CheckBoxSeq(lastSN, currentSN, packSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取箱序号信息
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<string> GetBoxSeq(int prodOrderId)
        {
            List<string> boxSeqArr = new List<string>();
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                boxSeqArr = packingBll.GetBoxSeq(prodOrderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return boxSeqArr;
        }

        /// <summary>
        ///  通过扫描的SN获取包装箱号
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetPackNumberBySN(string sn, int stationId, int resourceId, int boxSeq)
        {
            string[] packArr = new string[5];
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                packArr = packingBll.GetPackNumberBySN(sn, stationId, resourceId, userId, boxSeq);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return packArr;
        }

        /// <summary>
        /// 包装产品SN到包装箱内
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="packSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public decimal[] CollectPackSN(string sn, string packSN, int stationId, int resourceId, int boxSeq)
        {
            decimal[] packArr = new decimal[2];
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                packArr = packingBll.CollectPackSN(sn, packSN, stationId, resourceId, userId, boxSeq);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return packArr;
        }

        /// <summary>
        /// 手动关闭容器(包装箱,栈板)
        /// </summary>
        /// <param name="ContainerSN">容器条码</param>
        /// <param name="UserId">用户ID</param>
        /// <param name="OpeId">工序ID</param>
        /// <param name="ResId">资源ID</param>
        /// <returns></returns>
        [AjaxMethod]
        public void ClosePackPalletContainer(string containerSN, int opeId, int resId)
        {
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                packingBll.ClosePackPalletContainer(containerSN, userId, opeId, resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        /// <summary>
        /// 根据包装箱号(栈板号)带出包装(栈板)信息
        /// </summary>
        /// <param name="SN">条码</param>
        /// <param name="ContainerType">包装条码Level,1:Packing.2:Pallet</param>
        /// <returns></returns>
        [AjaxMethod]
        public DataTable GetPackIngPalletDetailByContainerSN(string sn, int containerType)
        {
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            DataTable dt = new DataTable();
            try
            {
                dt = packingBll.GetPackIngPalletDetailByContainerSN(sn, containerType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dt;
        }

        /// <summary>
        /// 根据条码获取包装箱号
        /// </summary>
        /// <param name="SN"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetPackSNBySN(string sn)
        {
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            string packSN = "";
            try
            {
                packSN = packingBll.GetPackSNBySN(sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return packSN;
        }

        /// <summary>
        /// 解绑
        /// </summary>
        /// <param name="unitAssyDataIds"></param>
        /// <param name="unBindType"></param>
        /// <param name="ContainerType">1:包装箱,2:栈板</param>
        /// <param name="sn"></param>
        /// <param name="userId"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        [AjaxMethod]
        public void RemovePackData(string unitPackDataIds, int containerType, string sn, int userId, int opeId, int resId)
        {
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            try
            {
                packingBll.RemovePackData(unitPackDataIds, containerType, sn, userId, opeId, resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #endregion

        #region 栈板

        /// <summary>
        /// 通过扫描的SN获取包装箱号
        /// </summary>
        /// <param name="packSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetPalletNumberBySN(string packSN, int stationId, int resourceId)
        {
            string[] palletArr = new string[3];
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                palletArr = packingBll.GetPalletNumberBySN(packSN, stationId, resourceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return palletArr;
        }

        /// <summary>
        /// 保存包装箱与栈板之间的关系
        /// </summary>
        /// <param name="packSN"></param>
        /// <param name="palletSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public decimal[] CollectPalletSN(string packSN, string palletSN, int stationId, int resourceId)
        {
            decimal[] palletArr = new decimal[2];
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                palletArr = packingBll.CollectPalletSN(packSN, palletSN, stationId, resourceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return palletArr;
        }

        /// <summary>
        /// 获取包装内的第一个产品SN 2017-10-16
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetPackingSN(string packSn)
        {
            string sn = "";
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            try
            {
                sn = packingBll.GetPackingSN(packSn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return sn;
        }

        #endregion

        #region 包装附件采集

        /// <summary>
        /// 获取包装附件采集配置信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<PackingAccessoriesConfigInfo> GetPackingAccessoriesConfig(string sn, int stationId)
        {
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            List<PackingAccessoriesConfigInfo> list = new List<PackingAccessoriesConfigInfo>();
            try
            {
                list = packingBll.GetPackingAccessoriesConfig(sn, stationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 添加包装附件条码信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="list"></param>
        [AjaxMethod]
        public void PackingAccessoriesDetailEdit(string sn, int stationId, int resId, List<PackingAccessoriesConfigInfo> list)
        {
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                if (list.Count > 0)
                {
                    var accessoriesSN = "";
                    var packingAccessoriesConfigId = "";
                    for (int i = 0; i < list.Count; i++)
                    {
                        accessoriesSN += list[i].AccessoriesSN + ",";
                        packingAccessoriesConfigId += list[i].PackingAccessoriesConfigId.ToString() + ",";
                    }

                    packingAccessoriesConfigId = packingAccessoriesConfigId.Substring(0, packingAccessoriesConfigId.Length - 1);
                    accessoriesSN = accessoriesSN.Substring(0, accessoriesSN.Length - 1);
                    packingBll.PackingAccessoriesDetailEdit(packingAccessoriesConfigId, sn, accessoriesSN, resId, userName, userId, stationId);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        /// <summary>
        /// 检查是否已采集包装附件
        /// </summary>
        /// <param name="offlineSN"></param>
        /// <returns></returns>
        [AjaxMethod]
        public bool CheckIsCollectAccessoriesSN(string offlineSN)
        {
            bool flag = false;
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            try
            {
                flag = packingBll.CheckIsCollectAccessoriesSN(offlineSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return flag;
        }

        [AjaxMethod]
        public void GetofflineCheck(string scanSN, string assySN, int itemId, int checkType, int maskId)
        {
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            try
            {
                packingBll.offlineCheck(scanSN, assySN, itemId, checkType, maskId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 包装附件检查离线条码验证
        /// </summary>
        /// <param name="scanSN">主条码</param>
        /// <param name="assySN">离线条码</param>
        /// <param name="itemId"></param>
        /// <param name="checkType"></param>
        /// <param name="maskId"></param>
        [AjaxMethod]
        public void GetPartsOfflineSNCheck(string scanSN, string assySN, int maskId)
        {
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            try
            {
                packingBll.PartsOfflineSNCheck(scanSN, assySN, maskId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region Repacking

        /// <summary>
        /// 获取‘重新包装-栈板’界面数据（产品信息、外箱列表）
        /// </summary>
        /// <param name="palletNo">栈板号</param>
        /// <param name="userId">用户ID</param>
        /// <param name="outBoxNum">输出参数，外箱数量</param>
        /// <param name="msg">输出参数，返回空字符串则表示成功，否则返回具体错误消息</param>
        /// <returns></returns>
        [AjaxMethod]
        public DataSet GetRepackingPalletInfo(string palletNo)
        {
            ProdCollectionPacking bll = new ProdCollectionPacking();
            try
            {
                int userId = AccountController.GetCurrentUser().UserId;
                return bll.GetRepackingPalletInfo(palletNo, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }


        /// <summary>
        /// Repacking-栈板
        /// </summary>
        /// <param name="model">栈板与包装箱关联、产品序列号与包装箱关联 对象</param>
        /// <param name="opereateType">操作类型（0：只做校验 1：保存）</param>
        /// <returns></returns>
        [AjaxMethod]
        public DataTable RepackingPallet(PackingData model, int opereateType)
        {
            ProdCollectionPacking bll = new ProdCollectionPacking();
            try
            {
                model.UserId = AccountController.GetCurrentUser().UserId;
                return bll.RepackingPallet(model, opereateType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// Repacking-栈板
        /// </summary>
        /// <param name="model">栈板与包装箱关联、产品序列号与包装箱关联 对象</param>
        /// <param name="opereateType">操作类型（0：只做校验 1：保存）</param>
        /// <returns></returns>
        [AjaxMethod]
        public string RepackingPalletGeneratePalletNo(PackingData entity)
        {
            try
            {
                var modifyBy = AccountController.GetCurrentUser().UserName;
                SqlParameter[] parms = new SqlParameter[]
                {
                    new SqlParameter("@CartonSN", SqlDbType.VarChar) { Value = entity.BoxSN },
                    new SqlParameter("@ModifyBy", SqlDbType.VarChar) { Value = modifyBy },
                    new SqlParameter("@PalletNo", SqlDbType.VarChar,50) { Direction = ParameterDirection.Output }
                };
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspRepackingPalletGeneratePalletNo", parms);
                return Convert.ToString(parms[2].Value);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return string.Empty;
            }
        }

        /// <summary>
        /// 根据外箱号码获取‘重新包装-外箱’UI中的产品信息
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [AjaxMethod]
        public DataTable GetItemInfoByBoxNo(PackingData model)
        {
            ProdCollectionPacking bll = new ProdCollectionPacking();
            try
            {
                model.UserId = AccountController.GetCurrentUser().UserId;
                return bll.GetItemInfoByBoxNo(model);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 扫描外箱号码及产品号码，将产品重新包装到扫描的外箱中
        /// </summary>
        /// <param name="model">栈板与包装箱关联、产品序列号与包装箱关联 对象</param>
        /// <param name="opereateType">操作类型（0：只做校验 1：保存）</param>
        /// <returns></returns>
        [AjaxMethod]
        public DataTable RepackingOutBox(PackingData model, int opereateType)
        {
            ProdCollectionPacking bll = new ProdCollectionPacking();
            try
            {
                model.UserId = AccountController.GetCurrentUser().UserId;
                return bll.RepackingOutBox(model, opereateType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }


        #endregion

        #region 离线打印包装（先打印后包装）

        /// <summary>
        /// 手工关闭包装中箱
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="packSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] CollectHandOfflinePackSN(string sn, string boxSN, string packSN, int stationId, int resourceId)
        {
            string[] packArr = new string[3];
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                packArr = packingBll.CollectHandOfflinePackSN(sn, boxSN, packSN, stationId, resourceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return packArr;
        }
        #endregion

        /// <summary>
        /// 手工在线关箱
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="packSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <returns></returns>

        [AjaxMethod]
        public string[] HandCollectBoxSN(string sn, string packSN, int stationId, int resourceId, string addPackSN)
        {
            string[] packArr = new string[5];
            ProdCollectionPacking packingBll = new ProdCollectionPacking();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                packArr = packingBll.GetHandBoxNumberBySN(sn, packSN, stationId, resourceId, userId, addPackSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return packArr;
        }

        #region 根据包装箱号获取产品信息
        /// <summary>
        /// 根据包装箱号获取产品信息
        /// </summary>
        /// <param name="PackSN"></param>
        /// <returns></returns>
        [AjaxMethod]
        public DataTable GetPackSNItemInfo(string PackSN)
        {
            ProdCollectionPacking bll = new ProdCollectionPacking();
            try
            {
                return bll.GetPackSNItemInfo(PackSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        #endregion

        #region 生成栈板条码，建立包装箱与栈板关系
        /// <summary>
        /// 生成栈板条码，建立包装箱与栈板关系
        /// </summary>
        /// <param name="PackSN"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string SavePackPalletRelation(String ArrPackSN,int ItemId,int ProdOrderId, string palletSN)
        {
            ProdCollectionPacking bll = new ProdCollectionPacking();
            try
            {
                return bll.SavePackPalletRelation(ArrPackSN, ItemId, ProdOrderId, AccountController.GetCurrentUser().UserId, AccountController.GetCurrentUser().UserName, palletSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        #endregion

        /// <summary>
        /// 获取PrepSerialNumberInfo信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public PrepSerialNumberInfo GetPrepSerialNumberInfo(PrepSerialNumberInfo entity)
        {
            PrepSerialNumber bll = new PrepSerialNumber();
            try
            {
                return bll.GetPrepSerialNumberInfo(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        [AjaxMethod]
        public int CheckPackSNEmpty(string packSN)
        {
            ProdCollectionPacking bll = new ProdCollectionPacking();
            try
            {
               return bll.CheckPackSNEmpty(packSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }
    }
}