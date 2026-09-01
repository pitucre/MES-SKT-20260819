using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.ProductChange.Model;
namespace SKT.LeanMES.ProductChange.BLL
{
    public class SNScrapDelete
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 条码恢复
        /// </summary>
        /// <param name="entity"></param>
        public void SNRestore(SNScrapDeleteInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN_Value", SqlDbType.NVarChar,50),
                new SqlParameter("@Remark", SqlDbType.NVarChar,50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.SNVALUE;
            parms[1].Value = entity.REMARK;
            parms[2].Value = entity.CreateBy;
            parms[3].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSNRestore", parms);

        }

        /// <summary>
        /// 条码报废
        /// </summary>
        /// <param name="entity"></param>
        public void SNScrap(SNScrapDeleteInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN_Value", SqlDbType.NVarChar),
                new SqlParameter("@Remark", SqlDbType.NVarChar,50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.SNVALUE;
            parms[1].Value = entity.REMARK;
            parms[2].Value = entity.CreateBy;
            parms[3].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSNScrap", parms);

        }

        /// <summary>
        /// 条码删除
        /// </summary>
        /// <param name="entity"></param>
        public void SNDelete(SNScrapDeleteInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN_Value", SqlDbType.NVarChar),
                new SqlParameter("@Remark", SqlDbType.NVarChar,50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.SNVALUE;
            parms[1].Value = entity.REMARK;
            parms[2].Value = entity.CreateBy;
            parms[3].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSNDelete", parms);

        }


        /// <summary>
        /// 编辑（添加或更新） SNScrapDelete 信息。
        /// </summary>
        /// <param name="entity">SNScrapDelete 实体对象。</param>
        public Int32 Edit(SNScrapDeleteInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SNID", SqlDbType.Int),
                new SqlParameter("@SN_TypeID", SqlDbType.Int),
                new SqlParameter("@SN_Value", SqlDbType.NVarChar,50),
                new SqlParameter("@SN_Status", SqlDbType.Char,1),
                new SqlParameter("@Remark", SqlDbType.NVarChar,50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.SNID;
            parms[1].Value = entity.SNTYPEID;
            parms[2].Value = entity.SNVALUE;
            parms[3].Value = entity.SNSTATUS;
            parms[4].Value = entity.REMARK;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "PRODUCTION_SNScrapDelete_Edit", parms);

            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 根据 SNId 字符串删除 SNScrapDelete 信息。
        /// </summary>
        /// <param name="idString">SNScrapDeleteId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(Int32 id, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SNId", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = id;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "PRODUCTION_SNScrapDelete_Delete", parms);
        }

        /// <summary>
        /// 根据 SNScrapDeleteId 获取实体信息。
        /// </summary>
        /// <param name="SNScrapDeleteId">SNScrapDeleteId。</param>
        /// <returns>SNScrapDelete 实体对象。</returns>
        public SNScrapDeleteInfo GetInfo(Int32 soId)
        {
            SNScrapDeleteInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SNScrapDeleteId", SqlDbType.Int)
            };

            parms[0].Value = soId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "PRODUCTION_SNScrapDelete_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SNScrapDeleteInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3),
                        rdr.GetString(4), rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8));

                    entity.SNID = rdr.GetInt32(0);
                    entity.SNTYPEID = rdr.GetInt32(1);
                    entity.SNSTATUS = rdr.GetString(2);
                    entity.SNVALUE = rdr.GetString(3);

                }
                rdr.Close();
            }

            return entity;
        }


        /// <summary>
        /// 分页获取 SNScrapDelete 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="SNScrapDeleteCount">SNScrapDelete 总数。</param>
        /// <returns>SNScrapDelete 列表。</returns>
        public List<SNScrapDeleteInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SNScrapDeleteInfo> list = new List<SNScrapDeleteInfo>();
            SNScrapDeleteInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SN_SCRAPDELETE", "SNID",
                "SNI,SN_TypeID,SN_Value,SN_Satus,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,Remark", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SNScrapDeleteInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3),
                        rdr.GetString(4), rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8));

                    entity.SNID = rdr.GetInt32(0);
                    entity.SNTYPEID = rdr.GetInt32(1);
                    entity.SNVALUE = rdr.GetString(2);
                    entity.SNSTATUS = rdr.GetString(3);
                    entity.CreateBy = rdr.GetString(4);
                    entity.ModifyBy = rdr.GetString(5);
                    entity.REMARK = rdr.GetString(6);

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

        public List<SNScrapDeleteInfo> GetOrderSnList(string orderSn) 
        {
            List<SNScrapDeleteInfo> list = new List<SNScrapDeleteInfo>();
            SNScrapDeleteInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNo", SqlDbType.VarChar, 50)
            };
            parms[0].Value = orderSn;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetOrderSnList", parms))
            {
                while (rdr.Read())
                {
                    entity = new SNScrapDeleteInfo();
                    entity.SNVALUE = rdr.GetString(0);
                    entity.UnitId = rdr.GetInt64(1);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        
        /// <summary>
        /// 将数据插入临时表
        /// </summary>
        /// <param name="batchId">导入的批次号</param>
        /// <param name="val">导入的内容，用逗号隔开</param>
        /// <param name="type">导入内容的数据类型：0：int 1:varchar</param>
        /// <param name="userId"></param>
        public void AddBatchTmp(string batchId,string val,int type,int userId) {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@BatchId", SqlDbType.VarChar,40),
                new SqlParameter("@Val", SqlDbType.VarChar),
                new SqlParameter("@Type", SqlDbType.Int),
                new SqlParameter("@UserId", SqlDbType.Int),
            };

            parms[0].Value = batchId;
            parms[1].Value = val;
            parms[2].Value = type;
            parms[3].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspBatchTmpEdit", parms);
        }

    }
}
