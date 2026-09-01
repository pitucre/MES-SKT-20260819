using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentCheckOutPlan
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentCheckOutPlan 信息。
        /// </summary>
        /// <param name="entity">EquipmentCheckOutPlan 实体对象。</param>
        public Int32 Edit(EquipmentCheckOutPlanInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentCheckOutPlanId", SqlDbType.Int),
                new SqlParameter("@EqCode", SqlDbType.VarChar, 50),
                new SqlParameter("@CheckType", SqlDbType.Int),
                new SqlParameter("@CheckProject", SqlDbType.VarChar, 50),
                new SqlParameter("@CycleType", SqlDbType.VarChar, 50),
                new SqlParameter("@Cycle", SqlDbType.Int),
                new SqlParameter("@NextTime", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@ObjectType", SqlDbType.Int, 4),
                new SqlParameter("@EquipmentType", SqlDbType.Int,4),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50),
                new SqlParameter("@WarningDays", SqlDbType.Int),
                new SqlParameter("@LastTime", SqlDbType.DateTime)


            };
            //int time = 0;
            //var datetime = DateTime.Now;
            //if (entity.CycleType == "1")
            //{
            //    time = 60;
            //}
            //else if (entity.CycleType == "2")
            //{
            //    time = 60 * 24;
            //}
            //else if (entity.CycleType == "3")
            //{
            //    time = 60 * 24 * 7;
            //}
            //else if (entity.CycleType == "4")
            //{
            //    time = 60 * 24 * 30;
            //}
            //else if (entity.CycleType == "5")
            //{
            //    time = 60 * 24 * 365;
            //}
            //entity.NextTime = datetime.AddMinutes(time * entity.Cycle);
            parms[0].Value = entity.EquipmentCheckOutPlanId;
            parms[1].Value = entity.EqCode;
            parms[2].Value = entity.CheckType;
            parms[3].Value = entity.CheckProject;
            parms[4].Value = entity.CycleType;
            parms[5].Value = entity.Cycle;
            parms[6].Value = Convert.ToDateTime(entity.NextTimeStr);
            parms[7].Value = entity.CreateBy;
            parms[8].Value = entity.ObjectType;
            parms[9].Value = entity.EquipmentType;
            parms[10].Value = entity.ModifyBy;
            parms[11].Value = entity.WarningDays;
            parms[12].Value = entity.LastTimeStr == "" ? Convert.ToDateTime("9999-12-31 00:00:00.000") : Convert.ToDateTime(entity.LastTimeStr);


            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Equipment_EquipmentCheckOutPlan_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 EquipmentCheckOutPlanId 字符串删除 EquipmentCheckOutPlan 信息。
        /// </summary>
        /// <param name="idString">EquipmentCheckOutPlanId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Equipment_EquipmentCheckOutPlan_Delete", parms);
        }

        /// <summary>
        /// 根据 EquipmentCheckOutPlanId 获取实体信息。
        /// </summary>
        /// <param name="equipmentCheckOutPlanId">EquipmentCheckOutPlanId。</param>
        /// <returns>EquipmentCheckOutPlan 实体对象。</returns>
        public EquipmentCheckOutPlanInfo GetInfo(Int32 equipmentCheckOutPlanId)
        {
            EquipmentCheckOutPlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = equipmentCheckOutPlanId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Equipment_EquipmentCheckOutPlan_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentCheckOutPlanInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9));
                    entity.CheckProjectName = rdr.GetString(10);
                    entity.EqName = Convert.ToString(rdr["EquipmentName"]);

                    entity.ObjectType = Convert.ToInt32(rdr["ObjectType"]);
                    entity.ObjectTypeName = Convert.ToString(rdr["ObjectTypeName"]);
                    entity.EquipmentType = Convert.ToInt32(rdr["EquipmentType"]);
                    entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
                    if (!rdr.IsDBNull(rdr.GetOrdinal("WarningDays")))
                    {
                        entity.WarningDays = Convert.ToInt32(rdr["WarningDays"]);
                    }
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>EquipmentCheckOutPlan 实体对象。</returns>
        public EquipmentCheckOutPlanInfo GetInfo(String fieldValue)
        {
            EquipmentCheckOutPlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Equipment_EquipmentCheckOutPlan_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentCheckOutPlanInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9));
                    entity.CheckProjectName = rdr.GetString(10);
                    entity.EqName = Convert.ToString(rdr["EquipmentName"]);

                    entity.ObjectType = Convert.ToInt32(rdr["ObjectType"]);
                    entity.ObjectTypeName = Convert.ToString(rdr["ObjectTypeName"]);
                    entity.EquipmentType = Convert.ToInt32(rdr["EquipmentType"]);
                    entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EquipmentCheckOutPlan 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="equipmentCheckOutPlanCount">equipmentCheckOutPlan 总数。</param>
        /// <returns>EquipmentCheckOutPlan 列表。</returns>
        public List<EquipmentCheckOutPlanInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentCheckOutPlanInfo> list = new List<EquipmentCheckOutPlanInfo>();
            EquipmentCheckOutPlanInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwEquipmentCheckOutPlan", "EquipmentCheckOutPlanId",
                "[EquipmentCheckOutPlanId], [EqCode], [CheckType], [CheckProject], [CycleType], [Cycle], [LastTime], [NextTime], [CreateBy], [CreateTime],CheckTypeName,CycleTypeName,CheckOutProjectName,EquipmentName,ObjectType,ObjectTypeName,EquipmentType,EquipmentTypeName,IsWarning,ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentCheckOutPlanInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9));
                    entity.CheckTypeName = rdr.GetString(10);
                    entity.CycleTypeName = rdr.GetString(11);
                    entity.CheckProjectName = rdr.GetString(12);
                    entity.EqName = Convert.ToString(rdr["EquipmentName"]);

                    entity.ObjectType = Convert.ToInt32(rdr["ObjectType"]);
                    entity.ObjectTypeName = Convert.ToString(rdr["ObjectTypeName"]);
                    entity.EquipmentType = Convert.ToInt32(rdr["EquipmentType"]);
                    entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
                    entity.IsWarning = Convert.ToInt32(rdr["IsWarning"]);
                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyTime")))
                    {
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

        /// <summary>
        /// 根据设备编码获取校验计划信息
        /// </summary>
        /// <param name="equipmentCode">MaintenancePlan 总数。</param>
        /// <returns>MaintenancePlan 列表。</returns>
        public List<EquipmentCheckOutPlanInfo> GetEquipmentChildAll(string equipmentCode)
        {
            List<EquipmentCheckOutPlanInfo> list = new List<EquipmentCheckOutPlanInfo>();
            EquipmentCheckOutPlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentCode", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = equipmentCode;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspEquToCheckOutPlan", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentCheckOutPlanInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4),
                       rdr.GetInt32(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9));
                    entity.CheckTypeName = rdr.GetString(10);
                    entity.CycleTypeName = rdr.GetString(11);
                    entity.CheckProjectName = rdr.GetString(12);
                    entity.EqName = Convert.ToString(rdr["EquipmentName"]);

                    entity.ObjectType = Convert.ToInt32(rdr["ObjectType"]);
                    entity.ObjectTypeName = Convert.ToString(rdr["ObjectTypeName"]);
                    entity.EquipmentType = Convert.ToInt32(rdr["EquipmentType"]);
                    entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
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