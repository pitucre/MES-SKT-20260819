using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.MaterialDelivery.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.Common.Utility;

namespace SKT.LeanMES.MaterialDelivery.BLL
{
    public class MaterialPrepareDetail
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaterialPrepareDetail 信息。
        /// </summary>
        /// <param name="entity">MaterialPrepareDetail 实体对象。</param>
        public Int32 Edit(MaterialPrepareDetailInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@PrepareId", SqlDbType.Int),
                new SqlParameter("@MaterialNO", SqlDbType.NVarChar, 60),
                new SqlParameter("@RequestQty", SqlDbType.Decimal),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@LastPrepareDetailId", SqlDbType.Int),
                new SqlParameter("@RecordType", SqlDbType.Int),
                new SqlParameter("@IsCurrent", SqlDbType.Bit)
            };

            parms[0].Value = entity.Id;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.PrepareId;
            parms[2].Value = entity.MaterialNO;
            parms[3].Value = entity.RequestQty;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.LastPrepareDetailId;
            parms[6].Value = entity.RecordType;
            parms[7].Value = entity.IsCurrent;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialPrepareDetail_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MaterialPrepareDetailId 字符串删除 MaterialPrepareDetail 信息。
        /// </summary>
        /// <param name="idString">MaterialPrepareDetailId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialPrepareDetail_Delete", parms);
        }

        /// <summary>
        /// 根据 MaterialPrepareDetailId 获取实体信息。
        /// </summary>
        /// <param name="materialPrepareDetailId">MaterialPrepareDetailId。</param>
        /// <returns>MaterialPrepareDetail 实体对象。</returns>
        public MaterialPrepareDetailInfo GetInfo(Int32 materialPrepareDetailId)
        {
            MaterialPrepareDetailInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = materialPrepareDetailId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialPrepareDetail_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialPrepareDetailInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetDecimal(3), rdr.GetString(4), 
                        TypeHelper.ToString(rdr.GetDateTime(5)), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetBoolean(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaterialPrepareDetail 实体对象。</returns>
        public MaterialPrepareDetailInfo GetInfo(String fieldValue)
        {
            MaterialPrepareDetailInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialPrepareDetail_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialPrepareDetailInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetDecimal(3), rdr.GetString(4), 
                        TypeHelper.ToString(rdr.GetDateTime(5)), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetBoolean(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MaterialPrepareDetail 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialPrepareDetailCount">materialPrepareDetail 总数。</param>
        /// <returns>MaterialPrepareDetail 列表。</returns>
        public List<MaterialPrepareDetailInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialPrepareDetailInfo> list = new List<MaterialPrepareDetailInfo>();
            MaterialPrepareDetailInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_MaterialPrepareDetail", "MaterialPrepareDetailId",
                "[Id], [PrepareId], [MaterialNO], [RequestQty], [CreateBy], [CreateDateTime], [LastPrepareDetailId], [RecordType], [IsCurrent]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialPrepareDetailInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetDecimal(3), rdr.GetString(4), 
                        TypeHelper.ToString(rdr.GetDateTime(5)), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetBoolean(8));

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
        /// 获取备料单变更明细
        /// </summary>
        /// <returns></returns>
        public List<MaterialPrepareDetailInfo> GetMaPrepChangeDetail(int prepareId)
        {
            List<MaterialPrepareDetailInfo> list = new List<MaterialPrepareDetailInfo>();
            MaterialPrepareDetailInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@PrepareId", SqlDbType.Int)
            ,   new SqlParameter("@GetChange", SqlDbType.Bit)};

            parms[0].Value = prepareId;
            parms[1].Value = 1;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSchedulePreMaDetail", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialPrepareDetailInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDecimal(2), rdr.GetString(3),
                        TypeHelper.ToString(rdr.GetDateTime(4)), rdr.GetString(5), rdr.GetString(6));

                    entity.Times = rdr.GetInt32(7);
                    entity.LineName = rdr.GetString(8);
                    entity.ShiftName = rdr.GetString(9);

                    list.Add(entity);
                }
            }

            return list;
        }

        /// <summary>
        /// 获取备料单明细
        /// </summary>
        /// <returns></returns>
        public List<MaterialPrepareDetailInfo> GetMaterialPrepareDetail(int prepareId)
        {
            List<MaterialPrepareDetailInfo> list = new List<MaterialPrepareDetailInfo>();
            MaterialPrepareDetailInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@PrepareId", SqlDbType.Int)
            ,   new SqlParameter("@GetChange", SqlDbType.Bit)};

            parms[0].Value = prepareId;
            parms[1].Value = 0;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSchedulePreMaDetail", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialPrepareDetailInfo();
                    entity.MaterialNO = rdr.GetString(1);
                    entity.RequestQty = rdr.GetDecimal(2);
                    entity.LineName = rdr.GetString(3);
                    entity.ShiftName = rdr.GetString(4);

                    list.Add(entity);
                }
            }

            return list;
        }


        /// <summary>
        /// 获取备料单子项变更历史
        /// </summary>
        /// <returns></returns>
        public List<MaterialPrepareDetailInfo> GetSubitemChangeHistory(int prepareSubId)
        {
            List<MaterialPrepareDetailInfo> list = new List<MaterialPrepareDetailInfo>();
            MaterialPrepareDetailInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@PrepareSubId", SqlDbType.Int)};

            parms[0].Value = prepareSubId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSchedulePreMaSubitemHistory", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialPrepareDetailInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDecimal(2), rdr.GetString(3),
                        TypeHelper.ToString(rdr.GetDateTime(4)), rdr.GetString(5), rdr.GetString(6));

                    entity.IsCurrent = rdr.GetBoolean(7);

                    list.Add(entity);
                }
            }

            return list;
        }
        
    }
}