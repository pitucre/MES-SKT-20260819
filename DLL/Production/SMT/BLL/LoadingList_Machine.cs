using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.SMT.Model;


namespace SKT.LeanMES.SMT.BLL
{
    public class LoadingList_MACHINE
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） LIST_MACHINE 信息。
        /// </summary>
        /// <param name="entity">LIST_MACHINE 实体对象。</param>
        public Int32 Edit(LoadingList_MACHINEInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@LoadingListID", SqlDbType.Int),
                new SqlParameter("@MachineID", SqlDbType.Int),
                new SqlParameter("@StatusID", SqlDbType.TinyInt),
                new SqlParameter("@CurrentPanelSide", SqlDbType.Bit),
                new SqlParameter("@IsConsumeByQty", SqlDbType.Bit),
                new SqlParameter("@MachineNo", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.LoadingListID;
            parms[2].Value = entity.MachineID;
            parms[3].Value = entity.StatusID;
            parms[4].Value = entity.CurrentPanelSide;
            parms[5].Value = entity.IsConsumeByQty;
            parms[6].Value = entity.MachineNo;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "LOADING_LIST_MACHINEEdit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LIST_MACHINEId 字符串删除 LIST_MACHINE 信息。
        /// </summary>
        /// <param name="idString">LIST_MACHINEId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "LOADING_LIST_MACHINEDelete", parms);
        }

        /// <summary>
        /// 根据 LIST_MACHINEId 获取实体信息。
        /// </summary>
        /// <param name="lIST_MACHINEId">LIST_MACHINEId。</param>
        /// <returns>LIST_MACHINE 实体对象。</returns>
        public LoadingList_MACHINEInfo GetInfo(Int32 lIST_MACHINEId)
        {
            LoadingList_MACHINEInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = lIST_MACHINEId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "LOADING_LIST_MACHINEGetInfo", parms))
            {
                if (rdr.Read())
                {

                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LIST_MACHINE 实体对象。</returns>
        public List<LoadingList_MACHINEInfo> GetInfo(String fieldValue)
        {
            List<LoadingList_MACHINEInfo> list = new List<LoadingList_MACHINEInfo>();

            LoadingList_MACHINEInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingListMachine_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadingList_MACHINEInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2),rdr.GetString(3));

                    list.Add(entity);
                }
                rdr.Close(); ;
            }

            return list;
        }

        /// <summary>
        /// 分页获取 LIST_MACHINE 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="lIST_MACHINECount">lIST_MACHINE 总数。</param>
        /// <returns>LIST_MACHINE 列表。</returns>
        public List<LoadingList_MACHINEInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadingList_MACHINEInfo> list = new List<LoadingList_MACHINEInfo>();
            LoadingList_MACHINEInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "dbo.Prod_LoadingListMachine", "LIST_MACHINEID",
                "[ID], [LoadingListID], [MachineID], [StatusID], [CurrentPanelSide], [IsConsumeByQty], [MachineNo]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    //entity = new LoadingList_MACHINEInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetByte(3), rdr.GetBoolean(4), 
                    //    rdr.GetBoolean(5), rdr.GetString(6));

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
