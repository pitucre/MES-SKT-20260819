using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Jig.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Jig.BLL
{
    public class Jig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Jig 信息。
        /// </summary>
        /// <param name="entity">Jig 实体对象。</param>
        public Int32 Edit(JigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@JigId", SqlDbType.Int),
                new SqlParameter("@JigName", SqlDbType.NVarChar, 50),
                new SqlParameter("@JigNickName", SqlDbType.NVarChar, 50),
                new SqlParameter("@JigCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@JigType", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@VendorId", SqlDbType.Int),
                new SqlParameter("@Position", SqlDbType.NVarChar, 50),
                new SqlParameter("@StandarLive", SqlDbType.Int),
                new SqlParameter("@StandarMaint", SqlDbType.Int),
                //new SqlParameter("@UseCount", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@WarningTime", SqlDbType.Int)
            };

            parms[0].Value = entity.JigId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.JigName;
            parms[2].Value = entity.JigNickName;
            parms[3].Value = entity.JigCode;
            parms[4].Value = entity.JigType;
            parms[5].Value = entity.ItemId;
            parms[6].Value = entity.VendorId;
            parms[7].Value = entity.Position;
            parms[8].Value = entity.StandarLive;
            parms[9].Value = entity.StandarMaint;
            //parms[10].Value = entity.UseCount;
            parms[10].Value = entity.CreateBy;
            parms[11].Value = entity.ModifyBy;
            parms[12].Value = entity.Remark;
            parms[13].Value = entity.WarningTime;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Jig_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 JigId 字符串删除 Jig 信息。
        /// </summary>
        /// <param name="idString">JigId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Jig_Delete", parms);
        }

        /// <summary>
        /// 根据 JigId 获取实体信息。
        /// </summary>
        /// <param name="jigId">JigId。</param>
        /// <returns>Jig 实体对象。</returns>
        public JigInfo GetInfo(Int32 jigId)
        {
            JigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = jigId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Jig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new JigInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2),rdr.GetString(3), rdr.GetInt32(4), rdr.GetInt32(5), 
                        rdr.GetInt32(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetInt32(10), 
                        rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetDateTime(14), rdr.GetString(15));

                    entity.CurPosition = rdr.GetValue(16).ToString();
                    entity.JigStatus = rdr.GetInt32(17);
                    entity.InOrOut = rdr.GetInt32(18);
                    entity.WarningTime = rdr.GetInt32(19);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Jig 实体对象。</returns>
        public JigInfo GetInfo(String fieldValue)
        {
            JigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit) 
            };

            parms[0].Value = fieldValue;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Jig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new JigInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), rdr.GetInt32(5),
                        rdr.GetInt32(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetInt32(10),
                        rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetDateTime(14), rdr.GetString(15));

                    entity.CurPosition = rdr.GetValue(16).ToString();
                    entity.JigStatus = rdr.GetInt32(17);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Jig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="jigCount">jig 总数。</param>
        /// <returns>Jig 列表。</returns>
        public List<JigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<JigInfo> list = new List<JigInfo>();
            JigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetJigList", "JigId",
                "JigId,JigName,JigNickName,JigCode,JigType, ItemId,VendorId,Position,StandarLive,StandarMaint,UseCount,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,Remark,ItemCode,ItemName,VendorCode,VendorName,TypeName, CurPosition, JigStatus",
                searchSettings, 
                sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new JigInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), rdr.GetInt32(5),
                        rdr.GetInt32(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetInt32(10),
                        rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetDateTime(14), rdr.GetString(15));
                    entity.ItemCode = rdr.GetString(16);
                    entity.ItemName = rdr.GetString(17);
                    entity.VendorCode = rdr.GetString(18);
                    entity.VendorName = rdr.GetString(19);
                    entity.TypeName = rdr.GetString(20);
                    entity.CurPosition = rdr.GetValue(21).ToString();
                    entity.JigStatus = rdr.GetInt32(22);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 工装夹具列表导出EXCEL获取数据的方法
        /// </summary>
        /// <param name="strWhere">查询条件</param>
        /// <returns></returns>
        public DataTable ImportToExcel(String JigName, String JigNickName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@jigName", SqlDbType.NVarChar,50),
                new SqlParameter("@jigNickName", SqlDbType.NVarChar,50)
            };
            parms[0].Value = JigName;
            parms[1].Value = JigNickName;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Basal_JigImportToExcel", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        /// <summary>
        /// 夹具报废
        /// </summary>
        /// <returns>日志内容。</returns>
        public void Scrap(String jigId, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@JigId", SqlDbType.VarChar, 300),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = jigId;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspScrapJig", parms);
        }

    }
}