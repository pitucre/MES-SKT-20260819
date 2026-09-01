using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.AccessoryManagement.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.AccessoryManagement.BLL
{
    public class AccessoryList
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） AccessoryList 信息。
        /// </summary>
        /// <param name="entity">AccessoryList 实体对象。</param>
        public Int32 Edit(AccessoryListInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@AccessoryCode", SqlDbType.VarChar, 50),
                new SqlParameter("@AccessoryName", SqlDbType.VarChar, 200),
                new SqlParameter("@AccessoryType", SqlDbType.VarChar, 50),
                new SqlParameter("@WLType", SqlDbType.VarChar, 50),
                new SqlParameter("@UnitName", SqlDbType.VarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@IsFreeze", SqlDbType.VarChar,5)
            };

            parms[0].Value = entity.Id;
            parms[1].Value = entity.AccessoryCode;
            parms[2].Value = entity.AccessoryName;
            parms[3].Value = entity.AccessoryType;
            parms[4].Value = entity.WLType;
            parms[5].Value = entity.UnitName;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.IsFreeze;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryList_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 AccessoryListId 字符串删除 AccessoryList 信息。
        /// </summary>
        /// <param name="idString">AccessoryListId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryList_Delete", parms);
        }

        /// <summary>
        /// 根据 AccessoryListId 获取实体信息。
        /// </summary>
        /// <param name="accessoryListId">AccessoryListId。</param>
        /// <returns>AccessoryList 实体对象。</returns>
        public AccessoryListInfo GetInfo(Int32 accessoryListId)
        {
            AccessoryListInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = accessoryListId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryList_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AccessoryListInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(10));
                    entity.AccessoryTypeName = rdr.GetString(8);
                    entity.ItemId = rdr["ItemId"] == DBNull.Value || rdr["ItemId"] == null ? -1 : Convert.ToInt32(rdr["ItemId"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AccessoryList 实体对象。</returns>
        public AccessoryListInfo GetInfo(String fieldValue)
        {
            AccessoryListInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryList_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AccessoryListInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(10));
                    entity.AccessoryTypeName = rdr.GetString(8);
                    entity.ItemId = rdr["ItemId"] == DBNull.Value || rdr["ItemId"] == null ? -1 : Convert.ToInt32(rdr["ItemId"]);
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// 分页获取 AccessoryList 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="accessoryListCount">accessoryList 总数。</param>
        /// <returns>AccessoryList 列表。</returns>
        public List<AccessoryListInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {

            List<AccessoryListInfo> list = new List<AccessoryListInfo>();
            //表名或者视图
            string strTb = "vwPoAccessoryList";
            //主键
            string strKey = "Id";
            //查询栏位字串
            string strColumns = @"[Id], [AccessoryCode], [AccessoryName], [AccessoryType],[AccessoryTypeName],ItemSpec, [WLType], [UnitName], [CreateBy], [CreateTime], [IsFreeze],ModifyBy,ModifyTime";
            list = ComMethod.GetComList<AccessoryListInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}