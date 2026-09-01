using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Kanban.Model;
using SKT.LeanMES.Kanban.BLL;

namespace SKT.LeanMES.Kanban.BLL
{
   public class EquipmentStatus
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Equipment 信息。
        /// </summary>
        /// <param name="entity">Equipment 实体对象。</param>
        public Int32 Edit(EquipmentStatusInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentId", SqlDbType.Int),
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar, 20),
                new SqlParameter("@EquipmentName", SqlDbType.NVarChar, 50),
                new SqlParameter("@EquipmentTypeId", SqlDbType.Int),
                new SqlParameter("@EquipmentModel", SqlDbType.NVarChar, 20),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.EquipmentId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.EquipmentCode;
            parms[2].Value = entity.EquipmentName;
            parms[3].Value = entity.EquipmentTypeId;
            parms[4].Value = entity.EquipmentModel; 
            parms[6].Value = entity.Status;
            parms[7].Value = entity.LineId;
            parms[8].Value = entity.StationId; 
            parms[10].Value = entity.CreateBy;
            parms[11].Value = entity.ModifyBy;
            parms[12].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Equipment_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 EquipmentId 字符串删除 Equipment 信息。
        /// </summary>
        /// <param name="idString">EquipmentId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Equipment_Delete", parms);
        } 
        /// <summary>
        /// 获取车间的值绑定到ddl下拉框
        /// </summary>
        /// <param name="fieldValue"></param>
        /// <returns></returns>
        public List<EquipmentStatusInfo> GetDDLInfo()
        {
            List<EquipmentStatusInfo> list = new List<EquipmentStatusInfo>();
            EquipmentStatusInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialEquipKanban_DDL_List"))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentStatusInfo();
                    entity.LineId = rdr.GetInt32(0);
                    entity.LineName = rdr.GetString(1);
                    list.Add(entity);
                }
                
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据车间的值获取此车间中的设备的状态，名称
        /// </summary>
        /// <param name="fieldValue"></param>
        /// <returns></returns>
        public  List<EquipmentStatusInfo>  GetEquipInfo(string fieldValue)
        {
            List<EquipmentStatusInfo> list = new List<EquipmentStatusInfo>();
            EquipmentStatusInfo entity =null;
            SqlParameter[] parms = new SqlParameter[]{
             new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
            };
            parms[0].Value = fieldValue;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialEquipKanban_List", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentStatusInfo();
                    entity.EquipmentName = rdr.GetString(0);
                    entity.Status = rdr.GetInt32(1);
                    list.Add(entity);
                } 
                rdr.Close();
            }
            return list;
        } 
        public List<EquipmentStatusInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentStatusInfo> list = new List<EquipmentStatusInfo>();
            EquipmentStatusInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "vwEquipmentList", "EquipmentId", "[EquipmentId],[EquipmentCode],[EquipmentName] ,[EquipmentTypeName],[EquipmentModel]"
                + ",[Status],[LineName] ,[Station],[CreateBy] ,[CreateDateTime] ,[ModifyBy] ,[ModifyDateTime] ,[Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentStatusInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                         rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), 
                        rdr.GetString(8), rdr.GetDateTime(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));

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
