using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Web.Script.Serialization;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Product.BLL
{
    public class OrderBom
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） OrderBom 信息。
        /// </summary>
        /// <param name="entity">OrderBom 实体对象。</param>
        public void Edit(string obOrderNo, string obItemIDStr
            , string obUnitTypeIDStr, string obTotalNumStr, string obPerNumStr, string obOpeIDStr
            , string obCustIDStr, string obIsReStr, string CreateBy, int PrivacyBOM)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNo", SqlDbType.VarChar, 100),
                //new SqlParameter("@obSeqStr", SqlDbType.NVarChar,5000),
                new SqlParameter("@obItemCodeStr", SqlDbType.NVarChar,5000),
                new SqlParameter("@obUnitTypeStr", SqlDbType.NVarChar,5000),
                new SqlParameter("@obTotalNumStr", SqlDbType.NVarChar,5000),
                new SqlParameter("@obPerNumStr", SqlDbType.NVarChar,5000),
                new SqlParameter("@obOpeIDStr", SqlDbType.NVarChar,5000),
                new SqlParameter("@obCustIDStr", SqlDbType.NVarChar,5000),
                new SqlParameter("@obIsReStr", SqlDbType.NVarChar,5000),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar,100)
                ,new SqlParameter("@PrivacyBOMFlag", SqlDbType.Int)
            };

            parms[0].Value = obOrderNo;
            //parms[1].Value = obSeqStr;
            parms[1].Value = obItemIDStr;
            parms[2].Value = obUnitTypeIDStr;
            parms[3].Value = obTotalNumStr;
            parms[4].Value = obPerNumStr;
            parms[5].Value = obOpeIDStr;
            parms[6].Value = obCustIDStr;
            parms[7].Value = obIsReStr;
            parms[8].Value = CreateBy;
            parms[9].Value = PrivacyBOM;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_OrderBom_Edit", parms);
            
        }

        /// <summary>
        /// 根据 OrderBomId 字符串删除 OrderBom 信息。
        /// </summary>
        /// <param>OrderBomId 工单，序号，物料code。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String OrderNo, String AssSeq ,String ItemID)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNo", SqlDbType.NVarChar, 100),
                new SqlParameter("@AssSeq", SqlDbType.NVarChar, 100),
                new SqlParameter("@ItemID", SqlDbType.NVarChar, 100)
            };

            parms[0].Value = OrderNo;
            parms[1].Value = AssSeq;
            parms[2].Value = ItemID;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_OrderBom_Delete", parms);
        }

     
        /// <summary>
        /// 根据 OrderNo 获取实体信息。
        /// </summary>
        /// <param name="OrderNo">工单。</param>
        /// <returns>OrderBom 实体对象。</returns>
        public List<OrderBomInfo> GetInfo(int OrderID ,int BomID,int ChoosingFlag)
        {
            List<OrderBomInfo> list = new List<OrderBomInfo>();
            OrderBomInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderID", SqlDbType.Int), 
                new SqlParameter("@BomID", SqlDbType.Int),
                new SqlParameter("@ChoosingFlag", SqlDbType.Int)
            };

            parms[0].Value = OrderID;
            parms[1].Value = BomID;
            parms[2].Value = ChoosingFlag;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_OrderBom_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new OrderBomInfo();
                    entity.ItemID = rdr["ItemID"].ToString();
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    entity.ItemName = rdr["ItemName"].ToString();
                    entity.AssOperationID =  rdr["AssOperationID"].ToString();
                    entity.Operation = rdr["Station"].ToString();
                    entity.CompCount = rdr["CompCount"].ToString();
                    entity.PerNum = rdr["PerNum"].ToString();
                    entity.DataTypeID = rdr["DataTypeID"].ToString();
                    entity.DataTypeName = rdr["DataTypeName"].ToString();
                    entity.IsReplacement = rdr["IsReplacement"].ToString();
                    entity.IsCustomize = rdr["IsCustomize"].ToString();
                    entity.CustomID = rdr["CustomID"].ToString();
                    entity.CustName = rdr["CustomerName"].ToString();
                    entity.CustCode = rdr["CustomerCode"].ToString();
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreateDateTime = rdr["CreateDateTime"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            //recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 OrderBom 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="orderBomCount">orderBom 总数。</param>
        /// <returns>OrderBom 列表。</returns>
//        public List<OrderBomInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
//        {
//            List<OrderBomInfo> list = new List<OrderBomInfo>();
//            OrderBomInfo entity = null;

//            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_OrderBom", "OrderBomID",
//                @"[OrderBomID], [OrderNo], [AssSequence], [ItemID], [AssOperationID], [RefDes], [CompCount]
//                , [PerNum], [DataTypeID], [IsReplacement], [IsCustomize], [CustomID], [CreateBy], [CreateDateTime]
//                , [ModifyBy], [ModifyDateTime], [Remark]"
//                , searchSettings, sortExpression);

//            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
//            {
//                while (rdr.Read())
//                {
//                    entity = new OrderBomInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4), 
//                        rdr.GetString(5), rdr.GetDouble(6), rdr.GetDouble(7), rdr.GetInt32(8), rdr.GetBoolean(9), 
//                        rdr.GetBoolean(10), rdr.GetInt32(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14),
//                        rdr.GetDateTime(15), rdr.GetString(16));

//                    list.Add(entity);
//                }
//                rdr.Close();
//            }

//            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
//            return list;
//        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// MES8.5  获取 当前版本产品BOM。
        /// </summary>
        /// 
        public string GetCurItemBom(int itemId)
        {
            ItemBomInfo entity = new ItemBomInfo();
            List<ItemBomInfo> list = new List<ItemBomInfo>();
            string sql =
                " SELECT TOP 1 ItemBomId,BomName,ItemName FROM Basal_ItemBom " +
                "WHERE IsCurrentVer=1 AND [State]=1 AND ItemId=" + itemId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, null))
            {
                if (rdr.Read())
                {
                    entity.ItemBomId = (int)rdr["ItemBomId"];
                    entity.BomName = rdr["BomName"].ToString();
                    entity.ItemName = rdr["ItemName"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }

            return new JavaScriptSerializer().Serialize(list);
        }


        #region 根据工单，工序，获取物料
        /// <summary>
        /// 根据工单，工序，获取物料
        /// </summary>
        /// <returns></returns>
        public List<ItemInfo> GetItemInMenCall(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemInfo> list = new List<ItemInfo>();
            //表名或者视图
            string strTb = "vwGetItemInMenCall";
            //主键
            string strKey = "ItemID";
            //查询栏位字串
            string strColumns = @" ItemID,ItemCode,ItemName,Station ";

            return ComMethod.GetComList<ItemInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            
        }

        #endregion

        #region 叫料信息
        /// <summary>
        /// 叫料信息 uspGetCryMaterialInfo
        /// </summary>
        /// <returns></returns>
        public List<ItemInfo> GetMenCallInfo(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemInfo> list = new List<ItemInfo>();
            //表名或者视图
            string strTb = "vwMenCallMaterialInfo";
            //主键
            string strKey = "RecordID";
            //查询栏位字串
            string strColumns = @" RecordID,ItemID,OrderNO,ItemCode,ItemName,PerNum,Qty,OutQty,SumQty,RequireTime
                                    ,States,CreateBy,CreateDateTime ";

            return ComMethod.GetComList<ItemInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

        }
        #endregion

        /// <summary>
        /// 获取手动叫料数量信息 
        /// </summary>
        /// <returns></returns>
        public string GetMenCallDetailInfo(int orderId, int stationId, int itemId)
        {
            OrderBomInfo entity = new OrderBomInfo();
            List<OrderBomInfo> list = new List<OrderBomInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderID", SqlDbType.Int), 
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int)
            };

            parms[0].Value = orderId;
            parms[1].Value = stationId;
            parms[2].Value = itemId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetMenCallDetail", parms))
            {
                if (rdr.Read())
                {
                    entity.PerNum = Convert.ToInt32(rdr["PerNum"]);
                    entity.TotalNum = Convert.ToInt32(rdr["TotalNum"]);
                    entity.EndNum = Convert.ToInt32(rdr["EndNum"]);
                    entity.SumOutNum = Convert.ToInt32(rdr["SumOutNum"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            return new JavaScriptSerializer().Serialize(list);
        }

        /// <summary>
        /// 保存叫料。
        /// </summary>
        public void SaveMenCall(int orderId, int itemId, int stationId, int resId
            ,int callNum, string rdate, string curUser)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderId", SqlDbType.Int),
                new SqlParameter("@ItemID", SqlDbType.Int),
                new SqlParameter("@CallNum", SqlDbType.Int),
                new SqlParameter("@ReqDate", SqlDbType.VarChar, 20),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@ResId", SqlDbType.Int),
                new SqlParameter("@userName", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = orderId;
            parms[1].Value = itemId;
            parms[2].Value = callNum;
            parms[3].Value = rdate;
            parms[4].Value = stationId;
            parms[5].Value = resId;
            parms[6].Value = curUser;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveMenCall", parms);
        }


        /// <summary>
        /// 取消叫料。
        /// </summary>
        public void CancelMenCall(int recId, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RecId", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.NVarChar, 100)
            };

            parms[0].Value = recId;
            parms[1].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCancelMenCall", parms);

        }

        /// <summary>
        /// 工单BOM明细列表导出EXCEL获取数据的方法
        /// </summary>
        /// <param name="OrderID">OrderID</param>
        /// <param name="BomID">BomID</param>
        /// <param name="ChoosingFlag">ChoosingFlag</param>
        /// <returns></returns>
        public DataTable ImportToExcel(int OrderID,int BomID,int ChoosingFlag)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderID", SqlDbType.Int),
                new SqlParameter("@BomID", SqlDbType.Int),
                new SqlParameter("@ChoosingFlag", SqlDbType.Int)
            };

            parms[0].Value = OrderID;
            parms[1].Value = BomID;
            parms[2].Value = ChoosingFlag;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspOrderBomToEXCEL", parms);
        }

    }
}