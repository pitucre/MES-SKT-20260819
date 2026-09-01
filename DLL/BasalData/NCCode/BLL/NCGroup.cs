using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.NCCode.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Text.RegularExpressions;

namespace SKT.LeanMES.NCCode.BLL
{
    public class NCGroup
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） NCGroup 信息。
        /// </summary>
        /// <param name="entity">NCGroup 实体对象。</param>
        public  void Edit(NCGroupInfo entity, string ncodeStr, string operationStr)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@NCGroupId", SqlDbType.Int),
                new SqlParameter("@NCGroupName", SqlDbType.NVarChar, 20),
                new SqlParameter("@IsAllOperations", SqlDbType.Bit),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ncodeStr", SqlDbType.VarChar,-1),
                new SqlParameter("@operationStr", SqlDbType.VarChar,-1),
            };
            parms[0].Value = entity.NCGroupId;
            parms[1].Value = entity.NCGroupName;
            parms[2].Value = entity.IsAllOperations;
            parms[3].Value = entity.Description;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = ncodeStr;
            parms[7].Value = operationStr;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_NCGroup_Edit", parms);;
        }
        #region 将 Json 解析成 DateTable
        /// <summary>    
        /// 将 Json 解析成 DateTable   
        /// Json 数据格式如:  
        ///     {table:[{column1:1,column2:2,column3:3},{column1:1,column2:2,column3:3}]}///</summary>    
        /// <param name="strJson">要解析的 Json 字符串</param>    
        /// <returns>返回 DateTable</returns>    
        public static DataTable JsonToDataTable(string strJson)
        {
            // 取出表名    
            var rg = new Regex(@"(?<={)[^:]+(?=:\[)", RegexOptions.IgnoreCase);
            string strName = rg.Match(strJson).Value;
            DataTable tb = null;
            // 去除表名    
            strJson = strJson.Substring(strJson.IndexOf("[") + 1);
            strJson = strJson.Substring(0, strJson.IndexOf("]"));
            // 获取数据    
            rg = new Regex(@"(?<={)[^}]+(?=})");
            MatchCollection mc = rg.Matches(strJson);
            for (int i = 0; i < mc.Count; i++)
            {
                string strRow = mc[i].Value;
                string[] strRows = strRow.Split(',');
                // 创建表    
                if (tb == null)
                {
                    tb = new DataTable();
                    tb.TableName = strName;
                    foreach (string str in strRows)
                    {
                        var dc = new DataColumn();
                        string[] strCell = str.Split(':');
                        dc.ColumnName = strCell[0].Replace("\"", "");
                        tb.Columns.Add(dc);
                    }
                    tb.AcceptChanges();
                }
                // 增加内容    
                DataRow dr = tb.NewRow();
                for (int j = 0; j < strRows.Length; j++)
                {
                    dr[j] = strRows[j].Split(':')[1].Replace("\"", "");
                }
                tb.Rows.Add(dr);
                tb.AcceptChanges();
            }
            return tb;
        }
        #endregion
        /// <summary>
        /// 根据 NCGroupId 字符串删除 NCGroup 信息。
        /// </summary>
        /// <param name="idString">NCGroupId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_NCGroup_Delete", parms);
        }

        /// <summary>
        /// 根据 NCGroupId 获取实体信息。
        /// </summary>
        /// <param name="nCGroupId">NCGroupId。</param>
        /// <returns>NCGroup 实体对象。</returns>
        public NCGroupInfo GetInfo(Int32 nCGroupId)
        {
            NCGroupInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = nCGroupId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_NCGroup_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new NCGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetBoolean(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>NCGroup 实体对象。</returns>
        public NCGroupInfo GetInfo(String fieldValue)
        {
            NCGroupInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_NCGroup_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new NCGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetBoolean(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 NCGroup 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="nCGroupCount">nCGroup 总数。</param>
        /// <returns>NCGroup 列表。</returns>
        public List<NCGroupInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<NCGroupInfo> list = new List<NCGroupInfo>();
            NCGroupInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_NCGroup", "NCGroupID",////Basal_NCGroup
                "[NCGroupId], [NCGroupName], [IsAllOperations], [Description], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new NCGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetBoolean(2), rdr.GetString(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));

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
