using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Maintenance.Model;

namespace SKT.LeanMES.Maintenance.BLL
{
    public class MaintenancePlan
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaintenancePlan 信息。
        /// </summary>
        /// <param name="entity">MaintenancePlan 实体对象。</param>
        public void Edit(MaintenancePlanInfo entity, String demoIdStr, Int32 creatorId, String creator)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaintenancePlanId", SqlDbType.Int),
                //new SqlParameter("@EquipmentCode", SqlDbType.VarChar, 20),
                new SqlParameter("@MaintainContents", SqlDbType.NVarChar, 1000),
                new SqlParameter("@MaintainWay", SqlDbType.TinyInt),
                new SqlParameter("@CycleType", SqlDbType.TinyInt),
                new SqlParameter("@CycleTime", SqlDbType.Int),
                //new SqlParameter("@Usage", SqlDbType.Int),
                new SqlParameter("@Prewarning", SqlDbType.Int),
                new SqlParameter("@MaintainPerson", SqlDbType.VarChar, 20),
                new SqlParameter("@WarningTo", SqlDbType.VarChar, 20),
               // new SqlParameter("@WarningEmail", SqlDbType.VarChar, 50),
                //new SqlParameter("@Status", SqlDbType.Int),
                //new SqlParameter("@FinisheDateTime", SqlDbType.DateTime),
                //new SqlParameter("@LifeTime", SqlDbType.Int),
                //new SqlParameter("@UsedTimes", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@demoIdStr", SqlDbType.NVarChar, 100),
                new SqlParameter("@creatorId", SqlDbType.Int),
                new SqlParameter("@creator", SqlDbType.NVarChar, 50),
                //new SqlParameter("@FinisheDateTime", SqlDbType.DateTime),
                new SqlParameter("@PlanName", SqlDbType.NVarChar, 50)
                //new SqlParameter("@PlanObjectType", SqlDbType.Int, 4),
                //new SqlParameter("@EquipmentType", SqlDbType.Int, 4)
            };

            parms[0].Value = entity.MaintenancePlanId;
            //parms[1].Value = entity.EquipmentCode;
            parms[1].Value = entity.MaintainContents;
            parms[2].Value = entity.MaintainWay;
            parms[3].Value = entity.CycleType;
            parms[4].Value = entity.CycleTime;
            //parms[6].Value = entity.Usage;
            parms[5].Value = entity.Prewarning;
            parms[6].Value = entity.MaintainPerson;
            parms[7].Value = entity.WarningTo;
            //parms[9].Value = entity.WarningEmail;
            //parms[11].Value = entity.Status;
            //parms[12].Value = entity.FinisheDateTime;
            // parms[10].Value = entity.LifeTime;
            //parms[14].Value = entity.UsedTimes;
            parms[8].Value = entity.CreateBy;
            parms[9].Value = entity.ModifyBy;
            parms[10].Value = entity.Remark;

            parms[11].Value = demoIdStr;
            parms[12].Value = creatorId;
            parms[13].Value = creator;
            //parms[15].Value = entity.FinisheDateTime;
            parms[14].Value = entity.PlanName;
            //parms[17].Value = entity.PlanObjectType;
            //parms[18].Value = entity.EquipmentType;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenancePlan_Edit", parms);

        }

        /// <summary>
        /// 编辑（添加或更新） MaintenanceEquiment 信息。
        /// </summary>
        /// <param name="entity">MaintenancePlan 实体对象。</param>
        public void EditMaintenanceEquiment(MaintenancePlanInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PlanId", SqlDbType.Int),
                new SqlParameter("@PlanObject", SqlDbType.Int, 4),
                new SqlParameter("@EquimentTypeId", SqlDbType.Int, 4),
                new SqlParameter("@EquimentId", SqlDbType.Int),
                new SqlParameter("@NextMaintainTime", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@Eid", SqlDbType.Int, 4),
                new SqlParameter("@LastMaintainTime", SqlDbType.DateTime)
            };


            parms[0].Value = entity.MaintenancePlanId;
            parms[1].Value = entity.PlanObjectType;
            parms[2].Value = entity.EquipmentType;
            parms[3].Value = entity.EquipmentId;
            parms[4].Value = entity.FinisheDateTime;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.Remark;
            parms[7].Value = entity.Eid;
            parms[8].Value = entity.LastMaintainTime;


            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceEquimentEdit", parms);

        }




        /// <summary>
        /// 根据 MaintenancePlanId 字符串删除 MaintenancePlan 信息。
        /// </summary>
        /// <param name="idString">MaintenancePlanId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenancePlan_Delete", parms);
        }

        /// <summary>
        /// 根据 MaintenancePlanId 获取MaintenancePlan实体信息。
        /// </summary>
        /// <param name="maintenancePlanId">MaintenancePlanId。</param>
        /// <returns>MaintenancePlan 实体对象。</returns>
        public MaintenancePlanInfo GetInfo(Int32 maintenancePlanId)
        {
            MaintenancePlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = maintenancePlanId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenancePlan_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaintenancePlanInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetByte(3), rdr.GetByte(4), rdr.GetString(5), rdr.GetString(6),
                        rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetString(10), rdr.GetString(11),
                        rdr.GetString(12), rdr.GetString(13), rdr.GetDateTime(14), rdr.GetInt32(15), rdr.GetInt32(16), rdr.GetString(17), rdr.GetDateTime(18),
                        rdr.GetString(19), rdr.GetDateTime(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetString(24));
                    entity.LastMaintainTime = rdr.GetDateTime(25);
                    entity.Status = rdr.GetInt32(26);
                    entity.PlanName = Convert.ToString(rdr["PlanName"]);
                    entity.PlanObjectType = Convert.ToInt32(rdr["PlanObjectType"]);
                    entity.PlanObjectTypeName = Convert.ToString(rdr["PlanObjectTypeName"]);
                    entity.EquipmentType = Convert.ToInt32(rdr["EquipmentType"]);
                    entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);

                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取MaintenancePlan实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaintenancePlan 实体对象。</returns>
        public MaintenancePlanInfo GetInfo(String fieldValue)
        {
            MaintenancePlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenancePlan_GetInfo", parms))
            {
                if (rdr.Read())
                {

                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MaintenancePlan 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mAINTAINANCECount">MaintenancePlan 总数。</param>
        /// <returns>MaintenancePlan 列表。</returns>
        public List<MaintenancePlanInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaintenancePlanInfo> list = new List<MaintenancePlanInfo>();
            MaintenancePlanInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaintenancePlan", "MaintenancePlanId",
                "[MaintenancePlanId], [EquipmentCode], [MaintainContents], [MaintainWay], [CycleType], [MaintainWayStr], [CycleTypeStr], [CycleTime], [Usage], [Prewarning], [MaintainPerson], [WarningTo], [WarningEmail], [WarningStatus], [FinisheDateTime], [LifeTime]"
                + ", [UsedTimes], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], [EquipmentName], [LineName], [Station], [PrewarningStr],LastMaintainTime,Status,PlanName,PlanObjectType,PlanObjectTypeName,EquipmentType,EquipmentTypeName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaintenancePlanInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetByte(3), rdr.GetByte(4), rdr.GetString(5), rdr.GetString(6),
                        rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetString(10), rdr.GetString(11),
                        rdr.GetString(12), rdr.GetString(13), rdr.GetDateTime(14), rdr.GetInt32(15), rdr.GetInt32(16), rdr.GetString(17), rdr.GetDateTime(18),
                        rdr.GetString(19), rdr.GetDateTime(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetString(24));
                    entity.PrewarningStr = rdr.GetString(25);
                    entity.LastMaintainTime = Convert.ToDateTime(rdr["LastMaintainTime"]);
                    entity.Status = Convert.ToInt32(rdr["Status"]);
                    entity.PlanName = Convert.ToString(rdr["PlanName"]);
                    entity.PlanObjectType = Convert.ToInt32(rdr["PlanObjectType"]);
                    entity.PlanObjectTypeName = Convert.ToString(rdr["PlanObjectTypeName"]);
                    entity.EquipmentType = Convert.ToInt32(rdr["EquipmentType"]);
                    entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 分页获取 MaintenancePlan 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mAINTAINANCECount">MaintenancePlan 总数。</param>
        /// <returns>MaintenancePlan 列表。</returns>
        public List<MaintenancePlanInfo> GetEquimentAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaintenancePlanInfo> list = new List<MaintenancePlanInfo>();
            MaintenancePlanInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaintenanceEquimentList", "Eid",
                "Eid,EquimentId,EquipmentCode,MaintenancePlanId,PlanName,EquipmentName,MaintainWay,Usage,MaintainWayStr,CycleType,CycleTypeStr,CycleTime,"
          + " Prewarning,MaintainPerson,WarningTo,WarningEmail,Status,WarningStatus,LifeTime,UsedTimes,NextMaintainTime,LastMaintainTime,CreateTime,CreateBy,"
            + "Remark,MaintainPersonName,ModifyBy,ModifyDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaintenancePlanInfo();
                    entity.Eid = Convert.ToInt32(rdr["Eid"]);
                    entity.EquipmentId = Convert.ToInt32(rdr["EquimentId"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.PlanName = Convert.ToString(rdr["PlanName"]);
                    entity.MaintenancePlanId = Convert.ToInt32(rdr["MaintenancePlanId"]);

                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.MaintainWay = Convert.ToByte(rdr["MaintainWay"]);
                    entity.Usage = Convert.ToInt32(rdr["Usage"]);
                    entity.MaintainWayStr = Convert.ToString(rdr["MaintainWayStr"]);

                    entity.CycleType = Convert.ToByte(rdr["CycleType"]);
                    entity.CycleTypeStr = Convert.ToString(rdr["CycleTypeStr"]);
                    entity.CycleTime = Convert.ToInt32(rdr["CycleTime"]);

                    entity.Prewarning = Convert.ToInt32(rdr["Prewarning"]);
                    entity.MaintainPerson = Convert.ToString(rdr["MaintainPerson"]);
                    entity.WarningTo = Convert.ToString(rdr["WarningTo"]);
                    entity.WarningEmail = Convert.ToString(rdr["WarningEmail"]);
                    entity.Status = Convert.ToInt32(rdr["Status"]);
                    entity.StatusStr = Convert.ToString(rdr["WarningStatus"]);

                    entity.LifeTime = Convert.ToInt32(rdr["LifeTime"]);
                    entity.UsedTimes = Convert.ToInt32(rdr["UsedTimes"]);
                    if (rdr["NextMaintainTime"] != DBNull.Value)
                        entity.FinisheDateTime = Convert.ToDateTime(rdr["NextMaintainTime"]);
                    entity.LastMaintainTime = Convert.ToDateTime(rdr["LastMaintainTime"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.MaintainPersonName = Convert.ToString(rdr["MaintainPersonName"]);
                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyDateTime"))) {
                        entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                        entity.ModifyDateTime = Convert.ToDateTime(rdr["ModifyDateTime"]);
                    }
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 分页获取 MaintenancePlan 资料。
        /// </summary>
        /// <param name="eid">起始行。</param>

        /// <returns>MaintenancePlan 列表。</returns>
        public MaintenancePlanInfo GetEquimentInfo(int eid)
        {
            MaintenancePlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Eid", SqlDbType.Int, 4)

            };

            parms[0].Value = eid;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceEquiment_GetInfo", parms))
            {
                if (rdr.Read())
                {

                    entity = new MaintenancePlanInfo();
                    entity.Eid = Convert.ToInt32(rdr["Eid"]);
                    entity.EquipmentId = Convert.ToInt32(rdr["EquimentId"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.PlanName = Convert.ToString(rdr["PlanName"]);
                    entity.MaintenancePlanId = Convert.ToInt32(rdr["MaintenancePlanId"]);

                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.MaintainWay = Convert.ToByte(rdr["MaintainWay"]);
                    entity.Usage = Convert.ToInt32(rdr["Usage"]);
                    entity.MaintainWayStr = Convert.ToString(rdr["MaintainWayStr"]);

                    entity.CycleType = Convert.ToByte(rdr["CycleType"]);
                    entity.CycleTypeStr = Convert.ToString(rdr["CycleTypeStr"]);
                    entity.CycleTime = Convert.ToInt32(rdr["CycleTime"]);

                    entity.Prewarning = Convert.ToInt32(rdr["Prewarning"]);
                    entity.MaintainPerson = Convert.ToString(rdr["MaintainPerson"]);
                    entity.WarningTo = Convert.ToString(rdr["WarningTo"]);
                    entity.WarningEmail = Convert.ToString(rdr["WarningEmail"]);
                    entity.Status = Convert.ToInt32(rdr["Status"]);
                    entity.StatusStr = Convert.ToString(rdr["WarningStatus"]);

                    entity.LifeTime = Convert.ToInt32(rdr["LifeTime"]);
                    entity.UsedTimes = Convert.ToInt32(rdr["UsedTimes"]);
                    entity.FinisheDateTime = Convert.ToDateTime(rdr["NextMaintainTime"]);

                    entity.LastMaintainTime = Convert.ToDateTime(rdr["LastMaintainTime"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);

                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据设备编码获取保养计划信息
        /// </summary>
        /// <param name="equipmentCode">MaintenancePlan 总数。</param>
        /// <returns>MaintenancePlan 列表。</returns>
        public List<MaintenancePlanInfo> GetEquipmentChildAll(string equipmentCode)
        {
            List<MaintenancePlanInfo> list = new List<MaintenancePlanInfo>();
            MaintenancePlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentCode", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = equipmentCode;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspEquToMaintenancePlan", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaintenancePlanInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetByte(3), rdr.GetByte(4), rdr.GetString(5), rdr.GetString(6),
                        rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetString(10), rdr.GetString(11),
                        rdr.GetString(12), rdr.GetString(13), rdr.GetDateTime(14), rdr.GetInt32(15), rdr.GetInt32(16), rdr.GetString(17), rdr.GetDateTime(18),
                        rdr.GetString(19), rdr.GetDateTime(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23), rdr.GetString(24));
                    entity.PrewarningStr = rdr.GetString(25);
                    entity.LastMaintainTime = Convert.ToDateTime(rdr["LastMaintainTime"]);
                    entity.Status = Convert.ToInt32(rdr["Status"]);
                    entity.PlanName = Convert.ToString(rdr["PlanName"]);
                    entity.PlanObjectType = Convert.ToInt32(rdr["PlanObjectType"]);
                    entity.PlanObjectTypeName = Convert.ToString(rdr["PlanObjectTypeName"]);
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

        /// <summary>
        /// 获取设备编码，名称，产线名，工位名，用于DDL绑定和Label文本初始化。
        /// </summary>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mAINTAINANCECount">MaintenancePlan 总数。</param>
        /// <returns>MaintenancePlan 列表。</returns>
        public List<MaintenancePlanInfo> BindDDL(String sortExpression, SearchSettings searchSettings)
        {
            List<MaintenancePlanInfo> list = new List<MaintenancePlanInfo>();
            MaintenancePlanInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1, "vwEquipment", "EquipmentId",
                "[EquipmentCode], [EquipmentName],[LineName] ,[Station]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaintenancePlanInfo(rdr.GetString(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3));

                    entity.EquipmentName = "Code：" + entity.EquipmentCode + "  Name：" + entity.EquipmentName;     //将编码和名称组合，再赋给设备名字段。

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 保养确认，状态变为未预警，更新保养成功时的设备已使用次数，设备保养成功的时间。
        /// 将此次保养信息插入到保养记录表。如果不符合保养条件，则抛出异常。
        /// </summary>
        /// <param name="maintenancePlanId">计划id</param>
        /// <param name="modifyBy">操作者</param>
        public void MaintenanceConfirm(Int32 maintenancePlanId, string modifyBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaintenancePlanId", SqlDbType.Int),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = maintenancePlanId;
            parms[1].Value = modifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPlanMaintainConfirm", parms);
        }

        /// <summary>
        /// 用于自动更新下次保养日期已过的的记录
        /// </summary>
        public void MaintenanceUpdateStatus()
        {
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaintenanceUpdateStatus", null);
        }
        /// <summary>
        /// 根据Eid 设备保养计划id 字符串删除 Prod_MaintenancePlanRelationEquiment 信息。
        /// add by beichang.zhong 2019.07.27
        /// </summary>
        /// <param name="idString">Eid 字符串。</param>
        /// <returns>日志内容。</returns>
        public void MaintenanceEquimentDelete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaintenanceEquimentDelete", parms);
        }
    }
}