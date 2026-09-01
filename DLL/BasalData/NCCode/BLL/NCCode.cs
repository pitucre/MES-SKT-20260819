using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.NCCode.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.NCCode.BLL
{
    public class NCCode
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） NCCode 信息。
        /// </summary>
        /// <param name="entity">NCCode 实体对象。</param>
        public Int32 Edit(NCCodeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@NCCodeId", SqlDbType.Int),
                new SqlParameter("@NCCode", SqlDbType.NVarChar, 20),
                new SqlParameter("@Description", SqlDbType.NVarChar, 300),
                new SqlParameter("@Status", SqlDbType.NVarChar, 10),
                new SqlParameter("@Category", SqlDbType.NVarChar, 10),
                new SqlParameter("@DataTypeID", SqlDbType.Int),
                new SqlParameter("@DataType", SqlDbType.VarChar, 30),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@NCCodeTypeId",SqlDbType.Int)
            };

            parms[0].Value = entity.NCCodeId;
            parms[1].Value = entity.NCCode;
            parms[2].Value = entity.Description;
            parms[3].Value = entity.Status;
            parms[4].Value = entity.Category;
            parms[5].Value = entity.DataTypeID;
            parms[6].Value = entity.DataType;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.CreateBy;
            parms[9].Value = entity.NCCodeTypeId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_NCCode_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 NCCodeId 字符串删除 NCCode 信息。
        /// </summary>
        /// <param name="idString">NCCodeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_NCCode_Delete", parms);
        }

        /// <summary>
        /// 根据 NCCodeId 获取实体信息。
        /// </summary>
        /// <param name="nCCodeId">NCCodeId。</param>
        /// <returns>NCCode 实体对象。</returns>
        public NCCodeInfo GetInfo(Int32 nCCodeId)
        {
            NCCodeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = nCCodeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_NCCode_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new NCCodeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10));
                    entity.NCCodeTypeId = rdr.GetInt32(11);
                    entity.NCCodeTypeName = rdr.GetString(12);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>NCCode 实体对象。</returns>
        public NCCodeInfo GetInfo(String fieldValue)
        {
            NCCodeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_NCCode_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new NCCodeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10));
                    entity.NCCodeTypeId = rdr.GetInt32(11);
                    entity.NCCodeTypeName = rdr.GetString(12);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 NCCode 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="nCCodeCount">nCCode 总数。</param>
        /// <returns>NCCode 列表。</returns>
        public List<NCCodeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<NCCodeInfo> list = new List<NCCodeInfo>();
            NCCodeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwNCCode", "NCCodeID",
                "[NCCodeId], [NCCode], [Description], [Status], [Category], [DataTypeID], [DataType], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy], [NCGroupId], [NCGroupName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new NCCodeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10));
                    entity.NCCodeTypeId = rdr.GetInt32(11);
                    entity.NCCodeTypeName = rdr.GetString(12);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 NCCode 资料，根据传入的工序StationId和不良类别Category获取。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="nCCodeCount">nCCode 总数。</param>
        /// <returns>NCCode 列表。</returns>
        public List<NCCodeInfo> GetAllByStationAndCategory(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<NCCodeInfo> list = new List<NCCodeInfo>();
            NCCodeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, @"dbo.Basal_NCCode AS a
            LEFT  JOIN dbo.Basal_NCGroupMember AS b ON a.NCCodeId = b.NCCodeId
            LEFT  JOIN dbo.Basal_NCGroup AS c ON b.NCGroupId = c.NCGroupId
			LEFT JOIN Basal_NCGroupStation d ON d.NCGroupId=c.NCGroupId 
            LEFT JOIN SYS_Users m1 ( NOLOCK ) ON RTRIM(LTRIM(a.CreateBy)) = m1.UserName
            LEFT JOIN SYS_Users m2 ( NOLOCK ) ON RTRIM(LTRIM(a.ModifyBy)) = m2.UserName", "a.NCCodeID",
                @"a.NCCodeId ,
            a.NCCode ,
            a.Description ,
            a.Status ,
            CASE WHEN a.Category = 'Failure' THEN '失败品'
                 WHEN a.Category = 'Defect' THEN '缺陷品'
                 WHEN a.Category = 'Repair' THEN '返修品'
                 ELSE a.Category
            END AS Category ,
            a.DataTypeID ,
            a.DataType ,
 a.ModifyDateTime ,
			 ISNULL(m2.CName, '') AS [ModifyBy] ,
            a.CreateDateTime ,
            ISNULL(m1.CName,'') AS [CreateBy],
            ISNULL(c.NCGroupId, -1) AS 'NCGroupId' ,
            ISNULL(c.NCGroupName, '') AS 'NCGroupName' 
           ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new NCCodeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10));
                    entity.NCCodeTypeId = rdr.GetInt32(11);
                    entity.NCCodeTypeName = rdr.GetString(12);

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
        /// 分页获取 NCCode 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="nCCodeCount">nCCode 总数。</param>
        /// <returns>NCCode 列表。</returns>
        public List<NCCodeInfo> GetAllNCCode(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //List<NCCodeInfo> list = new List<NCCodeInfo>();
            //NCCodeInfo entity = null;

            //SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwNCCodeList", "NCCodeID",
            //    "[NCCodeId], [NCCode], [Description], [Status], [Category], [DataTypeID], [DataType], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy], [NCGroupId], [NCGroupName], [StationId]", searchSettings, sortExpression);

            //using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            //{
            //    while (rdr.Read())
            //    {
            //        entity = new NCCodeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
            //            rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
            //            rdr.GetString(10));
            //        entity.NCCodeTypeId = rdr.GetInt32(11);
            //        entity.NCCodeTypeName = rdr.GetString(12);
            //        entity.StationId = rdr.GetInt32(13);
            //        list.Add(entity);
            //    }
            //    rdr.Close();
            //}
            //recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            //return list;
            string queryColumns = "[NCCodeId], [NCCode], [Description], [Status], [Category], [DataTypeID], [DataType], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy], [NCGroupId], [NCGroupName], [StationId],Station";
            return ComMethod.GetComList<NCCodeInfo>(ref recordCount, startRow, maxRows, "vwNCCodeList", "NCCodeID", queryColumns, sortExpression, searchSettings);
        }

    }
}