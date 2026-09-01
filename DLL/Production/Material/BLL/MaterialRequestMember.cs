using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Material.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Material.BLL
{
    public class MaterialRequestMember
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaterialRequestMember 信息。
        /// </summary>
        /// <param name="entity">MaterialRequestMember 实体对象。</param>
        public Int32 Edit(MaterialRequestMemberInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaterialRequestMemberId", SqlDbType.Int),
                new SqlParameter("@MaterialRequestId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@RequestQty", SqlDbType.Decimal),
                new SqlParameter("@ResponseQty", SqlDbType.Decimal),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 100)
            };

            parms[0].Value = entity.MaterialRequestMemberId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MaterialRequestId;
            parms[2].Value = entity.ItemId;
            parms[3].Value = entity.RequestQty;
            parms[4].Value = entity.ResponseQty;
            parms[5].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialRequestMember_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MaterialRequestMemberId 字符串删除 MaterialRequestMember 信息。
        /// </summary>
        /// <param name="idString">MaterialRequestMemberId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialRequestMember_Delete", parms);
        }

        /// <summary>
        /// 删除数据库里不存在idString里不存在的ID 数据库里有MaterialRequestMemberId为44
        /// 而materialRequestMemberIdS没有则删除些数据
        /// </summary>
        /// <param name="MaterialRequestId">MaterialRequestId</param>
        /// <param name="materialRequestIds">materialRequestMemberIdS 格式：12,34,56,78</param>
        public void DeleteNotExists(int MaterialRequestId, String materialRequestMemberIdS)
        {
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@MaterialRequestId", SqlDbType.Int),
                new SqlParameter("@MaterialRequestMemberIdS", SqlDbType.VarChar, 1000)
            };
            parms[0].Value = MaterialRequestId;
            parms[1].Value = materialRequestMemberIdS;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialRequestMember_DeleteById", parms);
        }

        /// <summary>
        /// 根据 MaterialRequestMemberId 获取实体信息。
        /// </summary>
        /// <param name="materialRequestMemberId">MaterialRequestMemberId。</param>
        /// <returns>MaterialRequestMember 实体对象。</returns>
        public MaterialRequestMemberInfo GetInfo(Int32 materialRequestMemberId)
        {
            MaterialRequestMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = materialRequestMemberId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialRequestMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialRequestMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetDecimal(4), 
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
        /// <returns>MaterialRequestMember 实体对象。</returns>
        public MaterialRequestMemberInfo GetInfo(String fieldValue)
        {
            MaterialRequestMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialRequestMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialRequestMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetDecimal(4), 
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MaterialRequestMember 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialRequestMemberCount">materialRequestMember 总数。</param>
        /// <returns>MaterialRequestMember 列表。</returns>
        public List<MaterialRequestMemberInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialRequestMemberInfo> list = new List<MaterialRequestMemberInfo>();
            MaterialRequestMemberInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_MaterialRequestMember", "MaterialRequestMemberId",
                "[MaterialRequestMemberId], [MaterialRequestId], [ItemId], [RequestQty], [ResponseQty], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialRequestMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetDecimal(4), 
                        rdr.GetString(5));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public List<MaterialRequestMemberInfo> GetList(int MaterialRequestId)
        {
            List<MaterialRequestMemberInfo> list = new List<MaterialRequestMemberInfo>();
            MaterialRequestMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaterialRequestId", SqlDbType.Int)
            };
            parms[0].Value = MaterialRequestId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialRequestMember_ListByMaterialRequestId", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialRequestMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDecimal(3), rdr.GetDecimal(4),
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