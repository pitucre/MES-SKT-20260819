using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Container.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Container.BLL
{
    public class ContainerWeight
    {
        private Int32 recordCount = 0;
        public List<ContainerWeightInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ContainerWeightInfo> list = new List<ContainerWeightInfo>();
            ContainerWeightInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[vwContainerWeight]", "[ContainerWeightId]",
             "[ContainerWeightId], [ItemCode], [ItemID], [PackingType], [MinWeight], [MaxWeight],[UnitId], [UnitName], [CreateBy], [CreateDateTime],[modifyBy],[modifyDateTime],ProdOrderId,TypeId,OrderNO", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ContainerWeightInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetString(3),Convert.ToDecimal(rdr[rdr.GetOrdinal("MinWeight")]) ,
                        Convert.ToDecimal(rdr[rdr.GetOrdinal("MaxWeight")]), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDateTime(9), rdr.GetString(10), rdr.GetDateTime(11));
                    list.Add(entity);
                    entity.ProdOrderId = rdr.GetInt32(12);
                    entity.TypeId = rdr.GetInt32(13);
                    entity.OrderNO = rdr.GetString(14);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list.OrderByDescending(t => t.CreateDateTime).ToList();
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 编辑（添加或更新） Container 信息。
        /// </summary>
        /// <param name="entity">Container 实体对象。</param>
        public Int32 Edit(ContainerWeightInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@containerWeightId", SqlDbType.Int),
                new SqlParameter("@itemCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@packingType", SqlDbType.NVarChar, 20),
                new SqlParameter("@minWeight", SqlDbType.Decimal),
                new SqlParameter("@maxWeight", SqlDbType.Decimal),
                new SqlParameter("@unitId", SqlDbType.VarChar),
                new SqlParameter("@createBy", SqlDbType.VarChar,20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar,20),
                new SqlParameter("@TypeId", SqlDbType.Int),
                new SqlParameter("@ProdOrderId", SqlDbType.Int),
            };
            parms[0].Value = entity.ContainerWeightId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ItemCode;
            parms[2].Value = entity.PackingType;
            parms[3].Value = Convert.ToDecimal(entity.MinWeight);
            parms[4].Value = Convert.ToDecimal(entity.MaxWeight);
            parms[5].Value = entity.UnitId;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.TypeId;
            parms[9].Value = entity.ProdOrderId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ContainerWeight_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 获取包装重量实体
        /// </summary>
        /// <param name="containerWeightId"></param>
        /// <returns></returns>
        public ContainerWeightInfo GetInfo(Int32 containerWeightId)
        {
            ContainerWeightInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@containerWeightId", SqlDbType.Int)
            };

            parms[0].Value = containerWeightId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ContainerWeight_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ContainerWeightInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetString(3), Convert.ToDecimal(rdr[rdr.GetOrdinal("MinWeight")]),
                        Convert.ToDecimal(rdr[rdr.GetOrdinal("MaxWeight")]), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDateTime(9), rdr.GetString(10), rdr.GetDateTime(11));
                    entity.ProdOrderId = rdr.GetInt32(12);
                    entity.TypeId = rdr.GetInt32(13);
                    entity.OrderNO = rdr.GetString(14);

                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ContainerWeight_Delete", parms);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sn">传入的条码</param>
        /// <returns></returns>
        public List<ContainerWeightInfo> GetSN(string sn)
        {
            List<ContainerWeightInfo> list = new List<ContainerWeightInfo>();
            ContainerWeightInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@sn", SqlDbType.NVarChar)
            };

            parms[0].Value = sn;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "[Basal_PackingWeightRange]", parms))
            {
                while (rdr.Read())
                {
                    entity = new ContainerWeightInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetDecimal(4),
                       rdr.GetDecimal(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDateTime(9), rdr.GetString(10), rdr.GetDateTime(11));
                    list.Add(entity);

                }
                rdr.Close();
            }

            return list;
        }

        public string[] GetWeighBySN(string scanSN, string weightValue, int stationId, string userName, int Isflag)
        {
            string[] packArr = new string[1];
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@Weight",SqlDbType.NChar),
                new SqlParameter("@IsWeigh",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar)
            };
            param[0].Value = scanSN;
            param[1].Value = weightValue;
            param[2].Value = Isflag;
            param[2].Direction = ParameterDirection.InputOutput;
            param[3].Value = stationId;
            param[4].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspContainerWeightBySN", param);
            packArr[0] = Convert.ToString(param[2].Value);
            return packArr;
        }

        public void WeightByPacking(string scanSN, string weightValue, string userName)
        {

            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@Weight",SqlDbType.NChar),
                new SqlParameter("@UserName",SqlDbType.NVarChar)
            };
            param[0].Value = scanSN;
            param[1].Value = weightValue;
            param[2].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "[uspContainerWeightByPacking]", param);

        }

        #region 称重管理
        /// <summary>
        /// 检验扫描条码的重量范围
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="weight"></param>
        /// <param name="stationId"></param>
        public void CheckSNWeight(string sn, decimal weight, int stationId, int resouceId, string userName, int userId,int weightType)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar),
                new SqlParameter("@Weight",SqlDbType.Decimal),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResouceId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@WeightType",SqlDbType.Int),
            };
            param[0].Value = sn;
            param[1].Value = weight;
            param[2].Value = stationId;
            param[3].Value = resouceId;
            param[4].Value = userName;
            param[5].Value = userId;
            param[6].Value = weightType;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckSNWeight", param);
        }

        /// <summary>
        /// 产品称重不在标准范围时强制过站
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="weight"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userName"></param>
        /// <param name="userId"></param>
        /// <param name="byPassUserName"></param>
        public void ByPassSNWeight(string sn, decimal weight, int stationId, int resouceId, string userName, int userId, string byPassUserName)
        {
            SqlParameter[] param = new SqlParameter[]
           {
                new SqlParameter("@SN",SqlDbType.NVarChar),
                new SqlParameter("@Weight",SqlDbType.Decimal),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResouceId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar),
                new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@ByPassUserName",SqlDbType.NVarChar),
           };
            param[0].Value = sn;
            param[1].Value = weight;
            param[2].Value = stationId;
            param[3].Value = resouceId;
            param[4].Value = userName;
            param[5].Value = userId;
            param[6].Value = byPassUserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspByPassSNWeight", param);
        }
        #endregion
    }
}
