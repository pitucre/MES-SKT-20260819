using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.SMT.BLL
{
    public class PickList
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// add by weixia on 2015.11.11
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="GridTable"></param>
        /// <returns></returns>
        public int SavePickListAdd(PickListInfo entity, DataTable GridTable)
        {
            int ErrorMsg = 0;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@SetupName", SqlDbType.VarChar),
                new SqlParameter("@CustomerId", SqlDbType.Int),
                new SqlParameter("@Revision", SqlDbType.VarChar),
                new SqlParameter("@ResId", SqlDbType.Int),
                new SqlParameter("@LineID", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar,20),
                new SqlParameter("@Remark", SqlDbType.VarChar,20),
                new SqlParameter("@PickListData", SqlDbType.Structured),
                new SqlParameter("@IsFullSet",SqlDbType.Bit)
            };

            parms[0].Value = entity.ItemID;
            parms[1].Value = entity.ListName;
            parms[2].Value = entity.CustomerID;
            parms[3].Value = entity.Revision;
            parms[4].Value = entity.StationID;
            parms[5].Value = entity.LineID;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.Remark;
            parms[8].Value = GridTable;
            parms[9].Value = entity.IsFullSet;
            ErrorMsg = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PickList_Add", parms);
            return ErrorMsg;
        }

        /// <summary>
        /// 上料验证
        /// add by weixia on 2016.8.11
        /// </summary>
        /// <param name="entity"></param>
        public void PickListAddMaterial(Int32 lineId, Int32 resId, Int32 prodOrderId, String oldGRN, String newGRN, String userName, String location)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineID", SqlDbType.Int),
                new SqlParameter("@ResID", SqlDbType.Int),
                new SqlParameter("@ProdOrderID", SqlDbType.Int),
                new SqlParameter("@OldGRN", SqlDbType.NVarChar,100),
                new SqlParameter("@NewGRN", SqlDbType.NVarChar,100),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@Location", SqlDbType.VarChar,100)
            };

            parms[0].Value = lineId;
            parms[1].Value = resId;
            parms[2].Value = prodOrderId;
            parms[3].Value = oldGRN;
            parms[4].Value = newGRN;
            parms[5].Value = userName;
            parms[6].Value = location;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPickListAddMaterial", parms);

        }

        /// <summary>
        /// 线别设置
        /// add by weixia on 2016.8.10
        /// </summary>
        /// <param name="entity"></param>
        public void SavePickListMap(Int32 lineId, Int32 resId, Int32 prodOrderId, Int32 pickListId, String grn, String userName, String location)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineID", SqlDbType.Int),
                new SqlParameter("@ResID", SqlDbType.Int),
                new SqlParameter("@ProdOrderID", SqlDbType.Int),
                new SqlParameter("@PickListID", SqlDbType.Int),
                new SqlParameter("@GRN", SqlDbType.NVarChar,100),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@Location", SqlDbType.VarChar,100)
            };

            parms[0].Value = lineId;
            parms[1].Value = resId;
            parms[2].Value = prodOrderId;
            parms[3].Value = pickListId;
            parms[4].Value = grn;
            parms[5].Value = userName;
            parms[6].Value = location;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspValidatePickListMap", parms);

        }

        /// <summary>
        /// 手插上料 开拉/停拉
        /// add by weixia on 2016.8.10
        /// </summary>
        /// <param name="entity"></param>
        public void PickListPullAndStop(Int32 resId, Int32 lineId, Int32 pickListId, Int32 prodOrderId, String userName, Int32 falge)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineID", SqlDbType.Int),
                new SqlParameter("@ResID", SqlDbType.Int),
                new SqlParameter("@ProdOrderID", SqlDbType.Int),
                new SqlParameter("@PickListId", SqlDbType.Int),
                new SqlParameter("@Flage", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = lineId;
            parms[1].Value = resId;
            parms[2].Value = prodOrderId;
            parms[3].Value = pickListId;
            parms[4].Value = falge;
            parms[5].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPickListPullAndStop", parms);
        }

        /// <summary>
        /// 手插卸料
        /// add by weixia on 2016.8.10
        /// </summary>
        /// <param name="entity"></param>
        public void PickListUnLoadMaterial(Int32 resId, Int32 lineId, Int32 pickListId, Int32 prodOrderId, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineID", SqlDbType.Int),
                new SqlParameter("@ResID", SqlDbType.Int),
                new SqlParameter("@ProdOrderID", SqlDbType.Int),
                new SqlParameter("@PickListId", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = lineId;
            parms[1].Value = resId;
            parms[2].Value = prodOrderId;
            parms[3].Value = pickListId;
            parms[4].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPickListUnLoadMaterial", parms);
        }

        /// <summary>
        /// 线别设置
        /// add by weixia on 2016.8.10
        /// </summary>
        /// <param name="entity"></param>
        public void PickListLineSetUp(Int32 resId, Int32 lineId, Int32 pickListId, Int32 prodOrderId, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ResId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@PickListId", SqlDbType.Int),
                new SqlParameter("@ProdOrderId", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = resId;
            parms[1].Value = lineId;
            parms[2].Value = pickListId;
            parms[3].Value = prodOrderId;
            parms[4].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCreatePickListLineSetUp", parms);

        }
        /// <summary>
        /// 编辑（添加或更新） PickList 信息。
        /// </summary>
        /// <param name="entity">PickList 实体对象。</param>
        public void Edit(PickListInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PickListId", SqlDbType.Int),
                new SqlParameter("@ListName", SqlDbType.NVarChar, 100),
                new SqlParameter("@ItemID", SqlDbType.Int),
                new SqlParameter("@StationID", SqlDbType.Int),
                new SqlParameter("@LineID", SqlDbType.Int),
                new SqlParameter("@CustomerID", SqlDbType.Int),
                new SqlParameter("@Status", SqlDbType.TinyInt),
                new SqlParameter("@IsFullSet", SqlDbType.Bit),
                new SqlParameter("@Revision", SqlDbType.VarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 100),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.ListID;
            parms[1].Value = entity.ListName;
            parms[2].Value = entity.ItemID;
            parms[3].Value = entity.StationID;
            parms[4].Value = entity.LineID;
            parms[5].Value = entity.CustomerID;
            parms[6].Value = entity.StatusID;
            parms[7].Value = entity.IsFullSet;
            parms[8].Value = entity.Revision;
            parms[9].Value = entity.Remark;
            parms[10].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PickList_Edit", parms);

        }

        /// <summary>
        /// 根据 PickListId 字符串删除 PickList 信息。
        /// </summary>
        /// <param name="idString">PickListId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(Int32 pickListId, Int32 flage, String pickListIdString, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PickListId", SqlDbType.Int),
                new SqlParameter("@flage", SqlDbType.Int),
                new SqlParameter("@PickListIdString",SqlDbType.NVarChar,8000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 50),
            };

            parms[0].Value = pickListId;
            parms[1].Value = flage;
            parms[2].Value = pickListIdString;
            parms[3].Value = UserName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PickList_Delete", parms);
        }

        /// <summary>
        /// 根据不同的上料类型和用户名返回信息
        /// </summary>
        /// <param name="loadMaterialType"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public PickListInfo GetMaterialInfoByUser(Int32 loadMaterialType, String userName)
        {
            PickListInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LoadMaterialType", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar,20)
            };

            parms[0].Value = loadMaterialType;
            parms[1].Value = userName;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetMaterialInfoByUser", parms))
            {
                if (rdr.Read())
                {
                    entity = new PickListInfo();
                    entity.LineID = rdr.GetInt32(0);
                    entity.LineName = rdr.GetString(1);
                    entity.ResId = rdr.GetInt32(2);
                    entity.ResName = rdr.GetString(3);
                    entity.ProdOrderID = rdr.GetInt32(4);
                    entity.OrderNo = rdr.GetString(5);
                    entity.ListID = rdr.GetInt32(6);
                    entity.ListName = rdr.GetString(7);
                    entity.ItemID = rdr.GetInt32(8);
                    entity.ItemCode = rdr.GetString(9);
                    entity.ItemName = rdr.GetString(10);
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// add by weixia on 2016.8.10手插上料验证扫描grn带出信息
        /// </summary>
        /// <param name="lineId"></param>
        /// <param name="resId"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public PickListInfo GetHandMaterialInfoByGRN(Int32 resId, Int32 prodOrderId, Int32 pickListId, String GRN)
        {
            PickListInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ResID", SqlDbType.Int),
                new SqlParameter("@ProdOrderID", SqlDbType.Int),
                new SqlParameter("@PickListId", SqlDbType.Int),
                new SqlParameter("@GRN", SqlDbType.NVarChar,100)
            };

            parms[0].Value = resId;
            parms[1].Value = prodOrderId;
            parms[2].Value = pickListId;
            parms[3].Value = GRN;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetHandMaterialInfoByGRN", parms))
            {
                if (rdr.Read())
                {
                    entity = new PickListInfo();
                    entity.LocationStr = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.ItemCode = rdr.GetString(2);
                    entity.ItemName = rdr.GetString(3);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// add by weixia on 2016.8.10 续料时验证相关信息
        /// </summary>
        /// <param name="lineId"></param>
        /// <param name="resId"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public PickListInfo CheckAddMaterial(String grn, Int32 checkType)
        {
            PickListInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@GRN", SqlDbType.VarChar,100),
                new SqlParameter("@CheckType", SqlDbType.Int)
            };

            parms[0].Value = grn;
            parms[1].Value = checkType;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckAddMaterial", parms))
            {
                if (rdr.Read())
                {
                    entity = new PickListInfo();
                    entity.LocationStr = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.ItemCode = rdr.GetString(2);
                    entity.ItemName = rdr.GetString(3);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// add by weixia  on 2016.8.15查询pickList上料数据
        /// </summary>
        /// <param name="lId"></param>
        /// <returns></returns>
        public List<PickListInfo> GetPickListBySearch(Int32 lineId, Int32 resId, Int32 prodOrderId, Int32 pickListId)
        {
            PickListInfo entity = null;
            List<PickListInfo> list = new List<PickListInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ResId", SqlDbType.Int),
                new SqlParameter("@ProdOrderId", SqlDbType.Int),
                new SqlParameter("@PickList", SqlDbType.Int)
            };
            parms[0].Value = lineId;
            parms[1].Value = resId;
            parms[2].Value = prodOrderId;
            parms[3].Value = pickListId;


            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPickListBySearch", parms))
            {
                while (rdr.Read())
                {
                    entity = new PickListInfo();
                    entity.ItemCode = rdr.GetString(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.GrnStr = rdr.GetString(2);
                    entity.AlreadyQty = rdr.GetDecimal(3);
                    entity.NotQty = rdr.GetDecimal(4);
                    entity.NeedQty = rdr.GetDecimal(5);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// add by weixia on 2016.8.10根据线别资源获取相应数据信息
        /// </summary>
        /// <param name="lineId"></param>
        /// <param name="resId"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public PickListInfo ShowHandListByOrder(Int32 lineId, Int32 resId, Int32 prodOrderId, Int32 checkMType)
        {
            PickListInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ResId", SqlDbType.Int),
                new SqlParameter("@ProdOrderId", SqlDbType.Int),
                new SqlParameter("@CheckMType",SqlDbType.Int)
            };

            parms[0].Value = lineId;
            parms[1].Value = resId;
            parms[2].Value = prodOrderId;
            parms[3].Value = checkMType;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspShowHandListByOrder", parms))
            {
                if (rdr.Read())
                {
                    entity = new PickListInfo();
                    entity.ListID = rdr.GetInt32(0);
                    entity.ListName = rdr.GetString(1);
                    entity.ItemID = rdr.GetInt32(2);
                    entity.ItemCode = rdr.GetString(3);
                    entity.ItemName = rdr.GetString(4);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PickList 实体对象。</returns>
        public PickListInfo GetInfo(Int32 pickListId)
        {
            PickListInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PickListId", SqlDbType.Int)
            };

            parms[0].Value = pickListId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_PickList_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PickListInfo();
                    entity.ListID = rdr.GetInt32(0);
                    entity.ListName = rdr.GetString(1);
                    entity.ItemID = rdr.GetInt32(2);
                    entity.ItemName = rdr.GetString(3);
                    entity.ResId = rdr.GetInt32(4);
                    entity.ResName = rdr.GetString(5);
                    entity.LineID = rdr.GetInt32(6);
                    entity.LineName = rdr.GetString(7);
                    entity.CustomerID = rdr.GetInt32(8);
                    entity.CustomerName = rdr.GetString(9);
                    entity.StatusID = rdr.GetInt32(10);
                    entity.StatusStr = rdr.GetString(11);
                    entity.IsFullSet = rdr.GetBoolean(12);
                    entity.Revision = rdr.GetString(13);
                    entity.Remark = rdr.GetString(14);
                    entity.CreateBy = rdr.GetString(15);
                    entity.ItemCode = rdr.GetString(16);
                }
                rdr.Close();
            }

            return entity;
        }


        /// <summary>
        /// 分页获取 PickList 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="pickListCount">pickList 总数。</param>
        /// <returns>PickList 列表。</returns>
        public List<PickListInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PickListInfo> list = new List<PickListInfo>();
            PickListInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetAllPickList", "ListId",
                "[ListId], [ListName], [ItemName], [ResName], [LineName], [CustomerName], [StatusStr], [Revision], [CreateBy], [CreationTime], [ItemCode], StatusID,ModifyBy,ModifyDateTime,OrderNo", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PickListInfo();
                    entity.ListID = rdr.GetInt32(0);
                    entity.ListName = rdr.GetString(1);
                    entity.ItemName = rdr.GetString(2);
                    entity.ResName = rdr.GetString(3);
                    entity.LineName = rdr.GetString(4);
                    entity.CustomerName = rdr.GetString(5);
                    entity.StatusStr = rdr.GetString(6);
                    entity.Revision = rdr.GetString(7);
                    entity.CreateBy = rdr.GetString(8);
                    entity.CreationTime = rdr.GetDateTime(9);
                    entity.ItemCode = rdr.GetString(10);
                    entity.StatusID = Convert.ToInt32(rdr["StatusID"]);
                    entity.ModifyBy= rdr.GetString(12);
                    entity.ModifyDateTime = rdr.GetDateTime(13);
                    entity.OrderNo = rdr["OrderNo"].ToString();
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
        /// 批次上料清单—启用
        /// </summary>
        /// <param name="entity"></param>
        public void PickLoadingStart(PickListInfo entity)
        {
            SqlParameter[] prams = new SqlParameter[] {
                new SqlParameter("@ListId", SqlDbType.Int),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };
            prams[0].Value = entity.ListID;
            prams[1].Value = entity.ModifyBy;
            ComMethod.Edit("uspPickLoadingStart", prams);
        }

    }
}