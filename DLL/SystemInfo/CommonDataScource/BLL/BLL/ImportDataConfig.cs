using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonDataSource.Model;
using System.Web.Script.Serialization;

namespace SKT.LeanMES.CommonDataSource.BLL
{
    public class ImportDataConfig
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑（添加或更新） DataSource 信息。
        /// </summary>
        /// <param name="entity">DataSource 实体对象。</param>
        public Int32 Edit(ImportDataConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@IdcName", SqlDbType.NVarChar, 50),
                new SqlParameter("@TableName", SqlDbType.NVarChar, 200),
                new SqlParameter("@ProcName", SqlDbType.VarChar, 50),
                new SqlParameter("@FileNames", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@Remark", SqlDbType.VarChar, 500)
            };

            parms[0].Value = entity.ID;
           
            parms[1].Value = entity.IdcName;
            parms[2].Value = entity.TableName;
            parms[3].Value = entity.ProcName;
            parms[4].Value = entity.FileNames;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "usp_proc_ImportDataConfigtEdit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 删除 ImportConfig 信息。
        /// </summary>
        /// <param name="idString">逗号分隔的id集合</param>
        /// <returns>日志内容。</returns>
        public void Delete(string idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar,1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "usp_ImportConfig_Delete", parms);
        }

        /// <summary>
        /// 根据 Id 获取实体信息。
        /// </summary>
        /// <param name="Id">Id。</param>
        /// <returns>DataSource 实体对象。</returns>
        public ImportDataConfigInfo GetInfo(Int32 Id)
        {
            ImportDataConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = Id;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "usp_ImportDataConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ImportDataConfigInfo();
                    entity.ID = (int)rdr["ID"];
                    entity.IdcName = rdr["IdcName"].ToString();
                    entity.TableName = rdr["TableName"].ToString();
                    entity.ProcName = rdr["ProcName"].ToString();
                    entity.FileNames = rdr["FileNames"].ToString();
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreateTime = rdr["CreateTime"].ToString();
                    entity.UpateTime = rdr["UpdateTime"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ImportConfig 实体对象。</returns>
        public ImportDataConfigInfo GetInfo(String fieldValue)
        {
            ImportDataConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "usp_ImportDataConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ImportDataConfigInfo();
                    entity.ID = (int)rdr["ID"];
                    entity.IdcName = rdr["IdcName"].ToString();
                    entity.TableName = rdr["TableName"].ToString();
                    entity.ProcName = rdr["ProcName"].ToString();
                    entity.FileNames = rdr["FileNames"].ToString();
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreateTime = rdr["CreateTime"].ToString();
                    entity.UpateTime = rdr["UpdateTime"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                }
                rdr.Close();
            }

            return entity;
        }



        /// <summary>
        /// 分页获取 DataSource 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="dataSourceCount">dataSource 总数。</param>
        /// <returns>DataSource 列表。</returns>
        public List<ImportDataConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ImportDataConfigInfo> list = new List<ImportDataConfigInfo>();
            ImportDataConfigInfo entity = null;
            searchSettings.AddCondition("IsDelete","0");  //0等于未删除
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwBasal_ImportDataConfig"////Basal_ImportDataConfig
                , "Id"
                , "Id,IdcName ,TableName,ProcName,FileNames,CreateTime, CreateBy,UpdateTime,Remark,IsDelete,ModifyBy"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ImportDataConfigInfo();
                    entity.ID = (int) rdr["Id"];
                    entity.IdcName = rdr["IdcName"].ToString();
                    entity.TableName =  rdr["TableName"].ToString();
                    entity.ProcName = rdr["ProcName"].ToString();
                    entity.FileNames = rdr["FileNames"].ToString();
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreateTime = rdr["CreateTime"].ToString();
                    entity.UpateTime = rdr["UpdateTime"].ToString();
                    entity.UpdateTime = rdr["UpdateTime"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.ModifyBy = rdr["ModifyBy"].ToString();
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