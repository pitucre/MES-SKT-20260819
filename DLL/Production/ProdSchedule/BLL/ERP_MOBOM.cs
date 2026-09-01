using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Schedule.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Schedule.BLL
{
    public class ERP_MOBOM
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 根据 fieldValue 获取实体信息。  工单号
        /// </summary>
        /// <param name="fieldValue">fieldValue。</param>
        /// <returns>MOBOM 实体对象。</returns>
        public ERP_MOBOMInfo GetInfo(String fieldValue)
        {
            ERP_MOBOMInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "ERP_MOBOM_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ERP_MOBOMInfo(rdr.GetValue(0).ToString(), rdr.GetValue(1).ToString(), rdr.GetValue(2).ToString(), rdr.GetValue(3).ToString(), rdr.GetValue(4).ToString(),
                        rdr.GetValue(5).ToString(), rdr.GetValue(6).ToString(), rdr.GetValue(7).ToString(), rdr.GetValue(8).ToString(), rdr.GetValue(9).ToString(),
                        rdr.GetValue(10).ToString(), rdr.GetValue(11).ToString(), rdr.GetValue(12).ToString(), rdr.GetValue(13).ToString(), rdr.GetValue(14).ToString(),
                        rdr.GetValue(15).ToString(), rdr.GetValue(16).ToString(), rdr.GetValue(17).ToString(), rdr.GetValue(18).ToString(), rdr.GetValue(19).ToString(),
                        rdr.GetValue(20).ToString(), rdr.GetValue(21).ToString(), rdr.GetValue(22).ToString(), rdr.GetValue(23).ToString(), rdr.GetValue(24).ToString(),
                        rdr.GetValue(25).ToString(), rdr.GetValue(26).ToString(), rdr.GetValue(27).ToString(), rdr.GetValue(28).ToString(), rdr.GetValue(29).ToString(),
                        rdr.GetValue(30).ToString(), rdr.GetValue(31).ToString(), rdr.GetValue(32).ToString(), rdr.GetValue(33).ToString(), rdr.GetValue(34).ToString(),
                        rdr.GetValue(35).ToString(), rdr.GetValue(36).ToString());
                }
                rdr.Close();
            }

            return entity;
        }


        /// <summary>
        /// 分页获取 MOBOM 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mOBOMCount">mOBOM 总数。</param>
        /// <returns>MOBOM 列表。</returns>
        public List<ERP_MOBOMInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ERP_MOBOMInfo> list = new List<ERP_MOBOMInfo>();
            ERP_MOBOMInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "ERP_MOBOM", "MOBomId",
                "[MOBomId], [MoCode], [rowno], [BusType], [AllocateId], [MoId], [MDeptCode], [MDeptName], [InvCode], [InvName], [ComUnitCode], [WhCode], [WhName], [VouchCode], [VouchName], [Qty], [RequisitionIssQty], [IssQty], [CompScrap], [cBatch], [RSortSeq], [SortSeq], [CreateDate], [ModifyDate], [WhEndDate], [pubufts], [Define1], [Define2], [Define3], [Define4], [Define5], [Define6], [Define7], [Define8], [Define9], [Define10], [State], [WorkSeq]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ERP_MOBOMInfo(rdr.GetInt32(0), rdr.GetValue(1).ToString(), rdr.GetValue(2).ToString(), rdr.GetValue(3).ToString(), rdr.GetValue(4).ToString(),
                        rdr.GetValue(5).ToString(), rdr.GetValue(6).ToString(), rdr.GetValue(7).ToString(), rdr.GetValue(8).ToString(), rdr.GetValue(9).ToString(),
                        rdr.GetValue(10).ToString(), rdr.GetValue(11).ToString(), rdr.GetValue(12).ToString(), rdr.GetValue(13).ToString(), rdr.GetValue(14).ToString(),
                        rdr.GetValue(15).ToString(), rdr.GetValue(16).ToString(), rdr.GetValue(17).ToString(), rdr.GetValue(18).ToString(), rdr.GetValue(19).ToString(),
                        rdr.GetValue(20).ToString(), rdr.GetValue(21).ToString(), rdr.GetValue(22).ToString(), rdr.GetValue(23).ToString(), rdr.GetValue(24).ToString(),
                        rdr.GetValue(25).ToString(), rdr.GetValue(26).ToString(), rdr.GetValue(27).ToString(), rdr.GetValue(28).ToString(), rdr.GetValue(29).ToString(),
                        rdr.GetValue(30).ToString(), rdr.GetValue(31).ToString(), rdr.GetValue(32).ToString(), rdr.GetValue(33).ToString(), rdr.GetValue(34).ToString(),
                        rdr.GetValue(35).ToString(), rdr.GetValue(36).ToString(), rdr.GetValue(37).ToString().ToString());

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 分页获取 存在工单BOM变更信息的工单列表。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mOBOMCount">mOBOM 总数。</param>
        /// <returns>MOBOM 列表。</returns>
        public List<ERP_MOBOMInfo> GetWaitChangeAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ERP_MOBOMInfo> list = new List<ERP_MOBOMInfo>();
            ERP_MOBOMInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwShopOrderBomWaitChange", "Id",
                "[Id], [MoCode], [OrderType], [ItemCode], [ItemName], [Status], [pubufts]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ERP_MOBOMInfo();
                    entity.Id = rdr.GetInt32(0);
                    entity.MoCode = rdr.GetValue(1).ToString();
                    entity.BusType = rdr.GetValue(2).ToString();
                    entity.InvCode = rdr.GetValue(3).ToString();
                    entity.InvName = rdr.GetValue(4).ToString();
                    entity.State = rdr.GetInt32(5).ToString();
                    entity.Pubufts = rdr.GetValue(6).ToString();

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