using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Navigation.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Navigation.BLL
{
    public class Navigation
    {
        private Int32 recordCount = 0;


        /// <summary>
        /// 编辑（添加或更新）Navigation  信息。
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public Int32 Edit(NavigationInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter ("@ID",SqlDbType.Int),
                new SqlParameter("@Icon",SqlDbType.VarChar,100),
                new SqlParameter("@NavigationgpName",SqlDbType.VarChar,100),
                new SqlParameter("@Sequence",SqlDbType.Int),
                new SqlParameter ("@CreateBy",SqlDbType.VarChar,50),
                new SqlParameter("@ModifyBy",SqlDbType.VarChar,50),
            };
            parms[0].Value = entity.ID;
            parms[1].Value = entity.Icon;
            parms[2].Value = entity.NavigationgpName;
            parms[3].Value = entity.Sequence;
            parms[4].Value = entity.CreateBy;
            parms[5].Value= entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Navigation_group_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 Id 获取实体信息。
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        public NavigationInfo GetInfo(Int32 Id)
        {
            NavigationInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@FieldValue",SqlDbType.NVarChar,50),
                new SqlParameter("@IsByID",SqlDbType.Bit)
            };

            parms[0].Value = Id;
            parms[1].Value = true;

            using (SqlDataReader rdr=SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Navigation_group_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new NavigationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 根据 fieldValue 获取实体信息。
        /// </summary>
        /// <param name="fieldValue"></param>
        /// <returns></returns>
        public NavigationInfo GetInfo(String fieldValue)
        {
            NavigationInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@FieldValue",SqlDbType.NVarChar,50),
                new SqlParameter("@IsByID",SqlDbType.Bit)
            };
            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr=SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Navigation_group_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new NavigationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                    rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }
            return entity;
            
        }
        /// <summary>
        /// 根据 Id 字符串删除 Navigation 信息。
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

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Navigation_group_Delete", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        public List<NavigationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<NavigationInfo> list = new List<NavigationInfo>();
            NavigationInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwNavigation_group", "ID",////Navigation_group
                "[ID],[Icon],[NavigationgpName],[Sequence],[CreateBy],[CreateDateTime],[ModifyBy],[ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr=SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new NavigationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;

        }
        public string GetSequence(Int32 id)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@Sequence",SqlDbType.Int),
                new SqlParameter("@Id",SqlDbType.Int)
            };
            parms[0].Direction = ParameterDirection.Output;
            parms[1].Value = id;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Navigation_group_GetSequence", parms);
            return parms[0].Value.ToString();
        }
    }
}
