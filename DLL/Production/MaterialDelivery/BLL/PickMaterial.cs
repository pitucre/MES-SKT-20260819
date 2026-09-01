using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.MaterialDelivery.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.MaterialDelivery.BLL
{
    public class PickMaterial
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取 PickMaterial 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="pickMaterialCount">pickMaterial 总数。</param>
        /// <returns>PickMaterial 列表。</returns>
        public List<PickMaterialInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PickMaterialInfo> list = new List<PickMaterialInfo>();
            PickMaterialInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwCallMaterialBand", "PickId",
                "[PickId],[PickCode],[LineId],[OrderId],[Flag],[Qty],[Status],[CreateBy],[CreateDateTime],[ModifyBy],[ModifyDateTime],[Remark],[LineName],[OrderNO],[EdgeName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PickMaterialInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetDecimal(5), rdr.GetInt32(6),rdr.GetString(7),rdr.GetDateTime(8), rdr.GetString(9), rdr.GetDateTime(10),rdr.GetString(11));
                    entity.LineName = rdr.GetString(12);
                    entity.OrderNo = rdr.GetString(13);
                    entity.EdgeName = rdr.GetString(14);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 根据 PickMaterialId 获取实体信息。
        /// </summary>
        /// <param name="pickMaterialId">PickMaterialId。</param>
        /// <returns>PickMaterial 实体对象。</returns>
        public PickMaterialInfo GetInfo(Int32 pickMaterialId)
        {
            List<PickMaterialInfo> list = new List<PickMaterialInfo>();
            PickMaterialInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = pickMaterialId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PickMaterial_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PickMaterialInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetDecimal(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), rdr.GetDateTime(10), rdr.GetString(11));
                    entity.LineName = rdr.GetString(12);
                    entity.OrderNo = rdr.GetString(13);
                    list.Add(entity);
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// 获取拉式叫料看板记录  指定线边仓的信息
        /// </summary>
        /// <param name="edge">线边仓</param>
        /// <returns></returns>
        public DataTable GetInfo(string edge)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EdgeName", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = edge;

            DataTable dt = new DataTable();

            return dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Prod_CallMaterial_GetInfo", parms);

        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}