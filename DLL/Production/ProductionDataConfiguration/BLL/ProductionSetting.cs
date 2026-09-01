using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.ProductionDataConfiguration.Model;

namespace SKT.LeanMES.ProductionDataConfiguration.BLL
{
    public class ProductionSetting
    {
        private Int32 recordCount = 0;


        public void Edit(ProductionSettingInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@ConfigTypeId", SqlDbType.Int),
                new SqlParameter("@ConfigType", SqlDbType.VarChar, 50),
                new SqlParameter("@ConfigResult", SqlDbType.NVarChar,-1),
                new SqlParameter("@ConfigDesc", SqlDbType.VarChar, 50),
                new SqlParameter("@IsGlobal", SqlDbType.Bit),
                new SqlParameter("@Remark", SqlDbType.VarChar, 200)
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.ConfigTypeId;
            parms[2].Value = entity.ConfigType;
            parms[3].Value = entity.ConfigResult;
            parms[4].Value = entity.ConfigDesc;
            parms[5].Value = entity.IsGlobal;
            parms[6].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ProductionSetting_Edit", parms);

        }

        /// <summary>
        /// 根据 ProductionSettingId 字符串删除 ProductionSetting 信息。
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

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ProductionSetting_Delete", parms);
        }

        /// <summary>
        /// 分页获取ProductionSetting资料
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ProductionSettingInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ProductionSettingInfo> list = new List<ProductionSettingInfo>();
            ProductionSettingInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_ProductionSetting", "ID",
                "[ID], [ConfigTypeId], [ConfigType], [ConfigResult], [ConfigDesc], [IsGlobal], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProductionSettingInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetBoolean(5), rdr.GetString(6));

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

        /// <summary>
        /// 根据ID获取实体信息
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public ProductionSettingInfo GetInfo(int ID)
        {
            ProductionSettingInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter ("@FieldValue",SqlDbType.NVarChar,50),
                new SqlParameter ("@IsByID",SqlDbType.Bit)
            };
            parms[0].Value = ID;
            parms[1].Value = true;

            using (SqlDataReader dr=SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ProductionSetting_GetInfo", parms))
            {
                if (dr.Read())
                {
                    entity = new ProductionSettingInfo(dr.GetInt32(0), dr.GetInt32(1), dr.GetString(2), dr.GetString(3),
                        dr.GetString(4), dr.GetBoolean(5), dr.GetString(6));
                }
                dr.Close(); 
            }
            return entity;
        }
        /// <summary>
        /// 根据 字段值 获取实体信息
        /// </summary>
        /// <param name="fieldValue"></param>
        /// <returns></returns>
        public ProductionSettingInfo GetInfo(String fieldValue)
        {
            ProductionSettingInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter ("@FieldValue",SqlDbType.NVarChar,50),
                new SqlParameter ("@IsByID",SqlDbType.Bit)
            };
            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ProductionSetting_GetInfo", parms))
            {
                if (dr.Read())
                {
                    entity = new ProductionSettingInfo(dr.GetInt32(0), dr.GetInt32(1), dr.GetString(2), dr.GetString(3),
                        dr.GetString(4), dr.GetBoolean(5), dr.GetString(6));
                }
                dr.Close();
            }
            return entity;
        }
    }
}
