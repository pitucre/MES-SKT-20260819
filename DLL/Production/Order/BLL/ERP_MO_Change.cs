using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Order.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Order.BLL
{
    public class MO_Change
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 根据 MO_ChangeId 获取实体信息。
        /// </summary>
        /// <param name="mO_ChangeId">MO_ChangeId。</param>
        /// <returns>MO_Change 实体对象。</returns>
        public MO_ChangeInfo GetInfo(Int32 mO_ChangeId)
        {
            MO_ChangeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = mO_ChangeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "ERP_MO_Change_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MO_ChangeInfo(rdr.GetInt32(0), rdr.GetValue(1), rdr.GetValue(2), rdr.GetValue(3), rdr.GetValue(4),
                        rdr.GetValue(5), rdr.GetValue(6), rdr.GetValue(7), rdr.GetValue(8), rdr.GetValue(9),
                        rdr.GetValue(10), rdr.GetValue(11), rdr.GetValue(12), rdr.GetValue(13), rdr.GetValue(14),
                        rdr.GetValue(15), rdr.GetValue(16), rdr.GetValue(17), rdr.GetValue(18), rdr.GetValue(19),
                        rdr.GetValue(20), rdr.GetValue(21), rdr.GetValue(22), rdr.GetValue(23), rdr.GetValue(24),
                        rdr.GetValue(25), rdr.GetValue(26), rdr.GetValue(27), rdr.GetValue(28));
                }
                rdr.Close();
            }

            return entity;
        }


        /// <summary>
        /// 分页获取 MO_Change 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mO_ChangeCount">mO_Change 总数。</param>
        /// <returns>MO_Change 列表。</returns>
        public List<MO_ChangeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MO_ChangeInfo> list = new List<MO_ChangeInfo>();
            MO_ChangeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "ERP_MO_Change", "Id",
                "[Id], [MoCode], [rowno], [BusType], [MoId], [MDeptCode], [MDeptName], [MDate], [PlanBeginDate], [PlanEndTime], [InvCode], [InvName], [ComUnitCode], [Qty], [QualifiedInQty], [pubufts], [cMemo], [Define1], [Define2], [Define3], [Define4], [Define5], [Define6], [Define7], [Define8], [Define9], [Define10], [State], [MOStatus], [ChangeStatus]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MO_ChangeInfo(rdr.GetInt32(0), rdr.GetValue(1), rdr.GetValue(2), rdr.GetValue(3), rdr.GetValue(4),
                        rdr.GetValue(5), rdr.GetValue(6), rdr.GetValue(7), rdr.GetValue(8), rdr.GetValue(9),
                        rdr.GetValue(10), rdr.GetValue(11), rdr.GetValue(12), rdr.GetValue(13), rdr.GetValue(14),
                        rdr.GetValue(15), rdr.GetValue(16), rdr.GetValue(17), rdr.GetValue(18), rdr.GetValue(19),
                        rdr.GetValue(20), rdr.GetValue(21), rdr.GetValue(22), rdr.GetValue(23), rdr.GetValue(24),
                        rdr.GetValue(25), rdr.GetValue(26), rdr.GetValue(27), rdr.GetValue(28));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 分页获取 工单变更历史记录。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mO_ChangeCount">mO_Change 总数。</param>
        /// <returns>MO_Change 列表。</returns>
        public List<MO_ChangeInfo> GetChangeHistoryAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MO_ChangeInfo> list = new List<MO_ChangeInfo>();
            MO_ChangeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "ERP_MO_ChangeHistory", "MOchangeId",
                "[MOchangeId], [MoCode], [rowno], [BusType], [MoId], [MDeptCode], [MDeptName], [MDate], [PlanBeginDate], [PlanEndTime], [InvCode], [InvName], [ComUnitCode], [Qty], [QualifiedInQty], [pubufts], [cMemo], [Define1], [Define2], [Define3], [Define4], [Define5], [Define6], [Define7], [Define8], [Define9], [Define10], [State], [MOStatus], [ChangePerson], [ChangeDate], [ChangeRemark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MO_ChangeInfo(rdr.GetInt32(0), rdr.GetValue(1), rdr.GetValue(2), rdr.GetValue(3), rdr.GetValue(4),
                        rdr.GetValue(5), rdr.GetValue(6), rdr.GetValue(7), rdr.GetValue(8), rdr.GetValue(9),
                        rdr.GetValue(10), rdr.GetValue(11), rdr.GetValue(12), rdr.GetValue(13), rdr.GetValue(14),
                        rdr.GetValue(15), rdr.GetValue(16), rdr.GetValue(17), rdr.GetValue(18), rdr.GetValue(19),
                        rdr.GetValue(20), rdr.GetValue(21), rdr.GetValue(22), rdr.GetValue(23), rdr.GetValue(24),
                        rdr.GetValue(25), rdr.GetValue(26), rdr.GetValue(27), rdr.GetValue(28));

                    entity.ChangePerson = rdr.GetValue(29);
                    entity.ChangeDate = rdr.GetValue(30);
                    entity.ChangeRemark = rdr.GetValue(31);

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
        /// 工单确认更新
        /// </summary>
        /// <param name="moId"></param>
        public void ConfirmUpdate(int moChangeId, string user)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MoChangeId", SqlDbType.Int),
                new SqlParameter("@User", SqlDbType.VarChar, 20)
            };

            parms[0].Value = moChangeId;
            parms[1].Value = user;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspShopOrderConfirmUpdate", parms);
        }
    }
}