using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Sparepart.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Sparepart.BLL
{
    public class Sparepart
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Parts 信息。
        /// </summary>
        /// <param name="entity">Parts 实体对象。</param>
        public Int32 Edit(SparepartInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PartId", SqlDbType.Int),
                new SqlParameter("@PartName", SqlDbType.NVarChar, 100),
                new SqlParameter("@PartNickName", SqlDbType.NVarChar, 100),
                new SqlParameter("@PartCategory", SqlDbType.NVarChar, 100),
                new SqlParameter("@PartStandard", SqlDbType.NVarChar, 100),
                new SqlParameter("@VenName", SqlDbType.NVarChar, 50),
                new SqlParameter("@SupplierName", SqlDbType.NVarChar, 50),
                new SqlParameter("@PartLocation", SqlDbType.NVarChar, 50),
                new SqlParameter("@PartQty", SqlDbType.Decimal),
                new SqlParameter("@PartUnit", SqlDbType.NVarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@FactoryDate", SqlDbType.DateTime),
                new SqlParameter("@ProduceDate", SqlDbType.DateTime),
                new SqlParameter("@ServiceLife", SqlDbType.DateTime)
            };

            parms[0].Value = entity.PartId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.PartName;
            parms[2].Value = entity.PartNickName;
            parms[3].Value = entity.PartCategory;
            parms[4].Value = entity.PartStandard;
            parms[5].Value = entity.VenName;
            parms[6].Value = entity.SupplierName;
            parms[7].Value = entity.PartLocation;
            parms[8].Value = entity.PartQty;
            parms[9].Value = entity.PartUnit;
            parms[10].Value = entity.CreateBy;
            parms[11].Value = entity.ModifyBy;
            parms[12].Value = entity.Remark;
            parms[13].Value = entity.FactoryDate.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?
                    "9999-12-31 00:00:00" : entity.FactoryDate.ToString("yyyy-MM-dd hh:mm:ss");
            parms[14].Value = entity.ProduceDate.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?
                    "9999-12-31 00:00:00" : entity.ProduceDate.ToString("yyyy-MM-dd hh:mm:ss");
            parms[15].Value = entity.ServiceLife.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?
                    "9999-12-31 00:00:00" : entity.ServiceLife.ToString("yyyy-MM-dd hh:mm:ss");
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Parts_Edit", parms);

            return (Int32)parms[0].Value;
        }
        /// <summary>
        /// 复制新增编辑（添加或更新） Parts 信息。
        /// </summary>
        /// <param name="entity">Parts 实体对象。</param>
        public Int32 CopyEdit(SparepartInfo entity, int oldID)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PartId", SqlDbType.Int),
                new SqlParameter("@PartName", SqlDbType.NVarChar, 100),
                new SqlParameter("@PartNickName", SqlDbType.NVarChar, 100),
                new SqlParameter("@PartCategory", SqlDbType.NVarChar, 100),
                new SqlParameter("@PartStandard", SqlDbType.NVarChar, 100),
                new SqlParameter("@VenName", SqlDbType.NVarChar, 50),
                new SqlParameter("@SupplierName", SqlDbType.NVarChar, 50),
                new SqlParameter("@PartLocation", SqlDbType.NVarChar, 50),
                new SqlParameter("@PartQty", SqlDbType.Decimal),
                new SqlParameter("@PartUnit", SqlDbType.NVarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@FactoryDate", SqlDbType.DateTime),
                new SqlParameter("@ProduceDate", SqlDbType.DateTime),
                new SqlParameter("@ServiceLife", SqlDbType.DateTime),
                new SqlParameter("@oldID", SqlDbType.Int)
            };

            parms[0].Value = entity.PartId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.PartName;
            parms[2].Value = entity.PartNickName;
            parms[3].Value = entity.PartCategory;
            parms[4].Value = entity.PartStandard;
            parms[5].Value = entity.VenName;
            parms[6].Value = entity.SupplierName;
            parms[7].Value = entity.PartLocation;
            parms[8].Value = entity.PartQty;
            parms[9].Value = entity.PartUnit;
            parms[10].Value = entity.CreateBy;
            parms[11].Value = entity.ModifyBy;
            parms[12].Value = entity.Remark;
            parms[13].Value = entity.FactoryDate.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?
                    "9999-12-31 00:00:00" : entity.FactoryDate.ToString("yyyy-MM-dd hh:mm:ss");
            parms[14].Value = entity.ProduceDate.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?
                    "9999-12-31 00:00:00" : entity.ProduceDate.ToString("yyyy-MM-dd hh:mm:ss");
            parms[15].Value = entity.ServiceLife.ToString("yyyy-MM-dd hh:mm:ss") == "0001-01-01 12:00:00" ?
                    "9999-12-31 00:00:00" : entity.ServiceLife.ToString("yyyy-MM-dd hh:mm:ss");
            parms[16].Value = oldID;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Parts_CopyEdit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PartsId 字符串删除 Parts 信息。
        /// </summary>
        /// <param name="idString">PartsId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Parts_Delete", parms);
        }

        /// <summary>
        /// 工具报废
        /// </summary>
        /// <param name="idString">PartsId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void EditPartScrap(SparepartInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.Int),
                new SqlParameter("@ScrapQty", SqlDbType.Int),
                new SqlParameter("@ScrapRemark", SqlDbType.VarChar,1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.PartId;
            parms[1].Value = entity.ScrapQty;
            parms[2].Value = entity.ScrapRemark;
            parms[3].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Parts_EditPartScrap", parms);
        }

        /// <summary>
        /// 根据 PartsId 获取实体信息。
        /// </summary>
        /// <param name="partsId">PartsId。</param>
        /// <returns>Parts 实体对象。</returns>
        public SparepartInfo GetInfo(Int32 partsId)
        {
            SparepartInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = partsId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Parts_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SparepartInfo();
                    entity.PartId = Convert.ToInt32(rdr["PartId"]);
                    entity.PartName = Convert.ToString(rdr["PartName"]);
                    entity.PartNickName = Convert.ToString(rdr["PartNickName"]);
                    entity.PartNO = Convert.ToString(rdr["PartNO"]);

                    entity.PartCategory = Convert.ToString(rdr["PartCategory"]);
                    entity.PartMachine = Convert.ToString(rdr["PartMachine"]);
                    entity.PartLocation = Convert.ToString(rdr["partLocation"]);
                    entity.PartBrand = Convert.ToString(rdr["partBrand"]);
                    entity.PartStandard = Convert.ToString(rdr["partStandard"]);
                    entity.PartSafeQty = Convert.ToInt32(rdr["partSafeQty"]);
                    entity.PartQty = Convert.ToInt32(rdr["partQty"]);
                    entity.PartUnit = Convert.ToString(rdr["partUnit"]);
                    entity.CreateBy = Convert.ToString(rdr["createBy"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["createDateTime"]);

                    entity.ModifyDateTime = Convert.ToDateTime(rdr["modifyDateTime"]);
                    entity.ModifyBy = Convert.ToString(rdr["modifyBy"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);

                    entity.VenName = Convert.ToString(rdr["VenName"]);
                    entity.SupplierName = Convert.ToString(rdr["SupplierName"]);
                    entity.FactoryDate = Convert.ToDateTime(rdr["FactoryDate"]);
                    entity.ProduceDate = Convert.ToDateTime(rdr["ProduceDate"]);
                    entity.ServiceLife = Convert.ToDateTime(rdr["ServiceLife"]);
                    entity.OnLineQty = Convert.ToInt32(rdr["OnLineQty"]);
                    entity.ScrapQty = Convert.ToInt32(rdr["ScrapQty"]);
                    entity.InStockQty = Convert.ToInt32(rdr["InStockQty"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Parts 实体对象。</returns>
        public SparepartInfo GetInfo(String fieldValue)
        {
            SparepartInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Parts_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SparepartInfo();

                    entity.PartId = Convert.ToInt32(rdr["PartId"]);
                    entity.PartName = Convert.ToString(rdr["PartName"]);
                    entity.PartNickName = Convert.ToString(rdr["PartNickName"]);
                    entity.PartNO = Convert.ToString(rdr["PartNO"]);

                    entity.PartCategory = Convert.ToString(rdr["PartCategory"]);
                    entity.PartMachine = Convert.ToString(rdr["PartMachine"]);
                    entity.PartLocation = Convert.ToString(rdr["partLocation"]);
                    entity.PartBrand = Convert.ToString(rdr["partBrand"]);

                    entity.PartStandard = Convert.ToString(rdr["partStandard"]);
                    entity.PartSafeQty = Convert.ToInt32(rdr["partSafeQty"]);
                    entity.PartQty = Convert.ToInt32(rdr["partQty"]);
                    entity.PartUnit = Convert.ToString(rdr["partUnit"]);

                    entity.CreateBy = Convert.ToString(rdr["createBy"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["createDateTime"]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr["modifyDateTime"]);
                    entity.ModifyBy = Convert.ToString(rdr["modifyBy"]);

                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.VenName = Convert.ToString(rdr["VenName"]);
                    entity.SupplierName = Convert.ToString(rdr["SupplierName"]);
                    entity.FactoryDate = Convert.ToDateTime(rdr["FactoryDate"]);
                    entity.ProduceDate = Convert.ToDateTime(rdr["ProduceDate"]);
                    entity.OnLineQty = Convert.ToInt32(rdr["OnLineQty"]);
                    entity.ScrapQty = Convert.ToInt32(rdr["ScrapQty"]);
                    entity.InStockQty = Convert.ToInt32(rdr["InStockQty"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Parts 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="partsCount">parts 总数。</param>
        /// <returns>Parts 列表。</returns>
        public List<SparepartInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SparepartInfo> list = new List<SparepartInfo>();
            SparepartInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProd_Parts", "PartId",
                "[PartId], [PartName], [PartNickName], [PartNO], [PartCategory], [PartMachine], [PartLocation], [PartBrand], [PartStandard], [PartParam], [PartSafeQty], [PartQty], [PartUnit], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],VenName,SupplierName,ServiceLife,OnLineQty,ScrapQty,InStockQty", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SparepartInfo();
                    entity.PartId = Convert.ToInt32(rdr["PartId"]);
                    entity.PartName = Convert.ToString(rdr["PartName"]);
                    entity.PartNickName = Convert.ToString(rdr["PartNickName"]);
                    entity.PartNO = Convert.ToString(rdr["PartNO"]);

                    entity.PartCategory = Convert.ToString(rdr["PartCategory"]);
                    entity.PartMachine = Convert.ToString(rdr["PartMachine"]);
                    entity.PartLocation = Convert.ToString(rdr["partLocation"]);
                    entity.PartBrand = Convert.ToString(rdr["partBrand"]);

                    entity.PartStandard = Convert.ToString(rdr["partStandard"]);
                    entity.PartSafeQty = Convert.ToInt32(rdr["partSafeQty"]);
                    entity.PartQty = Convert.ToInt32(rdr["partQty"]);
                    entity.OnLineQty = Convert.ToInt32(rdr["OnLineQty"]);
                    entity.ScrapQty = Convert.ToInt32(rdr["ScrapQty"]);
                    entity.InStockQty = Convert.ToInt32(rdr["InStockQty"]);
                    entity.PartUnit = Convert.ToString(rdr["partUnit"]);

                    entity.CreateBy = Convert.ToString(rdr["createBy"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["createDateTime"]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr["modifyDateTime"]);
                    entity.ModifyBy = Convert.ToString(rdr["modifyBy"]);
                    entity.ServiceLife = Convert.ToDateTime(rdr["ServiceLife"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.VenName = Convert.ToString(rdr["VenName"]);
                    entity.SupplierName = Convert.ToString(rdr["SupplierName"]);

                    //rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                    //    rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                    //    rdr.GetDecimal(10), rdr.GetInt32(11), rdr.GetString(12), rdr.GetString(13), rdr.GetDateTime(14),
                    //    rdr.GetString(15), rdr.GetDateTime(16), rdr.GetString(17));

                    //entity.VenName = rdr.GetString(18);
                    //entity.SupplierName = rdr.GetString(19);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 备件清单导出EXCEL获取数据的方法
        /// </summary>
        /// <param name="strWhere">查询条件</param>
        /// <returns></returns>
        public DataTable ImportToExcel(String toolName, String toolCode, string category, string suppllier, string location)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ToolName", SqlDbType.NVarChar,50),
                new SqlParameter("@ToolCode", SqlDbType.NVarChar,50),
                new SqlParameter("@Category", SqlDbType.NVarChar,50),
                new SqlParameter("@Suppllier", SqlDbType.NVarChar,50),
                new SqlParameter("@Location", SqlDbType.NVarChar,50)
            };
            parms[0].Value = toolName;
            parms[1].Value = toolCode;
            parms[2].Value = category;
            parms[3].Value = suppllier;
            parms[4].Value = location;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspSparepartToEXCEL", parms);
        }
        /// <summary>
        /// 分页获取 EquipmentItemRelation 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="equipmentItemRelationCount">equipmentItemRelation 总数。</param>
        /// <returns>EquipmentItemRelation 列表。</returns>
        public List<PartsItemRelationInfo> GetPartsItemRelation(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PartsItemRelationInfo> list = new List<PartsItemRelationInfo>();
            PartsItemRelationInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSparePartsItemRelation", "EquipmentItemRelationId",
                "[EquipmentItemRelationId], [ItemCode], [EqCode], [CreateBy], [CreateDateTime],[PartName],[PartNickName],[PartCategory]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PartsItemRelationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4));
                    entity.PartName = rdr.GetString(5);
                    entity.PartNickName = rdr.GetString(6);
                    entity.PartCategory = rdr.GetString(7);
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