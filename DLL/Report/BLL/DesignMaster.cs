using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Report.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Report.BLL
{
    public class DesignMaster
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） DesignMaster 信息。
        /// </summary>
        /// <param name="entity">DesignMaster 实体对象。</param>
        public Int32 Edit(DesignMasterInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DesignMasterID", SqlDbType.Int),
                new SqlParameter("@TableName", SqlDbType.NVarChar, 200),
                new SqlParameter("@ReportName", SqlDbType.NVarChar, 200),
                new SqlParameter("@TableDbType", SqlDbType.NVarChar,200),
                new SqlParameter("@ValueString", SqlDbType.NVarChar, -1),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateTime", SqlDbType.DateTime),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyTime", SqlDbType.DateTime),
                new SqlParameter("@StatusFlag", SqlDbType.Int)
            };

            parms[0].Value = entity.DesignMasterID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.TableName;
            parms[2].Value = entity.ReportName;
            parms[3].Value = entity.TableDbType;
            parms[4].Value = entity.ValueString;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.CreateTime;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.ModifyTime;
            parms[9].Value = entity.StatusFlag;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Report_DesignMaster_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 DesignMasterID 字符串删除 DesignMaster 信息。
        /// </summary>
        /// <param name="idString">DesignMasterID 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Report_DesignMaster_Delete", parms);
        }

        /// <summary>
        /// 根据 DesignMasterID 获取实体信息。
        /// </summary>
        /// <param name="DesignMasterID">DesignMasterID。</param>
        /// <returns>DesignMaster 实体对象。</returns>
        public DesignMasterInfo GetInfo(Int32 DesignMasterID)
        {
            DesignMasterInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = DesignMasterID;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Report_DesignMaster_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DesignMasterInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetInt32(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>DesignMaster 实体对象。</returns>
        public DesignMasterInfo GetInfo(String fieldValue)
        {
            DesignMasterInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Report_DesignMaster_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DesignMasterInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetInt32(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 DesignMaster 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="designMasterCount">designMaster 总数。</param>
        /// <returns>DesignMaster 列表。</returns>
        public List<DesignMasterInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DesignMasterInfo> list = new List<DesignMasterInfo>();
            DesignMasterInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Report_DesignMaster", "DesignMasterID",
                "[DesignMasterID], [TableName], [ReportName], [TableDbType], [ValueString], [CreateBy], [CreateTime], [ModifyBy], [ModifyTime], [StatusFlag]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new DesignMasterInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetInt32(9));

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