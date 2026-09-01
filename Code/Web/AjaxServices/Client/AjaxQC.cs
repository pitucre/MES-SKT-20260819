using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.ProductionCollection.Model;
using SKT.LeanMES.ProductionCollection.Client;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Quality.BLL;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using AJAXdataHelper;
using System.Data;
using SKT.MES.DAL.Marshal;
using Aspose.Cells.Charts;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Station.BLL;
using System.Security.Cryptography;
using System.Windows.Forms;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.SDP.Model;
using NPOI.SS.Formula.Functions;

namespace SKT.LeanMES.Web.AjaxServices
{
    /******************************************************************************************
     * 类名：AjaxQC      
     * 功能描述：此类主要应用于开发内置UI类型为【QC】的Ajax方法
     * 创建人：zhiman.yuan
     * 创建时间：2017-7-3
     * 修改人：
     * 修改时间：
     ******************************************************************************************/
    public class AjaxQC
    {
        #region QC检验模块
        /// <summary>
        /// 获取送检单信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public InspectionInfo GetInspectionInfoByLotId(int inspectionLotId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            InspectionInfo entity = new InspectionInfo();
            try
            {
                entity = qcBll.GetInspectionInfoByLotId(inspectionLotId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }


        /// <summary>
        /// 根据包装条码获取送检单信息,如果不存在则生成批次信息
        /// </summary>
        /// <param name="packSN"></param>
        /// <param name="statonId"></param>
        /// <param name="resId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public InspectionInfo GetInspectionInfoByPackSN(int inspectionLotId, string packSN, int statonId, int resId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            InspectionInfo entity = new InspectionInfo();
            try
            {
                entity = qcBll.GetInspectionInfoByPackSN(inspectionLotId, packSN, statonId, resId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        [AjaxMethod]
        public InspectionInfo GetInspectionInfoByPackSN2(int inspectionLotId, string packSN, int statonId, int resId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            InspectionInfo entity = new InspectionInfo();
            try
            {
                entity = qcBll.GetInspectionInfoByPackSN2(inspectionLotId, packSN, statonId, resId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 根据送检批ID获取包装信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<PackInfo> GetPackSNByInspectionLotId(int inspectionLotId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            List<PackInfo> list = new List<PackInfo>();
            try
            {
                list = qcBll.GetPackSNByInspectionLotId(inspectionLotId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取批次、检验项信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<InspectionLotMemberInfo> GetInspectionMemberByLotId(int inspectionLotId, int checkType, int qcType)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            List<InspectionLotMemberInfo> list = new List<InspectionLotMemberInfo>();
            try
            {
                list = qcBll.GetInspectionMemberByLotId(inspectionLotId, userName, checkType, qcType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 提前录入 根据SN获取检验项 ZCL 2018-02-27
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="checkType"></param>
        /// <param name="qcType"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<InspectionLotMemberInfo> GetInspectionMemberBySN(string sn, string userName, int qcType)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            List<InspectionLotMemberInfo> list = new List<InspectionLotMemberInfo>();
            try
            {
                list = qcBll.GetInspectionMemberBySN(sn, userName, qcType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取扫描的SN信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<InspectionLotMemberSNInfo> GetInspectionLotSNInfo(int inspectionLotId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            List<InspectionLotMemberSNInfo> list = new List<InspectionLotMemberSNInfo>();
            try
            {
                list = qcBll.GetInspectionLotSNInfo(inspectionLotId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 添加扫描的SN信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="sn"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        /// <param name="ncCodeArr"></param>
        /// <param name="value"></param>
        /// <param name="flag">标识 0：校验 1：校验及保存</param>
        [AjaxMethod]
        public void CollectInspectionLotSNInfo(int inspectionLotId, int inspectionLotMemberId, string sn, int opeId, int resId, string ncCodeArr, string value, int flag)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                qcBll.CollectInspectionLotSNInfo(inspectionLotId, inspectionLotMemberId, sn, userName, ncCodeArr, opeId, resId, userId, value, flag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 添加扫描的SN信息 批量
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="sn"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        /// <param name="ncCodeArr"></param>
        /// <param name="value"></param>
        /// <param name="flag">标识 0：校验 1：校验及保存</param>
        [AjaxMethod]
        public void CollectInspectionLotSNInfoBatch(int inspectionLotId, string inspectionLotMemberIds, string sn, int opeId, int resId, string ncCodeArr, string value, int flag)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                qcBll.CollectInspectionLotSNInfoBatch(inspectionLotId, inspectionLotMemberIds, sn, userName, ncCodeArr, opeId, resId, userId, value, flag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 记录产品SN不良信息
        /// </summary>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="sn"></param>
        /// <param name="ncCode"></param>
        [AjaxMethod]
        public void CollectInspectionLotNCCodeInfo(int inspectionLotMemberId, string sn, string ncCode, int opeId, int resId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                qcBll.CollectInspectionLotNCCodeInfo(inspectionLotMemberId, sn, ncCode, userName, userId, opeId, resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 检验单PASS操作
        /// </summary>
        /// <param name="inspectionLotId"></param>
        [AjaxMethod]
        public void CollectInspectionLotPass(int inspectionLotId, int passType, int stationId, int resId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                qcBll.CollectInspectionLotPass(inspectionLotId, passType, userName, userId, stationId, resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 检验单PASS操作
        /// </summary>
        /// <param name="inspectionLotId"></param>
        [AjaxMethod]
        public void CollectInspectionLotPassPQC(int inspectionLotId, int passType, int stationId, int resId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                qcBll.CollectInspectionLotPassPQC(inspectionLotId, passType, userName, userId, stationId, resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 检验单拆分Pass操作
        /// </summary>
        /// <param name="inspectionLotId"></param>
        [AjaxMethod]
        public void CollectInspectionLotSplitPass(int inspectionLotId, int passType, int stationId, int resId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                qcBll.CollectInspectionLotSplitPass(inspectionLotId, passType, userName, userId, stationId, resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 检验单Reject操作
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="stationId"></param>
        [AjaxMethod]
        public void CollectInspectionLotReject(int inspectionLotId, int stationId, int returnStationId, int resId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                qcBll.CollectInspectionLotReject(inspectionLotId, stationId, userName, returnStationId, userId, resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 检验单Reject操作 pqc 采用爱都的版本
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="stationId"></param>
        [AjaxMethod]
        public void CollectInspectionLotRejectPQC(int inspectionLotId, int stationId, int returnStationId, int resId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                qcBll.CollectInspectionLotRejectPQC(inspectionLotId, stationId, userName, returnStationId, userId, resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 检验单强制Reject操作(PQC批次检验UI)
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="stationId"></param>
        [AjaxMethod]
        public void CollectInspectionLotForceReject(int inspectionLotId, int stationId, int returnStationId, int resId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                qcBll.CollectInspectionLotForceReject(inspectionLotId, stationId, userName, returnStationId, userId, resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取送检批关联的路由信息
        /// </summary>
        /// <param name="inspectionLotMemberId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<StationInfo> GetInspectionLotRouter(int inspectionLotId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            List<StationInfo> list = new List<StationInfo>();
            try
            {
                list = qcBll.GetInspectionLotRouter(inspectionLotId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取送检项信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<SKT.LeanMES.Quality.Model.AQLSampleInfo> GetAQLSampleInfo()
        {
            SKT.LeanMES.Quality.BLL.AQLSample sample = new LeanMES.Quality.BLL.AQLSample();
            List<SKT.LeanMES.Quality.Model.AQLSampleInfo> list = new List<SKT.LeanMES.Quality.Model.AQLSampleInfo>();
            try
            {
                list = sample.GetAll(0, -1, "", new Common.Model.SearchSettings());
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 记录SN检验信息 提前录入
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void CollectInspectionLotRecords(string sn, int aqlSampledId, string aqlSampledName)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                qcBll.CollectInspectionLotRecords(sn, userName, aqlSampledId, aqlSampledName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 记录SN检验信息 【提前录入】
        /// </summary>
        /// <param name="sn">SN</param>
        /// <param name="aqlSampledId">检验项</param>
        /// <param name="aqlSampledName">检验项名称</param>
        /// <param name="Value">检验值</param>
        /// <param name="Result">检验结果</param>
        /// <param name="ncCodes">不良代码</param>
        [AjaxMethod]
        public void CollectInspectionLotRecordsPre(string sn, int aqlSampledId, string aqlSampledName, string Value, int Result, string ncCodes)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                qcBll.CollectInspectionLotRecordsPre(sn, userName, aqlSampledId, aqlSampledName, Value, Result, ncCodes);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 记录SN检验信息 【提前录入】
        /// </summary>
        /// <param name="sn">SN</param>
        /// <param name="aqlSampledIds">检验项集合</param>
        /// <param name="aqlSampledNames">检验项名称集合</param>
        /// <param name="Value">检验值</param>
        /// <param name="Result">检验结果</param>
        /// <param name="ncCodes">不良代码</param>
        [AjaxMethod]
        public void CollectInspectionLotRecordsPreBatch(string sn, string aqlSampledIds, string aqlSampledNames, string Value, int Result, string ncCodes)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                qcBll.CollectInspectionLotRecordsPreBatch(sn, userName, aqlSampledIds, aqlSampledNames, Value, Result, ncCodes);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取提前录入的扫描SN信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<InspectionLotRecordsInfo> GetInspectionLotRecords(int importType, int aqlSampleId, int itemId, string preSN)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            List<InspectionLotRecordsInfo> list = new List<InspectionLotRecordsInfo>();
            try
            {
                list = qcBll.GetInspectionLotRecords(importType, aqlSampleId, itemId, preSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 记录提前录入产品SN不良信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="ncCode"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        [AjaxMethod]
        public void CollectPreInspectionLotNCCodeInfo(string sn, string ncCode, int opeId, int resId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                qcBll.CollectPreInspectionLotNCCodeInfo(sn, ncCode, userName, userId, opeId, resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 切入提前录入的扫描SN信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        [AjaxMethod]
        public void ImportInspectionLotRecords(int inspectionLotId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                qcBll.ImportInspectionLotRecords(inspectionLotId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 删除已抽检的SN信息
        /// </summary>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="sn"></param>
        [AjaxMethod]
        public void DelInspectionLotMemberSN(int inspectionLotMemberId, string sn)
        {

            ProdCollectionQC qcBll = new ProdCollectionQC();
            try
            {
                qcBll.DelInspectionLotMemberSN(inspectionLotMemberId, sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 删除当前扫描的包装箱/栈板条码
        /// </summary>
        /// <param name="packSN"></param>
        /// <param name="delLotId"></param>
        [AjaxMethod]
        public void DelPackSN(string packSN, int inspectionLotId, bool isDelLotId)
        {

            ProdCollectionQC qcBll = new ProdCollectionQC();
            try
            {
                qcBll.DelPackSN(packSN, inspectionLotId, isDelLotId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region IPQC检验模块

        [AjaxMethod]
        public string AdditionalSerialNumberGeneral(int InspectionTypeId, int ItemId, string ItemCode, string SNStr, string CreateBy, int IOrderId, int OpeId, int LineId, int ResourceId, int StationId, int OrderId,
            int TemplateId, string LotCode, int EquipmentId, int sampleQty, string sendman, string classType)
        {
            try
            {
                InspectionOrderMember bll = new InspectionOrderMember();
                return bll.InspectionAdditionalMemberGeneral(ref IOrderId, InspectionTypeId, ItemId, ItemCode,
                    SNStr, CreateBy, OpeId, LineId, ResourceId, StationId, OrderId, TemplateId, LotCode,
                    EquipmentId, sampleQty, sendman, classType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return "";
        }

        [AjaxMethod]
        public string InspectionIPQCGeneral()
        {
            try
            {
                InspectionOrderMember bll = new InspectionOrderMember();
                return bll.InspectionIPQCGeneral();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return "";
        }

        [AjaxMethod]
        public string InspectionProjectGeneral()
        {
            try
            {
                InspectionOrderMember bll = new InspectionOrderMember();
                return bll.InspectionProjectGeneral();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return "";
        }

        /// <summary>
        /// 保存受检条码检验项目结果
        /// </summary>
        /// <param name="info"></param>
        [AjaxMethod]
        public void SaveInspectionOrderMemberItem(InspectionOrderMemberItemInfo info)
        {
            try
            {
                InspectionOrderMemberItem bll = new InspectionOrderMemberItem();
                bll.Edit(info);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 保存受检条码检验项目结果
        /// </summary>
        /// <param name="info"></param>
        [AjaxMethod]
        public void SaveInspectionOrderMemberItemJW(InspectionOrderMemberItemInfo info)
        {
            try
            {
                InspectionOrderMemberItem bll = new InspectionOrderMemberItem();
                bll.EditJW(info);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        /// <summary>
        /// 保存检验单结果
        /// </summary>
        /// <param name="IOrderId"></param>
        /// <param name="DealResult"></param>
        /// <param name="DealResultRemark"></param>
        [AjaxMethod]
        public void SaveInspectionOrderResult(Int32 IOrderId, String DealResult, String FAISNStr)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[] {
                        new SqlParameter("@IOrderId", SqlDbType.Int),
                        new SqlParameter("@DealResult", SqlDbType.VarChar,20),
                        new SqlParameter("@FAISNStr", SqlDbType.VarChar,2000),
                        new SqlParameter("@DealResultRemark", SqlDbType.NVarChar)
                    };

                parms[0].Value = IOrderId;
                parms[1].Value = DealResult;
                parms[2].Value = FAISNStr;
                parms[3].Value = "";
                //MES.DAL.Marshal.SQLHelper.ExecuteScalarStoredProcedure(MES.DAL.Marshal.SQLHelper.MESConnString, "uspInspectionOrderResult", parms);
                CommonHelper.BLL.ComMethod.Edit("uspInspectionOrderResult", parms);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }

        [AjaxMethod]
        public int SaveInspectionIPQC(string strJson)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOrderId", SqlDbType.Int){ Direction=ParameterDirection.InputOutput} ,
                new SqlParameter("@ItemId", SqlDbType.Int) ,
                new SqlParameter("@IOrderNo", SqlDbType.NVarChar) ,
                new SqlParameter("@LineId", SqlDbType.Int) ,
                new SqlParameter("@TemplateId", SqlDbType.Int) ,
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@InspectionTypeId", SqlDbType.Int) ,
                new SqlParameter("@SNStr",SqlDbType.NVarChar),
                new SqlParameter("@Remark", SqlDbType.VarChar),
                new SqlParameter("@CreateBy", SqlDbType.VarChar),
                new SqlParameter("@InspectionSelectType", SqlDbType.VarChar),
                new SqlParameter("@QualityInspectionMemberDetail", SqlDbType.Structured)

            };
                ComMethod.Edit<InspectionTemplateInfo>(strJson, "uspSaveIPQCItem", parms);

                return Convert.ToInt32(parms[0].Value);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        [AjaxMethod]
        public int SaveInspectionProjectFAL(string strJson)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOrderId", SqlDbType.Int){ Direction=ParameterDirection.InputOutput} ,
                new SqlParameter("@ItemId", SqlDbType.Int) ,
                new SqlParameter("@IOrderNo", SqlDbType.NVarChar) ,
                new SqlParameter("@LineId", SqlDbType.Int) ,
                new SqlParameter("@TemplateId", SqlDbType.Int) ,
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@InspectionTypeId", SqlDbType.Int) ,
                new SqlParameter("@SNStr",SqlDbType.NVarChar),
                new SqlParameter("@Remark", SqlDbType.VarChar),
                new SqlParameter("@CreateBy", SqlDbType.VarChar),
                new SqlParameter("@InspectionSelectType", SqlDbType.VarChar),
                new SqlParameter("@SYDate", SqlDbType.DateTime),
                new SqlParameter("@JYDate",SqlDbType.DateTime),
                new SqlParameter("@Result",SqlDbType.Int),
                new SqlParameter("@MoudleCode",SqlDbType.NVarChar),
                new SqlParameter("@DryingMaterialTemperature",SqlDbType.NVarChar),
                new SqlParameter("@HotRunnerTemperature",SqlDbType.NVarChar),
                new SqlParameter("@BarrelTemperature1",SqlDbType.NVarChar),
                new SqlParameter("@BarrelTemperature2",SqlDbType.NVarChar),
                new SqlParameter("@BarrelTemperature3",SqlDbType.NVarChar),
                new SqlParameter("@BarrelTemperature4",SqlDbType.NVarChar),
                new SqlParameter("@BarrelTemperature5",SqlDbType.NVarChar),
                new SqlParameter("@MoldTemperatureDynamic",SqlDbType.NVarChar),
                new SqlParameter("@MoldTemperatureStatic",SqlDbType.NVarChar),
                new SqlParameter("@MaterialItemId",SqlDbType.Int),
                new SqlParameter("@MaterialItemLot",SqlDbType.NVarChar),
                new SqlParameter("@QualityInspectionMemberDetail", SqlDbType.Structured)


            };
                ComMethod.Edit<InspectionTemplateInfo>(strJson, "uspSaveInspectionProjectFAL", parms);

                return Convert.ToInt32(parms[0].Value);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        [AjaxMethod]
        public int SaveInspectionProjectFALEdit(string strJson)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOrderId", SqlDbType.Int){ Direction=ParameterDirection.InputOutput} ,
                new SqlParameter("@ItemId", SqlDbType.Int) ,
                new SqlParameter("@IOrderNo", SqlDbType.NVarChar) ,
                new SqlParameter("@LineId", SqlDbType.Int) ,
                new SqlParameter("@TemplateId", SqlDbType.Int) ,
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@InspectionTypeId", SqlDbType.Int) ,
                new SqlParameter("@SNStr",SqlDbType.NVarChar),
                new SqlParameter("@Remark", SqlDbType.VarChar),
                new SqlParameter("@CreateBy", SqlDbType.VarChar),
                new SqlParameter("@InspectionSelectType", SqlDbType.VarChar),
                new SqlParameter("@SYDate", SqlDbType.DateTime),
                new SqlParameter("@JYDate",SqlDbType.DateTime),
                new SqlParameter("@Result",SqlDbType.Int),
                new SqlParameter("@MoudleCode",SqlDbType.NVarChar),
                new SqlParameter("@DryingMaterialTemperature",SqlDbType.NVarChar),
                new SqlParameter("@HotRunnerTemperature",SqlDbType.NVarChar),
                new SqlParameter("@BarrelTemperature1",SqlDbType.NVarChar),
                new SqlParameter("@BarrelTemperature2",SqlDbType.NVarChar),
                new SqlParameter("@BarrelTemperature3",SqlDbType.NVarChar),
                new SqlParameter("@BarrelTemperature4",SqlDbType.NVarChar),
                new SqlParameter("@BarrelTemperature5",SqlDbType.NVarChar),
                new SqlParameter("@MoldTemperatureDynamic",SqlDbType.NVarChar),
                new SqlParameter("@MoldTemperatureStatic",SqlDbType.NVarChar),
                new SqlParameter("@MaterialItemId",SqlDbType.Int),
                new SqlParameter("@MaterialItemLot",SqlDbType.NVarChar),
                new SqlParameter("@QualityInspectionMemberDetail", SqlDbType.Structured)


            };
                ComMethod.Edit<InspectionTemplateInfo>(strJson, "uspSaveInspectionProjectFALEdit", parms);

                return Convert.ToInt32(parms[0].Value);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        [AjaxMethod]
        public Boolean InspectionItemExists(int ItemId, int SystemType)
        {
            try
            {
                InspectionTemplate bll = new InspectionTemplate();
                return bll.InspectionItemExists(ItemId, SystemType);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        /// <summary>
        /// 前端调用查询
        /// </summary>
        /// <param name="tableNameString">表名或视图</param>
        /// <param name="primaryKey">主键</param>
        /// <param name="getFieldString">需要返回的列</param>
        /// <param name="searcheConditions">查询条件，如果没有则为""</param>
        /// <param name="sortExpression">排序条件，如果没有则为""</param>
        /// <returns>返回对象数组，如[obj1,obj2,obj3...]</returns>
        [AjaxMethod]
        public List<EntityInfo> Search(String tableNameString, String primaryKey, String getFieldString, String searcheConditions, String sortExpression)
        {
            List<EntityInfo> list = new List<EntityInfo>();

            list = new AjaxHelper().Search(tableNameString, primaryKey, getFieldString, searcheConditions, sortExpression, SKT.Common.DAL.Marshal.SQLHelper.MESConnString);

            return list;
        }

        #endregion

        #region 首件检验模块

        /// <summary>
        /// 生成首件检验单号
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="templateId"></param>
        /// <param name="lineId"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<FAICodeInfo> GenerateFAICode(int prodOrderId, int stationId, int resouceId, int lineId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            List<FAICodeInfo> list = new List<FAICodeInfo>();
            try
            {
                list = qcBll.GenerateFAICode(prodOrderId, stationId, resouceId, lineId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取检验模板版本号
        /// </summary>
        /// <param name="templateId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetTemplateVersion(int templateId)
        {
            string version = "";
            ProdCollectionQC qcBll = new ProdCollectionQC();
            try
            {
                version = qcBll.GetTemplateVersion(templateId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return version;
        }

        /// <summary>
        /// 采集首件信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int CollectFAIInspecitonInfo(FAIInspectionInfo entity)
        {
            int iOrderId = 0;
            ProdCollectionQC qcBll = new ProdCollectionQC();
            try
            {
                iOrderId = qcBll.CollectFAIInspecitonInfo(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return iOrderId;
        }

        /// <summary>
        /// 获取首件检验项信息
        /// </summary>
        /// <param name="iorderId"></param>
        /// <param name="templateId"></param>
        /// <returns></returns>
        /// 
        [AjaxMethod]
        public List<InspectionTemplateMemberInfo> GetFAITemplateInfo(int iorderId, int templateId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            List<InspectionTemplateMemberInfo> list = new List<InspectionTemplateMemberInfo>();
            try
            {
                list = qcBll.GetFAITemplateInfo(iorderId, templateId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取首件检验单信息
        /// </summary>
        /// <param name="faiCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public FAIInspectionInfo GetFAIInspectionInfo(string faiCode)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            FAIInspectionInfo entity = new FAIInspectionInfo();
            try
            {
                entity = qcBll.GetFAIInspectionInfo(faiCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 获取首件检验SN信息
        /// </summary>
        /// <param name="iorderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<FAISNInfo> GetFAISNInfo(int iorderId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            List<FAISNInfo> list = new List<FAISNInfo>();
            try
            {
                list = qcBll.GetFAISNInfo(iorderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 检查录入的SN信息
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="sn"></param>
        [AjaxMethod]
        public void CheckFAISN(int prodOrderId, string sn)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            try
            {
                qcBll.CheckFAISN(prodOrderId, sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        [AjaxMethod]
        public string GetInspectionItem(int iorderID)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            try
            {
                return qcBll.GetInspectionItem(iorderID);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }
        #endregion


        #region 末件检验模块
        /// <summary>
        /// 生成末件检验单号
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="templateId"></param>
        /// <param name="lineId"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<EAICodeInfo> GenerateEAICode(int prodOrderId, int stationId, int resouceId, int lineId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            List<EAICodeInfo> list = new List<EAICodeInfo>();
            try
            {
                list = qcBll.GenerateEAICode(prodOrderId, stationId, resouceId, lineId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        /// <summary>
        /// 获取末件检验单信息
        /// </summary>
        /// <param name="faiCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public EAIInspectionInfo GetEAIInspectionInfo(string faiCode)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            EAIInspectionInfo entity = new EAIInspectionInfo();
            try
            {
                entity = qcBll.GetEAIInspectionInfo(faiCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 获取末件检验项信息
        /// </summary>
        /// <param name="iorderId"></param>
        /// <param name="templateId"></param>
        /// <returns></returns>
        /// 
        [AjaxMethod]
        public List<InspectionTemplateMemberInfo> GetEAITemplateInfo(int iorderId, int templateId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            List<InspectionTemplateMemberInfo> list = new List<InspectionTemplateMemberInfo>();
            try
            {
                list = qcBll.GetFAITemplateInfo(iorderId, templateId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        /// 获取末件检验SN信息
        /// </summary>
        /// <param name="iorderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<EAISNInfo> GetEAISNInfo(int iorderId)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            List<EAISNInfo> list = new List<EAISNInfo>();
            try
            {
                list = qcBll.GetEAISNInfo(iorderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        /// 采集末件信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int CollectEAIInspecitonInfo(EAIInspectionInfo entity)
        {
            int iOrderId = 0;
            ProdCollectionQC qcBll = new ProdCollectionQC();
            try
            {
                iOrderId = qcBll.CollectEAIInspecitonInfo(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return iOrderId;
        }

        /// <summary>
        /// 检查录入的SN信息(末件)
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="sn"></param>
        [AjaxMethod]
        public void CheckEAISN(int prodOrderId, string sn)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            try
            {
                qcBll.CheckEAISN(prodOrderId, sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #endregion
        /// <summary>
        /// 添加扫描的SN信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="sn"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        /// <param name="ncCodeArr"></param>
        /// <param name="value"></param>
        /// <param name="flag">标识 0：校验 1：校验及保存</param>
        [AjaxMethod]
        public void CollectPQCInspectionLotSNInfo(int inspectionLotId, int inspectionLotMemberId, string sn, int opeId, int resId, string ncCodeArr, string value, int flag)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                qcBll.CollectPQCInspectionLotSNInfo(inspectionLotId, inspectionLotMemberId, sn, userName, ncCodeArr, opeId, resId, userId, value, flag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 添加扫描的SN信息,全通过  OK  批量处理
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="sn"></param>
        /// <param name="value"></param>
        [AjaxMethod]
        public void CollectInspectionLotSNInfoBatch_PQC(int inspectionLotId, string sn, string value)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                qcBll.CollectInspectionLotSNInfoBatch_PQC(inspectionLotId, sn, userName, value);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 获取送检批关联的路由信息
        /// </summary>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="RejectType">回流类型：0-reject ,1-强制reject</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<StationInfo> GetInspectionLotRouter_ForceReject(int inspectionLotId, int RejectType)
        {
            ProdCollectionQC qcBll = new ProdCollectionQC();
            List<StationInfo> list = new List<StationInfo>();
            try
            {
                list = qcBll.GetInspectionLotRouter_ForceReject(inspectionLotId, RejectType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

    }
}