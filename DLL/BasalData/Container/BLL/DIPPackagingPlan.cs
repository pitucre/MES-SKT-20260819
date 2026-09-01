using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Container.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Container.BLL
{
    public class DIPPackagingPlan
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） DIPPackagingPlan 信息。
        /// </summary>
        /// <param name="entity">DIPPackagingPlan 实体对象。</param>
        public Int32 Edit(DIPPackagingPlanInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DPPId", SqlDbType.Int),
                new SqlParameter("@Fid", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@OrderId", SqlDbType.Int),
                new SqlParameter("@OrderNO", SqlDbType.NVarChar, 100),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.NVarChar, 100),
                new SqlParameter("@ItemDes", SqlDbType.NVarChar, 1000),
                new SqlParameter("@PlanQty", SqlDbType.Int),
                new SqlParameter("@PlanDatiTime", SqlDbType.DateTime),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200)
            };

            parms[0].Value = entity.DPPId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.Fid;
            parms[2].Value = entity.LineId;
            parms[3].Value = entity.OrderId;
            parms[4].Value = entity.OrderNO;
            parms[5].Value = entity.ItemId;
            parms[6].Value = entity.ItemCode;
            parms[7].Value = entity.ItemDes;
            parms[8].Value = entity.PlanQty;
            parms[9].Value = entity.PlanDatiTime;
            parms[10].Value = entity.Status;
            parms[11].Value = entity.CreateBy;
            parms[12].Value = entity.ModifyBy;
            parms[13].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_DIPPackagingPlan_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 DIPPackagingPlanId 字符串删除 DIPPackagingPlan 信息。
        /// </summary>
        /// <param name="idString">DIPPackagingPlanId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_DIPPackagingPlan_Delete", parms);
        }

        /// <summary>
        /// 根据 DIPPackagingPlanId 获取实体信息。
        /// </summary>
        /// <param name="dIPPackagingPlanId">DIPPackagingPlanId。</param>
        /// <returns>DIPPackagingPlan 实体对象。</returns>
        public DIPPackagingPlanInfo GetInfo(Int32 dIPPackagingPlanId)
        {
            DIPPackagingPlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = dIPPackagingPlanId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_DIPPackagingPlan_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DIPPackagingPlanInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetDateTime(9), 
                        rdr.GetInt32(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetDateTime(14), 
                        rdr.GetString(15));
                    entity.FName = rdr.GetString(16);
                    entity.ItemName = rdr.GetString(17);
                    entity.LineName = rdr.GetString(18);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>DIPPackagingPlan 实体对象。</returns>
        public DIPPackagingPlanInfo GetInfo(String fieldValue)
        {
            DIPPackagingPlanInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_DIPPackagingPlan_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DIPPackagingPlanInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetDateTime(9), 
                        rdr.GetInt32(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetDateTime(14), 
                        rdr.GetString(15));
                    entity.FName = rdr.GetString(16);
                    entity.ItemName = rdr.GetString(17);
                    entity.LineName = rdr.GetString(18);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 DIPPackagingPlan 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="dIPPackagingPlanCount">dIPPackagingPlan 总数。</param>
        /// <returns>DIPPackagingPlan 列表。</returns>
        public List<DIPPackagingPlanInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DIPPackagingPlanInfo> list = new List<DIPPackagingPlanInfo>();
            DIPPackagingPlanInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwDIPPackagingPlan", "DPPId",
                "[DPPId], [Fid], [LineId], [OrderId], [OrderNO], [ItemId], [ItemCode], [ItemSpec], [PlanQty], [PlanDatiTime], [Status], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[FName],[ItemName],[LineName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new DIPPackagingPlanInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetDateTime(9), 
                        rdr.GetInt32(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetDateTime(14), 
                        rdr.GetString(15));
                    entity.FName = rdr.GetString(16);
                    entity.ItemName= rdr.GetString(17);
                    entity.LineName= rdr.GetString(18);
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