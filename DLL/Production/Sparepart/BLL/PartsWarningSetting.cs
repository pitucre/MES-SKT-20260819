using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Sparepart.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Sparepart.BLL
{
    public class PartsWarningSetting
    {
        /// <summary>
        /// 编辑（添加或更新） PartsWarningSetting 信息。
        /// </summary>
        /// <param name="entity">PartsWarningSetting 实体对象。</param>
        public Int32 Edit(PartsWarningSettingInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WSId", SqlDbType.Int),
                new SqlParameter("@WSIsWarning", SqlDbType.Bit),
                new SqlParameter("@WSWarningRate", SqlDbType.NVarChar, 20),
                new SqlParameter("@WSWarningTime", SqlDbType.NVarChar, 20),
                new SqlParameter("@WSWarningFirst", SqlDbType.NVarChar, 2000),
                new SqlParameter("@WSWarningSecond", SqlDbType.NVarChar, 2000),
                new SqlParameter("@WSWarningThird", SqlDbType.NVarChar, 2000),
                new SqlParameter("@WSIsInventory", SqlDbType.Bit),
                new SqlParameter("@WSInventoryRate", SqlDbType.NVarChar, 20),
                new SqlParameter("@WSInventoryTime", SqlDbType.NVarChar, 20),
                new SqlParameter("@WSInventoryFirst", SqlDbType.NVarChar, 2000),
                new SqlParameter("@WSInventorySecond", SqlDbType.NVarChar, 2000),
                new SqlParameter("@WSInventoryThird", SqlDbType.NVarChar, 2000),
                new SqlParameter("@WSText", SqlDbType.NVarChar, 2000)
            };

            parms[0].Value = entity.WSId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.WSIsWarning;
            parms[2].Value = entity.WSWarningRate;
            parms[3].Value = entity.WSWarningTime;
            parms[4].Value = entity.WSWarningFirst;
            parms[5].Value = entity.WSWarningSecond;
            parms[6].Value = entity.WSWarningThird;
            parms[7].Value = entity.WSIsInventory;
            parms[8].Value = entity.WSInventoryRate;
            parms[9].Value = entity.WSInventoryTime;
            parms[10].Value = entity.WSInventoryFirst;
            parms[11].Value = entity.WSInventorySecond;
            parms[12].Value = entity.WSInventoryThird;
            parms[13].Value = entity.WSText;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PartsWarningSetting_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PartsWarningSettingId 获取实体信息。
        /// </summary>
        /// <param name="partsWarningSettingId">PartsWarningSettingId。</param>
        /// <returns>PartsWarningSetting 实体对象。</returns>
        public PartsWarningSettingInfo GetInfo(Int32 partsWarningSettingId)
        {
            PartsWarningSettingInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = partsWarningSettingId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PartsWarningSetting_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PartsWarningSettingInfo(rdr.GetInt32(0), rdr.GetBoolean(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetBoolean(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13));
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// 查询预警数据
        /// </summary>
        /// <returns></returns>
        public PartsWarningSettingInfo GetOneRecord()
        {
            PartsWarningSettingInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { };

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSelectSetting", parms))
            {
                if (rdr.Read())
                {
                    entity = new PartsWarningSettingInfo(rdr.GetInt32(0), rdr.GetBoolean(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetBoolean(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PartsWarningSetting 实体对象。</returns>
        public PartsWarningSettingInfo GetInfo(String fieldValue)
        {
            PartsWarningSettingInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PartsWarningSetting_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PartsWarningSettingInfo(rdr.GetInt32(0), rdr.GetBoolean(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetBoolean(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13));
                }
                rdr.Close();
            }

            return entity;
        }
    }
}