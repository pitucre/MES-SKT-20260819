using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SMT.BLL
{
    public class MachineTableSlot
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） TABLE_SLOT 信息。
        /// </summary>
        /// <param name="entity">TABLE_SLOT 实体对象。</param>
        public Int32 Edit(MachineTableSlotInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TableSlotID", SqlDbType.Int),
                new SqlParameter("@MachineTableID", SqlDbType.Int),
                new SqlParameter("@TableSlotSN", SqlDbType.VarChar, 50),
                new SqlParameter("@Description", SqlDbType.VarChar, 100),
                new SqlParameter("@SlotPosition", SqlDbType.SmallInt),
                new SqlParameter("@Status", SqlDbType.TinyInt),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateDateTime", SqlDbType.DateTime),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyDateTime", SqlDbType.DateTime),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.TableSlotID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MachineTableID;
            parms[2].Value = entity.TableSlotSN;
            parms[3].Value = entity.Description;
            parms[4].Value = entity.SlotPosition;
            parms[5].Value = entity.Status;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.CreateDateTime;
            parms[8].Value = entity.ModifyBy;
            parms[9].Value = entity.ModifyDateTime;
            parms[10].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "MACHINE_TABLE_SLOT_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 TABLE_SLOTId 字符串删除 TABLE_SLOT 信息。
        /// </summary>
        /// <param name="idString">TABLE_SLOTId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "MACHINE_TABLE_SLOT_Delete", parms);
        }

        /// <summary>
        /// 根据 TABLE_SLOTId 获取实体信息。
        /// </summary>
        /// <param name="tABLE_SLOTId">TABLE_SLOTId。</param>
        /// <returns>TABLE_SLOT 实体对象。</returns>
        public MachineTableSlotInfo GetInfo(Int32 tABLE_SLOTId)
        {
            MachineTableSlotInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = tABLE_SLOTId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MachineTableSlot_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MachineTableSlotInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt16(4), 
                        rdr.GetByte(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>TABLE_SLOT 实体对象。</returns>
        public List<MachineTableSlotInfo> GetInfo(String fieldValue)
        {
            List<MachineTableSlotInfo> list = new List<MachineTableSlotInfo>();
            MachineTableSlotInfo entity = null;


            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MachineTableSlot_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new MachineTableSlotInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt16(4),
    rdr.GetByte(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
    rdr.GetString(10));

                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 分页获取 TABLE_SLOT 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="tABLE_SLOTCount">tABLE_SLOT 总数。</param>
        /// <returns>TABLE_SLOT 列表。</returns>
        public List<MachineTableSlotInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MachineTableSlotInfo> list = new List<MachineTableSlotInfo>();
            MachineTableSlotInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_MachineTableSlot", "TABLE_SLOTId",
                "[TableSlotID], [MachineTableID], [TableSlotSN], [Description], [SlotPosition], [Status], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MachineTableSlotInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt16(4), 
                        rdr.GetByte(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10));

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
