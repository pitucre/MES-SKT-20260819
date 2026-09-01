using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SteelMesh.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SteelMesh.BLL
{
    public class SteelMesh
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SteelMesh 信息。
        /// </summary>
        /// <param name="entity">SteelMesh 实体对象。</param>
        public Int32 Edit(SteelMeshInfo entity, String enterFactory)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SteelId", SqlDbType.Int),
                new SqlParameter("@SteelName", SqlDbType.NVarChar, 50),
                new SqlParameter("@SteelCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@Position", SqlDbType.NVarChar, 50),

                new SqlParameter("@CodeType", SqlDbType.Int),
                new SqlParameter("@Thick", SqlDbType.Decimal),
                new SqlParameter("@Vendor", SqlDbType.Int),
                new SqlParameter("@EnterFactory", SqlDbType.DateTime),
                new SqlParameter("@VendorBarcode", SqlDbType.NVarChar,50),
                //new SqlParameter("@UseCount", SqlDbType.Int),

                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),

                //new SqlParameter("@OutPeople", SqlDbType.Int),
                //new SqlParameter("@InPeople", SqlDbType.Int),
                new SqlParameter("@StandarLive", SqlDbType.Int),
                new SqlParameter("@WarningTime", SqlDbType.Int)
            };

            parms[0].Value = entity.SteelId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.SteelName;
            parms[2].Value = entity.SteelCode;
            parms[3].Value = entity.Position;

            parms[4].Value = entity.CodeType;

            parms[5].Precision = 18;
            parms[5].Scale = 2;
            parms[5].Value = entity.Thick;

            parms[6].Value = entity.Vendor;
            parms[7].Value = enterFactory;
            parms[8].Value = entity.VendorBarcode;
            //parms[9].Value = entity.UseCount;

            parms[9].Value = entity.CreateBy;
            parms[10].Value = entity.ModifyBy;
            parms[11].Value = entity.Remark;

            //parms[13].Value = entity.OutPeople;
            //parms[14].Value = entity.InPeople;
            parms[12].Value = entity.StandarLive;
            parms[13].Value = entity.WarningTime;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SteelMesh_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SteelMeshId 字符串删除 SteelMesh 信息。
        /// </summary>
        /// <param name="idString">SteelMeshId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Equipment_Delete", parms);
        }
        /// <summary>
        /// 根据 SteelMeshId 字符串删除 SteelMesh 信息。
        /// </summary>
        /// <param name="idString">SteelMeshId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void DeleteNew(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Equipment_DeleteNew", parms);
        }

        /// <summary>
        /// 根据 SteelMeshId 获取实体信息。 
        /// </summary>
        /// <param name="steelMeshId">SteelMeshId。</param>
        /// <returns>SteelMesh 实体对象。</returns>
        public SteelMeshInfo GetInfo(Int32 steelMeshId)
        {
            SteelMeshInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = steelMeshId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SteelMesh_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SteelMeshInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetDecimal(5), rdr.GetInt32(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetInt32(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12),
                        rdr.GetDateTime(13), rdr.GetString(14), rdr.GetInt32(15));

                    entity.CurPosition = rdr.GetValue(16).ToString();
                    entity.SteelStatus = rdr.GetInt32(17);
                    entity.InOrOut = rdr.GetInt32(18);
                    entity.WarningTime = rdr.GetInt32(19);

                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SteelMesh 实体对象。</returns>
        public SteelMeshInfo GetInfo(String fieldValue)
        {
            SteelMeshInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SteelMesh_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SteelMeshInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetDecimal(5), rdr.GetInt32(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetInt32(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12),
                        rdr.GetDateTime(13), rdr.GetString(14), rdr.GetInt32(15));

                    entity.CurPosition = rdr.GetValue(16).ToString();
                    entity.SteelStatus = rdr.GetInt32(17);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SteelMesh 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="steelMeshCount">steelMesh 总数。</param>
        /// <returns>SteelMesh 列表。</returns>
        public List<SteelMeshInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SteelMeshInfo> list = new List<SteelMeshInfo>();
            SteelMeshInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetSteelMesh", "SteelId",
                "[SteelId], [SteelName], [SteelCode], [Position], [CodeType],[Thick],[Vendor],[EnterFactory],[VendorBarcode],[UseCount], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyTime], [Remark],[VendorName],StandarLive,CurPosition, SteelStatus", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SteelMeshInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetDecimal(5), rdr.GetInt32(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetInt32(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12),
                        rdr.GetDateTime(13), rdr.GetString(14));
                    entity.VendorName = rdr.GetString(15);
                    entity.StandarLive = rdr.GetInt32(16);
                    entity.CurPosition = rdr.GetValue(17).ToString();
                    entity.SteelStatus = rdr.GetInt32(18);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 分页获取 SteelMesh 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="steelMeshCount">steelMesh 总数。</param>
        /// <returns>SteelMesh 列表。</returns>
        public List<SteelMeshInfo> GetSteelAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SteelMeshInfo> list = new List<SteelMeshInfo>();
            SteelMeshInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "dbo.Basal_SteelMesh", "SteelId",
                "[SteelId], [SteelName], [SteelCode], [Position], [CodeType],[Thick],[Vendor],[EnterFactory],[VendorBarcode],[UseCount], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SteelMeshInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetDecimal(5), rdr.GetInt32(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetInt32(9), rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12),
                        rdr.GetDateTime(13), rdr.GetString(14));


                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 钢网列表导出EXCEL获取数据的方法
        /// </summary>
        /// <param name="strWhere">查询条件</param>
        /// <returns></returns>
        public DataTable ImportToExcel(String steelName, String steelCode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@steelName", SqlDbType.NVarChar,50),
                new SqlParameter("@steelCode", SqlDbType.NVarChar,50)
            };
            parms[0].Value = steelName;
            parms[1].Value = steelCode;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Basal_SteelImportToExcel", parms);
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        /// <summary>
        /// 钢网报废
        /// </summary>
        /// <returns>日志内容。</returns>
        public void Scrap(String steelId, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SteelId", SqlDbType.VarChar, 300),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = steelId;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspScrapSteelMesh", parms);
        }

        /// <summary>
        /// 取消报废
        /// </summary>
        /// <returns>日志内容。</returns>
        public void CancelScrap(String equipmentId, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentId", SqlDbType.VarChar, 300),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = equipmentId;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCancelScrapEquipment", parms);
        }
        /// <summary>
        /// 钢网报废
        /// </summary>
        /// <returns>日志内容。</returns>
        public void ScrapNew(String steelId, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SteelId", SqlDbType.VarChar, 300),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = steelId;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspScrapSteelMeshNew", parms);
        }

        public List<SteelConfigInfo> GetSteelConfig(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SteelConfigInfo> list = new List<SteelConfigInfo>();
            SteelConfigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vw_SteelConfig", "SteelConfigId",
                "SteelConfigCode, SteelConfig, Result, IsGlobal, Remark,ModifyBy,ModifyDate", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SteelConfigInfo(rdr.GetString(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4));
                    entity.ModifyBy = rdr.GetString(5);
                    entity.ModifyDate = rdr.GetDateTime(6);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
    }
}