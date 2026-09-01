using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class InspectionOrderMemberItem
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） InspectionOrderMemberItem 信息。
        /// </summary>
        /// <param name="entity">InspectionOrderMemberItem 实体对象。</param>
        public Int32 Edit(InspectionOrderMemberItemInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOMItemId", SqlDbType.Int),
                new SqlParameter("@IOrderId", SqlDbType.Int),
                new SqlParameter("@IOMemberId", SqlDbType.Int),
                new SqlParameter("@InspectionItemName", SqlDbType.NVarChar, 150),
                new SqlParameter("@StandardMaxValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@StandardMinValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@InspectionAccording", SqlDbType.NVarChar, 50),
                new SqlParameter("@SpecialRequest", SqlDbType.NVarChar, 50),
                new SqlParameter("@InspectionValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@InspectionResult", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@SamplingRate", SqlDbType.Int, 20),
                new SqlParameter("@RecordCount", SqlDbType.Int, 50)
            };

            parms[0].Value = entity.IOMItemId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.IOrderId;
            parms[2].Value = entity.IOMemberId;
            parms[3].Value = entity.InspectionItemName;
            parms[4].Value = entity.StandardMaxValue;
            parms[5].Value = entity.StandardMinValue;
            parms[6].Value = entity.InspectionAccording;
            parms[7].Value = entity.SpecialRequest;
            parms[8].Value = entity.InspectionValue;
            parms[9].Value = entity.InspectionResult;
            parms[10].Value = entity.CreateBy;
            parms[11].Value = entity.ModifyBy;
            parms[12].Value = entity.Remark;
            parms[13].Value = entity.SamplingCount;
            parms[14].Value = entity.RecordCount;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionOrderMemberItem_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 编辑（添加或更新） InspectionOrderMemberItem 信息。
        /// </summary>
        /// <param name="entity">InspectionOrderMemberItem 实体对象。</param>
        public Int32 EditJW(InspectionOrderMemberItemInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOMItemId", SqlDbType.Int),
                new SqlParameter("@IOrderId", SqlDbType.Int),
                new SqlParameter("@IOMemberId", SqlDbType.Int),
                new SqlParameter("@InspectionItemName", SqlDbType.NVarChar, 150),
                new SqlParameter("@StandardMaxValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@StandardMinValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@InspectionAccording", SqlDbType.NVarChar, 1000),
                new SqlParameter("@SpecialRequest", SqlDbType.NVarChar, 50),
                new SqlParameter("@InspectionValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@InspectionResult", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 1000),
                new SqlParameter("@SamplingRate", SqlDbType.Int, 20),
                new SqlParameter("@RecordCount", SqlDbType.Int, 50),
                new SqlParameter("@SaveOpenName", SqlDbType.NVarChar, 100),
                new SqlParameter("@FUrlString", SqlDbType.NVarChar, 1000),
                new SqlParameter("@PUrlString", SqlDbType.NVarChar, 1000),
            };

            parms[0].Value = entity.IOMItemId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.IOrderId;
            parms[2].Value = entity.IOMemberId;
            parms[3].Value = entity.InspectionItemName;
            parms[4].Value = entity.StandardMaxValue;
            parms[5].Value = entity.StandardMinValue;
            parms[6].Value = entity.InspectionAccording;
            parms[7].Value = entity.SpecialRequest;
            parms[8].Value = entity.InspectionValue;
            parms[9].Value = entity.InspectionResult;
            parms[10].Value = entity.CreateBy;
            parms[11].Value = entity.ModifyBy;
            parms[12].Value = entity.Remark;
            parms[13].Value = entity.SamplingCount;
            parms[14].Value = entity.RecordCount;
            parms[15].Value = entity.SaveOpenName;
            parms[16].Value = entity.FUrlString;
            parms[17].Value = entity.PUrlString;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionOrderMemberItem_EditJW", parms);

            return (Int32)parms[0].Value;
        }

        public Int32 Update(InspectionOrderMemberItemInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOMItemId", SqlDbType.Int),
                new SqlParameter("@IOrderId", SqlDbType.Int),
                new SqlParameter("@IOMemberId", SqlDbType.Int),
                new SqlParameter("@InspectionItemName", SqlDbType.NVarChar, 150),
                new SqlParameter("@StandardMaxValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@StandardMinValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@InspectionAccording", SqlDbType.NVarChar, 50),
                new SqlParameter("@SpecialRequest", SqlDbType.NVarChar, 50),
                new SqlParameter("@InspectionValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@InspectionResult", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.IOMItemId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.IOrderId;
            parms[2].Value = entity.IOMemberId;
            parms[3].Value = entity.InspectionItemName;
            parms[4].Value = entity.StandardMaxValue;
            parms[5].Value = entity.StandardMinValue;
            parms[6].Value = entity.InspectionAccording;
            parms[7].Value = entity.SpecialRequest;
            parms[8].Value = entity.InspectionValue;
            parms[9].Value = entity.InspectionResult;
            parms[10].Value = entity.CreateBy;
            parms[11].Value = entity.ModifyBy;
            parms[12].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionOrderMemberItem_Update", parms);

            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 根据 InspectionOrderMemberItemId 字符串删除 InspectionOrderMemberItem 信息。
        /// </summary>
        /// <param name="idString">InspectionOrderMemberItemId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionOrderMemberItem_Delete", parms);
        }

        /// <summary>
        /// 根据 InspectionOrderMemberItemId 获取实体信息。
        /// </summary>
        /// <param name="inspectionOrderMemberItemId">InspectionOrderMemberItemId。</param>
        /// <returns>InspectionOrderMemberItem 实体对象。</returns>
        public InspectionOrderMemberItemInfo GetInfo(Int32 inspectionOrderMemberItemId)
        {
            InspectionOrderMemberItemInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = inspectionOrderMemberItemId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionOrderMemberItem_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new InspectionOrderMemberItemInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionOrderMemberItem 实体对象。</returns>
        public InspectionOrderMemberItemInfo GetInfo(String fieldValue)
        {
            InspectionOrderMemberItemInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionOrderMemberItem_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new InspectionOrderMemberItemInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 InspectionOrderMemberItem 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionOrderMemberItemCount">inspectionOrderMemberItem 总数。</param>
        /// <returns>InspectionOrderMemberItem 列表。</returns>
        public List<InspectionOrderMemberItemInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionOrderMemberItemInfo> list = new List<InspectionOrderMemberItemInfo>();
            InspectionOrderMemberItemInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Quality_InspectionOrderMemberItem", "InspectionOrderMemberItemId",
                "[IOMItemId], [IOrderId], [IOMemberId], [InspectionItemName], [StandardMaxValue], [StandardMinValue], [InspectionAccording], [SpecialRequest], [InspectionValue], [InspectionResult], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new InspectionOrderMemberItemInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14));

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