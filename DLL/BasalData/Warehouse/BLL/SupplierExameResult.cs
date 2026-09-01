using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Warehouse.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Warehouse.BLL
{
    public class SupplierExameResult
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SupplierExameResult 信息。
        /// </summary>
        /// <param name="entity">SupplierExameResult 实体对象。</param>
        public Int32 Edit(SupplierExameResultInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SupplierExameResultID", SqlDbType.Int),
                new SqlParameter("@SupplierExameTempletID", SqlDbType.Int),
                new SqlParameter("@SupplierExameTempletType", SqlDbType.VarChar, 10),
                new SqlParameter("@SupplierExameTempletCode", SqlDbType.VarChar, 50),
                new SqlParameter("@SupplierExameTempletName", SqlDbType.VarChar, 100),
                new SqlParameter("@ExameDate", SqlDbType.VarChar, 10),
                new SqlParameter("@SupplierID", SqlDbType.Int),
                new SqlParameter("@VendorCode", SqlDbType.VarChar, 20),
                new SqlParameter("@VendorName", SqlDbType.VarChar, 200),
                new SqlParameter("@TotalGrades", SqlDbType.Decimal),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.SupplierExameResultID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.SupplierExameTempletID;
            parms[2].Value = entity.SupplierExameTempletType;
            parms[3].Value = entity.SupplierExameTempletCode;
            parms[4].Value = entity.SupplierExameTempletName;
            parms[5].Value = entity.ExameDate;
            parms[6].Value = entity.SupplierID;
            parms[7].Value = entity.VendorCode;
            parms[8].Value = entity.VendorName;
            parms[9].Value = entity.TotalGrades;
            parms[10].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_SupplierExameResult_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SupplierExameResultId 字符串删除 SupplierExameResult 信息。
        /// </summary>
        /// <param name="idString">SupplierExameResultId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_SupplierExameResult_Delete", parms);
        }

        /// <summary>
        /// 根据 SupplierExameResultId 获取实体信息。
        /// </summary>
        /// <param name="supplierExameResultId">SupplierExameResultId。</param>
        /// <returns>SupplierExameResult 实体对象。</returns>
        public SupplierExameResultInfo GetInfo(Int32 supplierExameResultId)
        {
            SupplierExameResultInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = supplierExameResultId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_SupplierExameResult_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SupplierExameResultInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDecimal(9), 
                        rdr.GetString(10), rdr.GetDateTime(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SupplierExameResult 实体对象。</returns>
        public SupplierExameResultInfo GetInfo(String fieldValue)
        {
            SupplierExameResultInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_SupplierExameResult_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SupplierExameResultInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDecimal(9), 
                        rdr.GetString(10), rdr.GetDateTime(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SupplierExameResult 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="supplierExameResultCount">supplierExameResult 总数。</param>
        /// <returns>SupplierExameResult 列表。</returns>
        public List<SupplierExameResultInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierExameResultInfo> list = new List<SupplierExameResultInfo>();
            SupplierExameResultInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_SupplierExameResult", "SupplierExameResultID",
                "[SupplierExameResultID], [SupplierExameTempletID], [SupplierExameTempletType], [SupplierExameTempletCode], [SupplierExameTempletName], [ExameDate], [SupplierID], [VendorCode], [VendorName], [TotalGrades], [CreateBy], [CreateDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SupplierExameResultInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDecimal(9), 
                        rdr.GetString(10), rdr.GetDateTime(11));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 SupplierExameResult 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="supplierExameResultCount">supplierExameResult 总数。</param>
        /// <returns>SupplierExameResult 列表。</returns>
        public List<SupplierExameContentResultInfo> GetAllSupplierExam(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierExameContentResultInfo> list = new List<SupplierExameContentResultInfo>();
            SupplierExameContentResultInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_SupplierExameContentResult", "SupplierExameContentResultID",
                "SupplierExameContentResultID, SupplierExameResultID, SupplierExameID, SupplierExameContentId, SupplierExameName, SupplierExameType, SupplierExameCompute, Grades, WeightGrades, Sorting, CreateBy, CreateDateTime, AssessmentWeight", 
                searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SupplierExameContentResultInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDecimal(7), rdr.GetDecimal(8), rdr.GetInt32(9),
                        rdr.GetString(10), rdr.GetDateTime(11));
                    entity.AssessmentWeight = rdr.GetInt32(12);
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

        public List<SupplierExameContentResultInfo> GenerateExamData(string ExamType, string ExamData, string UserName)
        {
            List<SupplierExameContentResultInfo> list = new List<SupplierExameContentResultInfo>();
            SupplierExameContentResultInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ExamType", SqlDbType.NVarChar, 10),
                new SqlParameter("@ExamData", SqlDbType.VarChar,10),
                new SqlParameter("@UserName", SqlDbType.VarChar,20),
            };

            parms[0].Value = ExamType;
            parms[1].Value = ExamData;
            parms[2].Value = UserName;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGenerateExamData", parms))
            {
                while (rdr.Read())
                {
                    entity = new SupplierExameContentResultInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDecimal(7), rdr.GetDecimal(8), rdr.GetInt32(9), rdr.GetString(10), rdr.GetDateTime(11));
                    entity.AssessmentWeight = rdr.GetInt32(12);
                    entity.ExameDate = rdr.GetString(13);
                    entity.VendorCode = rdr.GetString(14);
                    entity.VendorName = rdr.GetString(15);

                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        public List<SupplierExameContentResultInfo> SearchExamData(string ExamType, string ExamData, bool IsALLData = false)
        {
            List<SupplierExameContentResultInfo> list = new List<SupplierExameContentResultInfo>();
            SupplierExameContentResultInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ExamType", SqlDbType.NVarChar, 10),
                new SqlParameter("@ExamData", SqlDbType.VarChar,10),
                new SqlParameter("@IsALLData", SqlDbType.Bit)
            };

            parms[0].Value = ExamType;
            parms[1].Value = ExamData;
            parms[2].Value = IsALLData;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSearchExamData", parms))
            {
                while (rdr.Read())
                {
                    entity = new SupplierExameContentResultInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDecimal(7), rdr.GetDecimal(8), rdr.GetInt32(9), rdr.GetString(10), rdr.GetDateTime(11));
                    entity.AssessmentWeight = rdr.GetInt32(12);
                    entity.ExameDate = rdr.GetString(13);
                    entity.VendorCode = rdr.GetString(14);
                    entity.VendorName = rdr.GetString(15);

                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        public List<SupplierExameContentResultInfo> SearchExamDataSupplier(string ExamType, string ExamData, string VendorCode)
        {
            List<SupplierExameContentResultInfo> list = new List<SupplierExameContentResultInfo>();
            SupplierExameContentResultInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ExamType", SqlDbType.NVarChar, 10),
                new SqlParameter("@ExamData", SqlDbType.VarChar,10),
                new SqlParameter("@VendorCode", SqlDbType.VarChar,20)
            };

            parms[0].Value = ExamType;
            parms[1].Value = ExamData;
            parms[2].Value = VendorCode;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSearchExamDataSupplier", parms))
            {
                while (rdr.Read())
                {
                    entity = new SupplierExameContentResultInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDecimal(7), rdr.GetDecimal(8), rdr.GetInt32(9), rdr.GetString(10), rdr.GetDateTime(11));
                    entity.AssessmentWeight = rdr.GetInt32(12);
                    entity.ExameDate = rdr.GetString(13);
                    entity.VendorCode = rdr.GetString(14);
                    entity.VendorName = rdr.GetString(15);

                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        public void SaveExamChangeData(List<ExamChangeDataInfo> list)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ExamChangeData", SqlDbType.Structured)
            };
            parms[0].Value = CommonHelper.BLL.ComMethod.ConvertToDataTable(list);
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveExamChangeData", parms);
        }

        public void CheckSupplierExameCompute(string Proc)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProcName", SqlDbType.VarChar,200)
            };
            parms[0].Value = Proc;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckSupplierExameCompute", parms);
        }
    }
}