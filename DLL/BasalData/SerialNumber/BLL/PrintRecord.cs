using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using SKT.LeanMES.SerialNumber.Model;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SerialNumber.BLL
{
    public class PrintRecord
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） PrintRecord 信息。
        /// </summary>
        /// <param name="entity">PrintRecord 实体对象。</param>
        public Int32 Edit(PrintRecordInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RecordId", SqlDbType.Int),
                new SqlParameter("@ActionType", SqlDbType.Int),
                new SqlParameter("@PrintType", SqlDbType.Int),
                new SqlParameter("@PrintKey", SqlDbType.NVarChar, 100),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@ResourceId", SqlDbType.Int),
                new SqlParameter("@PrintUser", SqlDbType.VarChar, 20),
                new SqlParameter("@PrintTime", SqlDbType.DateTime)
            };

            parms[0].Value = entity.RecordId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ActionType;
            parms[2].Value = entity.PrintType;
            parms[3].Value = entity.PrintKey;
            parms[4].Value = entity.StationId;
            parms[5].Value = entity.ResourceId;
            parms[6].Value = entity.PrintUser;
            parms[7].Value = entity.PrintTime;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PrintRecord_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PrintRecordId 字符串删除 PrintRecord 信息。
        /// </summary>
        /// <param name="idString">PrintRecordId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PrintRecord_Delete", parms);
        }

        /// <summary>
        /// 根据 PrintRecordId 获取实体信息。
        /// </summary>
        /// <param name="printRecordId">PrintRecordId。</param>
        /// <returns>PrintRecord 实体对象。</returns>
        public PrintRecordInfo GetInfo(Int32 printRecordId)
        {
            PrintRecordInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = printRecordId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PrintRecord_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PrintRecordInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetInt32(6), rdr.GetString(8), rdr.GetDateTime(9));
                    entity.Station = rdr.IsDBNull(5) ? "" : rdr.GetString(5);
                    entity.Resource = rdr.IsDBNull(7) ? "" : rdr.GetString(7);
                    entity.SerialNumberType = rdr.IsDBNull(10) ? "" : rdr.GetString(10);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PrintRecord 实体对象。</returns>
        public PrintRecordInfo GetInfo(String fieldValue)
        {
            PrintRecordInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PrintRecord_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PrintRecordInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetInt32(6), rdr.GetString(8), rdr.GetDateTime(9));
                    entity.Station = rdr.IsDBNull(5) ? "" : rdr.GetString(5);
                    entity.Resource = rdr.IsDBNull(7) ? "" : rdr.GetString(7);
                    entity.SerialNumberType = rdr.IsDBNull(10) ? "" : rdr.GetString(10);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 PrintRecord 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="printRecordCount">printRecord 总数。</param>
        /// <returns>PrintRecord 列表。</returns>
        public List<PrintRecordInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PrintRecordInfo> list = new List<PrintRecordInfo>();
            PrintRecordInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwPrintRecord"
                , "RecordId"
                , @" [RecordId], [ActionType], [PrintType], [PrintKey], [StationId], [Station], [ResourceId]
                    , [ResName] , [PrintUser], [PrintTime] ,ItemCode ,ItemName
                    , OrderNo ,OrderType,OrderTypeName ,CustomerOrder ,SerialNumberType"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrintRecordInfo((int)rdr["RecordId"], (string)rdr["ActionType"]
                        , (int)rdr["PrintType"], (string)rdr["PrintKey"], (int)rdr["StationId"],
                        (int)rdr["ResourceId"], (string)rdr["PrintUser"], (DateTime)rdr["PrintTime"]);
                    entity.Station = (string)rdr["Station"];
                    entity.Resource = (string)rdr["ResName"];
                    entity.ItemCode = (string)rdr["ItemCode"];
                    entity.ItemName = (string)rdr["ItemName"];
                    entity.OrderNo = (string)rdr["OrderNo"];
                    entity.OrderType = rdr["OrderTypeName"].ToString();
                    entity.CustomerOrder = (string)rdr["CustomerOrder"];
                    entity.SerialNumberType = (string)rdr["SerialNumberType"];
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
