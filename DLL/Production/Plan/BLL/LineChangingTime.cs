using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Plan.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Plan.BLL
{
    public class LineChangingTime
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新 信息。
        /// </summary>
        /// <param name="entity"> 实体对象。</param>
        public Int32 Edit(LineChangingTimeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LctId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ResourceId", SqlDbType.Int,4),
                new SqlParameter("@ItemIdOne", SqlDbType.Int, 4),
                new SqlParameter("@ItemIdTwo", SqlDbType.Int, 4),
                new SqlParameter("@LineChangingTime", SqlDbType.Decimal, 10),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
               new SqlParameter("@Remark", SqlDbType.VarChar, 200)
            };

            parms[0].Value = entity.LctId;
            parms[1].Value = entity.LineId;
            parms[2].Value = entity.ResourceId;
            parms[3].Value = entity.ItemOneId;
            parms[4].Value = entity.ItemTwoId;
            parms[5].Value = entity.LineChangingTime;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.Remark;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_LineChangingTime_Edit", parms);

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

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_LineChangingTime_Delete", parms);
        }


        /// <summary>
        /// 根据 lctId 获取实体信息。
        /// </summary>
        /// <param name="lctId">lctId。</param>
        /// <returns> 实体对象。</returns>
        public LineChangingTimeInfo GetInfo(Int32 lctId)
        {
            LineChangingTimeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = lctId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_LineChangingTime_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LineChangingTimeInfo();
                    entity.LctId = Convert.ToInt32(rdr["LctId"]);
                    entity.LineId = Convert.ToInt32(rdr["LineId"]);
                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                    entity.ItemOneId = Convert.ToInt32(rdr["ItemOneId"]);
                    entity.ItemTwoId = Convert.ToInt32(rdr["ItemTwoId"]);
                    entity.LineChangingTime = Convert.ToString(rdr["LineChangingTime"]);

                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.LineName = Convert.ToString(rdr["LineName"]);
                    entity.ResName = Convert.ToString(rdr["ResName"]);
                    entity.ItemOneCode = Convert.ToString(rdr["ItemOneCode"]);
                    entity.ItemTwoCode = Convert.ToString(rdr["ItemTwoCode"]);
                    entity.Remark= Convert.ToString(rdr["Remark"]);
                    
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
        public List<LineChangingTimeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LineChangingTimeInfo> list = new List<LineChangingTimeInfo>();
            LineChangingTimeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vWLineChangingTimeList", "LctId",
                @"[LctId], [LineId], [ResourceId], [ItemOneId], [ItemTwoId], LineChangingTime ,
                    CreateBy,
                    CreateTime,
                    LineName,
                    ResName,
                    ItemOneCode,
                    ItemTwoCode,Remark", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LineChangingTimeInfo();
                    entity.LctId = Convert.ToInt32(rdr["LctId"]);
                    entity.LineId = Convert.ToInt32(rdr["LineId"]);
                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                    entity.ItemOneId = Convert.ToInt32(rdr["ItemOneId"]);
                    entity.ItemTwoId = Convert.ToInt32(rdr["ItemTwoId"]);
                    entity.LineChangingTime = Convert.ToString(rdr["LineChangingTime"]);

                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.LineName = Convert.ToString(rdr["LineName"]);
                    entity.ResName = Convert.ToString(rdr["ResName"]);
                    entity.ItemOneCode = Convert.ToString(rdr["ItemOneCode"]);
                    entity.ItemTwoCode = Convert.ToString(rdr["ItemTwoCode"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
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