using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Station.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Station.BLL
{
    public class Line
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Line 信息。
        /// </summary>
        /// <param name="entity">Line 实体对象。</param>
        public Int32 Edit(LineInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@LineName", SqlDbType.NVarChar, 20),
                new SqlParameter("@LineDescription", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.LineId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.LineName;
            parms[2].Value = entity.LineDescription;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Line_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LineId 字符串删除 Line 信息。
        /// </summary>
        /// <param name="idString">LineId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Line_Delete", parms);
        }

        /// <summary>
        /// 根据 LineId 获取实体信息。
        /// </summary>
        /// <param name="lineId">LineId。</param>
        /// <returns>Line 实体对象。</returns>
        public LineInfo GetInfo(Int32 lineId)
        {
            LineInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = lineId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Line_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Line 实体对象。</returns>
        public LineInfo GetInfo(String fieldValue)
        {
            LineInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Line_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Line 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="lineCount">line 总数。</param>
        /// <returns>Line 列表。</returns>
        public List<LineInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LineInfo> list = new List<LineInfo>();
            LineInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Line", "LineId",
                "[LineId], [LineName], [LineDescription], [CreateBy], [ModifyBy], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 获取所有线别
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<LineInfo> GetAllLine()
        {
            List<LineInfo> list = new List<LineInfo>();
            LineInfo entity = null;

            SqlParameter[] parms = null;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetAllLine", parms))
            {
                while(rdr.Read())
                {
                    entity = new LineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5));
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }
        /// <summary>
        /// 根据id字符串获取线别
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<LineInfo> GetLineByIdStr(String idStr)
        {
            List<LineInfo> list = new List<LineInfo>();
            LineInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@idStr", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = idStr;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetLineByIdStr", parms))
            {
                while (rdr.Read())
                {
                    entity = new LineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5));
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }
        /// <summary>
        /// 根据id字符串获取不在该id字符串范围内的线别
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<LineInfo> GetLineByIdString(String idStr)
        {
            List<LineInfo> list = new List<LineInfo>();
            LineInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@idStr", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = idStr;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetLineByIdString", parms))
            {
                while (rdr.Read())
                {
                    entity = new LineInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5));
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}