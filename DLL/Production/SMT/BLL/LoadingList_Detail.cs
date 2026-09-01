using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.SMT.Model;


namespace SKT.LeanMES.SMT.BLL
{
    public class LoadingList_DETAIL
    {
        private Int32 recordCount = 0;

        //public void SaveLoadingListDetail(Int32 detailId, Int32 itemId, String location, Int32 needQty, Int32 feederTypeId)
        //{
        //    SqlParameter[] parms = new SqlParameter[]{
        //        new SqlParameter("@DetailId", SqlDbType.Int),
        //        new SqlParameter("@ItemId", SqlDbType.Int),
        //        new SqlParameter("@Location", SqlDbType.VarChar,100),
        //        new SqlParameter("@NeedQty", SqlDbType.Int),
        //        new SqlParameter("@FeederTypeId", SqlDbType.Int)
        //    };

        //    parms[0].Value = detailId;
        //    parms[1].Value = itemId;
        //    parms[2].Value = location;
        //    parms[3].Value = needQty;
        //    parms[4].Value = feederTypeId;

        //    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveLoadingListDetail", parms);
        //}

        /// <summary>
        /// 用户绑定关系的 LIST_DETAIL 信息导入。
        /// </summary>
        /// <param name="colSeq">处理后的列排序字符串。</param>
        public void SaveByUserBind(LoadinglistInfo entity)
        {

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@SetupName", SqlDbType.VarChar),
                new SqlParameter("@CustomerName", SqlDbType.VarChar),
                new SqlParameter("@Revision", SqlDbType.VarChar),
                new SqlParameter("@IsFullSet",SqlDbType.Bit),
                new SqlParameter("@LoadingType",SqlDbType.Int),
                new SqlParameter("@SmtLineTypeId",SqlDbType.Int),
                new SqlParameter("@SmtLineTypeSeq",SqlDbType.Int),
                new SqlParameter("@CreateBy",SqlDbType.NVarChar,50),
                new SqlParameter("@SmtLayout",SqlDbType.NVarChar,100),
                new SqlParameter("@CLNumber",SqlDbType.Decimal)
            };

            parms[0].Value = entity.ItemId; ;
            parms[1].Value = entity.SetupName;
            parms[2].Value = entity.CustomerName;
            parms[3].Value = entity.Revision;
            parms[4].Value = entity.IsFullSet;
            parms[5].Value = entity.LoadingTypeId;
            parms[6].Value = entity.EquipmentLineId;
            parms[7].Value = entity.SequenceNo;
            parms[8].Value = entity.CreateBy;
            parms[9].Value = entity.SmtLayout;
            parms[10].Value = entity.CLNumber;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveSMTListDetail", parms);
        }


