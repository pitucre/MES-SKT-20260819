using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Accessories.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Accessories.BLL
{
    public class LOG
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） LOG 信息。
        /// </summary>
        /// <param name="entity">LOG 实体对象。</param>
        public void Edit(LOGInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@BARCODE", SqlDbType.NVarChar, 50),
                new SqlParameter("@CREATEDTIME", SqlDbType.DateTime),
                new SqlParameter("@USERID", SqlDbType.Int),
                new SqlParameter("@ACTION", SqlDbType.NVarChar, 20),
                new SqlParameter("@PN", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.BARCODE;
            parms[2].Value = entity.CREATEDTIME;
            parms[3].Value = entity.USERID;
            parms[4].Value = entity.ACTION;
            parms[5].Value = entity.PN;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SOLDER_LOGEdit", parms);

            // return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LOGId 字符串删除 LOG 信息。
        /// </summary>
        /// <param name="idString">LOGId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SOLDER_LOGDelete", parms);
        }
        /// <summary>
        /// 解冻
        /// </summary>
        public void AccessoriesThaw(string barCode, int uId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@barCode", SqlDbType.VarChar, 50),
                new SqlParameter("@uId",SqlDbType.Int)
            };

            parms[0].Value = barCode;
            parms[1].Value = uId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAddThawInfo", parms);
        }
        /// <summary>
        /// 使用
        /// </summary>
        /// <param name="uId">操作此功能的人</param>
        /// <param name="usePeople">使用此辅料的人</param>
        public void AccessoriesUseOf(string barCode, int usePeople, int line, int orderId, string useTime, int uId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@barCode", SqlDbType.VarChar, 50),
                new SqlParameter("@UsePeople", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@OrderId", SqlDbType.Int),
                new SqlParameter("@UseTime", SqlDbType.VarChar,30),
                new SqlParameter("@uId",SqlDbType.Int)
            };

            parms[0].Value = barCode;
            parms[1].Value = usePeople;
            parms[2].Value = line;
            parms[3].Value = orderId;
            parms[4].Value = useTime;
            parms[5].Value = uId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAddUseOf", parms);
        }


        /// <summary>
        /// 冰冻
        /// </summary>
        public void AccessoriesFrostOf(string barCode, int uId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@barCode", SqlDbType.VarChar, 50),
                new SqlParameter("@uId",SqlDbType.Int)
            };

            parms[0].Value = barCode;
            parms[1].Value = uId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAddFrostInfo", parms);
        }

        /// <summary>
        /// 获取barcode操作信息
        /// add by weixia on 2016.6.25
        /// </summary>
        /// <param name="barCode"></param>
        /// <returns></returns>
        public LOGInfo GetSetTimeByType(Int32 typeId)
        {
            LOGInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TypeId", SqlDbType.Int)
            };
            parms[0].Value = typeId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetSetTimeByType", parms))
            {
                while (rdr.Read())
                {
                    entity = new LOGInfo();
                    entity.Minthaw = rdr.GetInt32(0);
                    entity.Maxvoid = rdr.GetInt32(1);
                    entity.Maxuse = rdr.GetInt32(2);


                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 获取barcode操作信息
        /// </summary>
        /// <param name="barCode"></param>
        /// <returns></returns>
        public List<LOGInfo> GetUseLogInfoByBarCode(string barCode)
        {
            List<LOGInfo> list = new List<LOGInfo>();
            LOGInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@barCode", SqlDbType.VarChar, 50),
            };
            parms[0].Value = barCode;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetAllUseSolderLog", parms))
            {
                while (rdr.Read())
                {
                    entity = new LOGInfo();
                    entity.CreateTime = rdr.GetDateTime(0).ToString();
                    entity.ACTION = rdr.GetString(1);
                    entity.LoginID = rdr.GetString(2);
                    entity.PN = rdr.GetString(3);
                    entity.EXPIREDDATE = rdr.GetDateTime(4).ToString();


                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 添加报废信息
        /// </summary>
        public void SetInvidatedInfo(string barCode, int uId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@barCode", SqlDbType.VarChar, 50),
                new SqlParameter("@uId",SqlDbType.Int)
            };

            parms[0].Value = barCode;
            parms[1].Value = uId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAddInvalidatedInfo", parms);
        }
        /// <summary>
        /// 根据 LOGId 获取实体信息。
        /// </summary>
        /// <param name="lOGId">LOGId。</param>
        /// <returns>LOG 实体对象。</returns>
        public LOGInfo GetInfo(Int32 lOGId)
        {
            LOGInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = lOGId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SOLDER_LOGGetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LOGInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetDateTime(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LOG 实体对象。</returns>
        public LOGInfo GetInfo(String fieldValue)
        {
            LOGInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SOLDER_LOGGetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 LOG 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="lOGCount">lOG 总数。</param>
        /// <returns>LOG 列表。</returns>
        public List<LOGInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LOGInfo> list = new List<LOGInfo>();
            LOGInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vw_GetAllThawInfoByTime", "[ID]",
                "[ID],[BARCODE], [PN], [CREATEDTIME], [UseTime], [EXPIREDDATE]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LOGInfo();
                    entity.ID = rdr.GetInt32(0);
                    entity.BARCODE = rdr.GetString(1);
                    entity.PN = rdr.GetString(2);
                    entity.CREATEDTIMEStr = String.IsNullOrEmpty(rdr.GetDateTime(3).ToString()) ? "" : rdr.GetDateTime(3).ToString();

                    //entity.UseTimeStr = String.IsNullOrEmpty(rdr.GetDateTime(4).ToString()) ? "" : rdr.GetDateTime(4).ToString();                    
                    if (rdr.GetDateTime(4).ToString().Trim().Substring(0, 4) == "1900")
                    {
                        entity.UseTimeStr = "";
                    }
                    else
                    {
                        entity.UseTimeStr = rdr.GetDateTime(4).ToString();
                    }

                    entity.ExpireTimeStr = String.IsNullOrEmpty(rdr.GetDateTime(5).ToString()) ? "" : rdr.GetDateTime(5).ToString();
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