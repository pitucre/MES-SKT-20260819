using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SMT.BLL
{
    public class MachineTable
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） TABLE 信息。
        /// </summary>
        /// <param name="entity">TABLE 实体对象。</param>
        public Int32 Edit(MachineTableInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MachineTableID", SqlDbType.Int),
                new SqlParameter("@MachineID", SqlDbType.Int),
                new SqlParameter("@MachineTableSN", SqlDbType.VarChar, 50),
                new SqlParameter("@Description", SqlDbType.VarChar, 100),
                new SqlParameter("@TablePosition", SqlDbType.TinyInt),
                new SqlParameter("@MachineTableTypeID", SqlDbType.TinyInt),
                new SqlParameter("@Status", SqlDbType.TinyInt),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateDateTime", SqlDbType.DateTime),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyDateTime", SqlDbType.DateTime),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.MachineTableID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MachineID;
            parms[2].Value = entity.MachineTableSN;
            parms[3].Value = entity.Description;
            parms[4].Value = entity.TablePosition;
            parms[5].Value = entity.MachineTableTypeID;
            parms[6].Value = entity.Status;
            parms[7].Value = entity.CreateBy;
            parms[8].Value = entity.CreateDateTime;
            parms[9].Value = entity.ModifyBy;
            parms[10].Value = entity.ModifyDateTime;
            parms[11].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "MACHINE_TABLE_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 TABLEId 字符串删除 TABLE 信息。
        /// </summary>
        /// <param name="idString">TABLEId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "MACHINE_TABLE_Delete", parms);
        }

        /// <summary>
        /// 根据 TABLEId 获取实体信息。
        /// </summary>
        /// <param name="tABLEId">TABLEId。</param>
        /// <returns>TABLE 实体对象。</returns>
        public MachineTableInfo GetInfo(Int32 tABLEId)
        {
            MachineTableInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = tABLEId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MachineTable_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MachineTableInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetByte(4), 
                        rdr.GetByte(5), rdr.GetByte(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11));
                    entity.MachineTableTypeName = rdr.GetString(12);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>TABLE 实体对象。</returns>
        public List<MachineTableInfo> GetInfo(String fieldValue)
        {
            List<MachineTableInfo> list = new List<MachineTableInfo>();
            MachineTableInfo entity = null;


            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MachineTable_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new MachineTableInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetByte(4),
                        rdr.GetByte(5), rdr.GetByte(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9),
                        rdr.GetDateTime(10), rdr.GetString(11));
                    entity.MachineTableTypeName = rdr.GetString(12);
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 分页获取 TABLE 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="tABLECount">tABLE 总数。</param>
        /// <returns>TABLE 列表。</returns>
        public List<MachineTableInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MachineTableInfo> list = new List<MachineTableInfo>();
            MachineTableInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_MachineTable", "TABLEId",
                "[MachineTableID], [MachineID], [MachineTableSN], [Description], [TablePosition], [MachineTableTypeID], [Status], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MachineTableInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetByte(4), 
                        rdr.GetByte(5), rdr.GetByte(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11));

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