using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Lookup.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Text;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Lookup.BLL
{
    public class Lookup
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Lookup 信息。
        /// </summary>
        /// <param name="entity">Lookup 实体对象。</param>
        public string Edit(LookupInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@TabaleName", SqlDbType.VarChar, 50),
                new SqlParameter("@Alpha1", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha2", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha3", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha4", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha5", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha6", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha7", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha8", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha9", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha10", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha11", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha12", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha13", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha14", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha15", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha16", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha17", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha18", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha19", SqlDbType.VarChar, 200),
                new SqlParameter("@Alpha20", SqlDbType.VarChar, 200),
                new SqlParameter("@AlphaM21", SqlDbType.VarChar),
                new SqlParameter("@AlphaM22", SqlDbType.VarChar),
                new SqlParameter("@AlphaM23", SqlDbType.VarChar),
                new SqlParameter("@AlphaM24", SqlDbType.VarChar),
                new SqlParameter("@AlphaM25", SqlDbType.VarChar),
                new SqlParameter("@AlphaM26", SqlDbType.VarChar),
                new SqlParameter("@AlphaM27", SqlDbType.VarChar),
                new SqlParameter("@AlphaM28", SqlDbType.VarChar),
                new SqlParameter("@AlphaM29", SqlDbType.VarChar),
                new SqlParameter("@AlphaM30", SqlDbType.VarChar),
                new SqlParameter("@AlphaM31", SqlDbType.VarChar),
                new SqlParameter("@AlphaM32", SqlDbType.VarChar),
                new SqlParameter("@AlphaM33", SqlDbType.VarChar),
                new SqlParameter("@AlphaM34", SqlDbType.VarChar),
                new SqlParameter("@AlphaM35", SqlDbType.VarChar),
                new SqlParameter("@AlphaM36", SqlDbType.VarChar),
                new SqlParameter("@AlphaM37", SqlDbType.VarChar),
                new SqlParameter("@AlphaM38", SqlDbType.VarChar),
                new SqlParameter("@AlphaM39", SqlDbType.VarChar),
                new SqlParameter("@AlphaM40", SqlDbType.VarChar),
                new SqlParameter("@Numeric1", SqlDbType.Decimal),
                new SqlParameter("@Numeric2", SqlDbType.Decimal),
                new SqlParameter("@Numeric3", SqlDbType.Decimal),
                new SqlParameter("@Numeric4", SqlDbType.Decimal),
                new SqlParameter("@Numeric5", SqlDbType.Decimal),
                new SqlParameter("@Numeric6", SqlDbType.Decimal),
                new SqlParameter("@Numeric7", SqlDbType.Decimal),
                new SqlParameter("@Numeric8", SqlDbType.Decimal),
                new SqlParameter("@Numeric9", SqlDbType.Decimal),
                new SqlParameter("@Numeric10", SqlDbType.Decimal),
                new SqlParameter("@Numeric11", SqlDbType.Decimal),
                new SqlParameter("@Numeric12", SqlDbType.Decimal),
                new SqlParameter("@Numeric13", SqlDbType.Decimal),
                new SqlParameter("@Numeric14", SqlDbType.Decimal),
                new SqlParameter("@Numeric15", SqlDbType.Decimal),
                new SqlParameter("@Numeric16", SqlDbType.Decimal),
                new SqlParameter("@Numeric17", SqlDbType.Decimal),
                new SqlParameter("@Numeric18", SqlDbType.Decimal),
                new SqlParameter("@Numeric19", SqlDbType.Decimal),
                new SqlParameter("@Numeric20", SqlDbType.Decimal),
                new SqlParameter("@Creator", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateDate", SqlDbType.DateTime),
                new SqlParameter("@Modifier", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyDate", SqlDbType.DateTime)
            };

            parms[0].Value = entity.Id;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.TabaleName;
            parms[2].Value = entity.Alpha1;
            parms[3].Value = entity.Alpha2;
            parms[4].Value = entity.Alpha3;
            parms[5].Value = entity.Alpha4;
            parms[6].Value = entity.Alpha5;
            parms[7].Value = entity.Alpha6;
            parms[8].Value = entity.Alpha7;
            parms[9].Value = entity.Alpha8;
            parms[10].Value = entity.Alpha9;
            parms[11].Value = entity.Alpha10;
            parms[12].Value = entity.Alpha11;
            parms[13].Value = entity.Alpha12;
            parms[14].Value = entity.Alpha13;
            parms[15].Value = entity.Alpha14;
            parms[16].Value = entity.Alpha15;
            parms[17].Value = entity.Alpha16;
            parms[18].Value = entity.Alpha17;
            parms[19].Value = entity.Alpha18;
            parms[20].Value = entity.Alpha19;
            parms[21].Value = entity.Alpha20;
            parms[22].Value = entity.AlphaM21;
            parms[23].Value = entity.AlphaM22;
            parms[24].Value = entity.AlphaM23;
            parms[25].Value = entity.AlphaM24;
            parms[26].Value = entity.AlphaM25;
            parms[27].Value = entity.AlphaM26;
            parms[28].Value = entity.AlphaM27;
            parms[29].Value = entity.AlphaM28;
            parms[30].Value = entity.AlphaM29;
            parms[31].Value = entity.AlphaM30;
            parms[32].Value = entity.AlphaM31;
            parms[33].Value = entity.AlphaM32;
            parms[34].Value = entity.AlphaM33;
            parms[35].Value = entity.AlphaM34;
            parms[36].Value = entity.AlphaM35;
            parms[37].Value = entity.AlphaM36;
            parms[38].Value = entity.AlphaM37;
            parms[39].Value = entity.AlphaM38;
            parms[40].Value = entity.AlphaM39;
            parms[41].Value = entity.AlphaM40;
            parms[42].Value = entity.Numeric1;
            parms[43].Value = entity.Numeric2;
            parms[44].Value = entity.Numeric3;
            parms[45].Value = entity.Numeric4;
            parms[46].Value = entity.Numeric5;
            parms[47].Value = entity.Numeric6;
            parms[48].Value = entity.Numeric7;
            parms[49].Value = entity.Numeric8;
            parms[50].Value = entity.Numeric9;
            parms[51].Value = entity.Numeric10;
            parms[52].Value = entity.Numeric11;
            parms[53].Value = entity.Numeric12;
            parms[54].Value = entity.Numeric13;
            parms[55].Value = entity.Numeric14;
            parms[56].Value = entity.Numeric15;
            parms[57].Value = entity.Numeric16;
            parms[58].Value = entity.Numeric17;
            parms[59].Value = entity.Numeric18;
            parms[60].Value = entity.Numeric19;
            parms[61].Value = entity.Numeric20;
            parms[62].Value = entity.Creator;
            parms[63].Value = entity.CreateDate;
            parms[64].Value = entity.Modifier;
            parms[65].Value = entity.ModifyDate;

            foreach (var parm in parms)
            {
                if (parm.Value == null)
                {
                    parm.Value = DBNull.Value;
                }
            }

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Lookup_Edit", parms);

            return parms[0].Value.ToString();
        }

        /// <summary>
        /// 根据 LookupId 字符串删除 Lookup 信息。
        /// </summary>
        /// <param name="idString">LookupId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Lookup_Delete", parms);
        }

        /// <summary>
        /// 根据 LookupId 获取实体信息。
        /// </summary>
        /// <param name="lookupId">LookupId。</param>
        /// <returns>Lookup 实体对象。</returns>
        public LookupInfo GetInfo(Int32 lookupId)
        {
            LookupInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = lookupId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Lookup_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = SetLookupinfoByDataReader(rdr);
                }
                rdr.Close();
            }

            return entity;
        }

        private LookupInfo SetLookupinfoByDataReader(SqlDataReader rdr)
        {
            LookupInfo entity = new LookupInfo(rdr.GetInt32(0), rdr.GetString(1));
            if (rdr.GetValue(2) != DBNull.Value)
            {
                entity.Alpha1 = rdr.GetString(2);
            }
            if (rdr.GetValue(3) != DBNull.Value)
            {
                entity.Alpha2 = rdr.GetString(3);
            }
            if (rdr.GetValue(4) != DBNull.Value)
            {
                entity.Alpha3 = rdr.GetString(4);
            }
            if (rdr.GetValue(5) != DBNull.Value)
            {
                entity.Alpha4 = rdr.GetString(5);
            }
            if (rdr.GetValue(6) != DBNull.Value)
            {
                entity.Alpha5 = rdr.GetString(6);
            }
            if (rdr.GetValue(7) != DBNull.Value)
            {
                entity.Alpha6 = rdr.GetString(7);
            }
            if (rdr.GetValue(8) != DBNull.Value)
            {
                entity.Alpha7 = rdr.GetString(8);
            }
            if (rdr.GetValue(9) != DBNull.Value)
            {
                entity.Alpha8 = rdr.GetString(9);
            }
            if (rdr.GetValue(10) != DBNull.Value)
            {
                entity.Alpha9 = rdr.GetString(10);
            }
            if (rdr.GetValue(11) != DBNull.Value)
            {
                entity.Alpha10 = rdr.GetString(11);
            }
            if (rdr.GetValue(12) != DBNull.Value)
            {
                entity.Alpha11 = rdr.GetString(12);
            }
            if (rdr.GetValue(13) != DBNull.Value)
            {
                entity.Alpha12 = rdr.GetString(13);
            }
            if (rdr.GetValue(14) != DBNull.Value)
            {
                entity.Alpha13 = rdr.GetString(14);
            }
            if (rdr.GetValue(15) != DBNull.Value)
            {
                entity.Alpha14 = rdr.GetString(15);
            }
            if (rdr.GetValue(16) != DBNull.Value)
            {
                entity.Alpha15 = rdr.GetString(16);
            }
            if (rdr.GetValue(17) != DBNull.Value)
            {
                entity.Alpha16 = rdr.GetString(17);
            }
            if (rdr.GetValue(18) != DBNull.Value)
            {
                entity.Alpha17 = rdr.GetString(18);
            }
            if (rdr.GetValue(19) != DBNull.Value)
            {
                entity.Alpha18 = rdr.GetString(19);
            }
            if (rdr.GetValue(20) != DBNull.Value)
            {
                entity.Alpha19 = rdr.GetString(20);
            }
            if (rdr.GetValue(21) != DBNull.Value)
            {
                entity.Alpha20 = rdr.GetString(21);
            }
            if (rdr.GetValue(22) != DBNull.Value)
            {
                entity.AlphaM21 = rdr.GetString(22);
            }
            if (rdr.GetValue(23) != DBNull.Value)
            {
                entity.AlphaM22 = rdr.GetString(23);
            }
            if (rdr.GetValue(24) != DBNull.Value)
            {
                entity.AlphaM23 = rdr.GetString(24);
            }
            if (rdr.GetValue(25) != DBNull.Value)
            {
                entity.AlphaM24 = rdr.GetString(25);
            }
            if (rdr.GetValue(26) != DBNull.Value)
            {
                entity.AlphaM25 = rdr.GetString(26);
            }
            if (rdr.GetValue(27) != DBNull.Value)
            {
                entity.AlphaM26 = rdr.GetString(27);
            }
            if (rdr.GetValue(28) != DBNull.Value)
            {
                entity.AlphaM27 = rdr.GetString(28);
            }
            if (rdr.GetValue(29) != DBNull.Value)
            {
                entity.AlphaM28 = rdr.GetString(29);
            }
            if (rdr.GetValue(30) != DBNull.Value)
            {
                entity.AlphaM29 = rdr.GetString(30);
            }
            if (rdr.GetValue(31) != DBNull.Value)
            {
                entity.AlphaM30 = rdr.GetString(31);
            }
            if (rdr.GetValue(32) != DBNull.Value)
            {
                entity.AlphaM31 = rdr.GetString(32);
            }
            if (rdr.GetValue(33) != DBNull.Value)
            {
                entity.AlphaM32 = rdr.GetString(33);
            }
            if (rdr.GetValue(34) != DBNull.Value)
            {
                entity.AlphaM33 = rdr.GetString(34);
            }
            if (rdr.GetValue(35) != DBNull.Value)
            {
                entity.AlphaM34 = rdr.GetString(35);
            }
            if (rdr.GetValue(36) != DBNull.Value)
            {
                entity.AlphaM35 = rdr.GetString(36);
            }
            if (rdr.GetValue(37) != DBNull.Value)
            {
                entity.AlphaM36 = rdr.GetString(37);
            }
            if (rdr.GetValue(38) != DBNull.Value)
            {
                entity.AlphaM37 = rdr.GetString(38);
            }
            if (rdr.GetValue(39) != DBNull.Value)
            {
                entity.AlphaM38 = rdr.GetString(39);
            }
            if (rdr.GetValue(40) != DBNull.Value)
            {
                entity.AlphaM39 = rdr.GetString(40);
            }
            if (rdr.GetValue(41) != DBNull.Value)
            {
                entity.AlphaM40 = rdr.GetString(41);
            }
            if (rdr.GetValue(42) != DBNull.Value)
            {
                entity.Numeric1 = rdr.GetDecimal(42);
            }
            if (rdr.GetValue(43) != DBNull.Value)
            {
                entity.Numeric2 = rdr.GetDecimal(43);
            }
            if (rdr.GetValue(44) != DBNull.Value)
            {
                entity.Numeric3 = rdr.GetDecimal(44);
            }
            if (rdr.GetValue(45) != DBNull.Value)
            {
                entity.Numeric4 = rdr.GetDecimal(45);
            }
            if (rdr.GetValue(46) != DBNull.Value)
            {
                entity.Numeric5 = rdr.GetDecimal(46);
            }
            if (rdr.GetValue(47) != DBNull.Value)
            {
                entity.Numeric6 = rdr.GetDecimal(47);
            }
            if (rdr.GetValue(48) != DBNull.Value)
            {
                entity.Numeric7 = rdr.GetDecimal(48);
            }
            if (rdr.GetValue(49) != DBNull.Value)
            {
                entity.Numeric8 = rdr.GetDecimal(49);
            }
            if (rdr.GetValue(50) != DBNull.Value)
            {
                entity.Numeric9 = rdr.GetDecimal(50);
            }
            if (rdr.GetValue(51) != DBNull.Value)
            {
                entity.Numeric10 = rdr.GetDecimal(51);
            }
            if (rdr.GetValue(52) != DBNull.Value)
            {
                entity.Numeric11 = rdr.GetDecimal(52);
            }
            if (rdr.GetValue(53) != DBNull.Value)
            {
                entity.Numeric12 = rdr.GetDecimal(53);
            }
            if (rdr.GetValue(54) != DBNull.Value)
            {
                entity.Numeric13 = rdr.GetDecimal(54);
            }
            if (rdr.GetValue(55) != DBNull.Value)
            {
                entity.Numeric14 = rdr.GetDecimal(55);
            }
            if (rdr.GetValue(56) != DBNull.Value)
            {
                entity.Numeric15 = rdr.GetDecimal(56);
            }
            if (rdr.GetValue(57) != DBNull.Value)
            {
                entity.Numeric16 = rdr.GetDecimal(57);
            }
            if (rdr.GetValue(58) != DBNull.Value)
            {
                entity.Numeric17 = rdr.GetDecimal(58);
            }
            if (rdr.GetValue(59) != DBNull.Value)
            {
                entity.Numeric18 = rdr.GetDecimal(59);
            }
            if (rdr.GetValue(60) != DBNull.Value)
            {
                entity.Numeric19 = rdr.GetDecimal(60);
            }
            if (rdr.GetValue(61) != DBNull.Value)
            {
                entity.Numeric20 = rdr.GetDecimal(61);
            }
            if (rdr.GetValue(62) != DBNull.Value)
            {
                entity.Creator = rdr.GetString(62);
            }
            if (rdr.GetValue(63) != DBNull.Value)
            {
                entity.CreateDate = rdr.GetDateTime(63);
            }
            if (rdr.GetValue(64) != DBNull.Value)
            {
                entity.Modifier = rdr.GetString(64);
            }
            if (rdr.GetValue(65) != DBNull.Value)
            {
                entity.ModifyDate = rdr.GetDateTime(65);
            }
            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Lookup 实体对象。</returns>
        public LookupInfo GetInfo(String fieldValue)
        {
            LookupInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Lookup_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = SetLookupinfoByDataReader(rdr);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Lookup 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="lookupCount">lookup 总数。</param>
        /// <returns>Lookup 列表。</returns>
        public List<LookupInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LookupInfo> list = new List<LookupInfo>();
            LookupInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SYS_Lookup", "Id",
                @"[Id], [TabaleName], [Alpha1], [Alpha2], [Alpha3], [Alpha4], [Alpha5], [Alpha6], [Alpha7], [Alpha8], [Alpha9], [Alpha10], [Alpha11], [Alpha12], [Alpha13], 
                [Alpha14], [Alpha15], [Alpha16], [Alpha17], [Alpha18], [Alpha19], [Alpha20], [AlphaM21], [AlphaM22], [AlphaM23], [AlphaM24], [AlphaM25], [AlphaM26], 
                [AlphaM27], [AlphaM28], [AlphaM29], [AlphaM30], [AlphaM31], [AlphaM32], [AlphaM33], [AlphaM34], [AlphaM35], [AlphaM36], [AlphaM37], [AlphaM38], [AlphaM39], 
                [AlphaM40], [Numeric1], [Numeric2], [Numeric3], [Numeric4], [Numeric5], [Numeric6], [Numeric7], [Numeric8], [Numeric9], [Numeric10], [Numeric11], [Numeric12], 
                [Numeric13], [Numeric14], [Numeric15], [Numeric16], [Numeric17], [Numeric18], [Numeric19], [Numeric20], [Creator], [CreateDate], [Modifier], [ModifyDate]",
                searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = SetLookupinfoByDataReader(rdr);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 根据条件查询Lookup表内容
        /// </summary>
        /// <param name="tableName">表名</param>
        /// <param name="conditionDic">条件</param>
        /// <returns></returns>
        public List<LookupInfo> GetLookupByCondition(string tableName, Dictionary<string, object> conditionDic = null)
        {
            List<LookupInfo> list = new List<LookupInfo>();

            string column = @"SELECT [Id], [TabaleName], [Alpha1], [Alpha2], [Alpha3], [Alpha4], [Alpha5], [Alpha6], [Alpha7], [Alpha8], [Alpha9], [Alpha10], [Alpha11], [Alpha12],  
                [Alpha13], [Alpha14], [Alpha15], [Alpha16], [Alpha17], [Alpha18], [Alpha19], [Alpha20], [AlphaM21], [AlphaM22], [AlphaM23], [AlphaM24], [AlphaM25], [AlphaM26], 
                [AlphaM27], [AlphaM28], [AlphaM29], [AlphaM30], [AlphaM31], [AlphaM32], [AlphaM33], [AlphaM34], [AlphaM35], [AlphaM36], [AlphaM37], [AlphaM38], [AlphaM39], 
                [AlphaM40], [Numeric1], [Numeric2], [Numeric3], [Numeric4], [Numeric5], [Numeric6], [Numeric7], [Numeric8], [Numeric9], [Numeric10], [Numeric11], [Numeric12], 
                [Numeric13], [Numeric14], [Numeric15], [Numeric16], [Numeric17], [Numeric18], [Numeric19], [Numeric20], [Creator], [CreateDate], [Modifier], [ModifyDate] 
                FROM SYS_Lookup";

            StringBuilder where = new StringBuilder(string.Format(" TabaleName ='{0}'", tableName));
            if (conditionDic != null)
            {
                foreach (string key in conditionDic.Keys)
                {
                    decimal conditionValue = 0;
                    if (decimal.TryParse(conditionDic[key].ToString(), out conditionValue))
                    {
                        where.AppendLine(string.Format(" and {0} = {1} ", key, conditionValue));
                    }
                    else
                    {
                        where.AppendLine(string.Format(" and {0} like '%{1}%' ", key, conditionDic[key].ToString()));
                    }
                }
            }

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, string.Format("{0} where {1}", column, where)))
            {
                while (rdr.Read())
                {
                    LookupInfo entity = SetLookupinfoByDataReader(rdr);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 编辑Lookup记录
        /// </summary>
        /// <param name="tableName"></param>
        /// <param name="ids"></param>
        /// <param name="value"></param>
        /// <param name="userName"></param>
        public void Edit(string tableName, string[] ids, string[] value, string userName)
        {
            var sql = "";
            for (int i = 0; i < ids.Length; i++)
            {
                sql += "UPDATE SYS_Lookup SET Modifier='" + userName + "',ModifyDate = GETDATE()," + value[i] + " WHERE TabaleName = '" + tableName.Trim() + "' AND Id = " + ids[i] + " ;";
            }
            //更新SYS_LookupDef表最后修改人、最后修改时间字段
            sql += "UPDATE SYS_LookupDef SET Modifier = '" + userName + "',ModifyDate = GETDATE() WHERE TabaleName = '" + tableName.Trim() + "' ;";
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, sql, null);
        }

        /// <summary>
        /// 获取钢网刮刀数据配置
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public LookupInfo GetSteelConfig(LookupInfo entity)
        {
            string sql = "SELECT Alpha1,Alpha2,Alpha3,Alpha4 FROM dbo.SYS_Lookup WHERE TabaleName='SYS_SteelConfig' AND Alpha2 = @Alpha2";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Alpha2", SqlDbType.VarChar) { Value = entity.Alpha2 }
            };
            return ComMethod.GetBySql<LookupInfo>(sql, parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}