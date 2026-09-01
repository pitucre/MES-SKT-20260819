using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Maintenance.Model;

namespace SKT.LeanMES.Maintenance.BLL
{
    public class MaintenanceRecord
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MAINTAINACERECORD 信息。
        /// </summary>
        /// <param name="entity">MAINTAINACERECORD 实体对象。</param>
        public void Edit(MaintenanceRecordInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaintenanceRecordId", SqlDbType.Int),
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar, 20),
                new SqlParameter("@MaintainDetail", SqlDbType.NVarChar, 1000),
                new SqlParameter("@MaintainActionPerson", SqlDbType.VarChar, 20),
                new SqlParameter("@MaintainDateTime", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.MaintenanceRecordId;
            parms[1].Value = entity.EquipmentCode;
            parms[2].Value = entity.MaintainDetail;
            parms[3].Value = entity.MaintainActionPerson;
            parms[4].Value = entity.MaintainDateTime;
            parms[5].Value = entity.CreateBy;
            parms[7].Value = entity.ModifyBy;
            parms[9].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceRecord_Edit", parms);
        }

        /// <summary>
        /// 根据 MAINTAINACERECORDId 字符串删除 MAINTAINACERECORD 信息。
        /// </summary>
        /// <param name="idString">MAINTAINACERECORDId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceRecord_Delete", parms);
        }

        /// <summary>
        /// 根据 MAINTAINACERECORDId 获取实体信息。
        /// </summary>
        /// <param name="mAINTAINACERECORDId">MAINTAINACERECORDId。</param>
        /// <returns>MAINTAINACERECORD 实体对象。</returns>
        public MaintenanceRecordInfo GetInfo(Int32 mAINTAINACERECORDId)
        {
            MaintenanceRecordInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = mAINTAINACERECORDId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceRecord_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaintenanceRecordInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), rdr.GetString(10), rdr.GetString(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MAINTAINACERECORD 实体对象。</returns>
        public MaintenanceRecordInfo GetInfo(String fieldValue)
        {
            MaintenanceRecordInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceRecord_GetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MAINTAINACERECORD 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mAINTAINACERECORDCount">mAINTAINACERECORD 总数。</param>
        /// <returns>MAINTAINACERECORD 列表。</returns>
        public List<MaintenanceRecordInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaintenanceRecordInfo> list = new List<MaintenanceRecordInfo>();
            MaintenanceRecordInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaintenanceRecord", "MaintenanceRecordId",
                "[MaintenanceRecordId], [EquipmentCode], [MaintainDetail], [MaintainActionPerson], [MaintainDateTime], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[EquipmentTypeName],[EquipmentName],DemoSubName,PlanName,FileSaveName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaintenanceRecordInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), rdr.GetString(10), rdr.GetString(11));
                    entity.DemoSubName = Convert.ToString(rdr["DemoSubName"]);
                    entity.PlanName = Convert.ToString(rdr["PlanName"]);
                    entity.FileSaveName = Convert.ToString(rdr["FileSaveName"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }



        ///// <summary>
        ///// 分页获取 MAINTAINACERECORD 资料。
        ///// </summary>

        ///// <param name="equimentCode"></param>
        ///// <returns>MAINTAINACERECORD 列表。</returns>
        //public List<MaintenanceRecordInfo> GetChildAll(string equipmentCode)
        //{
        //    List<MaintenanceRecordInfo> list = new List<MaintenanceRecordInfo>();
        //    MaintenanceRecordInfo entity = null;
        //    SqlParameter[] parms = new SqlParameter[]{
        //        new SqlParameter("@EquipmentCode", SqlDbType.NVarChar, 50)
        //    };

        //    parms[0].Value = equipmentCode;

        //    using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspEquToMaintenanceRecord", parms))
        //    {
        //        while (rdr.Read())
        //        {
        //            entity = new MaintenanceRecordInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
        //                rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), rdr.GetString(10), rdr.GetString(11));
        //            entity.PlanName = Convert.ToString(rdr["PlanName"]);
        //            entity.ObjectTypeName = Convert.ToString(rdr["ObjectTypeName"]);

        //            list.Add(entity);
        //        }
        //        rdr.Close();
        //    }


        //    return list;
        //}

        /// <summary>
        /// 分页获取保养计划记录
        /// </summary>
        /// <param name="optType">起始行。</param>
        /// <param name="eqCode">设备编码。</param>
        public List<MaintenanceHistory> GetAllMaintenanceHistory(int optType, string eqCode)
        {
            MaintenanceHistory entity = null;
            List<MaintenanceHistory> list = new List<MaintenanceHistory>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OperateType", SqlDbType.Int, 4),
                new SqlParameter("@EquimentCode", SqlDbType.VarChar,50)
            };

            parms[0].Value = optType;
            parms[1].Value = eqCode;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetMaintenanceHistoryList", parms))
            {
                while (rdr.Read())
                {

                    entity = new MaintenanceHistory();
                    entity.PlanName = Convert.ToString(rdr["PlanName"]);
                    entity.EquimentCode = Convert.ToString(rdr["EquimentCode"]);
                    entity.OperateType = Convert.ToString(rdr["OperateType"]);
                    entity.OperateTime = Convert.ToString(rdr["OperateTime"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.SubRemark = Convert.ToString(rdr["SubRemark"]);
                    entity.DemoCode = Convert.ToString(rdr["DemoCode"]);
                    entity.DemoName = Convert.ToString(rdr["DemoName"]);
                    entity.DemoSubCode = Convert.ToString(rdr["DemoSubCode"]);
                    entity.DemoSubName = Convert.ToString(rdr["DemoSubName"]);
                    entity.Description = Convert.ToString(rdr["Description"]);
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