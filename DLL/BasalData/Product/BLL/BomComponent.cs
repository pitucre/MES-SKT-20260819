using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Product.BLL
{
    public class BomComponent
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） BomComponent 信息。
        /// </summary>
        /// <param name="entity">BomComponent 实体对象。</param>
        public void Edit(BomComponentInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@BomComponentId", SqlDbType.Int),
                new SqlParameter("@BomId", SqlDbType.Int),
                new SqlParameter("@AssSequence", SqlDbType.Float),
                new SqlParameter("@ItemID", SqlDbType.Int),
                new SqlParameter("@AssOperationID", SqlDbType.Int),
                new SqlParameter("@RefDes", SqlDbType.VarChar, 20),
                new SqlParameter("@POLine", SqlDbType.VarChar, 20),
                new SqlParameter("@CompCount", SqlDbType.Float),
                new SqlParameter("@DataTypeID", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.BomComponentId;
            parms[1].Value = entity.BomId;
            parms[2].Value = entity.AssSequence;
            parms[3].Value = entity.ItemID;
            parms[4].Value = entity.AssOperationID;
            parms[5].Value = entity.RefDes;
            parms[6].Value = entity.POLine;
            parms[7].Value = entity.CompCount;
            parms[8].Value = entity.DataTypeID;
            parms[9].Value = entity.CreateBy;
            parms[10].Value = entity.ModifyBy;
            parms[11].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_BomComponent_Edit", parms);
        }

        /// <summary>
        /// 根据 BomComponentId 字符串删除 BomComponent 信息。
        /// </summary>
        /// <param name="idString">BomComponentId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_BomComponent_Delete", parms);
        }

        /// <summary>
        /// 根据 BomComponentId 获取实体信息。
        /// </summary>
        /// <param name="bomComponentId">BomComponentId。</param>
        /// <returns>BomComponent 实体对象。</returns>
        public BomComponentInfo GetInfo(Int32 bomComponentId)
        {
            BomComponentInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = bomComponentId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_BomComponent_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new BomComponentInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDouble(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDouble(7), rdr.GetInt32(8), rdr.GetString(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13));
                    entity.ItemName = rdr.GetString(14);
                    entity.OperationName = rdr.GetString(15);
                    entity.DataTypeName = rdr.GetString(16);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>BomComponent 实体对象。</returns>
        public BomComponentInfo GetInfo(String fieldValue)
        {
            BomComponentInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_BomComponent_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new BomComponentInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDouble(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDouble(7), rdr.GetInt32(8), rdr.GetString(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 BomComponent 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="bomComponentCount">bomComponent 总数。</param>
        /// <returns>BomComponent 列表。</returns>
        public List<BomComponentInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<BomComponentInfo> list = new List<BomComponentInfo>();
            BomComponentInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBomComponets", "BomComponentID",
                "[BomComponentId], [BomId], [AssSequence], [ItemID], [AssOperationID], [RefDes], [POLine], [CompCount], [DataTypeID],[CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[ItemName],[DataTypeName], [OperationName], itemCode,IsMESadd", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new BomComponentInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetDouble(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDouble(7), rdr.GetInt32(8), rdr.GetString(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13));
                    entity.ItemName = rdr.GetString(14);
                    entity.DataTypeName = rdr.GetString(15);
                    entity.OperationName = rdr.GetString(16);
                    entity.ItemCode = rdr.GetString(17);
                    if (rdr.GetBoolean(18) == true)
                    {
                        entity.IsMESadd = "是";
                    }
                    else
                    {
                        entity.IsMESadd = "不是";                    
                    }                    
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 这个产品Bom是否已存在的新增的ItemId
        /// </summary>
        /// <param name="BomId"></param>
        /// <param name="ItemId"></param>
        /// <returns></returns>
        public bool IsComponentExists(int BomId, int ItemId)
        {
            //不存在重复的
            bool flag = false;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@BomId", SqlDbType.Int), 
                new SqlParameter("@ItemId", SqlDbType.Int)
            };
            parms[0].Value = BomId;
            parms[1].Value = ItemId;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Basal_BomComponent_IsExists", parms))
            {
                if (Convert.ToInt32(dt.Rows[0][0]) == 1)
                {
                    flag = true;
                }
            }
            return flag;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}