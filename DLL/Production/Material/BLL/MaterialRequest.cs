using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Material.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Material.BLL
{
    public class MaterialRequest
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaterialRequest 信息。
        /// </summary>
        /// <param name="entity">MaterialRequest 实体对象。</param>
        public Int32 Edit(MaterialRequestInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaterialRequestId", SqlDbType.Int),
                new SqlParameter("@FormNO", SqlDbType.NVarChar, 100),
                new SqlParameter("@WOId", SqlDbType.Int),
                new SqlParameter("@DepartId", SqlDbType.Int),
                new SqlParameter("@RequestUserId", SqlDbType.Int),
                new SqlParameter("@ResponseUserId", SqlDbType.Int),
                new SqlParameter("@FormDescription", SqlDbType.NVarChar, 200),
                new SqlParameter("@State", SqlDbType.TinyInt),
                new SqlParameter("@PrepareState", SqlDbType.TinyInt),
                new SqlParameter("@Prioritys", SqlDbType.TinyInt),
                new SqlParameter("@UserDate", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.MaterialRequestId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.FormNO;
            parms[2].Value = entity.WOId;
            parms[3].Value = entity.DepartId;
            parms[4].Value = entity.RequestUserId;
            parms[5].Value = entity.ResponseUserId;
            parms[6].Value = entity.FormDescription;
            parms[7].Value = entity.State;
            parms[8].Value = entity.PrepareState;
            parms[9].Value = entity.Prioritys;
            parms[10].Value = entity.UserDate;
            parms[11].Value = entity.CreateBy;
            parms[12].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialRequest_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MaterialRequestId 字符串删除 MaterialRequest 信息。
        /// </summary>
        /// <param name="idString">MaterialRequestId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialRequest_Delete", parms);
        }

        /// <summary>
        /// 根据 MaterialRequestId 获取实体信息。
        /// </summary>
        /// <param name="materialRequestId">MaterialRequestId。</param>
        /// <returns>MaterialRequest 实体对象。</returns>
        public MaterialRequestInfo GetInfo(Int32 materialRequestId)
        {
            MaterialRequestInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = materialRequestId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialRequest_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialRequestInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetByte(7), rdr.GetByte(8), rdr.GetByte(9),
                        rdr.GetDateTime(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaterialRequest 实体对象。</returns>
       public MaterialRequestInfo GetInfo(String fieldValue)
        {
            MaterialRequestInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialRequest_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialRequestInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetByte(7), rdr.GetByte(8), rdr.GetByte(9),
                        rdr.GetDateTime(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14));
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// 查询未领料的单号
        /// add  by weixia on 2015/5/5
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialRequestInfo> GetRequestOrder(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialRequestInfo> list = new List<MaterialRequestInfo>();
            MaterialRequestInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaterialRequestMember", "MaterialRequestId",
                "[MaterialRequestId], [FormNO], [WOId], [DepartId], [RequestUserId], [ResponseUserId], [FormDescription], [State], [PrepareState], [Prioritys], [UserDate], [CreateDateTime], [CreateBy], [ModifyDateTime], [ModifyBy],[DepartName],[UserName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialRequestInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetByte(7), rdr.GetByte(8), rdr.GetByte(9),
                        rdr.GetDateTime(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14));
                    entity.DepartName = rdr.GetString(15);
                    entity.UserName = rdr.GetString(16);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 分页获取 MaterialRequest 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialRequestCount">materialRequest 总数。</param>
        /// <returns>MaterialRequest 列表。</returns>
        public List<MaterialRequestInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialRequestInfo> list = new List<MaterialRequestInfo>();
            MaterialRequestInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_MaterialRequest", "MaterialRequestId",
                "[MaterialRequestId], [FormNO], [WOId], [DepartId], [RequestUserId], [ResponseUserId], [FormDescription], [State], [PrepareState], [Prioritys], [UserDate], [CreateDateTime], [CreateBy], [ModifyDateTime], [ModifyBy],[OutForm]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialRequestInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetByte(7), rdr.GetByte(8), rdr.GetByte(9),
                        rdr.GetDateTime(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14));
                    entity.OutForm = rdr.GetString(15);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取领料单是否可删除和编辑
        /// </summary>
        /// <param name="id"></param>
        /// <returns>1可删除可编辑 0不能删除不可编辑</returns>
        public int Editable(int id)
        {
            MaterialRequestInfo info = GetInfo(id);
            if (info != null)
            {
                if (info.State == 0)
                {
                    return 1;
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return 1;
            }
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}