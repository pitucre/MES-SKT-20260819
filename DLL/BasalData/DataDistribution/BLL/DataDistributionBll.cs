using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.DataDistribution.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.DataDistribution.BLL
{
    public class DataDistributionBll
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） WorkShop 信息。
        /// </summary>
        /// <param name="entity">WorkShop 实体对象。</param>
        public Int32 Edit(DataDistributionInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@ID", SqlDbType.Int),
                    new SqlParameter("@TableDisPlayName", SqlDbType.VarChar, 50),
                    new SqlParameter("@TableName", SqlDbType.VarChar, 50),
                    new SqlParameter("@TableDescription", SqlDbType.VarChar, 50),
                    new SqlParameter("@IsCondition", SqlDbType.Bit),
                    new SqlParameter("@ConditionStr", SqlDbType.VarChar,300),
                    new SqlParameter("@AddPerson", SqlDbType.VarChar, 50),
                    new SqlParameter("@AddPersonName", SqlDbType.VarChar, 50),
                    new SqlParameter("@UpdatePerson", SqlDbType.VarChar, 50),
                    new SqlParameter("@UpdatePersonName", SqlDbType.VarChar,50)
                };
            parms[0].Value = entity.ID;
            parms[1].Value = entity.TableDisPlayName;
            parms[2].Value = entity.TableName;
            parms[3].Value = entity.TableDescription;
            parms[4].Value = entity.IsCondition;
            parms[5].Value = entity.ConditionStr;
            parms[6].Value = entity.AddPerson;
            parms[7].Value = entity.AddPersonName;
            parms[8].Value = entity.UpdatePerson;
            parms[9].Value = entity.UpdatePersonName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "DataDistributionList_Edit", parms);
            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 WorkShopId 字符串删除 WorkShop 信息。
        /// </summary>
        /// <param name="idString">WorkShopId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                    new SqlParameter("@UserName", SqlDbType.VarChar, 20)
                };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "DataDistributionList_Delete", parms);
        }

        /// <summary>
        /// 根据 WorkShopId 获取实体信息。
        /// </summary>
        /// <param name="workShopId">WorkShopId。</param>
        /// <returns>WorkShop 实体对象。</returns>
        public DataDistributionInfo GetInfo(Int32 ID)
        {
            DataDistributionInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                    new SqlParameter("@IsByID", SqlDbType.Bit)
                };

            parms[0].Value = ID;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "DataDistributionList_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DataDistributionInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetBoolean(4), rdr.GetString(5), rdr.GetString(6), rdr.GetString(7),
                      rdr.GetDateTime(8), rdr.GetString(9), rdr.GetString(10), rdr.GetDateTime(11));
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>WorkShop 实体对象。</returns>
        public DataDistributionInfo GetInfo(String fieldValue)
        {
            DataDistributionInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                    new SqlParameter("@IsByID", SqlDbType.Bit)
                };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "DataDistributionList_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DataDistributionInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetBoolean(4), rdr.GetString(5), rdr.GetString(6), rdr.GetString(7),
                       rdr.GetDateTime(8), rdr.GetString(9), rdr.GetString(10), rdr.GetDateTime(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 DataDistributionList 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="workShopCount">workShop 总数。</param>
        /// <returns>WorkShop 列表。</returns>
        public List<DataDistributionInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DataDistributionInfo> list = new List<DataDistributionInfo>();
            DataDistributionInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwDataDistributionList", "ID",
                "[ID],[TableDisPlayName], [TableName], [TableDescription], [IsCondition], [ConditionStr], [AddPerson], [AddPersonName], [AddTime], [UpdatePerson],[UpdatePersonName],UpdateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new DataDistributionInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetBoolean(4), rdr.GetString(5), rdr.GetString(6), rdr.GetString(7),
                       rdr.GetDateTime(8), rdr.GetString(9), rdr.GetString(10), rdr.GetDateTime(11));
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
