using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ProductionCollection.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.ProductionCollection.Client
{
    public class ProdCollectionRepair
    {
        #region 不良接收

        /// <summary>
        /// 检测扫描的SN条码信息是否需要维修，是否已经接收过
        /// </summary>
        /// <param name="sn"></param>
        public string CheckReceiveSN(string sn)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar),
                new SqlParameter("@MainSN",SqlDbType.NVarChar,100),
            };

            param[0].Value = sn;
            param[1].Value = "";
            param[1].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckReceiveSN", param);

            return Convert.ToString(param[1].Value);
        }

        /// <summary>
        /// 检查扫描的维修SN，如果扫的是部件带出主件SN
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public string CheckRepairSN(string sn,int stationId,int resouceId,int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ReouceId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@MainSN",SqlDbType.NVarChar,100),
            };

            param[0].Value = sn;
            param[1].Value = stationId;
            param[2].Value = resouceId;
            param[3].Value = userId;
            param[4].Value = "";
            param[4].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckRepairSN", param);

            return Convert.ToString(param[4].Value);
        }

        /// <summary>
        /// 保存不良接收信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="receiveUserId"></param>
        /// <param name="userId"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        public void CollectReceiveSN(string sn, int receiveUserId, int userId, int stationId, int resId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar),
                new SqlParameter("@ReceiveUserId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
            };

            param[0].Value = sn;
            param[1].Value = receiveUserId;
            param[2].Value = userId;
            param[3].Value = stationId;
            param[4].Value = resId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectReceiveSN", param);
        }

        #endregion

        #region 不良维修

        /// <summary>
        /// 获取具体产品相关的不良明细
        /// </summary>
        /// <param name="sn">产品条码</param>    
        /// <returns></returns>
        public DataTable GetNCDataInfo(string sn, string status)
        {
            DataTable dt = new DataTable();
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@Status",SqlDbType.VarChar)
            };
            paras[0].Value = sn;
            paras[1].Value = status;
            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetNCCodeDetail", paras);
            return dt;
        }

        /// <summary>
        /// 获取不良详情描述信息
        /// </summary>
        /// <param name="ncDataId">不良记录ID</param>
        /// <returns></returns>
        public DataTable GetNcDataDesc(int ncDataId)
        {
            DataTable dt = new DataTable();
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@NCDataId",SqlDbType.VarChar),
            };
            paras[0].Value = ncDataId;

            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetNCCodeDesc", paras);
            return dt;
        }

        /// <summary>
        /// <不良维修--查询工序绑定的不良检测代码>
        /// </summary>
        /// <param name="sn">产品条码</param>
        /// <param name="debugCode">检测代码</param>
        /// <returns></returns>
        public DataTable GetNCDebugCodeList(string sn, string debugCode, int OpeId)
        {
            DataTable dt = new DataTable();
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@NCDebugCode",SqlDbType.VarChar),
                new SqlParameter("@OpeId",SqlDbType.Int)
            };
            paras[0].Value = sn;
            paras[1].Value = debugCode;
            paras[2].Value = OpeId;

            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetNCDebugCodeList", paras);
            return dt;
        }

        /// <summary>
        /// <不良维修--查询工序绑定的不良维修代码>
        /// </summary>
        /// <param name="sn">产品条码</param>
        /// <param name="repairCode">维修代码</param>
        /// <returns></returns>
        public DataTable GetNCRepairCodeList(string sn, string repairCode, int OpeId)
        {
            DataTable dt = new DataTable();
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@NCRepairCode",SqlDbType.VarChar),
                new SqlParameter("@OpeId",SqlDbType.Int)
            };
            paras[0].Value = sn;
            paras[1].Value = repairCode;
            paras[2].Value = OpeId;

            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetNCRepairCodeList", paras);
            return dt;
        }

        /// <summary>
        /// <不良维修--查询检测代码数据收集项>
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="repairCode"></param>
        /// <returns></returns>
        public DataTable GetNCCodeDataField(int ncCodeId)
        {
            DataTable dt = new DataTable();
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@NCCodeId",SqlDbType.VarChar),
            };
            paras[0].Value = ncCodeId;

            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetNCCodeDataField", paras);
            return dt;
        }

        /// <summary>
        /// 查询不良维修完成后的目的工位
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="opeId"></param>
        /// <returns></returns>
        public DataTable GetRepairNextStation(string sn, int opeId)
        {
            DataTable dt = new DataTable();
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@StationId",SqlDbType.Int),
            };
            paras[0].Value = sn;
            paras[1].Value = opeId;

            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetRepairNextStation", paras);
            return dt;
        }

        /// <summary>
        /// 查询不良代码列表
        /// </summary>
        /// <param name="category">不良类别</param>
        /// <param name="nccode">不良代码</param>
        /// <returns></returns>
        public DataTable GetNCCodeList(string category, string nccode)
        {
            DataTable dt = new DataTable();
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@Category",SqlDbType.VarChar),
                new SqlParameter("@NCCode",SqlDbType.VarChar),
            };
            paras[0].Value = category;
            paras[1].Value = nccode;

            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetNCCodeList", paras);
            return dt;
        }

        /// <summary>
        /// 更新不良记录的不良点 
        /// </summary>
        /// <param name="ncDataId">不良记录ID</param>
        /// <param name="ncCodeId">不良代码ID</param>
        public void UpdateTypeInNCCode(int ncDataId, int ncCodeId)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@NCDataId",SqlDbType.Int),
                new SqlParameter("@NCCodeId",SqlDbType.Int),
            };
            param[0].Value = ncDataId;
            param[1].Value = ncCodeId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUpdateTypeInNCCode", param);
        }

        /// <summary>
        /// 保存维修记录 如果有组件变更保存组装信息，以及部件变更记录。
        /// </summary>
        /// <param name="unitId"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="data"></param>
        /// <param name="bomId"></param>
        /// <param name="assyDataChangeRecords"></param>
        public void SynthesisRepairPartsChange(int unitId, int opeId, int resId, int userId, string data, int bomId, string assyDataChangeRecords)
        {

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@unitid",System.Data.SqlDbType.Int),
                    new SqlParameter("@opeid",System.Data.SqlDbType.Int),
                    new SqlParameter("@resid",System.Data.SqlDbType.Int),
                    new SqlParameter("@userid",System.Data.SqlDbType.Int),
                    new SqlParameter("@data",System.Data.SqlDbType.NVarChar,2000),
                    new SqlParameter("@BOMID",System.Data.SqlDbType.Int),
                    new SqlParameter("@AssyDataChangeRecords",System.Data.SqlDbType.Xml)
                };

            parms[0].Value = unitId;
            parms[1].Value = opeId;
            parms[2].Value = resId;
            parms[3].Value = userId;
            parms[4].Value = data;
            parms[5].Value = bomId;
            parms[6].Value = assyDataChangeRecords;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSynthesisRepairPartsChange", parms);
        }

        /// <summary>
        /// <不良维修--产品条码所有不良维修完成后产品过站>
        /// </summary>
        /// <param name="unitID"></param>
        /// <param name="opeID">当前操作的工位</param>
        /// <param name="stationID">指定的过站工位</param>
        /// <param name="userID"></param>
        /// <param name="resID"></param>
        /// <param name="passType">
        /// 过站类型 
        /// 1、默认工位过站（维修后的目的工位只有一个） 
        ///	2、指定工位过站（维修后有多个目的工位可以选择）
        /// </param>
        public void NcRepairUnitComplete(Int64 unitID, int opeID, int stationID, int userID, int resID, int passType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                      new SqlParameter("@UnitID",System.Data.SqlDbType.Int),
                    new SqlParameter("@OpeID",System.Data.SqlDbType.Int),
                    new SqlParameter("@StationID",System.Data.SqlDbType.Int),
                    new SqlParameter("@UserID",System.Data.SqlDbType.Int),
                    new SqlParameter("@ResID",System.Data.SqlDbType.Int),
                    new SqlParameter("@PassType",System.Data.SqlDbType.Int),
                };

            parms[0].Value = unitID;
            parms[1].Value = opeID;
            parms[2].Value = stationID;
            parms[3].Value = userID;
            parms[4].Value = resID;
            parms[5].Value = passType;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspNcRepairUnitComplete", parms);

        }

        /// <summary>
        /// 产品手动报废
        /// </summary>
        /// <param name="SN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="gotoStationId"></param>
        /// <param name="userId"></param>
        public void SaveSNScrap(string SN, int stationId, int resourceId, int gotoStationId, int userId, int passType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SN",System.Data.SqlDbType.NVarChar),
                    new SqlParameter("@StationId",System.Data.SqlDbType.Int),
                    new SqlParameter("@ResourceId",System.Data.SqlDbType.Int),
                    new SqlParameter("@GotoStationId",System.Data.SqlDbType.Int),
                    new SqlParameter("@UserId",System.Data.SqlDbType.Int),
                    new SqlParameter("@PassType",System.Data.SqlDbType.Int)
                };

            parms[0].Value = SN;
            parms[1].Value = stationId;
            parms[2].Value = resourceId;
            parms[3].Value = gotoStationId;
            parms[4].Value = userId;
            parms[5].Value = passType;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveSNScrap", parms);

        }
        #endregion


        /// <summary>
        /// 物料更换
        /// </summary>
        /// <param name="entity"></param>
        public void MaterialReplace(NcReplaceMaterialInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@NcDataId",System.Data.SqlDbType.Int),
                    new SqlParameter("@NcPosition",System.Data.SqlDbType.VarChar,50),
                    new SqlParameter("@ItemCode",System.Data.SqlDbType.VarChar,50),
                    new SqlParameter("@GRN",System.Data.SqlDbType.VarChar,50),
                    new SqlParameter("@ReplaceGRN",System.Data.SqlDbType.VarChar,50),
                    new SqlParameter("@Qty",System.Data.SqlDbType.Int),
                    new SqlParameter("@UserName",System.Data.SqlDbType.VarChar,20)
                };
            parms[0].Value = entity.NcDataId;
            parms[1].Value = entity.NcPosition;
            parms[2].Value = entity.ItemCode;
            parms[3].Value = entity.GRN;
            parms[4].Value = entity.ReplaceGRN;
            parms[5].Value = entity.Qty;
            parms[6].Value = entity.UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaterialReplace", parms);
        }


        /// <summary>
        /// 维修更换物料列表
        /// </summary>
        /// <param name="entity"></param>
        public IList<NcReplaceMaterialInfo> GetRepairReplaceMaterial(NcReplaceMaterialInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",System.Data.SqlDbType.VarChar,50),
                //new SqlParameter("@ItemId",System.Data.SqlDbType.VarChar,50)
                };
            parms[0].Value = entity.SN;
            //parms[1].Value = entity.ItemId;
            return ComMethod.GetList<NcReplaceMaterialInfo>("uspGetRepairReplaceMaterial", parms);
        }


        
        #region RMA维修

        /// <summary>
        /// 获取RMA单信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public DataTable GetRMAInfo(string sn)
        {
            DataTable dt = new DataTable();
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.VarChar)
            };
            paras[0].Value = sn;

            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetRMAInfo", paras);
            return dt;
        }

        /// <summary>
        /// 获取扫描SN的不良代码记录
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public DataTable GetRMANcCode(string sn)
        {
            DataTable dt = new DataTable();
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.VarChar)
            };
            paras[0].Value = sn;

            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetRMANCCodeList", paras);
            return dt;
        }

        /// <summary>
        /// 采集RMA维修代码的保固期 是否保内信息
        /// </summary>
        /// <param name="unitId"></param>
        /// <param name="warrantyDate"></param>
        /// <param name="isWarranty"></param>
        public void CollectRMARepairInfo(Int64 unitId, string warrantyDate, bool isWarranty, int userId, int stationId, int resourceId)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@UnitId",SqlDbType.BigInt),
                new SqlParameter("@WarrantyDate",SqlDbType.DateTime),
                new SqlParameter("@IsWarranty",SqlDbType.Bit),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@StationId",System.Data.SqlDbType.Int),
                new SqlParameter("@ResouceId",System.Data.SqlDbType.Int),
            };
            param[0].Value = unitId;
            param[1].Value = warrantyDate;
            param[2].Value = isWarranty;
            param[3].Value = userId;
            param[4].Value = stationId;
            param[5].Value = resourceId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectRMARepairInfo", param);
        }

        #endregion
    }
}
