using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Molding.Model;

namespace SKT.LeanMES.Molding.BLL
{
    public class MaterialBurnMember
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaterialBurnMember 信息。
        /// </summary>
        /// <param name="entity">MaterialBurnMember 实体对象。</param>
        public Int32 Edit(MaterialBurnMemberInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@BurnMemberId", SqlDbType.Int),
                new SqlParameter("@BurnId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@MaterialItemId", SqlDbType.Int)
            };

            parms[0].Value = entity.BurnMemberId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.BurnId;
            parms[2].Value = entity.ItemId;
            parms[3].Value = entity.MaterialItemId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialBurnMember_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MaterialBurnMemberId 字符串删除 MaterialBurnMember 信息。
        /// </summary>
        /// <param name="idString">MaterialBurnMemberId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(int itemId , int burnId , String userName,int MaterialItemId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IteId", SqlDbType.Int),
                new SqlParameter("@burnId", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@MaterialItemId", SqlDbType.Int),
            };

            parms[0].Value = itemId;
            parms[1].Value = burnId;
            parms[2].Value = userName;
            parms[3].Value = MaterialItemId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialBurnMember_Delete", parms);
        }

        /// <summary>
        /// 根据 MaterialBurnMemberId 获取实体信息。
        /// </summary>
        /// <param name="materialBurnMemberId">MaterialBurnMemberId。</param>
        /// <returns>MaterialBurnMember 实体对象。</returns>
        public MaterialBurnMemberInfo GetInfo(Int32 materialBurnMemberId)
        {
            MaterialBurnMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = materialBurnMemberId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialBurnMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialBurnMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), rdr.GetString(5), rdr.GetString(6), rdr.GetInt32(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaterialBurnMember 实体对象。</returns>
        public MaterialBurnMemberInfo GetInfo(String fieldValue)
        {
            MaterialBurnMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialBurnMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialBurnMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), rdr.GetString(5), rdr.GetString(6), rdr.GetInt32(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MaterialBurnMember 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialBurnMemberCount">materialBurnMember 总数。</param>
        /// <returns>MaterialBurnMember 列表。</returns>
        public List<MaterialBurnMemberInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialBurnMemberInfo> list = new List<MaterialBurnMemberInfo>();
            MaterialBurnMemberInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaterialBurnMemberId", "BurnMemberId",
                "[BurnMemberId], [BurnId], [ItemId], ItemCode, ItemName,MItemCode,MItemName,MaterialItemId", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialBurnMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), rdr.GetString(5), rdr.GetString(6), rdr.GetInt32(7));

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