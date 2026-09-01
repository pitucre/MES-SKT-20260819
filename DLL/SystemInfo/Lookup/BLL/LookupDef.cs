using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Lookup.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Lookup.BLL
{
    public class LookupDef
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） LookupDef 信息。
        /// </summary>
        /// <param name="entity">LookupDef 实体对象。</param>
        public Int32 Edit(LookupDefInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TabaleName", SqlDbType.VarChar, 50),
                new SqlParameter("@Alpha1Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha2Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha3Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha4Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha5Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha6Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha7Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha8Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha9Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha10Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha11Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha12Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha13Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha14Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha15Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha16Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha17Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha18Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha19Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Alpha20Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM21Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM22Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM23Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM24Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM25Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM26Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM27Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM28Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM29Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM30Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM31Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM32Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM33Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM34Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM35Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM36Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM37Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM38Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM39Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@AlphaM40Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric1Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric2Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric3Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric4Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric5Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric6Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric7Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric8Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric9Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric10Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric11Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric12Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric13Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric14Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric15Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric16Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric17Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric18Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric19Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Numeric20Desc", SqlDbType.VarChar, 100),
                new SqlParameter("@Creator", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateDate", SqlDbType.DateTime),
                new SqlParameter("@Modifier", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyDate", SqlDbType.DateTime)
            };

            parms[0].Value = entity.TabaleName;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.Alpha1Desc;
            parms[2].Value = entity.Alpha2Desc;
            parms[3].Value = entity.Alpha3Desc;
            parms[4].Value = entity.Alpha4Desc;
            parms[5].Value = entity.Alpha5Desc;
            parms[6].Value = entity.Alpha6Desc;
            parms[7].Value = entity.Alpha7Desc;
            parms[8].Value = entity.Alpha8Desc;
            parms[9].Value = entity.Alpha9Desc;
            parms[10].Value = entity.Alpha10Desc;
            parms[11].Value = entity.Alpha11Desc;
            parms[12].Value = entity.Alpha12Desc;
            parms[13].Value = entity.Alpha13Desc;
            parms[14].Value = entity.Alpha14Desc;
            parms[15].Value = entity.Alpha15Desc;
            parms[16].Value = entity.Alpha16Desc;
            parms[17].Value = entity.Alpha17Desc;
            parms[18].Value = entity.Alpha18Desc;
            parms[19].Value = entity.Alpha19Desc;
            parms[20].Value = entity.Alpha20Desc;
            parms[21].Value = entity.AlphaM21Desc;
            parms[22].Value = entity.AlphaM22Desc;
            parms[23].Value = entity.AlphaM23Desc;
            parms[24].Value = entity.AlphaM24Desc;
            parms[25].Value = entity.AlphaM25Desc;
            parms[26].Value = entity.AlphaM26Desc;
            parms[27].Value = entity.AlphaM27Desc;
            parms[28].Value = entity.AlphaM28Desc;
            parms[29].Value = entity.AlphaM29Desc;
            parms[30].Value = entity.AlphaM30Desc;
            parms[31].Value = entity.AlphaM31Desc;
            parms[32].Value = entity.AlphaM32Desc;
            parms[33].Value = entity.AlphaM33Desc;
            parms[34].Value = entity.AlphaM34Desc;
            parms[35].Value = entity.AlphaM35Desc;
            parms[36].Value = entity.AlphaM36Desc;
            parms[37].Value = entity.AlphaM37Desc;
            parms[38].Value = entity.AlphaM38Desc;
            parms[39].Value = entity.AlphaM39Desc;
            parms[40].Value = entity.AlphaM40Desc;
            parms[41].Value = entity.Numeric1Desc;
            parms[42].Value = entity.Numeric2Desc;
            parms[43].Value = entity.Numeric3Desc;
            parms[44].Value = entity.Numeric4Desc;
            parms[45].Value = entity.Numeric5Desc;
            parms[46].Value = entity.Numeric6Desc;
            parms[47].Value = entity.Numeric7Desc;
            parms[48].Value = entity.Numeric8Desc;
            parms[49].Value = entity.Numeric9Desc;
            parms[50].Value = entity.Numeric10Desc;
            parms[51].Value = entity.Numeric11Desc;
            parms[52].Value = entity.Numeric12Desc;
            parms[53].Value = entity.Numeric13Desc;
            parms[54].Value = entity.Numeric14Desc;
            parms[55].Value = entity.Numeric15Desc;
            parms[56].Value = entity.Numeric16Desc;
            parms[57].Value = entity.Numeric17Desc;
            parms[58].Value = entity.Numeric18Desc;
            parms[59].Value = entity.Numeric19Desc;
            parms[60].Value = entity.Numeric20Desc;
            parms[61].Value = entity.Creator;
            parms[62].Value = entity.CreateDate;
            parms[63].Value = entity.Modifier;
            parms[64].Value = entity.ModifyDate;
            foreach (var parm in parms)
            {
                if (parm.Value == null)
                {
                    parm.Value = DBNull.Value;
                }
            }

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_LookupDef_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LookupDefId 字符串删除 LookupDef 信息。
        /// </summary>
        /// <param name="idString">LookupDefId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_LookupDef_Delete", parms);
        }

        /// <summary>
        /// 根据 LookupDefId 获取实体信息。
        /// </summary>
        /// <param name="lookupDefId">LookupDefId。</param>
        /// <returns>LookupDef 实体对象。</returns>
        public LookupDefInfo GetInfo(string tableName, bool isId)
        {
            LookupDefInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = tableName;
            parms[1].Value = isId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_LookupDef_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = SetLookupDefInfoByDataReader(rdr);
                }
                rdr.Close();
            }

            return entity;
        }

        private LookupDefInfo SetLookupDefInfoByDataReader(SqlDataReader rdr)
        {
            LookupDefInfo entity = new LookupDefInfo(rdr.GetString(0));
            if (rdr.GetValue(1) != DBNull.Value)
            {
                entity.Alpha1Desc = rdr.GetString(1);
            }
            if (rdr.GetValue(2) != DBNull.Value)
            {
                entity.Alpha2Desc = rdr.GetString(2);
            }
            if (rdr.GetValue(3) != DBNull.Value)
            {
                entity.Alpha3Desc = rdr.GetString(3);
            }
            if (rdr.GetValue(4) != DBNull.Value)
            {
                entity.Alpha4Desc = rdr.GetString(4);
            }
            if (rdr.GetValue(5) != DBNull.Value)
            {
                entity.Alpha5Desc = rdr.GetString(5);
            }
            if (rdr.GetValue(6) != DBNull.Value)
            {
                entity.Alpha6Desc = rdr.GetString(6);
            }
            if (rdr.GetValue(7) != DBNull.Value)
            {
                entity.Alpha7Desc = rdr.GetString(7);
            }
            if (rdr.GetValue(8) != DBNull.Value)
            {
                entity.Alpha8Desc = rdr.GetString(8);
            }
            if (rdr.GetValue(9) != DBNull.Value)
            {
                entity.Alpha9Desc = rdr.GetString(9);
            }
            if (rdr.GetValue(10) != DBNull.Value)
            {
                entity.Alpha10Desc = rdr.GetString(10);
            }
            if (rdr.GetValue(11) != DBNull.Value)
            {
                entity.Alpha11Desc = rdr.GetString(11);
            }
            if (rdr.GetValue(12) != DBNull.Value)
            {
                entity.Alpha12Desc = rdr.GetString(12);
            }
            if (rdr.GetValue(13) != DBNull.Value)
            {
                entity.Alpha13Desc = rdr.GetString(13);
            }
            if (rdr.GetValue(14) != DBNull.Value)
            {
                entity.Alpha14Desc = rdr.GetString(14);
            }
            if (rdr.GetValue(15) != DBNull.Value)
            {
                entity.Alpha15Desc = rdr.GetString(15);
            }
            if (rdr.GetValue(16) != DBNull.Value)
            {
                entity.Alpha16Desc = rdr.GetString(16);
            }
            if (rdr.GetValue(17) != DBNull.Value)
            {
                entity.Alpha17Desc = rdr.GetString(17);
            }
            if (rdr.GetValue(18) != DBNull.Value)
            {
                entity.Alpha18Desc = rdr.GetString(18);
            }
            if (rdr.GetValue(19) != DBNull.Value)
            {
                entity.Alpha19Desc = rdr.GetString(19);
            }
            if (rdr.GetValue(20) != DBNull.Value)
            {
                entity.Alpha20Desc = rdr.GetString(20);
            }
            if (rdr.GetValue(21) != DBNull.Value)
            {
                entity.AlphaM21Desc = rdr.GetString(21);
            }
            if (rdr.GetValue(22) != DBNull.Value)
            {
                entity.AlphaM22Desc = rdr.GetString(22);
            }
            if (rdr.GetValue(23) != DBNull.Value)
            {
                entity.AlphaM23Desc = rdr.GetString(23);
            }
            if (rdr.GetValue(24) != DBNull.Value)
            {
                entity.AlphaM24Desc = rdr.GetString(24);
            }
            if (rdr.GetValue(25) != DBNull.Value)
            {
                entity.AlphaM25Desc = rdr.GetString(25);
            }
            if (rdr.GetValue(26) != DBNull.Value)
            {
                entity.AlphaM26Desc = rdr.GetString(26);
            }
            if (rdr.GetValue(27) != DBNull.Value)
            {
                entity.AlphaM27Desc = rdr.GetString(27);
            }
            if (rdr.GetValue(28) != DBNull.Value)
            {
                entity.AlphaM28Desc = rdr.GetString(28);
            }
            if (rdr.GetValue(29) != DBNull.Value)
            {
                entity.AlphaM29Desc = rdr.GetString(29);
            }
            if (rdr.GetValue(30) != DBNull.Value)
            {
                entity.AlphaM30Desc = rdr.GetString(30);
            }
            if (rdr.GetValue(31) != DBNull.Value)
            {
                entity.AlphaM31Desc = rdr.GetString(31);
            }
            if (rdr.GetValue(32) != DBNull.Value)
            {
                entity.AlphaM32Desc = rdr.GetString(32);
            }
            if (rdr.GetValue(33) != DBNull.Value)
            {
                entity.AlphaM33Desc = rdr.GetString(33);
            }
            if (rdr.GetValue(34) != DBNull.Value)
            {
                entity.AlphaM34Desc = rdr.GetString(34);
            }
            if (rdr.GetValue(35) != DBNull.Value)
            {
                entity.AlphaM35Desc = rdr.GetString(35);
            }
            if (rdr.GetValue(36) != DBNull.Value)
            {
                entity.AlphaM36Desc = rdr.GetString(36);
            }
            if (rdr.GetValue(37) != DBNull.Value)
            {
                entity.AlphaM37Desc = rdr.GetString(37);
            }
            if (rdr.GetValue(38) != DBNull.Value)
            {
                entity.AlphaM38Desc = rdr.GetString(38);
            }
            if (rdr.GetValue(39) != DBNull.Value)
            {
                entity.AlphaM39Desc = rdr.GetString(39);
            }
            if (rdr.GetValue(40) != DBNull.Value)
            {
                entity.AlphaM40Desc = rdr.GetString(40);
            }
            if (rdr.GetValue(41) != DBNull.Value)
            {
                entity.Numeric10Desc = rdr.GetString(41);
            }
            if (rdr.GetValue(42) != DBNull.Value)
            {
                entity.Numeric20Desc = rdr.GetString(42);
            }
            if (rdr.GetValue(43) != DBNull.Value)
            {
                entity.Numeric3Desc = rdr.GetString(43);
            }
            if (rdr.GetValue(44) != DBNull.Value)
            {
                entity.Numeric4Desc = rdr.GetString(44);
            }
            if (rdr.GetValue(45) != DBNull.Value)
            {
                entity.Numeric5Desc = rdr.GetString(45);
            }
            if (rdr.GetValue(46) != DBNull.Value)
            {
                entity.Numeric6Desc = rdr.GetString(46);
            }
            if (rdr.GetValue(47) != DBNull.Value)
            {
                entity.Numeric7Desc = rdr.GetString(47);
            }
            if (rdr.GetValue(48) != DBNull.Value)
            {
                entity.Numeric8Desc = rdr.GetString(48);
            }
            if (rdr.GetValue(49) != DBNull.Value)
            {
                entity.Numeric9Desc = rdr.GetString(49);
            }
            if (rdr.GetValue(50) != DBNull.Value)
            {
                entity.Numeric10Desc = rdr.GetString(50);
            }
            if (rdr.GetValue(51) != DBNull.Value)
            {
                entity.Numeric11Desc = rdr.GetString(51);
            }
            if (rdr.GetValue(52) != DBNull.Value)
            {
                entity.Numeric12Desc = rdr.GetString(52);
            }
            if (rdr.GetValue(53) != DBNull.Value)
            {
                entity.Numeric13Desc = rdr.GetString(53);
            }
            if (rdr.GetValue(54) != DBNull.Value)
            {
                entity.Numeric14Desc = rdr.GetString(54);
            }
            if (rdr.GetValue(55) != DBNull.Value)
            {
                entity.Numeric15Desc = rdr.GetString(55);
            }
            if (rdr.GetValue(56) != DBNull.Value)
            {
                entity.Numeric16Desc = rdr.GetString(56);
            }
            if (rdr.GetValue(57) != DBNull.Value)
            {
                entity.Numeric17Desc = rdr.GetString(57);
            }
            if (rdr.GetValue(58) != DBNull.Value)
            {
                entity.Numeric18Desc = rdr.GetString(58);
            }
            if (rdr.GetValue(59) != DBNull.Value)
            {
                entity.Numeric19Desc = rdr.GetString(59);
            }
            if (rdr.GetValue(60) != DBNull.Value)
            {
                entity.Numeric20Desc = rdr.GetString(60);
            }
            if (rdr.GetValue(61) != DBNull.Value)
            {
                entity.Creator = rdr.GetString(61);
            }
            if (rdr.GetValue(62) != DBNull.Value)
            {
                entity.CreateDate = rdr.GetDateTime(62);
            }
            if (rdr.GetValue(63) != DBNull.Value)
            {
                entity.Modifier = rdr.GetString(63);
            }
            if (rdr.GetValue(64) != DBNull.Value)
            {
                entity.ModifyDate = rdr.GetDateTime(64);
            }
            return entity;
        }

        /// <summary>
        /// 分页获取 LookupDef 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="lookupDefCount">lookupDef 总数。</param>
        /// <returns>LookupDef 列表。</returns>
        public List<LookupDefInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //List<LookupDefInfo> list = new List<LookupDefInfo>();
            //LookupDefInfo entity = null;

            //SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SYS_LookupDef", "",
            //    @"[TabaleName], [Alpha1Desc], [Alpha2Desc], [Alpha3Desc], [Alpha4Desc], [Alpha5Desc], [Alpha6Desc], [Alpha7Desc], [Alpha8Desc], [Alpha9Desc], [Alpha10Desc], 
            //    [Alpha11Desc], [Alpha12Desc], [Alpha13Desc], [Alpha14Desc], [Alpha15Desc], [Alpha16Desc], [Alpha17Desc], [Alpha18Desc], [Alpha19Desc], [Alpha20Desc], 
            //    [AlphaM21Desc], [AlphaM22Desc], [AlphaM23Desc], [AlphaM24Desc], [AlphaM25Desc], [AlphaM26Desc], [AlphaM27Desc], [AlphaM28Desc], [AlphaM29Desc], 
            //    [AlphaM30Desc], [AlphaM31Desc], [AlphaM32Desc], [AlphaM33Desc], [AlphaM34Desc], [AlphaM35Desc], [AlphaM36Desc], [AlphaM37Desc], [AlphaM38Desc], [AlphaM39Desc], 
            //    [AlphaM40Desc], [Numeric1Desc], [Numeric2Desc], [Numeric3Desc], [Numeric4Desc], [Numeric5Desc], [Numeric6Desc], [Numeric7Desc], [Numeric8Desc], [Numeric9Desc], 
            //    [Numeric10Desc], [Numeric11Desc], [Numeric12Desc], [Numeric13Desc], [Numeric14Desc], [Numeric15Desc], [Numeric16Desc], [Numeric17Desc], [Numeric18Desc], 
            //    [Numeric19Desc], [Numeric20Desc], [Creator], [CreateDate], [Modifier], [ModifyDate]", searchSettings, sortExpression);

            //using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            //{
            //    while (rdr.Read())
            //    {
            //        entity = SetLookupDefInfoByDataReader(rdr);

            //        list.Add(entity);
            //    }
            //    rdr.Close();
            //}

            //recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            //return list;

            string columns = @"TabaleName,Alpha1Desc,Alpha2Desc,Alpha3Desc,Alpha4Desc,Alpha5Desc,Alpha6Desc,Alpha7Desc,Alpha8Desc,Alpha9Desc,Alpha10Desc,
            Alpha11Desc,Alpha12Desc,Alpha13Desc,Alpha14Desc,Alpha15Desc,Alpha16Desc,Alpha17Desc,Alpha18Desc,Alpha19Desc,Alpha20Desc,
            AlphaM21Desc,AlphaM22Desc,AlphaM23Desc,AlphaM24Desc,AlphaM25Desc,AlphaM26Desc,AlphaM27Desc,AlphaM28Desc,AlphaM29Desc,
            AlphaM30Desc,AlphaM31Desc,AlphaM32Desc,AlphaM33Desc,AlphaM34Desc,AlphaM35Desc,AlphaM36Desc,AlphaM37Desc,AlphaM38Desc,AlphaM39Desc,
            AlphaM40Desc,Numeric1Desc,Numeric2Desc,Numeric3Desc,Numeric4Desc,Numeric5Desc,Numeric6Desc,Numeric7Desc,Numeric8Desc,Numeric9Desc,
            Numeric10Desc,Numeric11Desc,Numeric12Desc,Numeric13Desc,Numeric14Desc,Numeric15Desc,Numeric16Desc,Numeric17Desc,Numeric18Desc,
            Numeric19Desc,Numeric20Desc,Creator,CreateDate,Modifier,ModifyDate";
            return ComMethod.GetComList<LookupDefInfo>(ref this.recordCount, startRow, maxRows, "vwSYS_LookupDef", string.Empty, columns, sortExpression, searchSettings);////SYS_LookupDef
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}