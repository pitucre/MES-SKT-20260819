using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentMouldRelation
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentItemRelation 信息。
        /// </summary>
        /// <param name="entity">EquipmentItemRelation 实体对象。</param>
        public Int32 Edit(EquipmentMouldRelationInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentMouldRelationId", SqlDbType.Int),
                new SqlParameter("@EquimentId", SqlDbType.Int, 4),
                new SqlParameter("@MouldId", SqlDbType.Int, 4),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.EquipmentMouldRelationId;
            parms[1].Value = entity.EquimentId;
            parms[2].Value = entity.MouldId;
            parms[3].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentMouldRelation_Edit", parms);

            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 新增机种与设备关系
        /// </summary>
        /// <param name="equimentId">模具ID</param>
        /// <param name="createBy">用户名</param>
        /// <param name="mouldString">设备ID</param>
        /// <returns></returns>
        public string SaveMouldInEquiment(int equimentId, string mouldString, string createBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquimentId", SqlDbType.VarChar,50),
                new SqlParameter("@MouldString", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = equimentId;
            parms[1].Value = mouldString;
            parms[2].Value = createBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Mould_EditInEquipment", parms);

            return parms[0].Value.ToString();
        }

        /// <summary>
        /// 删除设备模具关系
        /// </summary>
        /// <param name="equimentId">设备ID</param>
        /// <param name="createBy">用户名</param>
        /// <param name="itemString">设备ID</param>
        public void RemoveMouldOutEquiment(int equimentId, string itemString, string createBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquimentId", SqlDbType.Int,4),
                new SqlParameter("@MouldString", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = equimentId;
            parms[1].Value = itemString;
            parms[2].Value = createBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Mould_EquipmentDelete", parms);
        }


        /// <summary>
        /// 根据 EquipmentItemRelationId 字符串删除 EquipmentItemRelation 信息。
        /// </summary>
        /// <param name="idString">EquipmentItemRelationId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentMouldRelation_Delete", parms);
        }

        /// <summary>
        /// 根据 equipmentMouldRelationId 获取实体信息。
        /// </summary>
        /// <param name="equipmentMouldRelationId">equipmentMouldRelationId。</param>
        /// <returns>EquipmentItemRelation 实体对象。</returns>
        public EquipmentMouldRelationInfo GetInfo(Int32 equipmentMouldRelationId)
        {
            EquipmentMouldRelationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = equipmentMouldRelationId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentMouldRelation_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentMouldRelationInfo();
                    entity.EquipmentMouldRelationId = Convert.ToInt32(rdr["EquipmentMouldRelationId"]);
                    entity.MouldId = Convert.ToInt32(rdr["MouldId"]);
                    entity.EquimentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquimentId = Convert.ToInt32(rdr["EquimentId"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                  
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>EquipmentItemRelation 实体对象。</returns>
        public EquipmentMouldRelationInfo GetInfo(String fieldValue)
        {
            EquipmentMouldRelationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentMouldRelation_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentMouldRelationInfo();
                    entity.EquipmentMouldRelationId = Convert.ToInt32(rdr["EquipmentMouldRelationId"]);
                    entity.MouldId = Convert.ToInt32(rdr["MouldId"]);
                    entity.EquimentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquimentId = Convert.ToInt32(rdr["EquimentId"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EquipmentItemRelation 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="equipmentItemRelationCount">equipmentItemRelation 总数。</param>
        /// <returns>EquipmentItemRelation 列表。</returns>
        public List<EquipmentMouldRelationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentMouldRelationInfo> list = new List<EquipmentMouldRelationInfo>();
            //表名或者视图
            string strTb = "vwEquipmentMouldRelation";
            //主键
            string strKey = "EquipmentMouldRelationId";
            //查询栏位字串         
            string strColumns = @"EquipmentMouldRelationId,MouldId,EquimentId,CreateDateTime,EquimentCode,EquimentName,BomName,BomCode,IsDelete,CreateBy,CreateBy2,ModifyBy,ModifyTime";
            list = ComMethod.GetComList<EquipmentMouldRelationInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }


        

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}