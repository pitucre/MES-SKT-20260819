using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Accessories.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Accessories.BLL
{
    public class AccessoryPart
    {

        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） AccessoryPart 信息。
        /// </summary>
        /// <param name="entity">AccessoryPart 实体对象。</param>
        public Int32 Edit(AccessoryPartInfo entity)
        {
            int retvalue = -1;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@ItemName", SqlDbType.NVarChar, 50),
                new SqlParameter("@LeedFree", SqlDbType.Int),
                new SqlParameter("@SupplierId", SqlDbType.Int),
                new SqlParameter("@FactoryTime", SqlDbType.VarChar,30),
                new SqlParameter("@BatchNO", SqlDbType.NVarChar,50),
                new SqlParameter("@Weight", SqlDbType.Decimal),
                new SqlParameter("@Spec", SqlDbType.NVarChar,50),
                new SqlParameter("@CreateBy", SqlDbType.Int),
                
                new SqlParameter("@returnValue", SqlDbType.Int)

            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.ItemName;
            parms[2].Value = entity.LeedFree;
            parms[3].Value = entity.SupplierId;
            parms[4].Value = entity.FactoryTime;
            parms[5].Value = entity.BatchNO;
            parms[6].Value = entity.Weight;
            parms[7].Value = entity.Spec;
            parms[8].Value = entity.CreateBy;
            parms[9].Direction = ParameterDirection.Output;


            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SOLDER_PARTEdit", parms);
            retvalue = 0;
            retvalue = Convert.ToInt32(parms[9].Value);
            return retvalue;
        }

        /// <summary>
        /// 根据 PARTId 字符串删除 PART 信息。
        /// </summary>
        /// <param name="idString">PARTId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SOLDER_PARTDelete", parms);
        }

        /// <summary>
        /// 根据 PARTId 获取实体信息。
        /// </summary>
        /// <param name="pARTId">PARTId。</param>
        /// <returns>PART 实体对象。</returns>
        public AccessoryPartInfo GetInfo(Int32 pARTId)
        {
            AccessoryPartInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = pARTId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SOLDER_PARTGetInfo", parms))
            {
                if (rdr.Read())
                {
                    //entity = new AccessoryPartInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), 
                    //                               rdr.GetDateTime(3), rdr.GetInt32(4),
                    //                               rdr.GetString(5), rdr.GetString(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PART 实体对象。</returns>
        public AccessoryPartInfo GetInfo(String fieldValue)
        {
            AccessoryPartInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SOLDER_PARTGetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 PART 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="pARTCount">pART 总数。</param>
        /// <returns>PART 列表。</returns>
        public List<AccessoryPartInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AccessoryPartInfo> list = new List<AccessoryPartInfo>();
            AccessoryPartInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSOLDER_PART", "ID",
                "[ID], [ItemName], [LeedFree], [CreateDateTime], [CreateBy],[UserName],SupplierId, SupplierCode, FactoryTime, BatchNO, Weight, Spec", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AccessoryPartInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetDateTime(3), rdr.GetInt32(4),
                        rdr.GetString(5));

                    entity.SupplierId = rdr.GetInt32(6);
                    entity.SupplierCode = rdr.GetString(7);
                    entity.FactoryTime = SKT.Common.Utility.TypeHelper.ToString(rdr.GetDateTime(8));
                    entity.BatchNO = rdr.GetString(9);
                    entity.Weight = rdr.GetDecimal(10);
                    entity.Spec = rdr.GetString(11);

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
