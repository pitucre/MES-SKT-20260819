using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using SKT.LeanMES.Plan.Model;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Plan.BLL
{
    public class ScheduleRecord
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） StandardLaborTime 信息。
        /// </summary>
        /// <param name="entity">StandardLaborTime 实体对象。</param>
        public Int32 Edit(ScheduleRecordInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ShiftId", SqlDbType.Int),
                new SqlParameter("@StartTime", SqlDbType.DateTime),
                new SqlParameter("@EndTime", SqlDbType.DateTime),
                new SqlParameter("@AllDay", SqlDbType.Bit),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@IsSaturd", SqlDbType.Int),
                new SqlParameter("@IsSunday", SqlDbType.Int),
                new SqlParameter("@ResourceId", SqlDbType.Int),
                
            };

            parms[0].Value = entity.Id;
            parms[1].Value = entity.LineId;
            parms[2].Value = entity.ShiftId;
            parms[3].Value = entity.StartTime;
            parms[4].Value = entity.EndTime;
            parms[5].Value = entity.AllDay;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.IsSaturd;
            parms[8].Value = entity.IsSunday;
            parms[9].Value = entity.ResourceId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "usp_SchduleRecord_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 复制资源日历班制
        /// </summary>
        /// <param name="resourceCopyId">被复制资源ID</param>
        /// <param name="resourceId">资源ID</param>
        /// <param name="startTime">开始时间</param>
        /// <param name="endtime">结束时间</param>
        public void ScheduleRecordCopy(int resourceCopyId,int resourceId,string startTime,string endtime)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ResourceCopyId", SqlDbType.Int),
                new SqlParameter("@ResourceId", SqlDbType.Int),
                new SqlParameter("@StartTime", SqlDbType.DateTime),
                new SqlParameter("@EndTime", SqlDbType.DateTime)
            
            };

            parms[0].Value = resourceCopyId;
            parms[1].Value = resourceId;
            parms[2].Value = startTime;
            parms[3].Value = endtime;
         
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ScheduleRecordCopy", parms);
                     
        }



        /// <summary>
        /// 复制角色权限
        /// </summary>
        /// <param name="copyId">被复制角色ID</param>
        /// <param name="id">角色ID</param>
        /// <param name="ceateBy">操作人</param>

        public void RolePopedomCopy(int copyId, int id,string ceateBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CopyId", SqlDbType.Int),
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar),

            };

            parms[0].Value = copyId;
            parms[1].Value = id;
            parms[2].Value = ceateBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspRolePopedomCopy", parms);

        }


        /// <summary>
        /// 根据 StandardLaborTimeId 字符串删除 StandardLaborTime 信息。
        /// </summary>
        /// <param name="idString">StandardLaborTimeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Plan_ScheduleRecord_Delete", parms);
        }

        /// <summary>
        /// 根据 StandardLaborTimeId 获取实体信息。
        /// </summary>
        /// <param name="standardLaborTimeId">StandardLaborTimeId。</param>
        /// <returns>StandardLaborTime 实体对象。</returns>
        public ScheduleRecordInfo GetInfo(Int32 id)
        {
            ScheduleRecordInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = id;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ScheduleRecord_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new ScheduleRecordInfo();
                    entity.Id = Convert.ToInt32(rdr["Id"]);
                    entity.StartTime = Convert.ToDateTime(rdr["StartTime"]);
                    entity.EndTime = Convert.ToDateTime(rdr["EndTime"]);
                    entity.AllDay = Convert.ToBoolean(rdr["AllDay"]);
                    entity.Color = Convert.ToString(rdr["Color"]);
                    entity.LineId = Convert.ToInt32(rdr["LineId"]);
                    entity.ShiftId = Convert.ToInt32(rdr["ShiftId"]);
                    entity.ShiftName = Convert.ToString(rdr["ShiftName"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);

                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>StandardLaborTime 实体对象。</returns>
        public StandardLaborTimeInfo GetInfo(String fieldValue)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<StandardLaborTimeInfo>(fieldValue, "Prod_StandardLaborTime_GetInfo");
        }


        /// <summary>
        /// 分页获取 Plan 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="planCount">plan 总数。</param>
        /// <returns>Plan 列表。</returns>
        public List<ScheduleRecordInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ScheduleRecordInfo> list = new List<ScheduleRecordInfo>();
            ScheduleRecordInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetScheduleRecordList", "Id",
                "Id ,StartTime,EndTime,AllDay,Color,LineId,ShiftId,ShiftName,CreateTime,CreateBy,ResourceId", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ScheduleRecordInfo();
                    entity.Id = Convert.ToInt32(rdr["Id"]);
                    entity.StartTime = Convert.ToDateTime(rdr["StartTime"]);
                    entity.EndTime = Convert.ToDateTime(rdr["EndTime"]);
                    entity.AllDay = Convert.ToBoolean(rdr["AllDay"]);
                    entity.Color = Convert.ToString(rdr["Color"]);
                    entity.LineId = Convert.ToInt32(rdr["LineId"]);
                    entity.ShiftId = Convert.ToInt32(rdr["ShiftId"]);
                    entity.ShiftName = Convert.ToString(rdr["ShiftName"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
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
