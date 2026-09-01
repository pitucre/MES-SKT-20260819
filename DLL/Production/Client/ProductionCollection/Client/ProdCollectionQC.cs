using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ProductionCollection.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.ProductionCollection.Client
{
    public class ProdCollectionQC
    {
        #region OQC检测

        /// <summary>
        /// 获取送检单信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <returns></returns>
        public InspectionInfo GetInspectionInfoByLotId(int inspectionLotId)
        {
            List<InspectionInfo> list = new List<InspectionInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@InspectionLotId",SqlDbType.Int),
            };
            param[0].Value = inspectionLotId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionInfoByLotId", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<InspectionInfo>(rdr);
                rdr.Close();
            }
            return list[0];
        }

        /// <summary>
        /// 根据包装条码获取送检单信息,如果不存在则生成批次信息
        /// </summary>
        /// <param name="packSN"></param>
        /// <param name="statinId"></param>
        /// <param name="resId"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public InspectionInfo GetInspectionInfoByPackSN(int inspectionLotId, string packSN, int statinId, int resId, string userName)
        {
            List<InspectionInfo> list = new List<InspectionInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@InspectionLotId",SqlDbType.Int),
                new SqlParameter("@PackSN",SqlDbType.NVarChar,512) ,
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar),
            };
            param[0].Value = inspectionLotId;
            param[1].Value = packSN;
            param[2].Value = statinId;
            param[3].Value = resId;
            param[4].Value = userName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionInfoByPackSN", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<InspectionInfo>(rdr);
                rdr.Close();
            }
            return list[0];
        }


        public InspectionInfo GetInspectionInfoByPackSN2(int inspectionLotId, string packSN, int statinId, int resId, string userName)
        {
            List<InspectionInfo> list = new List<InspectionInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@InspectionLotId",SqlDbType.Int),
                new SqlParameter("@PackSN",SqlDbType.NVarChar,512) ,
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar),
            };
            param[0].Value = inspectionLotId;
            param[1].Value = packSN;
            param[2].Value = statinId;
            param[3].Value = resId;
            param[4].Value = userName;

            DataSet ds = ComMethod.GetListDataSet("uspGetInspectionInfoByPackSN2", param);

            if (ds != null && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
            {
                list = ComMethod.ConvertDataTableToList<InspectionInfo>(ds.Tables[0]);
                if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                {
                    list[0].PackingDataList = ComMethod.ConvertDataTableToList<PackingData>(ds.Tables[1]);
                }
            } 
            return list[0];
        }
        /// <summary>
        /// 根据送检批ID获取包装信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <returns></returns>
        public List<PackInfo> GetPackSNByInspectionLotId(int inspectionLotId)
        {
            List<PackInfo> list = new List<PackInfo>();

            SqlParameter[] param = new SqlParameter[]{
                        new SqlParameter("@InspectionLotId",SqlDbType.Int),
                    };
            param[0].Value = inspectionLotId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPackSNByInspectionLotId", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<PackInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 获取批次、检验项信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public List<InspectionLotMemberInfo> GetInspectionMemberByLotId(int inspectionLotId, string userName, int checkType, int qcType)
        {
            List<InspectionLotMemberInfo> list = new List<InspectionLotMemberInfo>();

            SqlParameter[] param = new SqlParameter[]{
                        new SqlParameter("@InspectionLotId",SqlDbType.Int),
                         new SqlParameter("@UserName",SqlDbType.NVarChar),
                         new SqlParameter("@CheckType",SqlDbType.Int),
                         new SqlParameter("@QCType",SqlDbType.Int),
                    };
            param[0].Value = inspectionLotId;
            param[1].Value = userName;
            param[2].Value = checkType;
            param[3].Value = qcType;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionMemberByLotId", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<InspectionLotMemberInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 提前录入 根据SN获取检验项 ZCL 2018-02-27
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="userName"></param>
        /// <param name="checkType"></param>
        /// <param name="qcType"></param>
        /// <returns></returns>
        public List<InspectionLotMemberInfo> GetInspectionMemberBySN(string sn, string userName, int qcType)
        {
            List<InspectionLotMemberInfo> list = new List<InspectionLotMemberInfo>();

            SqlParameter[] param = new SqlParameter[]{
                        new SqlParameter("@SN",SqlDbType.VarChar),
                         new SqlParameter("@UserName",SqlDbType.VarChar),
                         new SqlParameter("@QCType",SqlDbType.Int),
                    };
            param[0].Value = sn;
            param[1].Value = userName;
            param[2].Value = qcType;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionMemberBySN", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<InspectionLotMemberInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 获取扫描的SN信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public List<InspectionLotMemberSNInfo> GetInspectionLotSNInfo(int inspectionLotMemberId)
        {
            List<InspectionLotMemberSNInfo> list = new List<InspectionLotMemberSNInfo>();

            SqlParameter[] param = new SqlParameter[]{
                        new SqlParameter("@InspectionLotMemberId",SqlDbType.Int)
                    };
            param[0].Value = inspectionLotMemberId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionLotSNInfo", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<InspectionLotMemberSNInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 添加扫描的SN信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="sn"></param>
        /// <param name="userName"></param>
        /// <param name="ncCodeArr"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="value"></param>
        /// <param name="flag">标识 0：校验 1：校验及保存</param>
        public void CollectInspectionLotSNInfo(int inspectionLotId, int inspectionLotMemberId, string sn, string userName, string ncCodeArr, int opeId, int resId, int userId, string value, int flag)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),
                  new SqlParameter("@InspectionLotMemberId",SqlDbType.Int),
                  new SqlParameter("@SN",SqlDbType.NVarChar),
                  new SqlParameter("@UserName",SqlDbType.VarChar),
                  new SqlParameter("@NCCodeArr",SqlDbType.NVarChar),
                  new SqlParameter("@OpeId",SqlDbType.Int),
                  new SqlParameter("@ResId",SqlDbType.Int),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@Value",SqlDbType.VarChar),
                  new SqlParameter("@Flag",SqlDbType.Int)
            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = inspectionLotMemberId;
            parms[2].Value = sn;
            parms[3].Value = userName;
            parms[4].Value = ncCodeArr;
            parms[5].Value = opeId;
            parms[6].Value = resId;
            parms[7].Value = userId;
            parms[8].Value = value;
            parms[9].Value = flag;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotSNInfo", parms);
        }

        /// <summary>
        /// 添加扫描的SN信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="sn"></param>
        /// <param name="userName"></param>
        /// <param name="ncCodeArr"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="value"></param>
        /// <param name="flag">标识 0：校验 1：校验及保存</param>
        public void CollectInspectionLotSNInfoBatch(int inspectionLotId, string inspectionLotMemberIds, string sn, string userName, string ncCodeArr, int opeId, int resId, int userId, string value, int flag)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),
                  new SqlParameter("@InspectionLotMemberIds",SqlDbType.VarChar),
                  new SqlParameter("@SN",SqlDbType.NVarChar),
                  new SqlParameter("@UserName",SqlDbType.VarChar),
                  new SqlParameter("@NCCodeArr",SqlDbType.NVarChar),
                  new SqlParameter("@OpeId",SqlDbType.Int),
                  new SqlParameter("@ResId",SqlDbType.Int),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@Value",SqlDbType.VarChar),
                  new SqlParameter("@Flag",SqlDbType.Int)
            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = inspectionLotMemberIds;
            parms[2].Value = sn;
            parms[3].Value = userName;
            parms[4].Value = ncCodeArr;
            parms[5].Value = opeId;
            parms[6].Value = resId;
            parms[7].Value = userId;
            parms[8].Value = value;
            parms[9].Value = flag;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotSNInfo_Batch", parms);
        }

        /// <summary>
        /// 记录产品SN不良信息
        /// </summary>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="sn"></param>
        /// <param name="ncCode"></param>
        public void CollectInspectionLotNCCodeInfo(int inspectionLotMemberId, string sn, string ncCode, string userName, int userId, int opeId, int resId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionLotMemberId",SqlDbType.Int),
                  new SqlParameter("@SN",SqlDbType.NVarChar),
                  new SqlParameter("@NCCode",SqlDbType.VarChar),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@UserName",SqlDbType.VarChar),
                  new SqlParameter("@OpeId",SqlDbType.Int),
                  new SqlParameter("@ResId",SqlDbType.Int),

            };
            parms[0].Value = inspectionLotMemberId;
            parms[1].Value = sn;
            parms[2].Value = ncCode;
            parms[3].Value = userId;
            parms[4].Value = userName;
            parms[5].Value = opeId;
            parms[6].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotNCCodeInfo", parms);
        }


        /// <summary>
        /// 检验单PASS操作
        /// </summary>
        /// <param name="inspectionLotId"></param>
        public void CollectInspectionLotPass(int inspectionLotId, int passType, string userName, int userId, int stationId, int resId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),
                  new SqlParameter("@PassType",SqlDbType.Int),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@UserName",SqlDbType.NVarChar),
                  new SqlParameter("@StationId",SqlDbType.Int),
                  new SqlParameter("@ResId",SqlDbType.Int)

            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = passType;
            parms[2].Value = userId;
            parms[3].Value = userName;
            parms[4].Value = stationId;
            parms[5].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotPassByLot", parms);
        }

        /// <summary>
        /// 检验单Reject操作
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="stationId"></param>
        /// <param name="userName"></param>
        public void CollectInspectionLotReject(int inspectionLotId, int stationId, string userName, int returnStationId, int userId, int resId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),
                  new SqlParameter("@StationId",SqlDbType.Int),
                  new SqlParameter("@ReturnStationId",SqlDbType.Int),
                  new SqlParameter("@UserName",SqlDbType.NVarChar),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@ResId",SqlDbType.Int),

            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = stationId;
            parms[2].Value = returnStationId;
            parms[3].Value = userName;
            parms[4].Value = userId;
            parms[5].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotRejectByLot", parms);
        }

        /// <summary>
        /// 获取送检批关联的路由信息
        /// </summary>
        /// <param name="inspectionLotMemberId"></param>
        /// <returns></returns>
        public List<StationInfo> GetInspectionLotRouter(int inspectionLotId)
        {
            List<StationInfo> list = new List<StationInfo>();

            SqlParameter[] param = new SqlParameter[]{
                        new SqlParameter("@InspectionLotId",SqlDbType.Int)
                    };
            param[0].Value = inspectionLotId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionLotRouter", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<StationInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 记录SN检验信息 提前录入
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="userName"></param>
        public void CollectInspectionLotRecords(string sn, string userName, int aqlSampleId, string aqlSampleName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@SN",SqlDbType.NVarChar),
                  new SqlParameter("@AQLSampleId",SqlDbType.Int),
                  new SqlParameter("@AQLSampleName",SqlDbType.NVarChar),
                  new SqlParameter("@UserName",SqlDbType.NVarChar),

            };
            parms[0].Value = sn;
            parms[1].Value = aqlSampleId;
            parms[2].Value = aqlSampleName;
            parms[3].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotRecords", parms);
        }

        /// <summary>
        /// 记录SN检验信息【提前录入】
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="userName"></param>
        /// <param name="aqlSampleId"></param>
        /// <param name="aqlSampleName"></param>
        /// <param name="Value"></param>
        /// <param name="Result"></param>
        /// <param name="ncCodes">不良代码</param>
        public void CollectInspectionLotRecordsPre(string sn, string userName, int aqlSampleId, string aqlSampleName, string Value, int Result, string ncCodes)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@SN",SqlDbType.NVarChar),
                  new SqlParameter("@AQLSampleId",SqlDbType.Int),
                  new SqlParameter("@AQLSampleName",SqlDbType.NVarChar),
                  new SqlParameter("@UserName",SqlDbType.NVarChar),
                  new SqlParameter("@Value",SqlDbType.VarChar),
                  new SqlParameter("@Result",SqlDbType.Int),
                  new SqlParameter("@NCCodes",SqlDbType.VarChar)
            };
            parms[0].Value = sn;
            parms[1].Value = aqlSampleId;
            parms[2].Value = aqlSampleName;
            parms[3].Value = userName;
            parms[4].Value = Value;
            parms[5].Value = Result;
            parms[6].Value = ncCodes;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotRecordsByPreSN", parms);
        }

        /// <summary>
        /// 批量记录SN检验信息【提前录入】
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="userName"></param>
        /// <param name="aqlSampleId"></param>
        /// <param name="aqlSampleName"></param>
        /// <param name="Value"></param>
        /// <param name="Result"></param>
        /// <param name="ncCodes">不良代码</param>
        public void CollectInspectionLotRecordsPreBatch(string sn, string userName, string aqlSampleIds, string aqlSampleNames, string Value, int Result, string ncCodes)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@SN",SqlDbType.NVarChar),
                  new SqlParameter("@AQLSampleIds",SqlDbType.VarChar,-1),
                  new SqlParameter("@AQLSampleNames",SqlDbType.NVarChar,-1),
                  new SqlParameter("@UserName",SqlDbType.VarChar,50),
                  new SqlParameter("@Value",SqlDbType.NVarChar,50),
                  new SqlParameter("@Result",SqlDbType.Int),
                  new SqlParameter("@NCCodes",SqlDbType.VarChar,-1)
            };
            parms[0].Value = sn;
            parms[1].Value = aqlSampleIds;
            parms[2].Value = aqlSampleNames;
            parms[3].Value = userName;
            parms[4].Value = Value;
            parms[5].Value = Result;
            parms[6].Value = ncCodes;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotRecordsPreBatch", parms);
        }

        /// <summary>
        /// 获取提前录入的扫描SN信息
        /// </summary>
        /// <returns></returns>
        public List<InspectionLotRecordsInfo> GetInspectionLotRecords(int importType, int aqlSampleId, int itemId, string preSN)
        {
            List<InspectionLotRecordsInfo> list = new List<InspectionLotRecordsInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                         new SqlParameter("@ImportType",SqlDbType.Int),
                         new SqlParameter("@AqlSampleId",SqlDbType.Int) ,
                         new SqlParameter("@ItemId",SqlDbType.Int),
                         new SqlParameter("@PreSN",SqlDbType.VarChar)
                    };
            parms[0].Value = importType;
            parms[1].Value = aqlSampleId;
            parms[2].Value = itemId;
            parms[3].Value = preSN;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionLotRecords", parms))
            {
                list = Utility.Helper.SqlDataReaderConverToList<InspectionLotRecordsInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 记录提前录入产品SN不良信息
        /// </summary>
        /// <param name="inspectionLotRecordsId"></param>
        /// <param name="sn"></param>
        /// <param name="ncCode"></param>
        /// <param name="userName"></param>
        /// <param name="userId"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        public void CollectPreInspectionLotNCCodeInfo(string sn, string ncCode, string userName, int userId, int opeId, int resId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@SN",SqlDbType.NVarChar),
                  new SqlParameter("@NCCode",SqlDbType.VarChar),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@UserName",SqlDbType.VarChar),
                  new SqlParameter("@OpeId",SqlDbType.Int),
                  new SqlParameter("@ResId",SqlDbType.Int),

            };
            parms[0].Value = sn;
            parms[1].Value = ncCode;
            parms[2].Value = userId;
            parms[3].Value = userName;
            parms[4].Value = opeId;
            parms[5].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectPreInspectionLotNCCodeInfo", parms);
        }

        /// <summary>
        /// 切入提前录入的扫描SN信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="userName"></param>
        public void ImportInspectionLotRecords(int inspectionLotId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),
                  new SqlParameter("@UserName",SqlDbType.VarChar),

            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspImportInspectionLotRecords", parms);
        }

        /// <summary>
        /// 删除已抽检的SN信息
        /// </summary>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="sn"></param>
        public void DelInspectionLotMemberSN(int inspectionLotMemberId, string sn)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionLotMemberId",SqlDbType.Int),
                  new SqlParameter("@SN",SqlDbType.VarChar),

            };
            parms[0].Value = inspectionLotMemberId;
            parms[1].Value = sn;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDelInspectionLotMemberSN", parms);
        }

        /// <summary>
        /// 删除当前扫描的包装箱/栈板条码
        /// </summary>
        /// <param name="packSN"></param>
        /// <param name="delLotId"></param>
        public void DelPackSN(string packSN, int inspectionLotId, bool isDelLotId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@PackSN",SqlDbType.VarChar),
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),
                  new SqlParameter("@IsDelLotId",SqlDbType.Bit),

            };
            parms[0].Value = packSN;
            parms[1].Value = inspectionLotId;
            parms[2].Value = isDelLotId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDelPackSN", parms);
        }


        /// <summary>
        /// 取消锁定
        /// </summary>
        /// <param name="entity"></param>
        public void CancelLock(InspectionInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),
                  new SqlParameter("@ModifyBy",SqlDbType.VarChar,20)

            };
            parms[0].Value = entity.InspectionLotId;
            parms[1].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspInspectionLotOQCCancelLock", parms);
        }

        #endregion

        #region FAI首件检验

        /// <summary>
        /// 生成首件检验单号
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="lineId"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <returns></returns>
        public List<FAICodeInfo> GenerateFAICode(int prodOrderId, int stationId, int resouceId, int lineId)
        {
            List<FAICodeInfo> list = new List<FAICodeInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@LineId",SqlDbType.Int),
            };
            param[0].Value = prodOrderId;
            param[1].Value = stationId;
            param[2].Value = resouceId;
            param[3].Value = lineId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGenerateFAICode", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<FAICodeInfo>(rdr);
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 获取检验模板版本号
        /// </summary>
        /// <param name="templateId"></param>
        /// <returns></returns>
        public string GetTemplateVersion(int templateId)
        {
            string version = "";
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@TemplateId",SqlDbType.Int),
            };

            param[0].Value = templateId;

            string sql = "SELECT Version FROM Quality_InspectionTemplate WHERE InspectionTemplateId = @TemplateId ";

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, param))
            {
                if (rdr.Read())
                {
                    version = rdr[0].ToString();
                }

                rdr.Close();
            }

            return version;
        }

        /// <summary>
        /// 采集首件信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public int CollectFAIInspecitonInfo(FAIInspectionInfo entity)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@TemplateId",SqlDbType.Int),
                new SqlParameter("@TemplateVersion",SqlDbType.NVarChar),
                new SqlParameter("@InspectionTypeId",SqlDbType.Int),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@LineId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@FAICode",SqlDbType.NVarChar),
                new SqlParameter("@SampleQty",SqlDbType.Int),
                new SqlParameter("@SendMan",SqlDbType.NVarChar),
                new SqlParameter("@ClassType",SqlDbType.NVarChar),
                new SqlParameter("@UserName",SqlDbType.NVarChar),
                new SqlParameter("@IOrderId",SqlDbType.Int),
                new SqlParameter("@MemberItemStr",SqlDbType.NVarChar),
                new SqlParameter("@FAISNStr",SqlDbType.NVarChar),
            };

            param[0].Value = entity.TemplateId;
            param[1].Value = entity.TemplateVersion;
            param[2].Value = entity.InspectionTypeId;
            param[3].Value = entity.ProdOrderId;
            param[4].Value = entity.LineId;
            param[5].Value = entity.StationId;
            param[6].Value = entity.ResourceId;
            param[7].Value = entity.FAICode;
            param[8].Value = entity.SampleQty;
            param[9].Value = entity.SendMan;
            param[10].Value = entity.ClassType;
            param[11].Value = entity.UserName;
            param[12].Value = entity.IOrderId;
            param[12].Direction = ParameterDirection.InputOutput;
            param[13].Value = entity.MemberItemStr;
            param[14].Value = entity.FAISNStr;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectFAIInspecitonInfo", param);

            return Convert.ToInt32(param[12].Value);
        }

        /// <summary>
        /// 获取首件检验项信息
        /// </summary>
        /// <param name="iorderId"></param>
        /// <param name="templateId"></param>
        /// <returns></returns>
        public List<InspectionTemplateMemberInfo> GetFAITemplateInfo(int iorderId, int templateId)
        {
            List<InspectionTemplateMemberInfo> list = new List<InspectionTemplateMemberInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@IOrderId",SqlDbType.Int),
                new SqlParameter("@TemplateId",SqlDbType.Int),
            };
            param[0].Value = iorderId;
            param[1].Value = templateId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetFAITemplateInfo", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<InspectionTemplateMemberInfo>(rdr);
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 获取首件检验单信息
        /// </summary>
        /// <param name="faiCode"></param>
        /// <returns></returns>
        public FAIInspectionInfo GetFAIInspectionInfo(string faiCode)
        {
            List<FAIInspectionInfo> list = new List<FAIInspectionInfo>();
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@FAICode",SqlDbType.NVarChar),
            };
            param[0].Value = faiCode;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetFAIInspectionInfo", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<FAIInspectionInfo>(rdr);
                rdr.Close();
            }

            return list[0];
        }

        /// <summary>
        /// 获取首件检验SN信息
        /// </summary>
        /// <param name="iorderId"></param>
        /// <returns></returns>
        public List<FAISNInfo> GetFAISNInfo(int iorderId)
        {
            List<FAISNInfo> list = new List<FAISNInfo>();
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@IOrderId",SqlDbType.NVarChar),
            };
            param[0].Value = iorderId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetFAISNInfo", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<FAISNInfo>(rdr);
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 检查录入的SN信息
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="sn"></param>
        public void CheckFAISN(int prodOrderId, string sn)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ProdOrderId",SqlDbType.Int),
                  new SqlParameter("@SN",SqlDbType.VarChar),

            };
            parms[0].Value = prodOrderId;
            parms[1].Value = sn;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckFAISN", parms);
        }
        
        public string GetInspectionItem(int iorderID)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@IOrderID",SqlDbType.Int) {Value=iorderID }
            };
            return ComMethod.GetList("uspGetInspectionItem", param);
        }

        #endregion


        #region EAI末件检验

        /// <summary>
        /// 生成末件检验单号
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="lineId"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <returns></returns>
        public List<EAICodeInfo> GenerateEAICode(int prodOrderId, int stationId, int resouceId, int lineId)
        {
            List<EAICodeInfo> list = new List<EAICodeInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@ProdOrderId",SqlDbType.Int) { Value = prodOrderId},
                new SqlParameter("@StationId",SqlDbType.Int) { Value = stationId},
                new SqlParameter("@ResId",SqlDbType.Int) { Value = resouceId},
                new SqlParameter("@LineId",SqlDbType.Int) { Value = lineId},
            };

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGenerateEAICode", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<EAICodeInfo>(rdr);
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 获取末件检验单信息
        /// </summary>
        /// <param name="faiCode"></param>
        /// <returns></returns>
        public EAIInspectionInfo GetEAIInspectionInfo(string eaiCode)
        {
            List<EAIInspectionInfo> list = new List<EAIInspectionInfo>();
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@EAICode",SqlDbType.NVarChar) { Value = eaiCode},
            }; 
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEAIInspectionInfo", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<EAIInspectionInfo>(rdr);
                rdr.Close();
            }

            return list[0];
        }
        /// <summary>
        /// 获取末件检验项信息
        /// </summary>
        /// <param name="iorderId"></param>
        /// <param name="templateId"></param>
        /// <returns></returns>
        public List<InspectionTemplateMemberInfo> GetEAITemplateInfo(int iorderId, int templateId)
        {
            List<InspectionTemplateMemberInfo> list = new List<InspectionTemplateMemberInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@IOrderId",SqlDbType.Int),
                new SqlParameter("@TemplateId",SqlDbType.Int),
            };
            param[0].Value = iorderId;
            param[1].Value = templateId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEAITemplateInfo", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<InspectionTemplateMemberInfo>(rdr);
                rdr.Close();
            }

            return list;
        }
        /// <summary>
        /// 获取末件检验SN信息
        /// </summary>
        /// <param name="iorderId"></param>
        /// <returns></returns>
        public List<EAISNInfo> GetEAISNInfo(int iorderId)
        {
            List<EAISNInfo> list = new List<EAISNInfo>();
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@IOrderId",SqlDbType.NVarChar),
            };
            param[0].Value = iorderId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEAISNInfo", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<EAISNInfo>(rdr);
                rdr.Close();
            }

            return list;
        }
        /// <summary>
        /// 采集末件信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public int CollectEAIInspecitonInfo(EAIInspectionInfo entity)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@TemplateId",SqlDbType.Int) { Value = entity.TemplateId},
                new SqlParameter("@TemplateVersion",SqlDbType.NVarChar){ Value = entity.TemplateVersion},
                new SqlParameter("@InspectionTypeId",SqlDbType.Int){ Value = entity.InspectionTypeId},
                new SqlParameter("@ProdOrderId",SqlDbType.Int){ Value = entity.ProdOrderId},
                new SqlParameter("@LineId",SqlDbType.Int){ Value = entity.LineId},
                new SqlParameter("@StationId",SqlDbType.Int){ Value = entity.StationId},
                new SqlParameter("@ResourceId",SqlDbType.Int){ Value = entity.ResourceId},
                new SqlParameter("@EAICode",SqlDbType.NVarChar){ Value = entity.EAICode},
                new SqlParameter("@SampleQty",SqlDbType.Int){ Value = entity.SampleQty},
                new SqlParameter("@SendMan",SqlDbType.NVarChar){ Value = entity.SendMan},
                new SqlParameter("@ClassType",SqlDbType.NVarChar){ Value = entity.ClassType},
                new SqlParameter("@UserName",SqlDbType.NVarChar){ Value = entity.UserName},
                new SqlParameter("@IOrderId",SqlDbType.Int){ Value = entity.IOrderId, Direction = ParameterDirection.InputOutput},
                new SqlParameter("@MemberItemStr",SqlDbType.NVarChar){ Value = entity.MemberItemStr},
                new SqlParameter("@EAISNStr",SqlDbType.NVarChar){ Value = entity.EAISNStr},
            };
             
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectEAIInspecitonInfo", param);

            return Convert.ToInt32(param[12].Value);
        }

        /// <summary>
        /// 检查录入的SN信息(末件)
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="sn"></param>
        public void CheckEAISN(int prodOrderId, string sn)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ProdOrderId",SqlDbType.Int) { Value = prodOrderId},
                  new SqlParameter("@SN",SqlDbType.VarChar) { Value = sn},

            }; 

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckEAISN", parms);
        }
        #endregion

        /// <summary>
        /// 添加扫描的SN信息
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="sn"></param>
        /// <param name="userName"></param>
        /// <param name="ncCodeArr"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="value"></param>
        /// <param name="flag">标识 0：校验 1：校验及保存</param>
        public void CollectPQCInspectionLotSNInfo(int inspectionLotId, int inspectionLotMemberId, string sn, string userName, string ncCodeArr, int opeId, int resId, int userId, string value, int flag)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),
                  new SqlParameter("@InspectionLotMemberId",SqlDbType.Int),
                  new SqlParameter("@SN",SqlDbType.NVarChar),
                  new SqlParameter("@UserName",SqlDbType.VarChar),
                  new SqlParameter("@NCCodeArr",SqlDbType.NVarChar),
                  new SqlParameter("@OpeId",SqlDbType.Int),
                  new SqlParameter("@ResId",SqlDbType.Int),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@Value",SqlDbType.VarChar),
                  new SqlParameter("@Flag",SqlDbType.Int)
            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = inspectionLotMemberId;
            parms[2].Value = sn;
            parms[3].Value = userName;
            parms[4].Value = ncCodeArr;
            parms[5].Value = opeId;
            parms[6].Value = resId;
            parms[7].Value = userId;
            parms[8].Value = value;
            parms[9].Value = flag;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectPQCInspectionLotSNInfo_New", parms);
        }
        /// <summary>
        /// 批量处理SN全通过OK---2019-12-26
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="sn"></param>
        /// <param name="userName"></param>
        /// <param name="value"></param>
        public void CollectInspectionLotSNInfoBatch_PQC(int inspectionLotId, string sn, string userName, string value)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),
                  new SqlParameter("@SN",SqlDbType.NVarChar),
                  new SqlParameter("@UserName",SqlDbType.VarChar),
                  new SqlParameter("@Value",SqlDbType.VarChar)
            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = sn;
            parms[2].Value = userName;
            parms[3].Value = value;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAutoTotalPassingSave_PQC", parms);
        }

        /// <summary>
        /// 检验单PASS操作
        /// </summary>
        /// <param name="inspectionLotId"></param>
        public void CollectInspectionLotSplitPass(int inspectionLotId, int passType, string userName, int userId, int stationId, int resId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),
                  new SqlParameter("@PassType",SqlDbType.Int),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@UserName",SqlDbType.NVarChar),
                  new SqlParameter("@StationId",SqlDbType.Int),
                  new SqlParameter("@ResId",SqlDbType.Int)

            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = passType;
            parms[2].Value = userId;
            parms[3].Value = userName;
            parms[4].Value = stationId;
            parms[5].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotSplitPassByLot", parms);
        }
        /// <summary>
        /// 获取送检批关联的路由信息
        /// </summary>
        /// <param name="inspectionLotMemberId"></param>
        /// <param name="RejectType">回流类型：0-reject ,1-强制reject</param>
        /// <returns></returns>
        public List<StationInfo> GetInspectionLotRouter_ForceReject(int inspectionLotId, int RejectType)
        {
            List<StationInfo> list = new List<StationInfo>();

            SqlParameter[] param = new SqlParameter[]{
                        new SqlParameter("@InspectionLotId",SqlDbType.Int),
                        new SqlParameter("@RejectType",SqlDbType.Int)
                    };
            param[0].Value = inspectionLotId;
            param[1].Value = RejectType;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionLotRouter_ForceReject", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<StationInfo>(rdr);
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 检验单强制Reject操作(PQC批次检验UI)
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="stationId"></param>
        /// <param name="userName"></param>
        public void CollectInspectionLotForceReject(int inspectionLotId, int stationId, string userName, int returnStationId, int userId, int resId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionLotId",SqlDbType.Int),
                  new SqlParameter("@StationId",SqlDbType.Int),
                  new SqlParameter("@ReturnStationId",SqlDbType.Int),
                  new SqlParameter("@UserName",SqlDbType.NVarChar),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@ResId",SqlDbType.Int),

            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = stationId;
            parms[2].Value = returnStationId;
            parms[3].Value = userName;
            parms[4].Value = userId;
            parms[5].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotForceRejectByLot", parms);
        }

        /// <summary>
        /// 检验单Reject操作 pqc
        /// </summary>
        /// <param name="inspectionLotId"></param>
        /// <param name="stationId"></param>
        /// <param name="userName"></param>
        public void CollectInspectionLotRejectPQC(int inspectionLotId, int stationId, string userName, int returnStationId, int userId, int resId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@InspectionLotId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ReturnStationId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),

            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = stationId;
            parms[2].Value = returnStationId;
            parms[3].Value = userName;
            parms[4].Value = userId;
            parms[5].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotRejectByLotPQC", parms);
        }

        /// <summary>
        /// 检验单PASS操作
        /// </summary>
        /// <param name="inspectionLotId"></param>
        public void CollectInspectionLotPassPQC(int inspectionLotId, int passType, string userName, int userId, int stationId, int resId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@InspectionLotId",SqlDbType.Int),
                new SqlParameter("@PassType",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int)

            };
            parms[0].Value = inspectionLotId;
            parms[1].Value = passType;
            parms[2].Value = userId;
            parms[3].Value = userName;
            parms[4].Value = stationId;
            parms[5].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectInspectionLotPassPQCByLot", parms);
        }
    }
}
