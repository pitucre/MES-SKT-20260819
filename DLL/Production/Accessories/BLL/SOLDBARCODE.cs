using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Accessories.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Accessories.BLL
{
    public class SOLDBARCODE
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SOLDBARCODE 信息。
        /// </summary>
        /// <param name="entity">SOLDBARCODE 实体对象。</param>
        public void Edit(SOLDBARCODEInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@BARCODE", SqlDbType.NVarChar, 50),
                new SqlParameter("@CREATEDTIME", SqlDbType.DateTime),
                new SqlParameter("@EXPIREDDATE", SqlDbType.DateTime),
                new SqlParameter("@CUR_STATUS", SqlDbType.NVarChar, 50),
                new SqlParameter("@LEADFREE", SqlDbType.NVarChar, 50),
                new SqlParameter("@partID", SqlDbType.Int),
                new SqlParameter("@SOLD_TYPE", SqlDbType.Int),
                new SqlParameter("@QUANTITY", SqlDbType.Int)
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.BARCODE;
            parms[2].Value = entity.CREATEDTIME;
            parms[3].Value = entity.EXPIREDDATE;
            parms[4].Value = entity.CUR_STATUS;
            parms[5].Value = entity.LEADFREE;
            parms[6].Value = entity.PartID;
            parms[7].Value = entity.SOLD_TYPE;
            parms[8].Value = entity.QUANTITY;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SOLDBARCODEEdit", parms);

            // return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SOLDBARCODEId 字符串删除 SOLDBARCODE 信息。
        /// </summary>
        /// <param name="idString">SOLDBARCODEId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SOLDBARCODEDelete", parms);
        }

        /// <summary>
        /// 根据 SOLDBARCODEId 获取实体信息。
        /// </summary>
        /// <param name="sOLDBARCODEId">SOLDBARCODEId。</param>
        /// <returns>SOLDBARCODE 实体对象。</returns>
        public SOLDBARCODEInfo GetInfo(Int32 sOLDBARCODEId)
        {
            SOLDBARCODEInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = sOLDBARCODEId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SOLDBARCODEGetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SOLDBARCODEInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDateTime(2), rdr.GetDateTime(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetInt32(7));
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// 锡膏红胶登记
        /// </summary>
        public void AddSoldbarcodeInfo(int pId, int quantity, string expiredTime, int selbCodeType, string strCode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@pId", SqlDbType.Int),
                new SqlParameter("@quantity", SqlDbType.Int),
                new SqlParameter("@expiredTime", SqlDbType.VarChar),
                new SqlParameter("@selbCodeType",SqlDbType.Int),
                new SqlParameter("@strCode", SqlDbType.VarChar, 1000)
            };

            parms[0].Value = pId;
            parms[1].Value = quantity;
            parms[2].Value = expiredTime;
            parms[3].Value = selbCodeType;
            parms[4].Value = strCode;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEnRegisterBarCode", parms);
        }
        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SOLDBARCODE 实体对象。</returns>
        public SOLDBARCODEInfo GetInfo(String fieldValue)
        {
            SOLDBARCODEInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SOLDBARCODEGetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SOLDBARCODE 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="sOLDBARCODECount">sOLDBARCODE 总数。</param>
        /// <returns>SOLDBARCODE 列表。</returns>
        public List<SOLDBARCODEInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SOLDBARCODEInfo> list = new List<SOLDBARCODEInfo>();
            SOLDBARCODEInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vw_SOLDBARCODEList", "ID",
                "[ID], [BARCODE], [CREATEDTIME], [EXPIREDDATE], [CUR_STATUS],[ItemName], [SoldType], [QUANTITY]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SOLDBARCODEInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDateTime(2), rdr.GetDateTime(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetInt32(7));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 辅料自动报废
        /// add by peter on 2016-4-13
        /// </summary>
        /// <param name="dateTime"></param>
        public void AutomaticScrap(DateTime dateTime)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DateTime", SqlDbType.DateTime),
            };
            parms[0].Value = dateTime;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAutomaticScrap", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}