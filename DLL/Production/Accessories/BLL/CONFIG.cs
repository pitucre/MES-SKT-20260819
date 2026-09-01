using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Accessories.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Accessories.BLL
{
    public class CONFIG
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） CONFIG 信息。
        /// </summary>
        /// <param name="entity">CONFIG 实体对象。</param>
        public void Edit(CONFIGInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@SOLD_TYPE", SqlDbType.Int),
                new SqlParameter("@MINTHAW", SqlDbType.Int),
                new SqlParameter("@MAXVOID", SqlDbType.Int),
                new SqlParameter("@MAXUSE", SqlDbType.Int)
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.SOLD_TYPE;
            parms[2].Value = entity.MINTHAW;
            parms[3].Value = entity.MAXVOID;
            parms[4].Value = entity.MAXUSE;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SOLDER_CONFIGEdit", parms);

            // return (Int32)parms[0].Value;
        }
        /// <summary>
        /// 设置时间
        /// </summary>
        /// <param name="selType">辅料类型</param>
        /// <param name="minThaw">至少解冻时间</param>
        /// <param name="maxVoID">解冻后最长闲置时间</param>
        /// <param name="maxUse">最长使用时间</param>
        public void AccessoriesAddSetTime(int soloType, int minThaw, int maxVoID, int maxUse)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@soloType", SqlDbType.Int),
                new SqlParameter("@minThaw", SqlDbType.Int),
                new SqlParameter("@maxVoID", SqlDbType.Int),
                new SqlParameter("@maxUse", SqlDbType.Int),
            };

            parms[0].Value = soloType;
            parms[1].Value = minThaw;
            parms[2].Value = maxVoID;
            parms[3].Value = maxUse;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAddSetTime", parms);
        }
        /// <summary>
        /// 根据 CONFIGId 字符串删除 CONFIG 信息。
        /// </summary>
        /// <param name="idString">CONFIGId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SOLDER_CONFIGDelete", parms);
        }

        /// <summary>
        /// 根据 CONFIGId 获取实体信息。
        /// </summary>
        /// <param name="cONFIGId">CONFIGId。</param>
        /// <returns>CONFIG 实体对象。</returns>
        public CONFIGInfo GetInfo(Int32 cONFIGId)
        {
            CONFIGInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = cONFIGId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SOLDER_CONFIGGetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CONFIGInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>CONFIG 实体对象。</returns>
        public CONFIGInfo GetInfo(String fieldValue)
        {
            CONFIGInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SOLDER_CONFIGGetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 CONFIG 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="cONFIGCount">cONFIG 总数。</param>
        /// <returns>CONFIG 列表。</returns>
        public List<CONFIGInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CONFIGInfo> list = new List<CONFIGInfo>();
            CONFIGInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SOLDER_CONFIG", "CONFIGID",
                "[ID], [SOLD_TYPE], [MINTHAW], [MAXVOID], [MAXUSE]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new CONFIGInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4));

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