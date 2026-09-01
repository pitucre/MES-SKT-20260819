using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Material.BLL
{
    public class PartNo
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） PartNo 信息。
        /// </summary>
        /// <param name="entity">PartNo 实体对象。</param>
        public Int32 Edit(ERPPartNoInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FactoryCode", SqlDbType.Int),
                new SqlParameter("@FNumber", SqlDbType.VarChar, 50),
                new SqlParameter("@FName", SqlDbType.VarChar, 200),
                new SqlParameter("@FModel", SqlDbType.VarChar, 350),
                new SqlParameter("@FstatusNo", SqlDbType.Int),
                new SqlParameter("@Ftatus", SqlDbType.VarChar, 20),
                new SqlParameter("@OperationState", SqlDbType.Int),
                new SqlParameter("@MESState", SqlDbType.Int),
                new SqlParameter("@Default_1", SqlDbType.NChar, 10),
                new SqlParameter("@Default_2", SqlDbType.NChar, 10),
                new SqlParameter("@Default_3", SqlDbType.NChar, 10),
                new SqlParameter("@Default_4", SqlDbType.NChar, 10),
                new SqlParameter("@Default_5", SqlDbType.NChar, 10),
                new SqlParameter("@Default_6", SqlDbType.NChar, 10),
                new SqlParameter("@Default_7", SqlDbType.NChar, 10),
                new SqlParameter("@Default_8", SqlDbType.NChar, 10),
                new SqlParameter("@Default_9", SqlDbType.NChar, 10),
                new SqlParameter("@Default_10", SqlDbType.NChar, 10)
            };

            parms[0].Value = entity.FactoryCode;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.FNumber;
            parms[2].Value = entity.FName;
            parms[3].Value = entity.FModel;
            parms[4].Value = entity.FstatusNo;
            parms[5].Value = entity.Ftatus;
            parms[6].Value = entity.OperationState;
            parms[7].Value = entity.MESState;
            parms[8].Value = entity.Default_1;
            parms[9].Value = entity.Default_2;
            parms[10].Value = entity.Default_3;
            parms[11].Value = entity.Default_4;
            parms[12].Value = entity.Default_5;
            parms[13].Value = entity.Default_6;
            parms[14].Value = entity.Default_7;
            parms[15].Value = entity.Default_8;
            parms[16].Value = entity.Default_9;
            parms[17].Value = entity.Default_10;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "ERP_PartNo_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PartNoId 字符串删除 PartNo 信息。
        /// </summary>
        /// <param name="idString">PartNoId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "ERP_PartNo_Delete", parms);
        }

        /// <summary>
        /// 根据 PartNoId 获取实体信息。
        /// </summary>
        /// <param name="partNoId">PartNoId。</param>
        /// <returns>PartNo 实体对象。</returns>
        public ERPPartNoInfo GetInfo(Int32 partNoId)
        {
            ERPPartNoInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = partNoId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "ERP_PartNo_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ERPPartNoInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetString(14), 
                        rdr.GetString(15), rdr.GetString(16), rdr.GetString(17));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PartNo 实体对象。</returns>
        public ERPPartNoInfo GetInfo(String fieldValue)
        {
            ERPPartNoInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "ERP_PartNo_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ERPPartNoInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetString(14), 
                        rdr.GetString(15), rdr.GetString(16), rdr.GetString(17));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 PartNo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="partNoCount">partNo 总数。</param>
        /// <returns>PartNo 列表。</returns>
        public List<ERPPartNoInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ERPPartNoInfo> list = new List<ERPPartNoInfo>();
            ERPPartNoInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "ERP_PartNo", "PartNoId",
                "[FactoryCode], [FNumber], [FName], [FModel], [FstatusNo], [Ftatus], [OperationState], [MESState], [Default_1], [Default_2], [Default_3], [Default_4], [Default_5], [Default_6], [Default_7], [Default_8], [Default_9], [Default_10]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ERPPartNoInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetString(14), 
                        rdr.GetString(15), rdr.GetString(16), rdr.GetString(17));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}