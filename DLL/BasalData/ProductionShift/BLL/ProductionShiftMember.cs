using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.ProductionShift.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;


namespace SKT.LeanMES.ProductionShift.BLL
{
    public class Shift_Member
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SHIFT_MEMBER 信息。
        /// </summary>
        /// <param name="entity">SHIFT_MEMBER 实体对象。</param>
        public Int32 Edit(Shift_MemberInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MemberId", SqlDbType.Int),
                new SqlParameter("@ShiftId", SqlDbType.Int),
                new SqlParameter("@ProductionShift", SqlDbType.VarChar, 20),
                new SqlParameter("@Description", SqlDbType.VarChar, 50),
                new SqlParameter("@StartTime", SqlDbType.VarChar,50),
                new SqlParameter("@EndTime", SqlDbType.VarChar,50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Sequence", SqlDbType.Int),
                new SqlParameter("@IsInterday", SqlDbType.Bit),
            };

            parms[0].Value = entity.MemberId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ShiftId;
            parms[2].Value = entity.ProductionShift;
            parms[3].Value = entity.Description;
            parms[4].Value = entity.StartTime;
            parms[5].Value = entity.EndTime;
            parms[6].Value = entity.ModifyBy;
            parms[7].Value = entity.CreateBy;
            parms[8].Value = entity.Sequence;
            parms[9].Value = entity.IsInterday;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ShiftMember_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 编辑（添加或更新） SHIFT_MEMBER 信息。
        /// </summary>
        /// <param name="xml"> Xml对象。</param>
        public Int32 EditChild(int memberId, string xml)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MemberId", SqlDbType.Int),
                new SqlParameter("@DocXml", SqlDbType.Text)

            };

            parms[0].Value = memberId;
            parms[1].Value = xml;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ShiftChildMember_Edit", parms);
            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MPID 字符串删除 SHIFT_MEMBER 信息。
        /// </summary>
        /// <param name="idString">MPID 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ShiftMember_Delete", parms);
        }

        /// <summary>
        /// 根据 MPID 获取实体信息。
        /// </summary>
        /// <param name="MPID">MPID。</param>
        /// <returns>SHIFT_MEMBER 实体对象。</returns>
        public Shift_MemberInfo GetInfo(Int32 MPID)
        {
            Shift_MemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = MPID;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ShiftMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new Shift_MemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9));
                    entity.Sequence = rdr.GetInt32(10);
                    entity.IsInterday = rdr.GetBoolean(11);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SHIFT_MEMBER 实体对象。</returns>
        public Shift_MemberInfo GetInfo(String fieldValue)
        {
            Shift_MemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ShiftMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SHIFT_MEMBER 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="sHIFT_MEMBERCount">sHIFT_MEMBER 总数。</param>
        /// <returns>SHIFT_MEMBER 列表。</returns>
        public List<Shift_MemberInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<Shift_MemberInfo> list = new List<Shift_MemberInfo>();
            Shift_MemberInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Shift_Member", "MemberId",
                "[MemberId], [ShiftId], [ProductionShift], [Description], [StartTime], [EndTime], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy],ISNULL(Sequence,0) as Sequence,ISNULL(IsInterday,0) IsInterday", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new Shift_MemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9));
                    entity.Sequence = rdr.GetInt32(10);
                    entity.IsInterday = rdr.GetBoolean(11);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 SHIFT_MEMBER 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="sHIFT_MEMBERCount">sHIFT_MEMBER 总数。</param>
        /// <returns>SHIFT_MEMBER 列表。</returns>
        public List<Shift_MemberInfo> GetChildAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<Shift_MemberInfo> list = new List<Shift_MemberInfo>();
            Shift_MemberInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Shift_ChildMember", "Cid",
                "Cid,MemberId, [Description], [StartTime], [EndTime], ISNULL(EndIsInterday,0) EndIsInterday,ISNULL(StartIsInterday,0) StartIsInterday", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new Shift_MemberInfo();
                    entity.Cid = Convert.ToInt32(rdr["Cid"]);
                    entity.MemberId = Convert.ToInt32(rdr["MemberId"]);
                    entity.Description = Convert.ToString(rdr["Description"]);
                    entity.StartTime = Convert.ToString(rdr["StartTime"]);
                    entity.EndTime = Convert.ToString(rdr["EndTime"]);
                    entity.IsInterday = Convert.ToBoolean(rdr["EndIsInterday"]);
                    entity.StartTimeIsterday = Convert.ToBoolean(rdr["StartIsInterday"]); ;
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