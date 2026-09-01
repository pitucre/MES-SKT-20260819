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
    public class ApplyDtl
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ApplyDtl 信息。
        /// </summary>
        /// <param name="entity">ApplyDtl 实体对象。</param>
        public Int32 Edit(ApplyDtlInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ApplyDtlId", SqlDbType.BigInt),
                new SqlParameter("@ApplyId", SqlDbType.BigInt),
                new SqlParameter("@ApplyNo", SqlDbType.VarChar, 20),
                new SqlParameter("@MODtlId", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 20),
                new SqlParameter("@ItemName", SqlDbType.NVarChar, 200),
                new SqlParameter("@Units", SqlDbType.VarChar, 20),
                new SqlParameter("@Statue", SqlDbType.Int),
                new SqlParameter("@SourceQty", SqlDbType.Decimal),
                new SqlParameter("@ApplyQty", SqlDbType.Decimal),
                new SqlParameter("@StockQty", SqlDbType.Decimal),
                new SqlParameter("@ActiQty", SqlDbType.Decimal),
                new SqlParameter("@ReturnQty", SqlDbType.Decimal),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.ApplyDtlId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ApplyId;
            parms[2].Value = entity.ApplyNo;
            parms[3].Value = entity.MODtlId;
            parms[4].Value = entity.ItemCode;
            parms[5].Value = entity.ItemName;
            parms[6].Value = entity.Units;
            parms[7].Value = entity.Statue;
            parms[8].Value = entity.SourceQty;
            parms[9].Value = entity.ApplyQty;
            parms[10].Value = entity.StockQty;
            parms[11].Value = entity.ActiQty;
            parms[12].Value = entity.ReturnQty;
            parms[13].Value = entity.Remark;
            parms[14].Value = entity.CreateBy;
            parms[15].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ApplyDtl_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ApplyDtlId 字符串删除 ApplyDtl 信息。
        /// </summary>
        /// <param name="idString">ApplyDtlId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ApplyDtl_Delete", parms);
        }

        /// <summary>
        /// 根据 ApplyDtlId 获取实体信息。
        /// </summary>
        /// <param name="applyDtlId">ApplyDtlId。</param>
        /// <returns>ApplyDtl 实体对象。</returns>
        public ApplyDtlInfo GetInfo(Int32 applyDtlId)
        {
            ApplyDtlInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = applyDtlId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ApplyDtl_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ApplyDtlInfo(rdr.GetInt64(0), rdr.GetInt64(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetInt32(7), rdr.GetDecimal(8), rdr.GetDecimal(9),
                        rdr.GetDecimal(10), rdr.GetDecimal(11), rdr.GetDecimal(12), rdr.GetString(13), rdr.GetString(14),
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetDateTime(17));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ApplyDtl 实体对象。</returns>
        public ApplyDtlInfo GetInfo(String fieldValue)
        {
            ApplyDtlInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ApplyDtl_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ApplyDtlInfo(rdr.GetInt64(0), rdr.GetInt64(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetInt32(7), rdr.GetDecimal(8), rdr.GetDecimal(9),
                        rdr.GetDecimal(10), rdr.GetDecimal(11), rdr.GetDecimal(12), rdr.GetString(13), rdr.GetString(14),
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetDateTime(17));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ApplyDtl 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="applyDtlCount">applyDtl 总数。</param>
        /// <returns>ApplyDtl 列表。</returns>
        public List<ApplyDtlInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ApplyDtlInfo> list = new List<ApplyDtlInfo>();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_ApplyDtl", "ApplyDtlId",
                "[ApplyDtlId], [ApplyId], [ApplyNo], [MODtlId], [ItemId], [ItemCode], [ItemName], [Units], [Statue], [SourceQty], [ApplyQty], [StockQty], [ActiQty], [ReturnQty], [Remark], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                list = ComMethod.ToListEntity<ApplyDtlInfo>(rdr);
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        public List<ApplyDtlInfo> GetMaterialPrepareItem(int applyID)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ApplyId", SqlDbType.Int)
            };

            parms[0].Value = applyID;
            //return ComMethod.GetListBySql<ApplyDtlInfo>("select * from vwGetMaterialPrepareItem where (Statue=0 or Statue=4) and ApplyId=@ApplyId", parms);
            return ComMethod.GetList<ApplyDtlInfo>("uspGetApplyListDtlInfo", parms);//sql 替换成存储过程 在查询前判断是否QHold  zhuchenglong  2017-09-01 11:53
        }
        /*********************PDA分页查询***********chenglong.zhu 2017/3/6***********************************/
        public List<ApplyDtlInfo> GetMaterialPrepareItem(Int32 startRow, Int32 maxRows, String sortExpression, string applyNo, ref int rowCount)
        {
            List<ApplyDtlInfo> list = new List<ApplyDtlInfo>();
            ////表名或者视图
            //string strTb = "vwProdMaterialIQCList";
            ////主键
            //string strKey = "InspectionId";
            ////查询栏位字串
            //string strColumns = @"";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ApplyNo", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = applyNo;
            list = ComMethod.GetPageList<ApplyDtlInfo>("uspPDAGetMaterialPrepareItem", parms, startRow, maxRows, ref rowCount);

            return list;
        }
        /// <summary>
        /// 根据领料单获取工单信息
        /// </summary>
        /// <param name="No"></param>
        /// <returns></returns>
        public List<ApplyInfo> GetWorkOrderInfo(string No)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ApplyNo", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = No;
            return ComMethod.GetList<ApplyInfo>("uspGetApplyListDtlInfoByNo", parms);//sql 替换成存储过程 在查询前判断是否QHold  zhuchenglong  2017-09-01 11:53
        }
        /// <summary>
        /// 获取领料单信息
        /// </summary>
        /// <param name="No"></param>
        /// <returns></returns>
        public List<ApplyDtlInfo> GetMaterialPrepareInfo(string WorkOrderNo,string ApplyNo)
        {
            String sqlstr = @"SELECT
                                A.[ApplyDtlId], A.[ApplyId], A.[ApplyNo], A.[ItemId], A.[ItemCode], A.[ItemName],
                                A.[Statue], A.[SourceQty], A.[ApplyQty], A.[StockQty], A.[ActiQty],
                                CASE
                                (select COUNT(1) from Prod_MaterialUnit B where B.Status=15 and B.PartId = A.ItemId)
                                WHEN 0 THEN '0' ELSE '1' END AS IsGrn
                                FROM  Prod_ApplyDtl A 
                                JOIN Prod_Apply B ON B.ApplyId=A.ApplyId
                                WHERE (A.Statue=0 or A.Statue=4) AND B.MOCode=@WorkOrderNo AND B.ApplyNo=@ApplyNo";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WorkOrderNo", SqlDbType.NVarChar, 50),
                new SqlParameter("@ApplyNo", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = WorkOrderNo;
            parms[1].Value = ApplyNo;
            List<ApplyDtlInfo> list = ComMethod.GetListBySql<ApplyDtlInfo>(sqlstr, parms);
            return list;
        }
    }
}