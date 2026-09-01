using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Anormal.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Anormal.BLL
{
    public class Anormal
    {
        private Int32 recordCount =0;
        /// <summary>
        /// 编辑（添加或更新） Anormal 信息。
        /// </summary>
        /// <param name="entity">Anormal 实体对象。</param>
        public Int32 Edit(AnormalInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AnormalId", SqlDbType.Int),
                new SqlParameter("@SubTypeId", SqlDbType.Int),
                new SqlParameter("@AnormalObject", SqlDbType.NVarChar, 50),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@OpeId", SqlDbType.Int),
                new SqlParameter("@UserId", SqlDbType.Int),
                new SqlParameter("@Owner", SqlDbType.NVarChar, 500),
                new SqlParameter("@DeptId", SqlDbType.VarChar, 100),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@StartTime", SqlDbType.DateTime),
                new SqlParameter("@EndTime", SqlDbType.DateTime),
                new SqlParameter("@Descriptions", SqlDbType.NVarChar, 500),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@LineStop", SqlDbType.TinyInt),
                new SqlParameter("@PlanId", SqlDbType.Int)
            };

            parms[0].Value = entity.AnormalId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.SubTypeId;
            parms[2].Value = entity.AnormalObject;
            parms[3].Value = entity.LineId;
            parms[4].Value = entity.OpeId;
            parms[5].Value = entity.UserId;
            parms[6].Value = entity.Owner;
            parms[7].Value = entity.DeptId;
            parms[8].Value = entity.Status;
            parms[9].Value = entity.StartTime;
            parms[10].Value = entity.EndTime;
            parms[11].Value = entity.Descriptions;
            parms[12].Value = entity.CreateBy;
            parms[13].Value = entity.ModifyBy;
            parms[14].Value = entity.Remark;
            parms[15].Value = entity.LineStop;
            parms[16].Value = entity.PlanId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 AnormalId 字符串删除 Anormal 信息。
        /// </summary>
        /// <param name="idString">AnormalId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_Delete", parms);
        }

        /// <summary>
        /// 根据 AnormalId 获取实体信息。
        /// </summary>
        /// <param name="anormalId">AnormalId。</param>
        /// <returns>Anormal 实体对象。</returns>
        public AnormalInfo GetInfo(Int32 anormalId)
        {
            AnormalInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = anormalId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AnormalInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetDateTime(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14), 
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetByte(17), rdr.GetInt32(18));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Anormal 实体对象。</returns>
        public AnormalInfo GetInfo(String fieldValue)
        {
            AnormalInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Anormal_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AnormalInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetDateTime(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14), 
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetByte(17), rdr.GetInt32(18));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Anormal 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="anormalCount">anormal 总数。</param>
        /// <returns>Anormal 列表。</returns>
        public List<AnormalInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AnormalInfo> list = new List<AnormalInfo>();
            AnormalInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Anormal", "AnormalId",
                "[AnormalId], [SubTypeId], [AnormalObject], [LineId], [OpeId], [UserId], [Owner], [DeptId], [Status], [StartTime], [EndTime], [Descriptions], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], [LineStop], [PlanId]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AnormalInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetDateTime(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14), 
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetByte(17), rdr.GetInt32(18));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 获取预警等级列表
        /// </summary>
        /// <returns></returns>
        public List<AnormalWarningLevelInfo> GetAnormalWarningLevelList()
        {
            var sql = @"SELECT 
		                    bwl.AnormalWarningLevelId,bwl.WarningLevel,bwl.WarningLevelName,bwl.CreateBy,bwl.CreateDateTime,bwl.ModifyBy,bwl.ModifyDateTime
	                    FROM dbo.Basal_AnormalWarningLevel bwl
	                    ORDER BY bwl.WarningLevel";
            return CommonHelper.BLL.ComMethod.GetListBySql<AnormalWarningLevelInfo>(sql, null);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}