using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentLineRelation
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentLineRelation 信息。
        /// </summary>
        /// <param name="entity">EquipmentLineRelation 实体对象。</param>
        public Int32 Edit(EquipmentLineRelationInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentLineId", SqlDbType.Int),
                new SqlParameter("@EquipmentLineType", SqlDbType.VarChar, 200),
                new SqlParameter("@EquipmentLineDisplayName", SqlDbType.VarChar, 200),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@UpdateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@Remark", SqlDbType.VarChar, 200)
             
            };

            parms[0].Value = entity.EquipmentLineId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.EquipmentLineType;
            parms[2].Value = entity.EquipmentLineDisplayName;
            parms[3].Value = entity.LineId;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.UpdateBy;
            parms[6].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentLineRelation_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 EquipmentLineRelationId 字符串删除 EquipmentLineRelation 信息。
        /// </summary>
        /// <param name="idString">EquipmentLineRelationId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentLineRelation_Delete", parms);
        }

        /// <summary>
        /// 根据 EquipmentLineRelationId 获取实体信息。
        /// </summary>
        /// <param name="equipmentLineRelationId">EquipmentLineRelationId。</param>
        /// <returns>EquipmentLineRelation 实体对象。</returns>
        public EquipmentLineRelationInfo GetInfo(Int32 equipmentLineRelationId)
        {
            EquipmentLineRelationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.Int),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = equipmentLineRelationId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentLineRelation_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentLineRelationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EquipmentLineRelation 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="equipmentLineRelationCount">equipmentLineRelation 总数。</param>
        /// <returns>EquipmentLineRelation 列表。</returns>
        public List<EquipmentLineRelationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentLineRelationInfo> list = new List<EquipmentLineRelationInfo>();
            EquipmentLineRelationInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_EquipmentLineRelation", "EquipmentLineId",
                "[EquipmentLineId], [EquipmentLineType], [EquipmentLineDisplayName], [LineId], [CreateBy], [CreateDateTime], [UpdateBy], [UpdateDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentLineRelationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));

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