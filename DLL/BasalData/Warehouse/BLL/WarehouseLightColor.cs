using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Warehouse.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Warehouse.BLL
{
    public class WarehouseLightColor
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） WarehouseLocationLightColor 信息。
        /// </summary>
        /// <param name="entity">WarehouseLocationLightColor 实体对象。</param>
        /// 
        public Int32 Edit(WarehouseLightColorInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FunctionId", SqlDbType.Int),
                new SqlParameter("@FunctionName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ColorCode", SqlDbType.VarChar,50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar)
            };

            parms[0].Value = entity.FunctionId;
            parms[1].Value = entity.FunctionName;
            parms[2].Value = entity.ColorCode;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseLightColorEdit_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 FunctionId 字符串删除 FunctionName 信息。
        /// </summary>
        /// <param name="idString">FunctionId 字符串。</param>
        public void Delete(String idString)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
               // new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            //parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseLightColor_Delete", parms);
        }
        /// <summary>
        /// 设置是否使用
        /// </summary>
        /// <param name="prodOrderNo"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public void SetInUseProdOrderNo(int id, string prodOrderNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FunctionId", SqlDbType.Int),
                new SqlParameter("@InUseProdOrderNo", SqlDbType.VarChar,50),
            };

            parms[0].Value = id;
            parms[1].Value = prodOrderNo;

            string sql = @"UPDATE Prod_LightColorSetting SET InUseProdOrderNo=@InUseProdOrderNo WHERE FunctionId=@FunctionId";
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, sql, parms);
        }

        /// <summary>
        /// 获取可用得工单颜色配置
        /// </summary>
        /// <returns></returns>
        public WarehouseLightColorInfo GetUsableProdOrderLightColor()
        {
            WarehouseLightColorInfo entity = null;

            string sql = @"
                SELECT TOP 1 A.FunctionId,B.ColorDescription
                FROM Prod_LightColorSetting A
                    LEFT JOIN Basal_LightColorCode B ON A.ColorCode = B.ColorCode
                WHERE A.FunctionName LIKE '%工单发料' AND (A.InUseProdOrderNo ='' OR A.InUseProdOrderNo IS NULL) 
                ORDER BY A.FunctionId";

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseLightColorInfo();
                    entity.FunctionId = Convert.ToInt32(rdr["FunctionId"]);
                    entity.ColorDescription = Convert.ToString(rdr["ColorDescription"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 获取工单绑定得亮灯配置
        /// </summary>
        /// <returns></returns>
        public WarehouseLightColorInfo GetProdOrderLightColor(string prodOrderNo)
        {
            WarehouseLightColorInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InUseProdOrderNo", SqlDbType.VarChar,50),
            };

            parms[0].Value = prodOrderNo;

            string sql = @"
                SELECT A.FunctionId,B.ColorDescription,A.InUseProdOrderNo
                FROM Prod_LightColorSetting A
                    LEFT JOIN Basal_LightColorCode B ON A.ColorCode = B.ColorCode
                WHERE A.FunctionName LIKE '%工单发料' AND A.InUseProdOrderNo =@InUseProdOrderNo";

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseLightColorInfo();
                    entity.FunctionId = Convert.ToInt32(rdr["FunctionId"]);
                    entity.ColorDescription = Convert.ToString(rdr["ColorDescription"]);
                    entity.InUseProdOrderNo = Convert.ToString(rdr["InUseProdOrderNo"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 FunctionId 获取实体信息。
        /// </summary>
        /// <param name="warehouseTypeId">FunctionId。</param>
        /// <returns>WarehouseName 实体对象。</returns>
        public WarehouseLightColorInfo GetInfo(Int32 functionId)
        {
            WarehouseLightColorInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = functionId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseLightColor_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseLightColorInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), rdr.GetString(5),
                        rdr.GetDateTime(6), rdr.GetString(7));
                    entity.InUseProdOrderNo = Convert.ToString(rdr["InUseProdOrderNo"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>FunctionName 实体对象。</returns>
        public WarehouseLightColorInfo GetInfo(String fieldValue)
        {
            WarehouseLightColorInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseLightColor_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseLightColorInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), rdr.GetString(5),
                        rdr.GetDateTime(6), rdr.GetString(7));
                    entity.InUseProdOrderNo = Convert.ToString(rdr["InUseProdOrderNo"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 WarehouseLightColor 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warehouseTypeCount">WarehouseLightColor 总数。</param>
        /// <returns>WarehouseLightColor 列表。</returns>
        public List<WarehouseLightColorInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseLightColorInfo> list = new List<WarehouseLightColorInfo>();
            WarehouseLightColorInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[dbo].[vwLightColorInfo]", "FunctionId",
                "[FunctionId], [FunctionName],[ColorCode], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime],[ColorDescription],[InUseProdOrderNo]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarehouseLightColorInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), rdr.GetString(5),
                        rdr.GetDateTime(6), rdr.GetString(7));
                    entity.InUseProdOrderNo = Convert.ToString(rdr["InUseProdOrderNo"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        public List<WarehouseLightColorInfo> GetWarehouseLightColorALL()
        {
            List<WarehouseLightColorInfo> list = new List<WarehouseLightColorInfo>();
            WarehouseLightColorInfo entity = null;
            string strSql = "SELECT FunctionId,FunctionName FROM dbo.Prod_LightColorSetting";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, strSql, null))
            {
                while (rdr.Read())
                {
                    entity = new WarehouseLightColorInfo(rdr.GetInt32(0), rdr.GetString(1));

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        public List<WarehouseLightColorInfo> GetAllColor()
        {
            List<WarehouseLightColorInfo> list = new List<WarehouseLightColorInfo>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, "select colorcode,colordescription from Basal_LightColorCode", null))
            {
                while (rdr.Read())
                {
                    list.Add(new WarehouseLightColorInfo
                    {
                        ColorCode = rdr["colorcode"].ToString(),
                        ColorDescription = rdr["colordescription"].ToString()
                    });
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 设置是否使用
        /// </summary>
        /// <param name="prodOrderNo"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public void SetInUseProdOrderNo(int id, string prodOrderNo, bool isUse)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FunctionId", SqlDbType.Int),
                new SqlParameter("@InUseProdOrderNo", SqlDbType.VarChar,50),
            };

            parms[0].Value = id;
            parms[1].Value = prodOrderNo;
            string sql = "";
            if (isUse)
            {
                sql = @"UPDATE Prod_LightColorSetting SET InUseProdOrderNo=@InUseProdOrderNo WHERE FunctionId=@FunctionId GO;";
            }
            else
            {
                sql = @"UPDATE Prod_LightColorSetting SET InUseProdOrderNo='' WHERE FunctionId=@FunctionId ;
                        DELETE FROM Prod_TakeMaterialLockInfo WHERE Code = @InUseProdOrderNo
                        UPDATE  dbo.Prod_MaterialUnit  SET LockCode=NULL    WHERE LockCode=@InUseProdOrderNo ; ";
            }

            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, sql, parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}
