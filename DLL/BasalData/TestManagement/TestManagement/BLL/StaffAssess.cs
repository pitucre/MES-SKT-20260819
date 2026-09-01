using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.TestManagement.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.TestManagement.BLL
{
    public class StaffAssess
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑或更新StaffAssess信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public Int32 Edit(StaffAssessInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar,50),
                new SqlParameter("@EmployeeNo",SqlDbType.NVarChar,50),
                new SqlParameter ("@DepartName",SqlDbType.VarChar,20),
                new SqlParameter("@QtyAet",SqlDbType.VarChar,20),
                new SqlParameter("@AetGrade",SqlDbType.VarChar,20),
                new SqlParameter("@Sex",SqlDbType.VarChar,10),
                new SqlParameter("@Phone",SqlDbType.Int),
                new SqlParameter("@Email",SqlDbType.NVarChar,50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar,50) 
            };
            parms[0].Value = entity.UserId;
            parms[1].Value = entity.UserName;
            parms[2].Value = entity.EmployeeNo;
            parms[3].Value = entity.DepartName;
            parms[4].Value = entity.QtyAet;
            parms[5].Value = entity.AetGrade;
            parms[6].Value = entity.Sex;
            parms[7].Value = entity.Phone;
            parms[8].Value = entity.Email;
            parms[9].Value = entity.ModifyBy;
            parms[10].Value = entity.CreateBy;
            parms[11].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_StaffAssess_Edit", parms);
            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 userId 获取实体信息。
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public StaffAssessInfo GetInfo(Int32 userId)
        {
            StaffAssessInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@FieldValue",SqlDbType.NVarChar,50),
                new SqlParameter("@IsByID",SqlDbType.Bit)
            };
            parms[0].Value = userId;
            parms[1].Value = true;

            using (SqlDataReader rdr=SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_StaffAssess_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new StaffAssessInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3),
                        rdr.GetString(4), rdr.GetString(5), rdr.GetString(6), rdr.GetInt32(7), rdr.GetString(8),
                        rdr.GetDateTime(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12),rdr.GetString(13));
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue"></param>
        /// <returns></returns>
        public StaffAssessInfo GetInfo(String fieldValue)
        {
            StaffAssessInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@FieldValue",SqlDbType.NVarChar,50),
                new SqlParameter("@IsByID",SqlDbType.Bit)
            };
            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr=SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_StaffAssess_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new StaffAssessInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3),
                        rdr.GetString(4), rdr.GetString(5), rdr.GetString(6), rdr.GetInt32(7), rdr.GetString(8),
                        rdr.GetDateTime(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12),rdr.GetString(13));
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        ///  根据 UserId 字符串删除 StaffAssess 信息。
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_StaffAssess_Delete", parms);
        }

        /// <summary>
        /// 分页获取StaffAssess
        /// </summary>
        /// <param name="startRow">起始行</param>
        /// <param name="maxRows">最大行数</param>
        /// <param name="sortExpression">排序表达式</param>
        /// <param name="searchSettings">搜索配置信息</param>
        /// <param name="recordCount">staffAssess总数</param>
        /// <returns>StaffAssess 列表</returns>
        public List<StaffAssessInfo> GetAll(Int32 startRow,Int32 maxRows,String sortExpression, SearchSettings searchSettings)
        {
            List<StaffAssessInfo> list = new List<StaffAssessInfo>();
            StaffAssessInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_StaffAssess", "UserId",
                "[UserId],[UserName],[EmployeeNo],[DepartName],[QtyAet],[AetGrade],[Sex],[Email],[ModifyDateTime],[Modify],[CreateByDateTime],[CreateBy],[Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr=SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new StaffAssessInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3),
                        rdr.GetString(4), rdr.GetString(5), rdr.GetString(6), rdr.GetInt32(7), rdr.GetString(8),
                        rdr.GetDateTime(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12),rdr.GetString(13));

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
