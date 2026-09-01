using System;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.SMT.Model;

using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SMT.BLL
{
    public class PreAssemblySetting
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） PreAssemblySetting 信息。
        /// </summary>
        /// <param name="entity">PreAssemblySetting 实体对象。</param>
        public Int32 Edit(PreAssemblySettingInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@ModelID", SqlDbType.Int),
                new SqlParameter("@ModelNo", SqlDbType.VarChar, 200),
                new SqlParameter("@PartID", SqlDbType.Int),
                new SqlParameter("@PartNo", SqlDbType.VarChar, 200),
                new SqlParameter("@Use_QTY", SqlDbType.VarChar, 50),
                new SqlParameter("@Location", SqlDbType.VarChar, 200),
                new SqlParameter("@Station", SqlDbType.VarChar, 200),
                new SqlParameter("@StationID", SqlDbType.Int),
                new SqlParameter("@Line", SqlDbType.VarChar, 100),
                new SqlParameter("@LineID", SqlDbType.Int)
            };

            parms[0].Value = entity.ID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ModelID;
            parms[2].Value = entity.ModelNo;
            parms[3].Value = entity.PartID;
            parms[4].Value = entity.PartNo;
            parms[5].Value = entity.Use_QTY;
            parms[6].Value = entity.Location;
            parms[7].Value = entity.Station;
            parms[8].Value = entity.StationID;
            parms[9].Value = entity.Line;
            parms[10].Value = entity.LineID;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PreAssemblySetting_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PreAssemblySettingId 字符串删除 PreAssemblySetting 信息。
        /// </summary>
        /// <param name="idString">PreAssemblySettingId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PreAssemblySetting_Delete", parms);
        }

        /// <summary>
        /// 根据 PreAssemblySettingId 获取实体信息。
        /// </summary>
        /// <param name="preAssemblySettingId">PreAssemblySettingId。</param>
        /// <returns>PreAssemblySetting 实体对象。</returns>
        public PreAssemblySettingInfo GetInfo(Int32 preAssemblySettingId)
        {
            PreAssemblySettingInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = preAssemblySettingId;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PreAssemblySetting_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PreAssemblySettingInfo(rdr.IsDBNull(0) ? 0 : rdr.GetInt32(0),
                        rdr.IsDBNull(1) ? 0 : rdr.GetInt32(1), rdr.IsDBNull(2) ? "" : rdr.GetString(2),
                        rdr.IsDBNull(3) ? 0 : rdr.GetInt32(3), rdr.IsDBNull(4) ? "" : rdr.GetString(4),
                        rdr.IsDBNull(5) ? "" : rdr.GetString(5), rdr.IsDBNull(6) ? "" : rdr.GetString(6),
                        rdr.IsDBNull(7) ? "" : rdr.GetString(7), rdr.IsDBNull(8) ? 0 : rdr.GetInt32(8),
                        rdr.IsDBNull(9) ? "" : rdr.GetString(9), rdr.IsDBNull(10) ? 0 : rdr.GetInt32(10));
                    entity.ItemName = rdr.GetString(11);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 PreAssemblySettingId 获取实体信息集合。
        /// </summary>
        /// <param name="preAssemblySettingId">PreAssemblySettingId。</param>
        /// <returns>PreAssemblySetting 实体对象集合。</returns>
        public List<PreAssemblySettingInfo> GetSubInfoList(int modelid, string modelno)
        {
            List<PreAssemblySettingInfo> list = new List<PreAssemblySettingInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ModelID", SqlDbType.Int),
                new SqlParameter("@ModelNo", SqlDbType.VarChar,200)
            };
            parms[0].Value = modelid;
            parms[1].Value = modelno;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPreAssemblyList", parms))
            {
                while (rdr.Read())
                {
                    var entity = new PreAssemblySettingInfo();
                    entity.ID = rdr.IsDBNull(0) ? 0 : rdr.GetInt32(0);
                    entity.PartID = rdr.IsDBNull(1) ? 0 : rdr.GetInt32(1);
                    entity.PartNo = rdr.IsDBNull(2) ? "" : rdr.GetString(2);
                    entity.Use_QTY = rdr.IsDBNull(3) ? "" : rdr.GetString(3);
                    entity.Location = rdr.IsDBNull(4) ? "" : rdr.GetString(4);
                    entity.Station = rdr.IsDBNull(5) ? "" : rdr.GetString(5);
                    entity.Line = rdr.IsDBNull(6) ? "" : rdr.GetString(6);
                    entity.LineID = rdr.IsDBNull(7) ? 0 : rdr.GetInt32(7);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PreAssemblySetting 实体对象。</returns>
        public PreAssemblySettingInfo GetInfo(String fieldValue)
        {
            PreAssemblySettingInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PreAssemblySetting_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PreAssemblySettingInfo(rdr.IsDBNull(0) ? 0 : rdr.GetInt32(0),
                        rdr.IsDBNull(1) ? 0 : rdr.GetInt32(1), rdr.IsDBNull(2) ? "" : rdr.GetString(2),
                        rdr.IsDBNull(3) ? 0 : rdr.GetInt32(3), rdr.IsDBNull(4) ? "" : rdr.GetString(4),
                        rdr.IsDBNull(5) ? "" : rdr.GetString(5), rdr.IsDBNull(6) ? "" : rdr.GetString(6),
                        rdr.IsDBNull(7) ? "" : rdr.GetString(7), rdr.IsDBNull(8) ? 0 : rdr.GetInt32(8),
                        rdr.IsDBNull(9) ? "" : rdr.GetString(9), rdr.IsDBNull(10) ? 0 : rdr.GetInt32(10));
                    entity.ItemName = rdr.GetString(11);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 PreAssemblySetting 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="preAssemblySettingCount">preAssemblySetting 总数。</param>
        /// <returns>PreAssemblySetting 列表。</returns>
        public List<PreAssemblySettingInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PreAssemblySettingInfo> list = new List<PreAssemblySettingInfo>();
            PreAssemblySettingInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_PreAssemblySetting", "ID",
                "[ID], [ModelID], [ModelNo], [PartID], [PartNo], [Use_QTY], [Location], [Station], [StationID], [Line], [LineID]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PreAssemblySettingInfo(
                    rdr.IsDBNull(0) ? 0 : rdr.GetInt32(0),
                    rdr.IsDBNull(1) ? 0 : rdr.GetInt32(1),
                    rdr.IsDBNull(2) ? "" : rdr.GetString(2),
                    rdr.IsDBNull(3) ? 0 : rdr.GetInt32(3),
                    rdr.IsDBNull(4) ? "" : rdr.GetString(4),
                    rdr.IsDBNull(5) ? "" : rdr.GetString(5),
                    rdr.IsDBNull(6) ? "" : rdr.GetString(6),
                    rdr.IsDBNull(7) ? "" : rdr.GetString(7),
                    rdr.IsDBNull(8) ? 0 : rdr.GetInt32(8),
                    rdr.IsDBNull(9) ? "" : rdr.GetString(9),
                    rdr.IsDBNull(10) ? 0 : rdr.GetInt32(10));
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

        public List<PreAssemblySettingInfo> GetPrintPreMaterial(String printType, Int32 stationId, Int32 resId, Int32 inputId,
            String GRN, Decimal cartonQty, Int32 printQty, String userName)
        {
            List<PreAssemblySettingInfo> list = new List<PreAssemblySettingInfo>();
            PreAssemblySettingInfo entity = null;
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@PrintType",SqlDbType.VarChar,20),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@InputId",SqlDbType.Int),
                new SqlParameter("@GRN",SqlDbType.VarChar,100),
                new SqlParameter("@CartonQty",SqlDbType.Decimal),
                new SqlParameter("@PrintQty",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            param[0].Value = printType;
            param[1].Value = stationId;
            param[2].Value = resId;
            param[3].Value = inputId;
            param[4].Value = GRN;
            param[5].Value = cartonQty;
            param[6].Value = printQty;
            param[7].Value = userName;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspPrintPreMaterialByOrder", param))
            {
                while (rdr.Read())
                {
                    entity = new PreAssemblySettingInfo();
                    entity.LotNo = rdr.GetString(0);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// add by weixia on 2016.8.19根据传入条件查询产品信息
        /// </summary>
        /// <param name="checkType"></param>
        /// <param name="searchId"></param>
        /// <returns></returns>
        public PreAssemblySettingInfo GetItemInfoBySearch(String checkType, Int32 searchId)
        {
            PreAssemblySettingInfo entity = null;
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@CheckType",SqlDbType.VarChar,20),
                new SqlParameter("@SearchId",SqlDbType.Int)
            };

            param[0].Value = checkType;
            param[1].Value = searchId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetItemInfoBySearch", param))
            {
                if (rdr.Read())
                {
                    entity = new PreAssemblySettingInfo();
                    entity.ItemCode = rdr.GetString(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.ItemDesc = rdr.GetString(2);
                }
                rdr.Close();
            }
            return entity;
        }

        //前置加工扫描GRN返回信息   返回物料编码， 物料描述，物料数量
        public PreAssemblySettingInfo GetGRNIteminfo(Int32 checkTypeId, Int32 OrderOrItemId, String GRN)
        {
            PreAssemblySettingInfo entity = null;
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@CheckTypeId",SqlDbType.Int),
                new SqlParameter("@OrderIdOrItemId",SqlDbType.Int),
                new SqlParameter("@GRN",SqlDbType.VarChar,100)
            };

            param[0].Value = checkTypeId;
            param[1].Value = OrderOrItemId;
            param[2].Value = GRN;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspPreCheckByOrderOrItem", param))
            {
                if (rdr.Read())
                {
                    entity = new PreAssemblySettingInfo();
                    entity.ModelID = rdr.GetInt32(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.ItemDesc = rdr.GetString(2);
                    entity.GrnQty = rdr.GetDecimal(3);
                }
                rdr.Close();
            }
            return entity;
        }
    }
}