using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.UserAttendance.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.UserAttendance.BLL
{
    public class UserAttendance
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） UserAttendance 信息。
        /// </summary>
        /// <param name="entity">UserAttendance 实体对象。</param>
        public Int32 Edit(string UserAttendanceId, string UserName, DateTime? Date, string Category, string Department, string Duty, DateTime? EntryDate, string IsBecome, string Shift, Decimal WorkDay, Decimal WorkTime, Decimal UsualTime, Decimal UsualOverTime, Decimal WeekendOverTime, string CreateBy, string ModifyBy, string Remark)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UserAttendanceId", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.NVarChar, 100),
                new SqlParameter("@Date", SqlDbType.DateTime),
                new SqlParameter("@Category", SqlDbType.NVarChar, 100),
                new SqlParameter("@Department", SqlDbType.NVarChar, 100),
                new SqlParameter("@Duty", SqlDbType.NVarChar, 100),
                new SqlParameter("@EntryDate", SqlDbType.DateTime),
                new SqlParameter("@IsBecome", SqlDbType.Int),
                new SqlParameter("@Shift", SqlDbType.NVarChar, 100),
                new SqlParameter("@WorkDay", SqlDbType.Decimal),
                new SqlParameter("@WorkTime", SqlDbType.Decimal),
                new SqlParameter("@UsualTime", SqlDbType.Decimal),
                new SqlParameter("@UsualOverTime", SqlDbType.Decimal),
                new SqlParameter("@WeekendOverTime", SqlDbType.Decimal),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = UserAttendanceId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = UserName;
            parms[2].Value = Date;
            parms[3].Value = Category;
            parms[4].Value = Department;
            parms[5].Value = Duty;
            parms[6].Value = EntryDate;
            parms[7].Value = IsBecome;
            parms[8].Value = Shift;
            parms[9].Value = WorkDay;
            parms[10].Value = WorkTime;
            parms[11].Value = UsualTime;
            parms[12].Value = UsualOverTime;
            parms[13].Value = WeekendOverTime;
            parms[14].Value = CreateBy;
            parms[15].Value = ModifyBy;
            parms[16].Value = Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_UserAttendance_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 UserAttendanceId 字符串删除 UserAttendance 信息。
        /// </summary>
        /// <param name="idString">UserAttendanceId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_UserAttendance_Delete", parms);
        }

        /// <summary>
        /// 根据 UserAttendanceId 获取实体信息。
        /// </summary>
        /// <param name="userAttendanceId">UserAttendanceId。</param>
        /// <returns>UserAttendance 实体对象。</returns>
        public UserAttendanceInfo GetInfo(Int32 userAttendanceId)
        {
            UserAttendanceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = userAttendanceId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_UserAttendance_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new UserAttendanceInfo(rdr.GetInt32(0), rdr.GetString(1), ComMethod.FromDatabase<DateTime?>(rdr["Date"]), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), ComMethod.FromDatabase<DateTime?>(rdr["EntryDate"]), rdr.GetInt32(7), rdr.GetString(8), rdr.GetDecimal(9),
                        rdr.GetDecimal(10), rdr.GetDecimal(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetString(14),
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetDateTime(17), rdr.GetString(18));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>UserAttendance 实体对象。</returns>
        public UserAttendanceInfo GetInfo(String fieldValue)
        {
            UserAttendanceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_UserAttendance_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new UserAttendanceInfo(rdr.GetInt32(0), rdr.GetString(1), ComMethod.FromDatabase<DateTime?>(rdr["Date"]), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), ComMethod.FromDatabase<DateTime?>(rdr["EntryDate"]), rdr.GetInt32(7), rdr.GetString(8), rdr.GetDecimal(9),
                        rdr.GetDecimal(10), rdr.GetDecimal(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetString(14),
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetDateTime(17), rdr.GetString(18));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 UserAttendance 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="userAttendanceCount">userAttendance 总数。</param>
        /// <returns>UserAttendance 列表。</returns>
        public List<UserAttendanceInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<UserAttendanceInfo> list = new List<UserAttendanceInfo>();
            UserAttendanceInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwUserAttendance", "UserAttendanceId",
                "[UserAttendanceId], [UserName], [Date], [Category], [Department], [Duty], [EntryDate], [IsBecome], [Shift], [WorkDay], [WorkTime], [UsualTime], [UsualOverTime], [WeekendOverTime], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],BecomeName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new UserAttendanceInfo(rdr.GetInt32(0), rdr.GetString(1), ComMethod.FromDatabase<DateTime?>(rdr["Date"]), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), ComMethod.FromDatabase<DateTime?>(rdr["EntryDate"]), rdr.GetInt32(7), rdr.GetString(8), rdr.GetDecimal(9),
                        rdr.GetDecimal(10), rdr.GetDecimal(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetString(14),
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetDateTime(17), rdr.GetString(18));
                    entity.BecomeName = rdr.GetString(19);
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


        /// <summary>
        /// 导入津贴信息
        /// </summary>
        /// <param name="dtFiboCom"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public int Import(DataTable dtUserAttendance, string userName)
        {
            int count = 0;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@dtUserAttendance", SqlDbType.Structured),
                 new SqlParameter("@userName", SqlDbType.NVarChar,50)
            };
            parms[0].Value = dtUserAttendance;
            parms[1].Value = userName;
            count = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUserAttendance_Import", parms);
            return count;
        }
    }
}