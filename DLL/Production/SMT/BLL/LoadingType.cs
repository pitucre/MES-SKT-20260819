using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.PubItems.Model;
using System.Web.Script.Serialization;

namespace SKT.LeanMES.SMT.BLL
{
    public class LoadingType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） LoadingType 信息。
        /// </summary>
        /// <param name="entity">LoadingType 实体对象。</param>
        public Int32 Edit(LoadingTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LoadingTypeID", SqlDbType.Int),
                new SqlParameter("@TypeName", SqlDbType.NVarChar, 100),
                new SqlParameter("@BeginRow", SqlDbType.Int),
                new SqlParameter("@Positon", SqlDbType.Int),
                new SqlParameter("@PartNum", SqlDbType.Int),
                new SqlParameter("@ReplaceNum", SqlDbType.Int),
                new SqlParameter("@Num", SqlDbType.Int),
                new SqlParameter("@ColFeederType", SqlDbType.Int),
                new SqlParameter("@ColLocationType", SqlDbType.Int),
                new SqlParameter("@Point", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@Surface", SqlDbType.NVarChar, 50),
                new SqlParameter("@Positon2", SqlDbType.Int),
                new SqlParameter("@ColArea", SqlDbType.Int),
                 new SqlParameter("@ElementDescription", SqlDbType.Int)
            };

            parms[0].Value = entity.LoadingTypeId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.TypeName;
            parms[2].Value = entity.BeginRow;
            parms[3].Value = entity.ColPosition;
            parms[4].Value = entity.ColPartNum;
            parms[5].Value = entity.ColReplaceNum;
            parms[6].Value = entity.ColNum;
            parms[7].Value = entity.ColFeederType;
            parms[8].Value = entity.ColLocationType;
            parms[9].Value = entity.ColPoint;
            parms[10].Value = entity.CreateBy;
            parms[11].Value = entity.ModifyBy;
            parms[12].Value = entity.Remark;
            parms[13].Value = entity.ColTable;
            parms[14].Value = entity.ColPosition_2;
            parms[15].Value = entity.ColArea;
            parms[16].Value = entity.ElementDescription;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingType_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LoadingTypeId 字符串删除 LoadingType 信息。
        /// </summary>
        /// <param name="idString">LoadingTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingType_Delete", parms);
        }

