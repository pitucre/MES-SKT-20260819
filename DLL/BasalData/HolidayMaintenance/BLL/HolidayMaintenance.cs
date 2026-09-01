using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.HolidayMaintenance.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
 
namespace SKT.LeanMES.HolidayMaintenance.BLL
{
    public class HolidayMaintenance
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） HolidayMaintenance 信息。
        /// </summary>
        /// <param name="entity">HolidayMaintenance 实体对象。</param>
        public Int32 Edit(int HolidayMaintenanceId, string Date, int Multiple, int IsHoliday, string CreateBy, string ModifyBy, string Remark)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@Date", SqlDbType.DateTime),
                new SqlParameter("@Multiple", SqlDbType.Int),
                new SqlParameter("@IsHoliday", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 100),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 100),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500)
            };

            parms[0].Value = HolidayMaintenanceId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = Date;
            parms[2].Value = Multiple;
            parms[3].Value = IsHoliday;
            parms[4].Value = CreateBy;
            parms[5].Value = ModifyBy;
            parms[6].Value = Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_HolidayMaintenance_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 HolidayMaintenanceId 字符串删除 HolidayMaintenance 信息。
        /// </summary>
        /// <param name="idString">HolidayMaintenanceId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_HolidayMaintenance_Delete", parms);
        }

        /// <summary>
        /// 根据 HolidayMaintenanceId 获取实体信息。
        /// </summary>
        /// <param name="holidayMaintenanceId">HolidayMaintenanceId。</param>
        /// <returns>HolidayMaintenance 实体对象。</returns>
        public HolidayMaintenanceInfo GetInfo(Int32 holidayMaintenanceId)
        {
            HolidayMaintenanceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = holidayMaintenanceId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_HolidayMaintenance_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new HolidayMaintenanceInfo(rdr.GetInt32(0), rdr.GetDateTime(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetString(8));
                    entity.Holiday = rdr.GetString(9);
                    entity.MultipleName = rdr.GetString(10);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>HolidayMaintenance 实体对象。</returns>
        public HolidayMaintenanceInfo GetInfo(String fieldValue)
        {
            HolidayMaintenanceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_HolidayMaintenance_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new HolidayMaintenanceInfo(rdr.GetInt32(0), rdr.GetDateTime(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 HolidayMaintenance 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="holidayMaintenanceCount">holidayMaintenance 总数。</param>
        /// <returns>HolidayMaintenance 列表。</returns>
        public List<HolidayMaintenanceInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<HolidayMaintenanceInfo> list = new List<HolidayMaintenanceInfo>();
            HolidayMaintenanceInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwHolidayMaintenance", "Id",
                "[Id], [Date], [Multiple], [IsHoliday], [CreateDateTime], [CreateBy], [ModifyDateTime], [ModifyBy], [Remark],Holiday,MultipleName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new HolidayMaintenanceInfo(rdr.GetInt32(0), rdr.GetDateTime(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetString(8));
                    entity.Holiday = rdr.GetString(9);
                    entity.MultipleName = rdr.GetString(10);
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
        /// 导入节假日信息
        /// </summary>
        /// <param name="dtFiboCom"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public int Import(DataTable dtHolidayMaintenance, string userName)
        {
            int count = 0;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@dtHolidayMaintenance", SqlDbType.Structured),
                 new SqlParameter("@userName", SqlDbType.NVarChar,50)
            };
            parms[0].Value = dtHolidayMaintenance;
            parms[1].Value = userName;
            count = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspHolidayMaintenance_Import", parms);
            return count;
        }
    }
}