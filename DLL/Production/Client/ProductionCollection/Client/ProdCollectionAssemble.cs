using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.ProductionCollection.Model;
namespace SKT.LeanMES.ProductionCollection.Client
{
    public class ProdCollectionAssemble
    {
        #region 综合组装（自制/外购）

        /// <summary>
        /// 组装在线SN(自制产品)及GRN
        /// </summary>
        /// <param name="sn">部件条码</param>
        /// <param name="mainSN">主件条码</param>
        /// <param name="userId">用户ID</param>
        /// <param name="stationId">工序ID</param>
        /// <param name="resId">资源ID</param>
        public void AssyDataActivity(string sn, string mainSN, int stationId, int resId, int userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@RelationNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@OpeID",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int),
                 new SqlParameter("@UserID",SqlDbType.Int),
            };

            parms[0].Value = sn;
            parms[1].Value = mainSN;
            parms[2].Value = stationId;
            parms[3].Value = resId;
            parms[4].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAssyDataActivity", parms);
        }


        /// <summary>
        /// 查询装配信息，FieldValue 返回已装配的内容列表;结合CompCount，AssSequence，HasCompCount三者可以计算当前用户需扫描的装配信息.
        /// </summary>
        /// <param name="serialNumber"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        public DataTable GetAssembleList(string serialNumber, int stationId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@StationId",SqlDbType.Int)
            };

            param[0].Value = serialNumber;
            param[1].Value = stationId;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetAssembleListBySN", param);
        }

        /// <summary>
        /// 根据主件SN获取已装配好的子件信息
        /// </summary>
        /// <param name="mainSN"></param>
        /// <returns></returns>
        public List<Model.AssyDataPartInfo> GetAssyDataInfoBySN(string mainSN, int stationId)
        {
            List<Model.AssyDataPartInfo> list = new List<Model.AssyDataPartInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@MainSN",SqlDbType.NVarChar,512) ,
                new SqlParameter("@StationId",SqlDbType.VarChar)
            };
            param[0].Value = mainSN;
            param[1].Value = stationId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetAssyPartsInfo", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<Model.AssyDataPartInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 组件解绑
        /// </summary>
        /// <param name="unitAssyDataIds"></param>
        /// <param name="unBindType"></param>
        /// <param name="sn"></param>
        /// <param name="userId"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        public void UnBindAssyDataInfo(string unitAssyDataIds, int unBindType, string sn, int userId, int opeId, int resId, string isOffline, int ncDataId)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@UnitAssyDataIds",SqlDbType.VarChar),
                new SqlParameter("@UnBindType",SqlDbType.Int),
                new SqlParameter("@SN",SqlDbType.VarChar),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@OpeID",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int),
                new SqlParameter("@IsOffline",SqlDbType.VarChar),
                new SqlParameter("@NCDataId",SqlDbType.Int)
            };
            param[0].Value = unitAssyDataIds;
            param[1].Value = unBindType;
            param[2].Value = sn;
            param[3].Value = userId;
            param[4].Value = opeId;
            param[5].Value = resId;
            param[6].Value = isOffline;
            param[7].Value = ncDataId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAssDataUnBind", param);
        }

        /// <summary>
        /// 根据部件条码获取需要收集的数据信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public List<AssyDataDetailInfo> GetAssyDataDetailInfo(string sn, string mainSN)
        {
            List<AssyDataDetailInfo> list = new List<AssyDataDetailInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512) ,
                new SqlParameter("@MainSN",SqlDbType.NVarChar,512)
            };
            param[0].Value = sn;
            param[1].Value = mainSN;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetDataFieldInfo", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<AssyDataDetailInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 数据采集详情新增、修改
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="AssyXml"></param>
        public void AssyDataDetailEdit(string sn, string AssyXml)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@AssyXml",SqlDbType.NVarChar)
            };
            param[0].Value = sn;
            param[1].Value = AssyXml;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAssyDataDetailEdit", param);
        }

        /// <summary>
        /// 获取产品离线条码组装信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public DataTable GetOfflineSNList(string sn, int stationId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SerialNumber", SqlDbType.NVarChar,512),
                    new SqlParameter("@StationId", SqlDbType.Int),
                };

            parms[0].Value = sn;
            parms[1].Value = stationId;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetOfflineSNList", parms);
        }


        #endregion

        #region 离线条码绑定

        /// <summary>
        /// 获取离线条码采集配置信息
        /// </summary>
        /// <param name="mainSN"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        public List<OfflineSNConfigInfo> GetOfflineSNConfig(string mainSN, int stationId)
        {
            List<OfflineSNConfigInfo> list = new List<OfflineSNConfigInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512) ,
                new SqlParameter("@StationId",SqlDbType.Int),
            };
            param[0].Value = mainSN;
            param[1].Value = stationId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetOfflineSNConfig", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<OfflineSNConfigInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 检测离线条码是否被组装
        /// </summary>
        /// <returns></returns>
        public bool CheckOfflineSNIsAssy(string offlineSN)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@OfflineSN",SqlDbType.NVarChar,512),
            };
            parms[0].Value = offlineSN;
            int offlineSNDetailId = -1;
            string sql = "select OfflineSNDetailId from Prod_OfflineSNDetail where PartSN=@OfflineSN";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, parms))
            {
                if (rdr.Read())
                {
                    offlineSNDetailId = rdr.GetInt32(0);
                }
            }

            return offlineSNDetailId > 0 ? true : false;
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
        public void OfflineSNDetailEdit(string offlineSNConfigId, string mainSN, string partItemId, string partSN, string assyStationId, string user, int resId, int userId, int stationId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@OfflineSNConfigId",SqlDbType.VarChar),
                  new SqlParameter("@MainSN",SqlDbType.VarChar,50),
                  new SqlParameter("@PartItemId",SqlDbType.VarChar),
                  new SqlParameter("@PartSN",SqlDbType.VarChar),
                  new SqlParameter("@AssyStationId",SqlDbType.VarChar),
                  new SqlParameter("@CreateBy",SqlDbType.VarChar,20),
                  new SqlParameter("@ResId",SqlDbType.Int),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@StationId",SqlDbType.Int),

            };
            parms[0].Value = offlineSNConfigId;
            parms[1].Value = mainSN;
            parms[2].Value = partItemId;
            parms[3].Value = partSN;
            parms[4].Value = assyStationId;
            parms[5].Value = user;
            parms[6].Value = resId;
            parms[7].Value = userId;
            parms[8].Value = stationId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOfflineSNDetailEdit", parms);
        }

        /// <summary>
        /// 添加离线条码详情信息--组装UI使用
        /// </summary>
        /// <param name="offlineSNConfigId"></param>
        /// <param name="mainSN"></param>
        /// <param name="partItemId"></param>
        /// <param name="partSN"></param>
        /// <param name="assyStationId"></param>
        /// <param name="user"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="stationId"></param>
        public void OfflineSNDetailEditAssy(int offlineSNConfigId, string mainSN, int partItemId, string partSN, int assyStationId, string user, int resId, int userId, int stationId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@OfflineSNConfigId",SqlDbType.Int),
                  new SqlParameter("@MainSN",SqlDbType.NVarChar,512),
                  new SqlParameter("@PartItemId",SqlDbType.Int),
                  new SqlParameter("@PartSN",SqlDbType.NVarChar,512),
                  new SqlParameter("@AssyStationId",SqlDbType.Int),
                  new SqlParameter("@CreateBy",SqlDbType.VarChar,20),
                  new SqlParameter("@ResId",SqlDbType.Int),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@StationId",SqlDbType.Int),

            };
            parms[0].Value = offlineSNConfigId;
            parms[1].Value = mainSN;
            parms[2].Value = partItemId;
            parms[3].Value = partSN;
            parms[4].Value = assyStationId;
            parms[5].Value = user;
            parms[6].Value = resId;
            parms[7].Value = userId;
            parms[8].Value = stationId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOfflineSNDetailEditAssy", parms);
        }


        #endregion

        #region 烽火投入
        
        ///获取烽火投入 离线条码采集配置信息   
        public List<OfflineSNConfigInfo> GetInputOfflineSNConfig(string mainSN, int stationId, int resouceId, int prodOrderId, int userId)
        {
            List<OfflineSNConfigInfo> list = new List<OfflineSNConfigInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512) ,
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResouceId",SqlDbType.Int),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
            };
            param[0].Value = mainSN;
            param[1].Value = stationId;
            param[2].Value = resouceId;
            param[3].Value = prodOrderId;
            param[4].Value = userId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInputOfflineSNConfig", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<OfflineSNConfigInfo>(rdr);
                rdr.Close();
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
        public void CheckInputOfflineSN(string mainSN, int stationId, int resouceId, int prodOrderId, int userId,string partType,string firstScanSN)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512) ,
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResouceId",SqlDbType.Int),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@PartType",SqlDbType.VarChar),
                new SqlParameter("@FirstScanSN",SqlDbType.VarChar),
            };
            param[0].Value = mainSN;
            param[1].Value = stationId;
            param[2].Value = resouceId;
            param[3].Value = prodOrderId;
            param[4].Value = userId;
            param[5].Value = partType;
            param[6].Value = firstScanSN;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckInputOfflineSN", param);
        }
        
        #endregion
    }
}
