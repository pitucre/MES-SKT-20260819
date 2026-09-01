using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentFileManage
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentFileManage 信息。
        /// </summary>
        /// <param name="entity">EquipmentFileManage 实体对象。</param>
        public Int32 Edit(EquipmentFileManageInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentFileManageId", SqlDbType.Int),
                new SqlParameter("@EqCode", SqlDbType.VarChar, 50),
                new SqlParameter("@FileName", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@Reserve", SqlDbType.VarChar, 50),
                new SqlParameter("@Reserve1", SqlDbType.VarChar, 50),
                new SqlParameter("@Reserve2", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.EquipmentFileManageId;
            parms[1].Value = entity.EqCode;
            parms[2].Value = entity.FileName;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.Reserve;
            parms[5].Value = entity.Reserve1;
            parms[6].Value = entity.Reserve2;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentFileManage_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 EquipmentFileManageId 字符串删除 EquipmentFileManage 信息。
        /// </summary>
        /// <param name="idString">EquipmentFileManageId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentFileManage_Delete", parms);
        }

        /// <summary>
        /// 根据 EquipmentFileManageId 获取实体信息。
        /// </summary>
        /// <param name="equipmentFileManageId">EquipmentFileManageId。</param>
        /// <returns>EquipmentFileManage 实体对象。</returns>
        public EquipmentFileManageInfo GetInfo(Int32 equipmentFileManageId)
        {
            EquipmentFileManageInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = equipmentFileManageId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentFileManage_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentFileManageInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>EquipmentFileManage 实体对象。</returns>
        public EquipmentFileManageInfo GetInfo(String fieldValue)
        {
            EquipmentFileManageInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentFileManage_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentFileManageInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EquipmentFileManage 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="equipmentFileManageCount">equipmentFileManage 总数。</param>
        /// <returns>EquipmentFileManage 列表。</returns>
        public List<EquipmentFileManageInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentFileManageInfo> list = new List<EquipmentFileManageInfo>();
            EquipmentFileManageInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_EquipmentFileManage", "EquipmentFileManageId",
                "[EquipmentFileManageId], [EqCode], [FileName], [CreateBy], [CreateDateTime], [Reserve], [Reserve1], [Reserve2],ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentFileManageInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7));

                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyTime"))) {
                        entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                        entity.ModifyTime = Convert.ToDateTime(rdr["ModifyTime"]);
                    }
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