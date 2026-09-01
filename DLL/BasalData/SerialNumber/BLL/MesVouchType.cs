using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SerialNumber.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SerialNumber.BLL
{
    public class MesVouchType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MesVouchType 信息。
        /// </summary>
        /// <param name="entity">MesVouchType 实体对象。</param>
        public void  Edit(MesVouchTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MesVouchTypeId", SqlDbType.Int),
                new SqlParameter("@PageName", SqlDbType.VarChar, 50),
                new SqlParameter("@VouchName", SqlDbType.NVarChar, 20),
                new SqlParameter("@VouchENName", SqlDbType.VarChar, 100),
                new SqlParameter("@MTableName", SqlDbType.NVarChar, 40),
                new SqlParameter("@CTableName", SqlDbType.NVarChar, 40),
                new SqlParameter("@EncodeRule", SqlDbType.Int),
                new SqlParameter("@RuleName", SqlDbType.Int),
                new SqlParameter("@PackRule", SqlDbType.Int),
                new SqlParameter("@CreatePerson", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyPerson", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 60)
            };

            parms[0].Value = entity.MesVouchTypeId;
            parms[1].Value = entity.PageName;
            parms[2].Value = entity.VouchName;
            parms[3].Value = entity.VouchENName;
            parms[4].Value = entity.MTableName;
            parms[5].Value = entity.CTableName;
            parms[6].Value = entity.EncodeRule;
            parms[7].Value = entity.RuleName;
            parms[8].Value = entity.PackRule;
            parms[9].Value = entity.CreateBy ;
            parms[10].Value = entity.ModifyBy ;
            parms[11].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_MesVouchType_Edit", parms);
        }

        /// <summary>
        /// 根据 MesVouchTypeId 字符串删除 MesVouchType 信息。
        /// </summary>
        /// <param name="idString">MesVouchTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_MesVouchType_Delete", parms);
        }

        /// <summary>
        /// 根据 MesVouchTypeId 获取实体信息。
        /// </summary>
        /// <param name="mesVouchTypeId">MesVouchTypeId。</param>
        /// <returns>MesVouchType 实体对象。</returns>
        public MesVouchTypeInfo GetInfo(Int32 mesVouchTypeId)
        {
            MesVouchTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = mesVouchTypeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MesVouchType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MesVouchTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13));
                    entity.EncodeStr = rdr.GetString(14);
                    entity.RuleStr = rdr.GetString(15);
                    entity.PackRuleStr = rdr.GetString(16);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MesVouchType 实体对象。</returns>
        public MesVouchTypeInfo GetInfo(String fieldValue)
        {
            MesVouchTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MesVouchType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MesVouchTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13));
                    entity.EncodeStr = rdr.GetString(14);
                    entity.RuleStr = rdr.GetString(15);
                    entity.PackRuleStr = rdr.GetString(16);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MesVouchType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mesVouchTypeCount">mesVouchType 总数。</param>
        /// <returns>MesVouchType 列表。</returns>
        public List<MesVouchTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MesVouchTypeInfo> list = new List<MesVouchTypeInfo>();
            MesVouchTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_MesVouchType", "MesVouchTypeId",
                "[MesVouchTypeId],[VouchName],[Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MesVouchTypeInfo();
                    entity.MesVouchTypeId = rdr.GetInt32(0);
                    entity.VouchName = rdr.GetString(1);
                    entity.Remark = rdr.GetString(2);

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