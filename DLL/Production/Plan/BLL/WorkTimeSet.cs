using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Plan.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Plan.BLL
{
    public class WorkTimeSet
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新 信息。
        /// </summary>
        /// <param name="entity"> 实体对象。</param>
        public Int32 Edit(WorkTimeSetInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WtId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ResourceId", SqlDbType.Int,4),
                new SqlParameter("@SetDate", SqlDbType.DateTime),
                new SqlParameter("@Name", SqlDbType.VarChar, 50),
                new SqlParameter("@Times", SqlDbType.Int, 4),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
           
            };

            parms[0].Value = entity.WtId;
            parms[1].Value = entity.LineId;
            parms[2].Value = entity.ResourceId;
            parms[3].Value = entity.SetDate;
            parms[4].Value = entity.Name;
            parms[5].Value = entity.Times;
            parms[6].Value = entity.CreateBy;
         
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_WorkTimeSet_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据  字符串删除 Plan 信息。
        /// </summary>
        /// <param name="idString">PlanId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_WorkTimeSet_Delete", parms);
        }


        /// <summary>
        /// 根据 lctId 获取实体信息。
        /// </summary>
        /// <param name="lctId">lctId。</param>
        /// <returns> 实体对象。</returns>
        public WorkTimeSetInfo GetInfo(Int32 lctId)
        {
            WorkTimeSetInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = lctId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_WorkTimeSet_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WorkTimeSetInfo();
                    entity.WtId = Convert.ToInt32(rdr["WtId"]);
                    entity.LineId = Convert.ToInt32(rdr["LineId"]);
                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                    entity.SetDate = Convert.ToString(rdr["SetDate"]);
                    entity.Name = Convert.ToString(rdr["Name"]);
                    entity.Times = Convert.ToInt32(rdr["Times"]);

                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.LineName = Convert.ToString(rdr["LineName"]);
                    entity.ResName = Convert.ToString(rdr["ResName"]);
                  

                }
                rdr.Close();
            }

            return entity;
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
        public List<WorkTimeSetInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WorkTimeSetInfo> list = new List<WorkTimeSetInfo>();
            WorkTimeSetInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vWWorkTimeSetList", "WtId",
                @"WtId ,
                    LineId ,
                    ResourceId ,
                    Name,
                    SetDate,
                    Times ,
                    CreateBy ,
                    CreateTime ,
                    LineName ,
                    ResName 
                   ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WorkTimeSetInfo();
                    entity.WtId = Convert.ToInt32(rdr["WtId"]);
                    entity.LineId = Convert.ToInt32(rdr["LineId"]);
                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                    entity.SetDate = Convert.ToString(rdr["SetDate"]);
                    entity.Name = Convert.ToString(rdr["Name"]);
                    entity.Times = Convert.ToInt32(rdr["Times"]);

                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.LineName = Convert.ToString(rdr["LineName"]);
                    entity.ResName = Convert.ToString(rdr["ResName"]);



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