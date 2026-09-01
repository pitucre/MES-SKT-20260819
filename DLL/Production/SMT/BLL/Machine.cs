using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SMT.BLL
{
    public class Machine
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MACHINE 信息。
        /// </summary>
        /// <param name="entity">MACHINE 实体对象。</param>
        public Int32 Edit(MachineInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@MachineSN", SqlDbType.VarChar, 50),
                new SqlParameter("@Description", SqlDbType.VarChar, 100),
                new SqlParameter("@MachineModelID", SqlDbType.Int),
                new SqlParameter("@ModelName", SqlDbType.NVarChar, 50),
                new SqlParameter("@LineID", SqlDbType.Int),
                new SqlParameter("@LineName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Status", SqlDbType.TinyInt),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MachineSN;
            parms[2].Value = entity.Description;
            parms[3].Value = entity.MachineModelID;
            parms[4].Value = entity.ModelName;
            parms[5].Value = entity.LineID;
            parms[6].Value = entity.LineName;
            parms[7].Value = entity.Status;
            parms[8].Value = entity.CreateBy;
            parms[9].Value = entity.ModifyBy;
            parms[10].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Machine_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// MACHINE [MACHINE_TABLE] [MACHINE_TABLE_SLOT] Status修改
        /// </summary>
        public Int32 EditStatus(int ID, int Table, byte Status, string ModifyBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@Table", SqlDbType.Int),
                new SqlParameter("@Status", SqlDbType.TinyInt),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = ID;
            parms[1].Value = Table;
            parms[2].Value = Status;
            parms[3].Value = ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_MachineStatus_Edit", parms);

            return (Int32)parms[0].Value;
        }
        /// <summary>
        /// 根据 MACHINEId 字符串删除 MACHINE 信息。
        /// </summary>
        /// <param name="idString">MACHINEId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Machine_Delete", parms);
        }

        /// <summary>
        /// 根据 MACHINEId 获取实体信息。
        /// </summary>
        /// <param name="mACHINEId">MACHINEId。</param>
        /// <returns>MACHINE 实体对象。</returns>
        public MachineInfo GetInfo(Int32 mACHINEId)
        {
            MachineInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = mACHINEId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Machine_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MachineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), rdr.GetInt32(5),
                         rdr.GetString(6), rdr.GetByte(7), rdr.GetString(8), rdr.GetDateTime(9), rdr.GetString(10), rdr.GetDateTime(11),
                        rdr.GetString(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MACHINE 实体对象。</returns>
        public List<MachineInfo> GetInfo(String fieldValue)
        {
            List<MachineInfo> list = new List<MachineInfo>();
            MachineInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Machine_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new MachineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetByte(7), rdr.GetString(8), rdr.GetDateTime(9), rdr.GetString(10),
                        rdr.GetDateTime(11), rdr.GetString(12));

                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 分页获取 MACHINE 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mACHINECount">mACHINE 总数。</param>
        /// <returns>MACHINE 列表。</returns>
        public List<MachineInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MachineInfo> list = new List<MachineInfo>();
            MachineInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "Basal_Machine A left join Basal_MachineModel B ON B.ModelID=A.MachineModelID left join Basal_Line C ON C.LineId=A.LineID", "ID",
                "[ID], [MachineSN], A.[Description], [MachineModelID],B.ModelName, A.[LineID],C.LineName, A.[Status],A. [CreateBy],A. [CreateDateTime], A.[ModifyBy], A.[ModifyDateTime], A.[Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MachineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), rdr.GetInt32(5),
                         rdr.GetString(6), rdr.GetByte(7), rdr.GetString(8), rdr.GetDateTime(9), rdr.GetString(10), rdr.GetDateTime(11),
                        rdr.GetString(12));

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