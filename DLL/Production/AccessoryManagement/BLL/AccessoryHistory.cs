using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.AccessoryManagement.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.AccessoryManagement.BLL
{
    public class AccessoryHistory
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） AccessoryHistory 信息。
        /// </summary>
        /// <param name="entity">AccessoryHistory 实体对象。</param>
        public Int32 Edit(AccessoryHistoryInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AccessoryId", SqlDbType.Int),
                new SqlParameter("@AccessoryCodoe", SqlDbType.VarChar, 50),
                new SqlParameter("@AccessoryName", SqlDbType.VarChar, 100),
                new SqlParameter("@SerialNumber", SqlDbType.VarChar, 300),
                new SqlParameter("@OpType", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@CreateTime", SqlDbType.DateTime)
            };

            parms[0].Value = entity.AccessoryId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.AccessoryCodoe;
            parms[2].Value = entity.AccessoryName;
            parms[3].Value = entity.SerialNumber;
            parms[4].Value = entity.OpType;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.CreateTime;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryHistory_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 AccessoryHistoryId 字符串删除 AccessoryHistory 信息。
        /// </summary>
        /// <param name="idString">AccessoryHistoryId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryHistory_Delete", parms);
        }

        /// <summary>
        /// 根据 AccessoryHistoryId 获取实体信息。
        /// </summary>
        /// <param name="accessoryHistoryId">AccessoryHistoryId。</param>
        /// <returns>AccessoryHistory 实体对象。</returns>
        public AccessoryHistoryInfo GetInfo(Int32 accessoryHistoryId)
        {
            AccessoryHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = accessoryHistoryId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AccessoryHistoryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetDateTime(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AccessoryHistory 实体对象。</returns>
        public AccessoryHistoryInfo GetInfo(String fieldValue)
        {
            AccessoryHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AccessoryHistoryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetDateTime(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 AccessoryHistory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="accessoryHistoryCount">accessoryHistory 总数。</param>
        /// <returns>AccessoryHistory 列表。</returns>
        public List<AccessoryHistoryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AccessoryHistoryInfo> list = new List<AccessoryHistoryInfo>();
            AccessoryHistoryInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_AccessoryHistory", "AccessoryId",////Prod_AccessoryHistory
                "[AccessoryId], [AccessoryCodoe], [AccessoryName], [SerialNumber], [OpType], [CreateBy], [CreateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AccessoryHistoryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetDateTime(6));

                    list.Add(entity);
                }
                rdr.Close();
            }
            for (int i = 0; i < list.Count; i++)
            {
                if (list[i].OpType == 0)
                {
                    list[i].OpTypeName = "打印登记";
                }
                else if (list[i].OpType == 1)
                {
                    list[i].OpTypeName = "登记";
                }
                else if (list[i].OpType == 2)
                {
                    list[i].OpTypeName = "解冻";
                }
                else if (list[i].OpType == 3)
                {
                    list[i].OpTypeName = "发料";
                }
                else if (list[i].OpType == 4)
                {
                    list[i].OpTypeName = "上料";
                }
                else if (list[i].OpType == 5)
                {
                    list[i].OpTypeName = "退回";
                }
                else if (list[i].OpType == 6)
                {
                    list[i].OpTypeName = "报废";
                }
                else if (list[i].OpType == 7)
                {
                    list[i].OpTypeName = "搅拌";
                }
                else if (list[i].OpType == 8)
                {
                    list[i].OpTypeName = "空瓶回收";
                }
                else if (list[i].OpType == 9)
                {
                    list[i].OpTypeName = "下线";
                }
                else
                {
                    list[i].OpTypeName = "未知";
                }
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