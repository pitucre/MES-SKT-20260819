using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentCheckOutHistory
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentCheckOutHistory 信息。
        /// </summary>
        /// <param name="entity">EquipmentCheckOutHistory 实体对象。</param>
        public Int32 Edit(EquipmentCheckOutHistoryInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentCheckOutPlanId", SqlDbType.Int),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@CertificateNo", SqlDbType.VarChar, 50),
                new SqlParameter("@CertificateFileName", SqlDbType.VarChar, 50),
                new SqlParameter("@Remark", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@InspectionTime", SqlDbType.DateTime),
                new SqlParameter("@InspectionUnit", SqlDbType.NVarChar, 200),
                
            };
            parms[0].Value = entity.EquipmentCheckOutPlanId;
            parms[1].Value = entity.Status;
            parms[2].Value = entity.CertificateNo;
            parms[3].Value = entity.CertificateFileName;
            parms[4].Value = entity.Remark;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.InspectionTime;
            parms[7].Value = entity.InspectionUnit;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Equipment_EquipmentCheckOutHistory_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 EquipmentCheckOutHistoryId 字符串删除 EquipmentCheckOutHistory 信息。
        /// </summary>
        /// <param name="idString">EquipmentCheckOutHistoryId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Equipment_EquipmentCheckOutHistory_Delete", parms);
        }

        /// <summary>
        /// 根据 EquipmentCheckOutHistoryId 获取实体信息。
        /// </summary>
        /// <param name="equipmentCheckOutHistoryId">EquipmentCheckOutHistoryId。</param>
        /// <returns>EquipmentCheckOutHistory 实体对象。</returns>
        public EquipmentCheckOutHistoryInfo GetInfo(Int32 equipmentCheckOutHistoryId)
        {
            EquipmentCheckOutHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = equipmentCheckOutHistoryId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Equipment_EquipmentCheckOutHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentCheckOutHistoryInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7));
                       entity.InspectionTime = Convert.ToDateTime(rdr["InspectionTime"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>EquipmentCheckOutHistory 实体对象。</returns>
        public EquipmentCheckOutHistoryInfo GetInfo(String fieldValue)
        {
            EquipmentCheckOutHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Equipment_EquipmentCheckOutHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentCheckOutHistoryInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7));
                    entity.InspectionTime = Convert.ToDateTime(rdr["InspectionTime"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EquipmentCheckOutHistory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="equipmentCheckOutHistoryCount">equipmentCheckOutHistory 总数。</param>
        /// <returns>EquipmentCheckOutHistory 列表。</returns>
        public List<EquipmentCheckOutHistoryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentCheckOutHistoryInfo> list = new List<EquipmentCheckOutHistoryInfo>();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwEquipmentCheckOutHistory", "EquipmentCheckOutHistory",
                "[EquipmentCheckOutHistory], [EqCode], [CheckTypeName],CheckProjectName,CycleTypeName,Cycle,LastTime,NextTime,StatusNmae, [CertificateNo], [CertificateFileName], [Remark], [CreateBy], [CreateTime],InspectionTime,ObjectTypeName,EquipmentTypeName,InspectionUnit", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    EquipmentCheckOutHistoryInfo entity = new EquipmentCheckOutHistoryInfo();
                    //entity.EqCode = rdr.GetInt32(0);
                    entity.EqCode = rdr.GetString(1);
                    entity.CheckTypeName = rdr.GetString(2);
                    entity.CheckProjectName = rdr.GetString(3);
                    entity.CycleTypeName = rdr.GetString(4);
                    entity.Cycle = rdr.GetInt32(5);
                    entity.LastTime = rdr.GetDateTime(6);
                    entity.NextTime = rdr.GetDateTime(7);
                    entity.StatusNmae = rdr.GetString(8);
                    entity.CertificateNo = rdr.GetString(9);
                    entity.CertificateFileName = rdr.GetString(10);
                    entity.Remark = rdr.GetString(11);
                    entity.CreateBy = rdr.GetString(12);
                    entity.CreateTime = rdr.GetDateTime(13);
                    entity.InspectionTime = Convert.ToDateTime(rdr["InspectionTime"]);
                    entity.ObjectTypeName = Convert.ToString(rdr["ObjectTypeName"]);
                    entity.EquimentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
                    entity.InspectionUnit = Convert.ToString(rdr["InspectionUnit"]);
                    
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        ///  EquipmentCheckOutHistory 资料。
        /// </summary>

        /// <returns>EquipmentCheckOutHistory 列表。</returns>
        public List<EquipmentCheckOutHistoryInfo> GetChildAll(string equimentCode)
        {
            List<EquipmentCheckOutHistoryInfo> list = new List<EquipmentCheckOutHistoryInfo>();

            SqlParameter[] parms = new SqlParameter[]{
               
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar,50)
            };

            parms[0].Value = equimentCode;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspEquToCheckOutHistory", parms))
            {
                while (rdr.Read())
                {
                    EquipmentCheckOutHistoryInfo entity = new EquipmentCheckOutHistoryInfo();
                    //entity.EqCode = rdr.GetInt32(0);
                    entity.EqCode = rdr.GetString(1);
                    entity.CheckTypeName = rdr.GetString(2);
                    entity.CheckProjectName = rdr.GetString(3);
                    entity.CycleTypeName = rdr.GetString(4);
                    entity.Cycle = rdr.GetInt32(5);
                    entity.LastTime = rdr.GetDateTime(6);
                    entity.NextTime = rdr.GetDateTime(7);
                    entity.StatusNmae = rdr.GetString(8);
                    entity.CertificateNo = rdr.GetString(9);
                    entity.CertificateFileName = rdr.GetString(10);
                    entity.Remark = rdr.GetString(11);
                    entity.CreateBy = rdr.GetString(12);
                    entity.CreateTime = rdr.GetDateTime(13);
                    entity.InspectionTime = Convert.ToDateTime(rdr["InspectionTime"]);
                    entity.ObjectTypeName = Convert.ToString(rdr["ObjectTypeName"]);
                    entity.EquimentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
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