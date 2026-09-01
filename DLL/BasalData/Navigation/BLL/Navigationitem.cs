using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Navigation.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Navigation.BLL
{
    public class Navigationitem
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑（添加或更新）Navigationitem  信息。
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public Int32 Edit(NavigationitemInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@Id",SqlDbType.Int),
                new SqlParameter("@NavigationId",SqlDbType.Int),
                new SqlParameter("@NavigationgpName",SqlDbType.VarChar,100),
                new SqlParameter("@NavigationName",SqlDbType.VarChar,100),
                new SqlParameter("@Sequence",SqlDbType.Int),
                new SqlParameter("@Url",SqlDbType.VarChar,1024),
                new SqlParameter("@CreateBy",SqlDbType.VarChar,50),
                new SqlParameter("@ModifyBy",SqlDbType.VarChar,50),
                new SqlParameter("@Target",SqlDbType.Int)
            };
            parms[0].Value = entity.ID;
            parms[1].Value = entity.NavigationId;
            parms[2].Value = entity.NavigationgpName;
            parms[3].Value = entity.NavigationName;
            parms[4].Value = entity.Sequence;
            parms[5].Value = entity.Url;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.Target;


            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Navigation_item_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 Id 获取实体信息。
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        public NavigationitemInfo GetInfo(Int32 Id)
        {
            NavigationitemInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@FieldValue",SqlDbType.NVarChar,50),
                new SqlParameter("@IsByID",SqlDbType.Bit)
            };
            parms[0].Value = Id;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Navigation_item_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new NavigationitemInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), rdr.GetString(5),
                        rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9));
                    entity.Target = rdr.GetInt32(10);
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
        public NavigationitemInfo GetInfo(String fieldValue)
        {
            NavigationitemInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@FieldValue",SqlDbType.NVarChar,50),
                new SqlParameter("@IsByID",SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Navigation_item_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new NavigationitemInfo(rdr.GetInt32(0), rdr.GetInt32(1),rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), rdr.GetString(5),
                        rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9));
                    entity.Target = rdr.GetInt32(10);
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 根据Id字符串 删除Navigationitem信息
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@IdString",SqlDbType.VarChar,1000),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };
            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Navigation_item_Delete", parms);
        }

        /// <summary>
        /// 分页获取 Navigationitem 资料
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<NavigationitemInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<NavigationitemInfo> list = new List<NavigationitemInfo>();
            NavigationitemInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwNavigation_item", "ID",////Navigation_item
                "[ID],[NavigationId],[NavigationgpName],[NavigationName],[Sequence],[Url],[CreateBy],[CreateDateTime],[ModifyBy],[ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new NavigationitemInfo(rdr.GetInt32(0), rdr.GetInt32(1),rdr.GetString(2) ,rdr.GetString(3), rdr.GetInt32(4), rdr.GetString(5),
                        rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9));
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

        public string GetmSequence(Int32 id)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@Sequence",SqlDbType.Int),
                new SqlParameter("@Id",SqlDbType.Int)
            };
            parms[0].Direction = ParameterDirection.Output;
            parms[1].Value = id;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Navigation_item_GetSequence", parms);
            return parms[0].Value.ToString();
        }
    }
}