        /// <summary>
        /// 根据 LoadingTypeId 获取实体信息。
        /// </summary>
        /// <param name="loadingTypeId">LoadingTypeId。</param>
        /// <returns>LoadingType 实体对象。</returns>
        public LoadingTypeInfo GetInfo(Int32 loadingTypeId)
        {
            LoadingTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = loadingTypeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LoadingTypeInfo();
                    entity.LoadingTypeId = Convert.ToInt32(rdr[0]);
                    entity.TypeName = Convert.ToString(rdr[1]);
                    entity.BeginRow = Convert.ToInt32(rdr[2]);
                    entity.ColPosition = Convert.ToInt32(rdr[3]);
                    entity.ColPartNum = Convert.ToInt32(rdr[4]);
                    entity.ColReplaceNum = Convert.ToInt32(rdr[5]);
                    entity.ColNum = Convert.ToInt32(rdr[6]);
                    entity.ColPoint = Convert.ToInt32(rdr[7]);
                    entity.CreateBy = Convert.ToString(rdr[8]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr[9]);
                    entity.Remark = Convert.ToString(rdr[10]);
                    entity.ColTable = Convert.ToInt32(rdr[11]);
                    entity.ColFeederType = Convert.ToInt32(rdr[12]);
                    entity.ColLocationType = Convert.ToInt32(rdr[13]);
                    entity.ColPosition_2 = Convert.ToInt32(rdr[14]);
                    entity.ColArea = Convert.ToInt32(rdr[15]);
                    entity.ElementDescription = Convert.ToInt32(rdr[16]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LoadingType 实体对象。</returns>
        public LoadingTypeInfo GetInfo(String fieldValue)
        {
            LoadingTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LoadingTypeInfo();
                    entity.LoadingTypeId = Convert.ToInt32(rdr[0]);
                    entity.TypeName = Convert.ToString(rdr[1]);
                    entity.BeginRow = Convert.ToInt32(rdr[2]);
                    entity.ColPosition = Convert.ToInt32(rdr[3]);
                    entity.ColPartNum = Convert.ToInt32(rdr[4]);
                    entity.ColReplaceNum = Convert.ToInt32(rdr[5]);
                    entity.ColNum = Convert.ToInt32(rdr[6]);
                    entity.ColPoint = Convert.ToInt32(rdr[7]);
                    entity.CreateBy = Convert.ToString(rdr[8]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr[9]);
                    entity.Remark = Convert.ToString(rdr[10]);
                    entity.ColTable = Convert.ToInt32(rdr[11]);
                    entity.ColFeederType = Convert.ToInt32(rdr[12]);
                    entity.ColLocationType = Convert.ToInt32(rdr[13]);
                    entity.ColPosition_2 = Convert.ToInt32(rdr[14]);
                    entity.ColArea = Convert.ToInt32(rdr[15]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 LoadingType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="loadingTypeCount">loadingType 总数。</param>
        /// <returns>LoadingType 列表。</returns>
        public List<LoadingTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadingTypeInfo> list = new List<LoadingTypeInfo>();
            LoadingTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow,
                maxRows,
                "vwLoadingType",
                "LoadingTypeId",
                "[LoadingTypeId], [TypeName], [BeginRow], [ColPosition], [ColPartNum], [ColReplaceNum]" +
                ", [ColNum], [ColPoint], [CreateBy], [CreateDateTime]" +
                ", [ModifyBy], [ModifyDateTime], [Remark],ColTable,ColFeederType,ColLocationType,ColPosition_2,ColArea,ElementDescription",
                searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadingTypeInfo();
                    entity.LoadingTypeId = Convert.ToInt32(rdr[0]);
                    entity.TypeName = Convert.ToString(rdr[1]);
                    entity.BeginRow = Convert.ToInt32(rdr[2]);
                    entity.ColPosition = Convert.ToInt32(rdr[3]);
                    entity.ColPartNum = Convert.ToInt32(rdr[4]);
                    entity.ColReplaceNum = Convert.ToInt32(rdr[5]);
                    entity.ColNum = Convert.ToInt32(rdr[6]);
                    entity.ColPoint = Convert.ToInt32(rdr[7]);
                    entity.CreateBy = Convert.ToString(rdr[8]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr[9]);
                    entity.ModifyBy = Convert.ToString(rdr[10]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr[11]);
                    entity.Remark = Convert.ToString(rdr[12]);
                    entity.ColTable = Convert.ToInt32(rdr[13]);
                    entity.ColFeederType = Convert.ToInt32(rdr[14]);
                    entity.ColLocationType = Convert.ToInt32(rdr[15]);
                    entity.ColPosition_2 = Convert.ToInt32(rdr[16]);
                    entity.ColArea = Convert.ToInt32(rdr[17]);
                    entity.ElementDescription = Convert.ToInt32(rdr[18]);
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

        //用于获取 LoadingList类型
        public List<PubItemsInfo> GetLoadType(SearchSettings searchSettings)
        {
            PubItemsInfo entity = null;
            List<PubItemsInfo> list = new List<PubItemsInfo>();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1
                , "Prod_LoadingType"
                , "LoadingTypeId"
                , "LoadingTypeId ,TypeName", searchSettings, "LoadingTypeId");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PubItemsInfo();
                    entity.ItemValue = rdr["LoadingTypeId"].ToString();
                    entity.ItemName = rdr["TypeName"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //return new JavaScriptSerializer().Serialize(list);
            return list;
        }

        //用于获取 SMT线别设备类型
        public String GetSMTLineRelationType(SearchSettings searchSettings)
        {
            PubItemsInfo entity = null;
            List<PubItemsInfo> list = new List<PubItemsInfo>();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1
                , "Basal_EquipmentLineRelation"
                , "EquipmentLineId"
                , "EquipmentLineId ,EquipmentLineDisplayName", searchSettings, "EquipmentLineId");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PubItemsInfo();
                    entity.ItemValue = rdr["EquipmentLineId"].ToString();
                    entity.ItemName = rdr["EquipmentLineDisplayName"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            return new JavaScriptSerializer().Serialize(list);
        }


        //用于获取 SMT线别设备类型zhuxi add 20171031
        public String GetSMTLineRelationTypeT(SearchSettings searchSettings)
        {
            PubItemsInfo entity = null;
            List<PubItemsInfo> list = new List<PubItemsInfo>();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1
                , "Basal_EquipmentLineRelation"
                , "EquipmentLineId"
                , "EquipmentLineId ,EquipmentLineType", searchSettings, "EquipmentLineId");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PubItemsInfo();
                    entity.ItemValue = rdr["EquipmentLineId"].ToString();
                    entity.ItemName = rdr["EquipmentLineType"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            return new JavaScriptSerializer().Serialize(list);
        }
        //用于获取 SMT线别设备类型的排序/机台数量
        public String GetSMTLineSequence(string linetype)
        {
            PubItemsInfo entity = null;
            List<PubItemsInfo> list = new List<PubItemsInfo>();
            SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            string EquipmentLineType = "";
            searchSettings.ExtensionCondition = "EquipmentLineId=" + linetype;
            //searchSettings.AddCondition("EquipmentLineId", linetype);
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1
                , "Basal_EquipmentLineRelation"
                , "EquipmentLineId"
                , "EquipmentLineId,EquipmentLineType ", searchSettings, "EquipmentLineId");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    EquipmentLineType = rdr["EquipmentLineType"].ToString();

                }
                rdr.Close();
            }
            string[] codeArr = EquipmentLineType.Split(new char[] { ',', '，' }, StringSplitOptions.RemoveEmptyEntries);
            for (int i = 0; i < codeArr.Length; i++)
            {
                entity = new PubItemsInfo();
                entity.ItemValue = i + 1;
                entity.ItemName = (i + 1).ToString() + " (" + codeArr[i] + ")";
                list.Add(entity);
            }
            return new JavaScriptSerializer().Serialize(list);
        }

        public List<LoadingList_DetailInfo> GetLoadTypeTempView(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadingList_DetailInfo> list = new List<LoadingList_DetailInfo>();
            LoadingList_DetailInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwTempLoadingListView"
                , "LoadingListDetailId"
                , " LoadingListDetailId, LoadingListId, SetupName, Position, MaterialItemCode" +
                  ", SmtNum, SmtTable, LocationType,Point,ReplaceNum,FeederType,Area,ElementDescription "
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
                    entity.ElementDescription = rdr["ElementDescription"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public void SaveTempLoading(int type)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TypeId", SqlDbType.Int)
            };
            parms[0].Value = type;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspTempLoadingList", parms);
        }
    }
}
