using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Product.BLL
{
    public class ItemGroup
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ItemGroup 信息。
        /// </summary>
        /// <param name="entity">ItemGroup 实体对象。</param>
        public void  Edit(ItemGroupInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemGroupId", SqlDbType.Int),
                new SqlParameter("@GroupName", SqlDbType.NVarChar, 500),
                new SqlParameter("@GroupDesc", SqlDbType.NVarChar, 500),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ItemGroupId;
            parms[1].Value = entity.GroupName;
            parms[2].Value = entity.GroupDesc;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemGroup_Edit", parms);
        }

        /// <summary>
        /// 根据 ItemGroupId 字符串删除 ItemGroup 信息。
        /// </summary>
        /// <param name="idString">ItemGroupId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemGroup_Delete", parms);
        }

        /// <summary>
        /// 根据 ItemGroupId 获取实体信息。
        /// </summary>
        /// <param name="itemGroupId">ItemGroupId。</param>
        /// <returns>ItemGroup 实体对象。</returns>
        public ItemGroupInfo GetInfo(Int32 itemGroupId)
        {
            ItemGroupInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = itemGroupId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ItemGroup_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ItemGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ItemGroup 实体对象。</returns>
        public ItemGroupInfo GetInfo(String fieldValue)
        {
            ItemGroupInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ItemGroup_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ItemGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ItemGroup 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemGroupCount">itemGroup 总数。</param>
        /// <returns>ItemGroup 列表。</returns>
        public List<ItemGroupInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemGroupInfo> list = new List<ItemGroupInfo>();
            ItemGroupInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_ItemGroup", "ItemGroupID",////Basal_ItemGroup
                "[ItemGroupId], [GroupName], [GroupDesc], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ItemGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));

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