using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ExtensionTables.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.ExtensionTables.BLL
{
    public class Base_Ext
    {
        private Int32 recordCount = 0;

        public Int32 RecordCount
        {
            get { return this.recordCount; }
            set { this.recordCount = value; }
        }
        /// <summary>
        /// 编辑（添加或更新） Base_Ext 信息。
        /// </summary>
        /// <param name="entity">Base_Ext 实体对象。</param>
        /// <param name="tableName">需扩展字段的表名。</param>
        public Int32 Edit(Base_ExtInfo entity, String tableName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ExtId", SqlDbType.Int),
                new SqlParameter("@TableDataId", SqlDbType.Int),
                new SqlParameter("@ExtFieldsId", SqlDbType.Int),
                new SqlParameter("@ExtFieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.ExtId;
            //parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.TableDataId;
            parms[2].Value = entity.ExtFieldsId;
            parms[3].Value = entity.ExtFieldValue;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, tableName + "_Ext_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// add by weixia on 2016.3.16
        /// </summary>
        /// <param name="extIds">扩展字段信息 ID 字符组。</param>
        /// <param name="extFieldsIds">扩展字段 ID 字符组。</param>
        /// <param name="extFieldValues">扩展字段信息属性值组。</param>
        /// <param name="tableDataId">基础表数据 ID 。</param>
        /// <param name="modifyBy">修改人。</param>
        /// <param name="createBy">创建人。</param>
        /// <param name="tableName">需扩展字段的表名。</param>
        public void BaseExtInfoListEdit(String extIds, String extFieldsIds, String extFieldValues,
            Int32 tableDataId, String modifyBy, String createBy, string tableName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ExtIds", SqlDbType.VarChar),
                new SqlParameter("@ExtFieldsIds", SqlDbType.VarChar),
                new SqlParameter("@ExtFieldValues", SqlDbType.NVarChar),
                new SqlParameter("@TableDataId", SqlDbType.Int),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = extIds;
            parms[1].Value = extFieldsIds;
            parms[2].Value = extFieldValues;
            parms[3].Value = tableDataId;
            parms[4].Value = modifyBy;
            parms[5].Value = createBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, tableName + "_Ext_Edit", parms);
        }
        /// <summary>
        /// 批量编辑（添加或更新）Base_Ext 信息。
        /// </summary>
        /// <param name="extIds">扩展字段信息 ID 字符组。</param>
        /// <param name="extFieldsIds">扩展字段 ID 字符组。</param>
        /// <param name="extFieldValues">扩展字段信息属性值组。</param>
        /// <param name="tableDataId">基础表数据 ID 。</param>
        /// <param name="modifyBy">修改人。</param>
        /// <param name="createBy">创建人。</param>
        /// <param name="tableName">需扩展字段的表名。</param>
        public void ExecGeneralMethod(String extIds, String extFieldsIds, String extFieldValues, 
            Int32 tableDataId, String modifyBy, String createBy, String tableName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ExtIds", SqlDbType.VarChar),
                new SqlParameter("@ExtFieldsIds", SqlDbType.VarChar),
                new SqlParameter("@ExtFieldValues", SqlDbType.NVarChar),
                new SqlParameter("@TableDataId", SqlDbType.Int),
                new SqlParameter("@TableName", SqlDbType.NVarChar,100),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = extIds;
            parms[1].Value = extFieldsIds;
            parms[2].Value = extFieldValues;
            parms[3].Value = tableDataId;
            parms[4].Value = tableName;
            parms[5].Value = modifyBy;
            parms[6].Value = createBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "General_TableExt_Edit", parms);
        }

        /// <summary>
        /// 根据 ExtId 字符串删除 Base_Ext 信息。
        /// </summary>
        /// <param name="idString">ExtId 字符串。</param>
        /// <param name="userName">用户名。</param>
        /// <param name="tableName">需扩展字段的表名。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName, String tableName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, tableName + "_Ext_Delete", parms);
        }

        /// <summary>
        /// 根据 ExtId 获取实体信息。
        /// </summary>
        /// <param name="extId">extId。</param>
        /// <param name="tableName">需扩展字段的表名。</param>
        /// <returns>Base_Ext 实体对象。</returns>
        public Base_ExtInfo GetInfo(Int32 extId, String tableName)
        {
            Base_ExtInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = extId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, tableName + "_Ext_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new Base_ExtInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetDateTime(4), rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <param name="tableName">需扩展字段的表名。</param>
        /// <returns>Base_Ext 实体对象。</returns>
        public Base_ExtInfo GetInfo(String fieldValue, String tableName)
        {
            Base_ExtInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, tableName + "_Ext_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new Base_ExtInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetDateTime(4), rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Base_Ext 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="Item_ExtCount">Base_Ext 总数。</param>
        /// <param name="tableName">需扩展字段的表名。</param>
        /// <returns>Base_Ext 列表。</returns>
        public List<Base_ExtInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression,
            SearchSettings searchSettings, String tableName)
        {
            List<Base_ExtInfo> list = new List<Base_ExtInfo>();
            Base_ExtInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, tableName + "_Ext", "ExtId",
                "[ExtId], [TableDataId], [ExtFieldsId], [ExtFieldValue], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy]",
                searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new Base_ExtInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3),
                            rdr.GetDateTime(4), rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 根据 基础表数据ID 获取所有扩展字段信息。
        /// </summary>
        /// <param name="_itemId">基础表数据ID。</param>
        /// <param name="tableName">需扩展字段的表名。</param>
        /// <returns>Base_Ext 列表</returns>
        public List<Base_ExtInfo> GetExtsionInfoListByItemId(int _itemId, String tableName)
        {
            List<Base_ExtInfo> extsionInfoList = new List<Base_ExtInfo>();
            Base_ExtInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TableDataId", SqlDbType.Int),
                new SqlParameter("@TableName", SqlDbType.VarChar, 50)
            };

            parms[0].Value = _itemId;
            parms[1].Value = tableName;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, tableName + "_Ext_GetExtensionInfoListByDataId", parms))
            {
                while (rdr.Read())
                {
                    entity = new Base_ExtInfo(rdr.IsDBNull(0) ? null : (Nullable<Int32>)rdr.GetInt32(0), rdr.GetInt32(1),
                            rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), rdr.GetString(5), rdr.GetString(6),
                            rdr.GetBoolean(7), rdr.IsDBNull(8) ? null : rdr.GetString(8), rdr.GetInt32(9),
                            rdr.IsDBNull(10) ? null : (Nullable<DateTime>)rdr.GetDateTime(10), rdr.IsDBNull(11) ? null : rdr.GetString(11),
                            rdr.IsDBNull(12) ? null : (Nullable<DateTime>)rdr.GetDateTime(12), rdr.IsDBNull(13) ? null : rdr.GetString(13));

                    extsionInfoList.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 2].Value);
            return extsionInfoList;
        }

        /// <summary>
        /// 获取通用的数据
        public List<Base_ExtInfo> GenerialGetExtensionInfoListByDataId(int orderId, String tableName)
        {
            List<Base_ExtInfo> extsionInfoList = new List<Base_ExtInfo>();
            Base_ExtInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TableDataId", SqlDbType.Int),
                new SqlParameter("@TableName", SqlDbType.VarChar, 50)
            };

            parms[0].Value = orderId;
            parms[1].Value = tableName;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "GenerialGetExtensionInfoListByDataId", parms))
            {
                while (rdr.Read())
                {
                    entity = new Base_ExtInfo(rdr.IsDBNull(0) ? null : (Nullable<Int32>)rdr.GetInt32(0), rdr.GetInt32(1),
                            rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), rdr.GetString(5), rdr.GetString(6),
                            rdr.GetBoolean(7), rdr.IsDBNull(8) ? null : rdr.GetString(8), rdr.GetInt32(9),
                            rdr.IsDBNull(10) ? null : (Nullable<DateTime>)rdr.GetDateTime(10), rdr.IsDBNull(11) ? null : rdr.GetString(11),
                            rdr.IsDBNull(12) ? null : (Nullable<DateTime>)rdr.GetDateTime(12), rdr.IsDBNull(13) ? null : rdr.GetString(13));

                    extsionInfoList.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 2].Value);
            return extsionInfoList;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
