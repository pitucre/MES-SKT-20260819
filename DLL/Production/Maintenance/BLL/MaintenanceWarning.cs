using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Maintenance.Model;

namespace SKT.LeanMES.Maintenance.BLL
{
    public class MaintenanceWarning
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 根据 MAINTAINANCEId 获取实体信息。 获取预警列表中，选定计划的信息。
        /// </summary>
        /// <param name="mAINTAINANCEId">MAINTAINANCEId。</param>
        /// <returns>MAINTAINANCE 实体对象。</returns>
        public MaintenanceWarningInfo GetInfo(Int32 mAINTAINANCEId)
        {
            MaintenanceWarningInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = mAINTAINANCEId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceWarring_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    //entity = new MaintenanceWarningInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetByte(5), rdr.GetByte(6), rdr.GetString(7), rdr.GetString(8)
                    //    , rdr.GetString(9), rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetValue(14).ToString(), rdr.GetInt32(15), rdr.GetString(16), rdr.GetInt32(17), rdr.GetInt32(18), rdr.GetInt32(19)
                    //    , rdr.GetString(20), rdr.GetString(21), rdr.GetString(22), rdr.GetString(23));
                    entity = new MaintenanceWarningInfo();
                    entity.Eid = Convert.ToInt32(rdr["Eid"]);
                    entity.MaintenancePlanId = Convert.ToInt32(rdr["MaintenancePlanId"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.MaintainWay = Convert.ToByte(rdr["MaintainWay"]);

                    entity.CycleType = Convert.ToByte(rdr["CycleType"]);
                    entity.MaintainWayStr = Convert.ToString(rdr["MaintainWayStr"]);
                    entity.CycleTypeStr = Convert.ToString(rdr["CycleTypeStr"]);
                    entity.MaintainContents = Convert.ToString(rdr["MaintainContents"]);
                    entity.MaintainPerson = Convert.ToString(rdr["MaintainPerson"]);
                    entity.WarningTo = Convert.ToString(rdr["WarningTo"]);

                    entity.WarningEmail = Convert.ToString(rdr["WarningEmail"]);
                    entity.StatusStr = Convert.ToString(rdr["WarningStatus"]);
                    entity.WillMaintainOfDateTime = Convert.ToString(rdr["WillMaintainOfDateTime"]);


                    entity.CycleTime = Convert.ToInt32(rdr["CycleTime"]);
                    entity.TimeoutWarning = Convert.ToString(rdr["TimeoutWarning"]);
                    entity.LifeTime = Convert.ToInt32(rdr["LifeTime"]);
                    entity.UsedTimes = Convert.ToInt32(rdr["UsedTimes"]);

                    entity.WillMaintainOfTimes = Convert.ToString(rdr["WillMaintainOfTimes"]);
                    entity.WillSendWarningTimes = Convert.ToString(rdr["WillSendWarningTimes"]);
                    entity.WillSendWarningDateTime = Convert.ToString(rdr["WillSendWarningDateTime"]);

                    entity.PlanName = Convert.ToString(rdr["PlanName"]);
                    entity.LastDateTime = Convert.ToString(rdr["LastMaintainTime"]);
                }
                rdr.Close();
            }

            return entity;
        }


        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MAINTAINANCE 实体对象。</returns>
        public MaintenanceWarningInfo GetInfo(String fieldValue)
        {
            MaintenanceWarningInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceWarring_GetInfo", parms))
            {
                if (rdr.Read())
                {

                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 所有符合预警的计划信息。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mAINTAINANCECount">mAINTAINANCE 总数。</param>
        /// <returns>EQUIPMENTWARNING 列表。</returns>
        public List<MaintenanceWarningInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaintenanceWarningInfo> list = new List<MaintenanceWarningInfo>();
            MaintenanceWarningInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaintenanceWarning", "Eid",
                "Eid,[MaintenancePlanId], [EquipmentCode], [EquipmentName], [MaintainWay], [CycleType], [MaintainWayStr], [CycleTypeStr], [MaintainContents], "
                + "[MaintainPerson], [WarningTo], [WarningEmail], [WarningStatus], [WillMaintainOfDateTime], [CycleTime]"
                + ",[TimeoutWarning], [LifeTime], [UsedTimes], [WillMaintainOfTimes], [WillSendWarningTimes], "
                + "[WillSendWarningDateTime],PlanName,LastMaintainTime,NextMaintainTime,MaintainPersonName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaintenanceWarningInfo();
                    entity.Eid = Convert.ToInt32(rdr["Eid"]);
                    entity.MaintenancePlanId = Convert.ToInt32(rdr["MaintenancePlanId"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.MaintainWay = Convert.ToByte(rdr["MaintainWay"]);

                    entity.CycleType = Convert.ToByte(rdr["CycleType"]);
                    entity.MaintainWayStr = Convert.ToString(rdr["MaintainWayStr"]);
                    entity.CycleTypeStr = Convert.ToString(rdr["CycleTypeStr"]);
                    entity.MaintainContents = Convert.ToString(rdr["MaintainContents"]);
                    entity.MaintainPerson = Convert.ToString(rdr["MaintainPerson"]);
                    entity.WarningTo = Convert.ToString(rdr["WarningTo"]);

                    entity.WarningEmail = Convert.ToString(rdr["WarningEmail"]);
                    entity.StatusStr = Convert.ToString(rdr["WarningStatus"]);
                    entity.WillMaintainOfDateTime = Convert.ToString(rdr["WillMaintainOfDateTime"]);

                  
                    entity.CycleTime = Convert.ToInt32(rdr["CycleTime"]);
                    entity.TimeoutWarning = Convert.ToString(rdr["TimeoutWarning"]);
                    entity.LifeTime = Convert.ToInt32(rdr["LifeTime"]);
                    entity.UsedTimes = Convert.ToInt32(rdr["UsedTimes"]);

                    entity.WillMaintainOfTimes = Convert.ToString(rdr["WillMaintainOfTimes"]);
                    entity.WillSendWarningTimes = Convert.ToString(rdr["WillSendWarningTimes"]);
                    entity.WillSendWarningDateTime = Convert.ToString(rdr["WillSendWarningDateTime"]);

                    entity.PlanName = Convert.ToString(rdr["PlanName"]);
                    entity.LastDateTime = Convert.ToDateTime(rdr["LastMaintainTime"]).ToString("yyyy-MM-dd HH:mm:ss");
                    entity.NextMaintainTime = Convert.ToDateTime(rdr["NextMaintainTime"]);
                    entity.MaintainPersonName = Convert.ToString(rdr["MaintainPersonName"]);
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
