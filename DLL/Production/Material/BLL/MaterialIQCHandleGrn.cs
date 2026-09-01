using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Material.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Material.BLL
{
    public class MaterialIQCHandleGrn
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MaterialIQCHandleGrn 信息。
        /// </summary>
        /// <param name="entity">MaterialIQCHandleGrn 实体对象。</param>
        public Int32 Edit(MaterialIQCHandleGrnInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IQCGrnId", SqlDbType.BigInt),
                new SqlParameter("@InspectionId", SqlDbType.BigInt),
                new SqlParameter("@ItemId", SqlDbType.BigInt),
                new SqlParameter("@GRN", SqlDbType.VarChar, 50),
                new SqlParameter("@TotalQty", SqlDbType.Decimal),
                new SqlParameter("@OkQty", SqlDbType.Decimal),
                new SqlParameter("@NgQty", SqlDbType.Decimal),
                new SqlParameter("@ScrapQty", SqlDbType.Decimal),
                new SqlParameter("@ChooseQty", SqlDbType.Decimal),
                new SqlParameter("@Remark", SqlDbType.VarChar, 500),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyDate", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateDate", SqlDbType.DateTime)
            };

            parms[0].Value = entity.IQCGrnId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.InspectionId;
            parms[2].Value = entity.ItemId;
            parms[3].Value = entity.GRN;
            parms[4].Value = entity.TotalQty;
            parms[5].Value = entity.OkQty;
            parms[6].Value = entity.NgQty;
            parms[7].Value = entity.ScrapQty;
            parms[8].Value = entity.ChooseQty;
            parms[9].Value = entity.Remark;
            parms[10].Value = entity.ModifyBy;
            parms[11].Value = entity.ModifyDate;
            parms[12].Value = entity.CreateBy;
            parms[13].Value = entity.CreateDate;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialIQCHandleGrn_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MaterialIQCHandleGrnId 字符串删除 MaterialIQCHandleGrn 信息。
        /// </summary>
        /// <param name="idString">MaterialIQCHandleGrnId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialIQCHandleGrn_Delete", parms);
        }

        /// <summary>
        /// 根据 MaterialIQCHandleGrnId 获取实体信息。
        /// </summary>
        /// <param name="materialIQCHandleGrnId">MaterialIQCHandleGrnId。</param>
        /// <returns>MaterialIQCHandleGrn 实体对象。</returns>
        public MaterialIQCHandleGrnInfo GetInfo(Int32 materialIQCHandleGrnId)
        {
            MaterialIQCHandleGrnInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = materialIQCHandleGrnId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialIQCHandleGrn_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialIQCHandleGrnInfo(rdr.GetInt64(0), rdr.GetInt64(1), rdr.GetInt64(2), rdr.GetString(3), rdr.GetDecimal(4), 
                        rdr.GetDecimal(5), rdr.GetDecimal(6), rdr.GetDecimal(7), rdr.GetDecimal(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaterialIQCHandleGrn 实体对象。</returns>
        public MaterialIQCHandleGrnInfo GetInfo(String fieldValue)
        {
            MaterialIQCHandleGrnInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialIQCHandleGrn_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialIQCHandleGrnInfo(rdr.GetInt64(0), rdr.GetInt64(1), rdr.GetInt64(2), rdr.GetString(3), rdr.GetDecimal(4), 
                        rdr.GetDecimal(5), rdr.GetDecimal(6), rdr.GetDecimal(7), rdr.GetDecimal(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 MaterialIQCHandleGrn 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialIQCHandleGrnCount">materialIQCHandleGrn 总数。</param>
        /// <returns>MaterialIQCHandleGrn 列表。</returns>
        public List<MaterialIQCHandleGrnInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialIQCHandleGrnInfo> list = new List<MaterialIQCHandleGrnInfo>();
            MaterialIQCHandleGrnInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_MaterialIQCHandleGrn", "MaterialIQCHandleGrnId",
                "[IQCGrnId], [InspectionId], [ItemId], [GRN], [TotalQty], [OkQty], [NgQty], [ScrapQty], [ChooseQty], [Remark], [ModifyBy], [ModifyDate], [CreateBy], [CreateDate]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialIQCHandleGrnInfo(rdr.GetInt64(0), rdr.GetInt64(1), rdr.GetInt64(2), rdr.GetString(3), rdr.GetDecimal(4), 
                        rdr.GetDecimal(5), rdr.GetDecimal(6), rdr.GetDecimal(7), rdr.GetDecimal(8), rdr.GetString(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13));

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
        /// 根据检验单ID和GRN获取检验单GRN信息。 过滤包装箱条码
        /// </summary>
        /// <param name="intIqcId">IQC单号</param>
        /// <returns>strJson</returns>
        public DataTable GetMaterialIQCHandleGrn(string strGrn, Int32 intIqcId)
        {
            string strSql = @"SELECT -1 AS IQCGrnNgId, B.InspectionId, B.ItemId, A.SerialNumber AS GRN, C.BalanceQty TotalQty,
                            0 NgQty, 0 OKQty, '' AS Remark, B.ItemCode,0 ChooseQty,0 ScrapQty ,isnull(pmu.SerialNumber,'') AS PKSerialNumber
                            FROM Prod_MaterialUnitMember AS  A WITH(NOLOCK)
                            INNER JOIN Prod_MaterialUnit AS C WITH(NOLOCK) ON A.MaterialUnitId = C.MaterialUnitId 
                            INNER JOIN Prod_MaterialIQC B ON A.IQCOrder = B.InspectionNo
                            LEFT JOIN dbo.Prod_MaterialUnit pmu WITH(NOLOCK) ON pmu.MaterialUnitId=c.PID AND pmu.Flag <>-1
                            WHERE C.BalanceQty>0  AND B.InspectionId = @InspectionId  AND c.Flag = -1 ";// AND A.SerialNumber = @GRN ";
            SqlParameter[] parms = new SqlParameter[]{
                    //new SqlParameter("@GRN", SqlDbType.VarChar, 50),
					new SqlParameter("@InspectionId", SqlDbType.Int)
				};
            parms[0].Value = intIqcId;
            //parms[1].Value = intIqcId;
            //return ComMethod.GetBySql(strSql, parms);           
            var ds = ComMethod.GetListDataSetBySql(strSql, parms);
            return ds == null ? new DataTable() : ds.Tables[0];
        }
        /// <summary>
        /// 根据IQC检验单ID，获取IQC检验单入库数量
        /// </summary>
        /// <param name="intIqcId"></param>
        /// <returns></returns>
        public string GetIQCStorageQty(Int64 intIqcId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int)
				};
            parms[0].Value = intIqcId;
            return ComMethod.GetList("uspGetIQCStorageQty", parms);
        }
        /// <summary>
        /// 检验库位条码是否正确
        /// </summary>
        /// <param name="barCode"></param>
        /// <returns></returns>
        public string GetBarCode(string barCode)
        {
            string strSql = @"select '' as GRN, 0 as StorageQty, a.cBarCode as BarCode,b.CWhName,b.CWhCode
                                from  [dbo].[Basal_WarehouseLocation] a 
                                inner join  [Basal_Warehouse] b 
                                on a.cWhId=b.WarehouseId 
                                where a.CBarCode=@BarCode";

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@BarCode", SqlDbType.VarChar, 50)
				};
            parms[0].Value = barCode;
            return ComMethod.GetBySql(strSql, parms);
        }


        /// <summary>
        /// 检验库位条码是否正确
        /// </summary>
        /// <param name="barCode"></param>
        /// <param name="warehouseName"></param>
        /// <returns></returns>
        public string GetBarCode(string barCode,string warehouseName)
        {
            string strSql = @"select '' as GRN, 0 as StorageQty, a.cBarCode as BarCode
                                from  [dbo].[Basal_WarehouseLocation] a 
                                inner join  [Basal_Warehouse] b 
                                on a.cWhId=b.WarehouseId 
                                where a.CBarCode=@BarCode and b.CWhName=@warehouseName";

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@BarCode", SqlDbType.VarChar, 50),
                     new SqlParameter("@warehouseName", SqlDbType.VarChar, 50)
                };
            parms[0].Value = barCode;
            parms[1].Value = warehouseName;
            return ComMethod.GetBySql(strSql, parms);
        }

        /// <summary>
        /// 检验仓库条码是否正确
        /// </summary>
        /// <param name="barCode"></param>
        /// <returns></returns>
        public string GetWarehouseCode(string barCode)
        {
            string strSql = @"select '' as GRN, 0 as StorageQty, a.CWhCode as CWhCode
                                from  [Basal_Warehouse] a 
                                where a.CWhCode=@id";

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@id", SqlDbType.VarChar, 50)
				};
            parms[0].Value = barCode;
            return ComMethod.GetBySql(strSql, parms);
        }
        /// <summary>
        /// 根据IQC检验单ID，GRN 获取IQC检验单入库数量
        /// </summary>
        /// <param name="intIqcId"></param>
        /// <returns></returns>
        public string GetIQCGRNStorageQty(Int64 intIqcId, string grn, int isAll)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@GRN", SqlDbType.VarChar, 50),
					new SqlParameter("@IsAll", SqlDbType.Int)
				};
            parms[0].Value = intIqcId;
            parms[1].Value = grn;
            parms[2].Value = isAll;
            return ComMethod.GetList("upsGetIQCGRNStorageQty", parms);
        }
    }
}