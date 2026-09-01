using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Warehouse.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Warehouse.BLL
{
    public class Warehouse
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Warehouse 信息。
        /// </summary>
        /// <param name="entity">Warehouse 实体对象。</param>
        public Int32 Edit(WarehouseInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WarehouseId", SqlDbType.Int),
                new SqlParameter("@CWhCode", SqlDbType.NVarChar, 10),
                new SqlParameter("@CWhName", SqlDbType.NVarChar, 20),
                new SqlParameter("@IWHProperty", SqlDbType.NVarChar, 20),
                new SqlParameter("@CDepCode", SqlDbType.NVarChar, 12),
                new SqlParameter("@CWhAddress", SqlDbType.NVarChar, 30),
                new SqlParameter("@CcWhPhone", SqlDbType.NVarChar, 20),
                new SqlParameter("@CWhPerson", SqlDbType.NVarChar, 10),
                new SqlParameter("@BWhPos", SqlDbType.Bit),
                new SqlParameter("@CWhMemo", SqlDbType.NVarChar, 20),
                new SqlParameter("@BFreeze", SqlDbType.Bit),
                new SqlParameter("@CBarCode", SqlDbType.NVarChar, 30),
                new SqlParameter("@CycleCount", SqlDbType.SmallInt),
                new SqlParameter("@CFrequency", SqlDbType.SmallInt),
                new SqlParameter("@CreateBy", SqlDbType.VarChar),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar),
                //new SqlParameter("@Remark", SqlDbType.NVarChar, 20)
            };

            parms[0].Value = entity.WarehouseId;
            parms[1].Value = entity.CWhCode;
            parms[2].Value = entity.CWhName;
            parms[3].Value = entity.IWHProperty;
            parms[4].Value = entity.CDepCode;
            parms[5].Value = entity.CWhAddress;
            parms[6].Value = entity.CcWhPhone;
            parms[7].Value = entity.CWhPerson;
            parms[8].Value = entity.BWhPos;
            parms[9].Value = entity.CWhMemo;
            parms[10].Value = entity.BFreeze;
            parms[11].Value = entity.CBarCode;
            parms[12].Value = entity.CycleCount;
            parms[13].Value = entity.CFrequency;
            parms[14].Value = entity.CreateBy;
            parms[15].Value = entity.ModifyBy;
            //parms[16].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Warehouse_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 WarehouseId 字符串删除 Warehouse 信息。
        /// </summary>
        /// <param name="idString">WarehouseId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Warehouse_Delete", parms);
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Warehouse 实体对象。</returns>
        public WarehouseInfo GetInfo(Int32 fieldValue)
        {
            WarehouseInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue",SqlDbType.Int)
            };

            parms[0].Value = fieldValue;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Warehouse_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetBoolean(8), rdr.GetString(9),
                        rdr.GetBoolean(10), rdr.GetString(11), rdr.GetInt16(12), rdr.GetInt16(13), rdr.GetString(14),
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetDateTime(17), rdr.GetString(18));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Warehouse 实体对象。</returns>
        public WarehouseInfo GetInfo(String fieldValue)
        {
            WarehouseInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Warehouse_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetBoolean(8), rdr.GetString(9),
                        rdr.GetBoolean(10), rdr.GetString(11), rdr.GetInt16(12), rdr.GetInt16(13), rdr.GetString(14),
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetDateTime(17), rdr.GetString(18));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Warehouse 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warehouseCount">warehouse 总数。</param>
        /// <returns>Warehouse 列表。</returns>
        public List<WarehouseInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseInfo> list = new List<WarehouseInfo>();
            WarehouseInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_Warehouse", "WarehouseID",////Basal_Warehouse
                "[WarehouseId], [CWhCode], [CWhName], [IWHProperty], [CDepCode], [CWhAddress], [CcWhPhone], [CWhPerson], [BWhPos], [CWhMemo], [BFreeze], [CBarCode], [CycleCount], [CFrequency], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarehouseInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetBoolean(8), rdr.GetString(9),
                        rdr.GetBoolean(10), rdr.GetString(11), rdr.GetInt16(12), rdr.GetInt16(13), rdr.GetString(14),
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetDateTime(17), rdr.GetString(18));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        #region 保存数据到数据库
        /// <summary>
        /// 保存数据到数据库
        /// </summary>
        /// <param name="dt"></param>
        public List<WarehouseLocationInfo> checkExoportWareLocation(DataTable dt)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@WareLocationList",SqlDbType.Structured)
            };
            parms[0].Value = dt;
            return ComMethod.GetList<WarehouseLocationInfo>("uspCheckImportWareLoction", parms);
        }
        #endregion

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        public IList<WarehouseInfo> GetWarehouseInfo()
        {
            IList<WarehouseInfo> list = new List<WarehouseInfo>();
            SqlParameter[] parms = null;
            using (DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, "SELECT WarehouseId AS Id,CWhName AS Name FROM dbo.Basal_Warehouse", parms))
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    WarehouseInfo entity = new WarehouseInfo();
                    entity.CWhCode = dt.Rows[i]["Id"].ToString();
                    entity.CWhName = dt.Rows[i]["Name"].ToString();
                    list.Add(entity);
                }
            }
            return list;
        }

    }
}