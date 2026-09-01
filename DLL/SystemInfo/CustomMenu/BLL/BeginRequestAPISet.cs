using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CustomMenu.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;

namespace SKT.LeanMES.CustomMenu.BLL
{
    public class BeginRequestAPISet
    {
        int recordCount = 0;
        public List<BeginRequestAPISetEntity> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<BeginRequestAPISetEntity> list = new List<BeginRequestAPISetEntity>();
            BeginRequestAPISetEntity entity = new BeginRequestAPISetEntity();
            PropertyInfo[] info = entity.GetType().GetProperties();
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSYS_BeginRequestAPISet", "Id",////SYS_BeginRequestAPISet
                "Id, RequestUrl, Deal_Param_Proc, APIUrl, APIMethod, Deal_Result_Proc, Remark, ModifyDateTime, CreateDateTime, ModifyBy, CreateBy,ResultType,DealError,[Application],ContentType", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    BeginRequestAPISetEntity en = new BeginRequestAPISetEntity();
                    foreach (var item in info)
                    {
                        if (rdr[item.Name] != DBNull.Value)
                            item.SetValue(en, rdr[item.Name], null);
                    }
                    list.Add(en);
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
        public void Edit(BeginRequestAPISetEntity entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@RequestUrl", SqlDbType.VarChar,200),
                new SqlParameter("@APIUrl", SqlDbType.VarChar,200),
                new SqlParameter("@ResultType", SqlDbType.Int),
                new SqlParameter("@APIMethod", SqlDbType.VarChar,10),
                new SqlParameter("@DealError", SqlDbType.Int),
                new SqlParameter("@Application", SqlDbType.Int),
                new SqlParameter("@ContentType", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar,20)
            };

            parms[0].Value = entity.Id;
            parms[1].Value = entity.RequestUrl;
            parms[2].Value = entity.APIUrl;
            parms[3].Value = entity.ResultType;
            parms[4].Value = entity.APIMethod;
            parms[5].Value = entity.DealError;
            parms[6].Value = entity.Application;
            parms[7].Value = entity.ContentType;
            parms[8].Value = entity.Remark;
            parms[9].Value = entity.ModifyBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_BeginRequestAPISet_Edit", parms);
        }
        public void Delete(int id)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int)
            };
            parms[0].Value = id;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_BeginRequestAPISet_Delete", parms);
        }

        public string ExeParamProc(string procname, string xml, int userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@xml", SqlDbType.Xml),
                new SqlParameter("@userId",  SqlDbType.Int),
                new SqlParameter("@json",  SqlDbType.VarChar,8000)

            };
            parms[0].Value = xml;
            parms[1].Value = userId;
            parms[2].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, procname, parms);
            return parms[2].Value.ToString();
        }
        public string ExeResultProc(string procname, string xml, int userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@xml", SqlDbType.Xml),
                new SqlParameter("@userId",  SqlDbType.Int),
                new SqlParameter("@msg",  SqlDbType.VarChar,200)

            };
            parms[0].Value = xml;
            parms[1].Value = userId;
            parms[2].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, procname, parms);
            return parms[2].Value.ToString();
        }
    }
}
