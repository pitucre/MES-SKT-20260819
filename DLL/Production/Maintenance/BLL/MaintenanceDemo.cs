using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Maintenance.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Maintenance.BLL
{
    public class MaintenanceDemo
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaintenanceDemo 信息。
        /// </summary>
        /// <param name="entity">MaintenanceDemo 实体对象。</param>
        /// <param name="xmlStr">保养项详细信息</param>
        public Int32 Edit(MaintenanceDemoInfo entity,string xmlStr)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DemoId", SqlDbType.Int),
                new SqlParameter("@DemoCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@DemoName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Description", SqlDbType.NVarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@XmlDoc", SqlDbType.NVarChar)
            };

            parms[0].Value = entity.DemoId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.DemoCode;
            parms[2].Value = entity.DemoName;
            parms[3].Value = entity.Description;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Remark;
            parms[7].Value = xmlStr;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceDemo_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MaintenanceDemoId 字符串删除 MaintenanceDemo 信息。
        /// </summary>
        /// <param name="idString">MaintenanceDemoId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceDemo_Delete", parms);
        }

        /// <summary>
        /// 根据 MaintenanceDemoId 获取实体信息。
        /// </summary>
        /// <param name="maintenanceDemoId">MaintenanceDemoId。</param>
        /// <returns>MaintenanceDemo 实体对象。</returns>
        public MaintenanceDemoInfo GetInfo(Int32 maintenanceDemoId)
        {
            MaintenanceDemoInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = maintenanceDemoId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceDemo_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaintenanceDemoInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaintenanceDemo 实体对象。</returns>
        public MaintenanceDemoInfo GetInfo(String fieldValue)
        {
            MaintenanceDemoInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaintenanceDemo_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaintenanceDemoInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MaintenanceDemo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="maintenanceDemoCount">maintenanceDemo 总数。</param>
        /// <returns>MaintenanceDemo 列表。</returns>
        public List<MaintenanceDemoInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaintenanceDemoInfo> list = new List<MaintenanceDemoInfo>();
            MaintenanceDemoInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_MaintenanceDemo", "DemoId",
                "[DemoId], [DemoCode], [DemoName], [Description], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaintenanceDemoInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
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