        /// <summary>
        /// 编辑（添加或更新） LIST_DETAIL 信息。
        /// </summary>
        /// <param name="entity">LIST_DETAIL 实体对象。</param>
        public Int32 Edit(LoadingList_DetailInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@LoadingListMachineID", SqlDbType.Int),
                new SqlParameter("@MachineTableSlotID", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@TopFrequency", SqlDbType.Int),
                new SqlParameter("@TopLocation", SqlDbType.VarChar, 3950),
                new SqlParameter("@BottomFrequency", SqlDbType.Int),
                new SqlParameter("@BottomLocation", SqlDbType.VarChar, 3950),
                new SqlParameter("@StatusID", SqlDbType.TinyInt),
                new SqlParameter("@FeederTypeID", SqlDbType.Int)
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.LoadingListMachineID;
            parms[2].Value = entity.MachineTableSlotID;
            parms[3].Value = entity.ItemId;
            parms[4].Value = entity.TopFrequency;
            parms[5].Value = entity.TopLocation;
            parms[6].Value = entity.BottomFrequency;
            parms[7].Value = entity.BottomLocation;
            parms[8].Value = entity.StatusID;
            parms[9].Value = entity.FeederTypeID;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "LOADINGLISTDETAIL_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LIST_DETAILId 字符串删除 LIST_DETAIL 信息。
        /// </summary>
        /// <param name="idString">LIST_DETAILId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "LOADINGLISTDETAIL_Delete", parms);
        }

        /// <summary>
        /// 根据 LIST_DETAILId 获取实体信息。
        /// </summary>
        /// <param name="lIST_DETAILId">LIST_DETAILId。</param>
        /// <returns>LIST_DETAIL 实体对象。</returns>
        public LoadingList_DetailInfo GetInfo(Int32 lIST_DETAILId)
        {
            LoadingList_DetailInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DetailId", SqlDbType.Int)
            };

            parms[0].Value = lIST_DETAILId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetLoadingListDetailId", parms))
            {
                if (rdr.Read())
                {
                    entity = new LoadingList_DetailInfo();
                    entity.ID = rdr.GetInt32(0);
                    entity.Position = rdr.GetString(1);
                    entity.SmtTable = rdr.GetString(2);
                    entity.ItemCode = rdr.GetString(3);
                    entity.ItemId = rdr.GetInt32(4);
                    entity.SmtNum = rdr.GetString(5);
                    entity.FeederType = rdr.GetString(6);
                    entity.LocationType = rdr.GetString(7);
                    entity.Point = rdr.GetString(8);
                    entity.ReplaceNum = rdr.GetString(9);
                    entity.Area = rdr.GetString(10);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LIST_DETAIL 实体对象。</returns>
        public List<LoadingList_DetailInfo> GetInfo(String fieldValue)
        {
            List<LoadingList_DetailInfo> list = new List<LoadingList_DetailInfo>();
            LoadingList_DetailInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingListDetail_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadingList_DetailInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetString(3),
                        rdr.GetString(4), rdr.GetString(5));
                    entity.ItemCode = rdr.GetString(6);
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 分页获取 LIST_DETAIL 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="lIST_DETAILCount">lIST_DETAIL 总数。</param>
        /// <returns>LIST_DETAIL 列表。</returns>
        public List<LoadingList_DetailInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadingList_DetailInfo> list = new List<LoadingList_DetailInfo>();
            LoadingList_DetailInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_LoadingListDetail", "LIST_DETAILID",
                "[ID], [LoadingListMachineID], [MachineTableSlotID], [ItemId], [TopFrequency], [TopLocation], [BottomFrequency], [BottomLocation], [StatusID], [FeederTypeID]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadingList_DetailInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetByte(8), rdr.GetInt32(9));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        public List<LoadingList_DetailInfo> GetLoadingListDetailAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadingList_DetailInfo> list = new List<LoadingList_DetailInfo>();
            LoadingList_DetailInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwSMTLoadingListDetail"
                , "LoadingListDetailId"
                , " LoadingListDetailId, LoadingListId, SetupName, Position, MaterialItemCode" +
                  ", SmtNum, SmtTable, LocationType,Point,ReplaceNum,FeederType,Area "
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadingList_DetailInfo();
                    entity.LoadingListDetailId = (int)rdr["LoadingListDetailId"];
                    entity.LoadingListId = (int)rdr["LoadingListId"];
                    entity.SetupName = rdr["SetupName"].ToString();
                    entity.Position = rdr["Position"].ToString();
                    entity.ItemCode = rdr["MaterialItemCode"].ToString();
                    entity.SmtNum = rdr["SmtNum"].ToString();
                    entity.SmtTable = rdr["SmtTable"].ToString();
                    entity.LocationType = rdr["LocationType"].ToString();
                    entity.Point = rdr["Point"].ToString();
                    entity.ReplaceNum = rdr["ReplaceNum"].ToString();
                    entity.FeederType = rdr["FeederType"].ToString();
                    entity.Area = rdr["Area"].ToString();
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
        /// 插入LoadingListDetail 实体信息。
        /// </summary>
        ///    /// <param name="iD"></param>
        /// <param name="loadingListMachineID"></param>
        /// <param name="machineTableSlotID"></param>
        /// <param name="itemId"></param>
        /// <param name="topFrequency"></param>
        /// <param name="topLocation"></param>
        /// <param name="bottomFrequency"></param>
        /// <param name="bottomLocation"></param>
        /// <param name="statusID"></param>
        /// <param name="feederTypeID"></param>
        /// <param name="entity">LIDTST 实体对象。</param>
        public void SaveLoadingListDetail(LoadingList_DetailInfo entity,string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DetailId", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.VarChar,100),
                new SqlParameter("@Position", SqlDbType.VarChar,100),
                new SqlParameter("@SmtNum", SqlDbType.Decimal),
                new SqlParameter("@LocationType", SqlDbType.NVarChar,2000),
                new SqlParameter("@FeederType", SqlDbType.VarChar,100),
                new SqlParameter("@Point", SqlDbType.NVarChar,2000),
                new SqlParameter("@ReplaceNum", SqlDbType.VarChar,100),
                new SqlParameter("@LoadingListId", SqlDbType.Int),
                new SqlParameter("@Area", SqlDbType.VarChar),
                new SqlParameter("@UserName", SqlDbType.VarChar)
            };

            parms[0].Value = entity.LoadingListDetailId;
            parms[1].Value = entity.ItemCode;
            parms[2].Value = entity.Position;
            parms[3].Value =  entity.SmtNum;
            parms[4].Value = entity.LocationType;
            parms[5].Value = entity.FeederType;
            parms[6].Value = entity.Point;
            parms[7].Value = entity.ReplaceNum;
            parms[8].Value = entity.LoadingListId;
            parms[9].Value = entity.Area;
            parms[10].Value = UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveLoadingListDetail", parms);
        }

    }
}