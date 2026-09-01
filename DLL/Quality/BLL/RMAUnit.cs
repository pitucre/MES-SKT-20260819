using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Quality.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class RMAUnit
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） RMAUnit 信息。
        /// </summary>
        /// <param name="entity">RMAUnit 实体对象。</param>
        public void Edit(RMAUnitInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RMAUnitID", SqlDbType.BigInt),
                new SqlParameter("@RMAID", SqlDbType.Int),
                new SqlParameter("@SerialNumber", SqlDbType.VarChar, 200),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@FailCode", SqlDbType.Int),
                new SqlParameter("@cWhCode", SqlDbType.VarChar, 20),
                new SqlParameter("@cBarCode", SqlDbType.VarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.RMAUnitID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.RMAID;
            parms[2].Value = entity.SerialNumber;
            parms[3].Value = entity.Status;
            parms[4].Value = entity.FailCode;
            parms[5].Value = entity.cWhCode;
            parms[6].Value = entity.cBarCode;
            parms[7].Value = entity.CreateBy;
            parms[8].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_RMAUnit_Edit", parms);
            
        }

        /// <summary>
        /// 根据 RMAUnitId 字符串删除 RMAUnit 信息。
        /// </summary>
        /// <param name="idString">RMAUnitId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(int idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_RMAUnit_Delete", parms);
        }

        /// <summary>
        /// 根据 RMAUnitId 获取实体信息。
        /// </summary>
        /// <param name="rMAUnitId">RMAUnitId。</param>
        /// <returns>RMAUnit 实体对象。</returns>
        public RMAUnitInfo GetInfo(Int32 rMAUnitId)
        {
            RMAUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = rMAUnitId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_RMAUnit_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new RMAUnitInfo(rdr.GetInt64(0), rdr.GetInt32(1), rdr.GetInt64(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>RMAUnit 实体对象。</returns>
        public RMAUnitInfo GetInfo(String fieldValue)
        {
            RMAUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_RMAUnit_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new RMAUnitInfo(rdr.GetInt64(0), rdr.GetInt32(1), rdr.GetInt64(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 RMAUnit 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="rMAUnitCount">rMAUnit 总数。</param>
        /// <returns>RMAUnit 列表。</returns>
        public List<RMAUnitInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<RMAUnitInfo> list = new List<RMAUnitInfo>();
            RMAUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwRMAUnit", "RMAUnitId",
                "[RMAUnitID], [RMAID], [UnitID], [Status], [FailCode], [cWhCode], [cBarCode], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], RmaNo, ItemCode, ItemName, ItemSpec, SN, StatusName, CWhName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new RMAUnitInfo(rdr.GetInt64(0), rdr.GetInt32(1), rdr.GetInt64(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10));

                    entity.RmaNo = rdr.GetString(11);
                    entity.ItemCode = rdr.GetString(12);
                    entity.ItemName = rdr.GetString(13);
                    entity.ItemSpec = rdr.GetString(14);
                    entity.SN = rdr.GetString(15);
                    entity.StatusName = rdr.GetString(16);
                    entity.CWhName = rdr.GetString(17);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public DataTable GetRMAUnitInfo(int RMAID)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RMAID", SqlDbType.Int)
            };

            parms[0].Value = RMAID;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetRMAUnitInfo", parms);            
        }

        public string CheckRePrintData(string RMAUnitIDStr)
        {
            int ItemId = -1;
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@RMAUnitID",SqlDbType.VarChar),
            };

            paras[0].Value = RMAUnitIDStr;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckRePrintData", paras))
            {
                while (rdr.Read())
                {
                    ItemId = rdr.GetInt32(0);
                }
                rdr.Close();
            }
            return ItemId.ToString();
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}