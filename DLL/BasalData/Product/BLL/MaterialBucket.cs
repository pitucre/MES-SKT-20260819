using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Product.BLL
{
    public class MaterialBucket
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Bom 信息。
        /// </summary>
        /// <param name="entity">Bom 实体对象。</param>
        public Int32  Edit(MaterialBucketInfo entity)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@BucketId", SqlDbType.Int),
                new SqlParameter("@MaterialBucketCode", SqlDbType.NVarChar, 100),
                new SqlParameter("@ItemAttr", SqlDbType.NVarChar),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500)
            };

            parms[0].Value = entity.BucketId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MaterialBucketCode;
            parms[2].Value = entity.ItemAttr;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.Remark;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialBucket_Edit", parms);
            return Convert.ToInt32(parms[0].Value);
        }

        /// <summary>
        /// 根据 bucketId 字符串删除 Bom 信息。
        /// </summary>
        /// <param name="idString">bucketId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialBucket_Del", parms);
        }

        /// <summary>
        /// 根据 bucketId 获取实体信息。
        /// </summary>
        /// <param name="bucketId">bucketId。</param>
        /// <returns>Bom 实体对象。</returns>
        public MaterialBucketInfo GetInfo(Int32 bucketId)
        {
            MaterialBucketInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = bucketId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialBucket_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialBucketInfo();
                    entity.BucketId =Convert.ToInt32(rdr["BucketId"]);
                    entity.MaterialBucketCode = rdr["MaterialBucketCode"].ToString();
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
        /// <returns>Bom 实体对象。</returns>
        public MaterialBucketInfo GetInfo(String fieldValue)
        {
            MaterialBucketInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialBucket_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialBucketInfo();
                    entity.BucketId = Convert.ToInt32(rdr["BucketId"]);
                    entity.MaterialBucketCode = rdr["MaterialBucketCode"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Bom 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="bomCount">bom 总数。</param>
        /// <returns>Bom 列表。</returns>
        public List<MaterialBucketInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialBucketInfo> list = new List<MaterialBucketInfo>();
            MaterialBucketInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_MaterialBucket", "BucketId",
                "[BucketId], [MaterialBucketCode], [Remark], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialBucketInfo();
                    entity.BucketId = Convert.ToInt32(rdr["BucketId"]);
                    entity.MaterialBucketCode = rdr["MaterialBucketCode"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreateDateTime =Convert.ToDateTime(rdr["CreateDateTime"]);
                    entity.ModifyBy = rdr["ModifyBy"].ToString();
                    entity.ModifyDateTime = Convert.ToDateTime(rdr["ModifyDateTime"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 分页获取 Bom 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="bomCount">bom 总数。</param>
        /// <returns>Bom 列表。</returns>
        public List<MaterialBucketRelationItemInfo> GetMaterialBucketRelationItemList(int bucketId=-1,string materialBucketCode="")
        {
            List<MaterialBucketRelationItemInfo> list = new List<MaterialBucketRelationItemInfo>();
            MaterialBucketRelationItemInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@BucketId", SqlDbType.Int, 4),
                new SqlParameter("@MaterialBucketCode", SqlDbType.VarChar,100)
            };

            parms[0].Value = bucketId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetMaterialBucketRelationItemListById", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialBucketRelationItemInfo();
                    entity.BucketId = Convert.ToInt32(rdr["BucketId"]);
                    entity.ItemId = Convert.ToInt32(rdr["ItemId"]);
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    entity.ItemName = rdr["ItemName"].ToString();
                    entity.MaterialBucketCode = rdr["MaterialBucketCode"].ToString();
                 
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