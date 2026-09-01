using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Container.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Container.BLL
{
    public class PackagingAttachmentOrder
    {
        private Int32 recordCount = 0;
        private Int32 recordCountDtl = 0;
        /// <summary>
        /// 编辑（添加或更新） PackagingAttachmentOrder 信息。
        /// </summary>
        /// <param name="strjson">PackagingAttachmentOrder json。</param>
        public void Edit(string strjson)
        {
            ComMethod.Edit(strjson, "uspSavePackagingAttachmentOrder");
        }

        /// <summary>
        /// 根据 PackagingAttachmentOrderId 字符串删除 PackagingAttachmentOrder 信息。
        /// </summary>
        /// <param name="idString">PackagingAttachmentOrderId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PackagingAttachmentOrder_Delete", parms);
        }

        /// <summary>
        /// 根据 PackagingAttachmentOrderId 获取实体信息。
        /// </summary>
        /// <param name="packagingAttachmentOrderId">PackagingAttachmentOrderId。</param>
        /// <returns>PackagingAttachmentOrder 实体对象。</returns>
        public PackagingAttachmentOrderInfo GetInfo(Int32 packagingAttachmentOrderId)
        {
            PackagingAttachmentOrderInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = packagingAttachmentOrderId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PackagingAttachmentOrder_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PackagingAttachmentOrderInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetDecimal(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10));
                    entity.OrderNO = rdr.GetString(11);
                    entity.ItemCode = rdr.GetString(12);
                    entity.ItemName = rdr.GetString(13);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PackagingAttachmentOrder 实体对象。</returns>
        public PackagingAttachmentOrderInfo GetInfo(String fieldValue)
        {
            PackagingAttachmentOrderInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PackagingAttachmentOrder_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PackagingAttachmentOrderInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetDecimal(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10));
                    entity.OrderNO = rdr.GetString(11);
                    entity.ItemCode = rdr.GetString(12);
                    entity.ItemName = rdr.GetString(13);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 PackagingAttachmentOrder 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="packagingAttachmentOrderCount">packagingAttachmentOrder 总数。</param>
        /// <returns>PackagingAttachmentOrder 列表。</returns>
        public List<PackagingAttachmentOrderInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PackagingAttachmentOrderInfo> list = new List<PackagingAttachmentOrderInfo>();
            PackagingAttachmentOrderInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwPackagingAttachmentOrder", "PAOId",
                "[PAOId], [ProdOrderID], [ItemId], [Description], [Quantity], [Status], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[OrderNO],[ItemCode] ,[ItemName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PackagingAttachmentOrderInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetDecimal(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10));
                    entity.OrderNO = rdr.GetString(11);
                    entity.ItemCode = rdr.GetString(12);
                    entity.ItemName = rdr.GetString(13);

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
        /// 分页获取 PackagingAttachmentOrderDtlInfo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="packagingAttachmentOrderCount">PackagingAttachmentOrderDtlInfo 总数。</param>
        /// <returns>PackagingAttachmentOrderDtlInfo 列表。</returns>
        public List<PackagingAttachmentOrderDtlInfo> GetAllDtl(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PackagingAttachmentOrderDtlInfo> list = new List<PackagingAttachmentOrderDtlInfo>();
            PackagingAttachmentOrderDtlInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwPackagingAttachmentOrderDtl", "PAOId",
                "[PAODId],[PAOId],[ProdOrderID],[ItemID],[Description],[Quantity],[Status],[CreateBy],[CreateDateTime],[ModifyBy],[ModifyDateTime],[Remark],[OrderNO],[ItemCode],[ItemName],[ZOrderNO]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PackagingAttachmentOrderDtlInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4),
                       rdr.GetDecimal(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9),
                       rdr.GetDateTime(10), rdr.GetString(11));
                    entity.OrderNO = rdr.GetString(12);
                    entity.ItemCode = rdr.GetString(13);
                    entity.ItemName = rdr.GetString(14);
                    entity.ZOrderNO = rdr.GetString(15);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCountDtl = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetCountDtl(SearchSettings searchSettings)
        {
            return this.recordCountDtl;
        }
    }
}