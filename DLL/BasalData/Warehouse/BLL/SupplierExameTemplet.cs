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
    public class SupplierExameTemplet
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） WarehouseType 信息。
        /// </summary>
        /// <param name="entity">WarehouseType 实体对象。</param>
        public Int32 Edit(SupplierExameTempletInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SupplierExameTempletID", SqlDbType.Int),
                new SqlParameter("@SupplierExameTempletCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@SupplierExameTempletName", SqlDbType.VarChar, 100),
                new SqlParameter("@IsEnable", SqlDbType.Bit),
                new SqlParameter("@Description", SqlDbType.VarChar, 100),
                new SqlParameter("@CreateBy", SqlDbType.VarChar),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar)
            };

            parms[0].Value = entity.SupplierExameTempletID;
            parms[1].Value = entity.SupplierExameTempletCode;
            parms[2].Value = entity.SupplierExameTempletName;
            parms[3].Value = entity.IsEnable;
            parms[4].Value = entity.Description;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SupplierExameTemplet_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SupplierExameTypeId 字符串删除 信息。
        /// </summary>
        /// <param name="idString">SupplierExameTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SupplierExameTemplet_Delete", parms);
        }

        /// <summary>
        /// 根据 SupplierExameTypeId 获取实体信息。
        /// </summary>
        /// <param name="warehouseTypeId">SupplierExameTypeId。</param>
        /// <returns>SupplierExameType 实体对象。</returns>
        public SupplierExameTempletInfo GetInfo(Int32 supplierExameTempletID)
        {
            SupplierExameTempletInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = supplierExameTempletID;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SupplierExameTemplet_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SupplierExameTempletInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2),rdr.GetString(3),rdr.GetString(4),rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7),
                        rdr.GetDateTime(8),rdr.GetString(9));
                    entity.IsAllSupplier = rdr.GetInt32(10);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>WarehouseType 实体对象。</returns>
        public SupplierExameTempletInfo GetInfo(String fieldValue)
        {
            SupplierExameTempletInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SupplierExameTemplet_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SupplierExameTempletInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7),
                        rdr.GetDateTime(8), rdr.GetString(9));
                    entity.IsAllSupplier = rdr.GetInt32(10);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 WarehouseType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warehouseTypeCount">warehouseType 总数。</param>
        /// <returns>WarehouseType 列表。</returns>
        public List<SupplierExameTempletInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierExameTempletInfo> list = new List<SupplierExameTempletInfo>();
            SupplierExameTempletInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_SupplierExameTemplet", "SupplierExameTempletID",
                "[SupplierExameTempletID], [SupplierExameTempletCode], [SupplierExameTempletName],[IsEnable],[Description], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime],SupplierExameTempletType, IsAllSupplier", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SupplierExameTempletInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7),
                        rdr.GetDateTime(8), rdr.GetString(9));
                    entity.IsAllSupplier = rdr.GetInt32(10);
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

        public void SaveExameTemplet(SupplierExameTempletInfo Info, DataTable TempletDtls, DataTable TempletVendors)//List<SupplierExameTempletDtlInfo> TempletDtls , List<SupplierExameTempletVendorInfo> TempletVendors)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SupplierExameTempletID", SqlDbType.Int),
                new SqlParameter("@SupplierExameTempletCode", SqlDbType.VarChar,50),
                new SqlParameter("@SupplierExameTempletName", SqlDbType.VarChar,100),
                new SqlParameter("@SupplierExameTempletType", SqlDbType.VarChar,10),
                new SqlParameter("@IsAllSupplier", SqlDbType.Int),
                new SqlParameter("@IsEnable", SqlDbType.VarChar,10),
                new SqlParameter("@Description", SqlDbType.VarChar,50),
                new SqlParameter("@UserName", SqlDbType.VarChar,20),
                new SqlParameter("@SupplierExameTempletDtl", SqlDbType.Structured),
                new SqlParameter("@ExameTempletVendor", SqlDbType.Structured)
            };
            parms[0].Value = Info.SupplierExameTempletID;
            parms[1].Value = Info.SupplierExameTempletCode;
            parms[2].Value = Info.SupplierExameTempletName;
            parms[3].Value = Info.SupplierExameTempletType;
            parms[4].Value = Info.IsAllSupplier;
            parms[5].Value = Info.IsEnable;
            parms[6].Value = Info.Description;
            parms[7].Value = Info.CreateBy;
            parms[8].Value = TempletDtls; //(from q in TempletDtls select new { q.SupplierExameTempletID, q.SupplierExameContentId , q.SupplierExameName , q.SupplierExameType, q.SupplierExameCompute, q.AssessmentWeight}).
            parms[9].Value = TempletVendors;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveExameTemplet", parms);
        }

        public List<SupplierExameTempletDtlInfo> GetTemplateDtlById(int TemplaterId)
        {
            List<SupplierExameTempletDtlInfo> list = new List<SupplierExameTempletDtlInfo>();
            SupplierExameTempletDtlInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@TemplaterId", SqlDbType.Int)
            };
            parms[0].Value = TemplaterId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SupplierExameTempletDtl_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new SupplierExameTempletDtlInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetDecimal(5), rdr.GetInt32(6));
                    list.Add(entity);
                }
                rdr.Close();
            }            
            return list;
        }

        public List<SupplierExameTempletVendorInfo> GetTemplateVendorById(int TemplaterId)
        {
            List<SupplierExameTempletVendorInfo> list = new List<SupplierExameTempletVendorInfo>();
            SupplierExameTempletVendorInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@TemplaterId", SqlDbType.Int)
            };
            parms[0].Value = TemplaterId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SupplierExameTempletVendorInfo_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new SupplierExameTempletVendorInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetString(4));
                    list.Add(entity);
                }
                rdr.Close();
            }            
            return list;
        }
    }
}
