using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.ProdAnormal.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.ProdAnormal.BLL
{
    public class AnormalConfig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） AnormalSolution 信息。
        /// </summary>
        /// <param name="entity">AnormalSolution 实体对象。</param>
        public Int32 Edit(AnormalConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AnormalConfigID", SqlDbType.Int),
                new SqlParameter("@AnormalTypeId", SqlDbType.Int),
                new SqlParameter("@Receiver", SqlDbType.NVarChar),
                new SqlParameter("@ReceiverName", SqlDbType.NVarChar),
                new SqlParameter("@SendWay", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar,50)
            };
            parms[0].Value = entity.AnormalConfigID;
            parms[1].Value = entity.AnormalTypeId;
            parms[2].Value = entity.Receiver;
            parms[3].Value = entity.ReceiverName;
            parms[4].Value = entity.SendWay;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AnormalConfig_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 AnormalSolutionId 字符串删除 AnormalSolution 信息。
        /// </summary>
        /// <param name="idString">AnormalSolutionId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AnormalConfig_Delete", parms);
        }

        public AnormalConfigInfo GetInfo(Int32 ID)
        {
            AnormalConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = ID;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AnormalConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AnormalConfigInfo();
                    entity.AnormalConfigID = Convert.ToInt32(rdr["AnormalConfigID"]);
                    entity.AnormalTypeId = Convert.ToInt32(rdr["AnormalTypeId"]);
                    entity.Receiver = Convert.ToString(rdr["Receiver"]);
                    entity.ReceiverName = Convert.ToString(rdr["ReceiverName"]);
                    entity.SendWay = Convert.ToInt32(rdr["SendWay"]);
                    entity.CreateDateTime = ComMethod.FromDatabase<DateTime?>(rdr["CreateDateTime"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.ModifyDateTime = ComMethod.FromDatabase<DateTime?>(rdr["ModifyDateTime"]);
                    entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                    entity.AnormalTypeName = Convert.ToString(rdr["AnormalTypeName"]);
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AnormalSolution 实体对象。</returns>
        public AnormalConfigInfo GetInfo(String fieldValue)
        {
            AnormalConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AnormalConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AnormalConfigInfo();
                    entity.AnormalConfigID = Convert.ToInt32(rdr["AnormalConfigID"]);
                    entity.AnormalTypeId = Convert.ToInt32(rdr["AnormalTypeId"]);
                    entity.Receiver = Convert.ToString(rdr["Receiver"]);
                    entity.ReceiverName = Convert.ToString(rdr["ReceiverName"]);
                    entity.SendWay = Convert.ToInt32(rdr["SendWay"]);
                    entity.CreateDateTime = ComMethod.FromDatabase<DateTime?>(rdr["CreateDateTime"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.ModifyDateTime = ComMethod.FromDatabase<DateTime?>(rdr["ModifyDateTime"]);
                    entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                    entity.AnormalTypeName = Convert.ToString(rdr["AnormalTypeName"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 AnormalSolution 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="anormalSolutionCount">anormalSolution 总数。</param>
        /// <returns>AnormalSolution 列表。</returns>
        public List<AnormalConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AnormalConfigInfo> list = new List<AnormalConfigInfo>();
            AnormalConfigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vw_AnormalConfig", "AnormalConfigID",
                "[AnormalConfigID], [AnormalTypeId], [Receiver], [ReceiverName], [SendWay],[CreateDateTime], [CreateBy], [ModifyDateTime], [ModifyBy],[AnormalTypeName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AnormalConfigInfo();
                    entity.AnormalConfigID = Convert.ToInt32(rdr["AnormalConfigID"]);
                    entity.AnormalTypeId = Convert.ToInt32(rdr["AnormalTypeId"]);
                    entity.Receiver = Convert.ToString(rdr["Receiver"]);
                    entity.ReceiverName = Convert.ToString(rdr["ReceiverName"]);
                    entity.SendWay = Convert.ToInt32(rdr["SendWay"]);
                    entity.CreateDateTime = ComMethod.FromDatabase<DateTime?>(rdr["CreateDateTime"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.ModifyDateTime = ComMethod.FromDatabase<DateTime?>(rdr["ModifyDateTime"]);
                    entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                    entity.AnormalTypeName = Convert.ToString(rdr["AnormalTypeName"]);
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
