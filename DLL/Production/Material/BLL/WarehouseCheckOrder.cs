using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Material.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Model;
using System.Web.Script.Serialization;

namespace SKT.LeanMES.Material.BLL
{
    public class WarehouseCheckOrder
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） WarehouseCheckOrder 信息。
        /// </summary>
        /// <param name="entity">WarehouseCheckOrder 实体对象。</param>
        public void  Edit(string  strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProdWarehouseCheckId", SqlDbType.Int),
                new SqlParameter("@CheckOrder", SqlDbType.VarChar, 50),
                new SqlParameter("@CheckTypeId", SqlDbType.Int),
                new SqlParameter("@WarehouseId", SqlDbType.Int),
                new SqlParameter("@BeginDate", SqlDbType.VarChar,20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
         //     new SqlParameter("@SN", SqlDbType.NVarChar,Int32.MaxValue),
                new SqlParameter("@CheckOrderName", SqlDbType.VarChar, 100),
                new SqlParameter("@TbDtl", SqlDbType.Structured),
            };

            /* parms[0].Value = entity.ProdWarehouseCheckId;
             //parms[0].Direction = ParameterDirection.InputOutput;
             parms[1].Value = entity.CheckOrder;
             parms[2].Value = entity.CheckTypeId;
             parms[3].Value = entity.WarehouseId;
             parms[4].Value = entity.Time;
             parms[5].Value = entity.Remark;
             parms[6].Value = entity.CreateBy;
             parms[7].Value = entity.SN;
             parms[8].Value = entity.CheckOrderName;

             SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_WarehouseCheckOrder_Edit", parms);*/

            ComMethod.Edit<WarehouseCheckOrderInfo>(strJson, "Prod_WarehouseCheckOrder_Edit", parms);
          //  return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据id返回对应的数据
        /// </summary>
        /// <param name="flage"></param>
        /// <param name="resId"></param>
        /// <returns></returns>
        public List<WarehouseCheckOrderInfo> GetMaterialForCheck(Int32 flage, Int32 whCheckId, int whId ,string searchItem)
        {
            List<WarehouseCheckOrderInfo> list = new List<WarehouseCheckOrderInfo>();
            WarehouseCheckOrderInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@Flag",SqlDbType.Int),
                new SqlParameter("@WhCheckId",SqlDbType.Int),
                new SqlParameter("@WhId",SqlDbType.Int),
                new SqlParameter("@ItemId",SqlDbType.NVarChar,2000)
            };
            parms[0].Value = flage;
            parms[1].Value = whCheckId;
            parms[2].Value = whId;
            parms[3].Value = searchItem;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetWhMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarehouseCheckOrderInfo();
                    entity.ItemCode = rdr.GetString(0);
                    entity.Item = rdr.GetString(1);
                    entity.WhBarcode = rdr.GetString(2);//货架
                    entity.StorageQty = rdr.GetDecimal(3);//库存
                    entity.SN = rdr.GetString(4);//SN/GSN
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        public List<WarehouseCheckOrderInfo> GetMaterialToChoose(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseCheckOrderInfo> list = new List<WarehouseCheckOrderInfo>();
            WarehouseCheckOrderInfo entity = null;
            //[vwMaterialForCheck]
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwTemWarehouseCheckInfo"
                , "MaterialUnitId"
                , @"ItemCode,ItemName,cBarCode,StockQty,GRN,ItemSpec,VendorCode,ABCCLass"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarehouseCheckOrderInfo();
                    entity.ItemCode = rdr.GetString(0);
                    entity.Item = rdr.GetString(1);
                    entity.WhBarcode = rdr.GetString(2);//货架
                    entity.StorageQty = rdr.GetDecimal(3);//库存
                    entity.GRN = rdr.GetString(4);//SN/GSN
                    entity.ItemSpec = rdr.GetString(5);
                    entity.VendorCode = rdr.GetString(6);
                    entity.ABCCLass = rdr.GetString(7);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public List<WarehouseCheckOrderInfo> GetMaterialChecking(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseCheckOrderInfo> list = new List<WarehouseCheckOrderInfo>();
            WarehouseCheckOrderInfo entity = null;
            //vwMaterialChecking
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
               //  , "Prod_TempWarehouseChecking"
               , "vwGetCheckOrderExistsGRN"
                , "ProdWhCheckDtlId"
                , @"ItemCode,ItemName,cBarCode,StockQty,GRN"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
 
                    entity = new WarehouseCheckOrderInfo();
                    entity.ItemCode = rdr.GetString(0);
                    entity.Item = rdr.GetString(1);
                    entity.WhBarcode = rdr.GetString(2);//货架
                    entity.StorageQty = rdr.GetDecimal(3);//库存
                    entity.GRN = rdr.GetString(4);//GRN
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 根据 prodWarehouseCheckId 字符串删除 WarehouseCheckOrder 信息。
        /// </summary>
        /// <param name="idString">prodWarehouseCheckId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_WarehouseCheckOrder_Delete", parms);
        }

        /// <summary>
        /// 根据 prodWarehouseCheckId 获取实体信息。
        /// </summary>
        /// <param name="prodWarehouseCheckId">prodWarehouseCheckId。</param>
        /// <returns>WarehouseCheckOrder 实体对象。</returns>
        public WarehouseCheckOrderInfo GetInfo(Int32 prodWarehouseCheckId)
        {
            WarehouseCheckOrderInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = prodWarehouseCheckId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_WarehouseCheckOrder_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseCheckOrderInfo();
                    entity.CheckOrder = rdr["CheckOrder"].ToString();
                    entity.WarehouseId = (int)rdr["WarehouseId"];
                    entity.Warehouse = rdr["Warehouse"].ToString();
                    entity.CheckTypeId = (int)rdr["CheckTypeId"];
                    entity.CheckType = rdr["CheckType"].ToString();
                    entity.BeginDate = Convert.ToDateTime(rdr["BeginDate"]);
                    entity.CheckOrderStatus = (int)rdr["CheckOrderStatus"];
                    entity.StatusDesc = rdr["StatusName"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.CheckOrderName = rdr["CheckOrderName"].ToString();
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>WarehouseCheckOrder 实体对象。</returns>
        public WarehouseCheckOrderInfo GetInfo(String fieldValue)
        {
            WarehouseCheckOrderInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_WarehouseCheckOrder_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseCheckOrderInfo();
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 WarehouseCheckOrder 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warehouseCheckOrderCount">warehouseCheckOrder 总数。</param>
        /// <returns>WarehouseCheckOrder 列表。</returns>
        public List<WarehouseCheckOrderInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseCheckOrderInfo> list = new List<WarehouseCheckOrderInfo>();
            WarehouseCheckOrderInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwWhCheckOrderList"
                , "ProdWarehouseCheckId"
                , @"[ProdWarehouseCheckId],[CheckOrder], [CheckType], [WarehouseId],[Warehouse], [BeginDate],[FinishDate], [StatusDesc],
                   [Remark], [CreateBy], [CreateTime], [UpdateBy], [UpdateTime],[ChangeBy],[ChangeTime],[IsChange],[CheckOrderName],[CheckBy],[CheckTime],[HandleStyle],ModifyBy"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarehouseCheckOrderInfo();
                    entity.ProdWarehouseCheckId = (int)rdr["ProdWarehouseCheckId"];
                    entity.CheckOrder = rdr["CheckOrder"].ToString();
                    entity.CheckType = rdr["CheckType"].ToString();
                    entity.WarehouseId = (int)rdr["WarehouseId"];
                    entity.Warehouse = rdr["Warehouse"].ToString();
                    entity.BeginTime = Convert.ToDateTime(rdr["BeginDate"]).ToShortDateString();
                    entity.FinishDate = rdr["FinishDate"].ToString();
                    entity.StatusDesc = rdr["StatusDesc"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.UpdateBy = rdr["ModifyBy"].ToString();
                    entity.UpdateTime = Convert.ToDateTime(rdr["UpdateTime"].ToString());
                    entity.ChangeBy = rdr["ChangeBy"].ToString();
                    entity.ChangeTime = rdr["ChangeTime"].ToString(); 
                    entity.IsChange = rdr["IsChange"].ToString();
                    entity.CheckOrderName = rdr["CheckOrderName"].ToString();
                    entity.CheckBy = rdr["CheckBy"].ToString();
                    entity.CheckTime = rdr["CheckTime"].ToString();
                    entity.HandleStyle = rdr["HandleStyle"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 审核 WarehouseCheckOrder 信息。
        /// </summary>
        /// <param name="idString">prodWarehouseCheckId 字符串。</param>
        public void Approve(String idString, String userName, int opFlag)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.NVarChar, Int32.MaxValue),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@OpFlag", SqlDbType.Int)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;
            parms[2].Value = opFlag;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_WarehouseCheckOrder_Approve", parms);
        }

        /// <summary>
        /// 获取系统盘点单号。
        /// </summary>
        public string GenerateOrderSN()
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@NextNumberType", SqlDbType.Int),
                    new SqlParameter("@ItemId", SqlDbType.Int),
                    new SqlParameter("@WOID", SqlDbType.Int),
                    new SqlParameter("@SN",SqlDbType.VarChar,50)
                };
            parms[0].Value = -13;
            parms[1].Value = -1;
            parms[2].Value = -1;
            parms[3].Value = -1;
            parms[3].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateItemSN", parms);

            return parms[3].Value.ToString();
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        #region  PDA操作
        /// <summary>
        /// 根据盘点单获取物料库存信息
        /// </summary>
        /// <param name="WhCheckNumber">盘点单</param>
        /// <returns></returns>
        public IList<WarehouseCheckOrderInfo> GetMaterialInfo(string WhCheckNumber)
        {
            string sqlstr = @"WITH c AS (
                                SELECT 
                                DISTINCT T.ItemCode AS ItemCode,T3.ItemID AS ItemId,ItemName,
                                iQuantity AS StorageQty
                                FROM dbo.Prod_WarehouseCheckOrderDtl T
                                JOIN dbo.Prod_WarehouseCheckOrder T1 ON T1.ProdWarehouseCheckId=T.WhCheckOrderId
                                JOIN dbo.Basal_Item T3 ON T3.ItemCode=T.ItemCode
                                LEFT JOIN Prod_CurrentStock T2 ON T2.WhID=T1.WarehouseId AND T2.ItemId=T3.ItemID
                                WHERE T1.CheckOrder=@WhCheckNumber
                                )
                                SELECT ItemCode,ItemId,ItemName,SUM(StorageQty) AS StorageQty FROM c  WHERE StorageQty<>0 GROUP BY ItemCode,ItemId,ItemName";
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@WhCheckNumber", SqlDbType.NVarChar,50)
                };
            parms[0].Value = WhCheckNumber;
            IList<WarehouseCheckOrderInfo> list = ComMethod.GetListBySql<WarehouseCheckOrderInfo>(sqlstr, parms);
            return list;
        }
        /// <summary>
        /// 扫描操作
        /// </summary>
        /// <param name="GRN">grn编码</param>
        /// <param name="order">工单号</param>
        /// <param name="store">货位号</param>
        /// <param name="type">1.扫描页面 2.修改页面</param>
        /// <returns></returns>
        public string ScanOperation(string GRN, string order, string store, string type)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@GRN", SqlDbType.NVarChar),
                    new SqlParameter("@ORDER", SqlDbType.NVarChar),
                    new SqlParameter("@store", SqlDbType.NVarChar),
                    new SqlParameter("@type", SqlDbType.NVarChar),
                    new SqlParameter("@RESULT",SqlDbType.NVarChar,50)
                };
            parms[0].Value = GRN;
            parms[1].Value = order;
            parms[2].Value = store;
            parms[3].Value = type;
            parms[4].Value = "";
            parms[4].Direction = ParameterDirection.InputOutput;
            DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspWarehouseCheckScanOperation", parms);
            string result = string.Empty;
            if (dt.Rows.Count < 0)
                return "";
            if (dt.Rows[0][0].ToString() == "成功")
            {
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    result += dt.Rows[0][i].ToString() + "_";
                }
                result = result.TrimEnd('_');
                return result;
            }
            else
            {
                result = dt.Rows[0][0].ToString();
                return result;
            }

        }
        /// <summary>
        /// 更新盘点状态
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public int UpdateCheckStatus(string id, string value)
        {
            int result = 0;
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@id", SqlDbType.NVarChar)
                };
            if (value == "Start")
            {
                parms[0].Value = id;
                result = SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, "UPDATE dbo.Prod_WarehouseCheckOrder SET CheckOrderStatus='3' WHERE CheckOrder=@id", parms);
            }
            else if (value == "End")
            {
                //                parms[0].Value = id;
                //                string sql = @"UPDATE T2 SET Status=4 FROM dbo.Prod_WarehouseCheckOrder T 
                //                                LEFT JOIN dbo.Prod_WarehouseCheckOrderDtl T1 ON T1.WhCheckOrderId=T.CheckOrder
                //                                LEFT JOIN Prod_MaterialUnit T2 ON T2.SerialNumber=T1.SN
                //                                WHERE T.CheckOrder=@id";
                //                result = SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, sql, parms);
                //                int result1 = SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, "UPDATE dbo.Prod_WarehouseCheckOrder SET CheckOrderStatus='4' WHERE CheckOrder=@id", parms);
                //                if (result == result1)
                //                {
                //                    result = 1; 
                //                }
                //                else
                //                {
                //                    result = 0;
                //                }
                result = SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, "UPDATE dbo.Prod_WarehouseCheckOrder SET CheckOrderStatus='4' WHERE CheckOrder=@id", parms);
            }
            return result;
        }
        /// <summary>
        /// 扫描保存数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="count"></param>
        /// <returns></returns>
        public int SaveCount(string id, string count)
        {
            //保存数据到盘点单明细表
            int result = 0;
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@id", SqlDbType.NVarChar),
                    new SqlParameter("@count", SqlDbType.NVarChar)
                };
            parms[0].Value = id;
            parms[1].Value = count;
            result = SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, "UPDATE Prod_WarehouseCheckOrderDtl SET NowQty=NowQty + @count WHERE SN=@id", parms);
            return result;
        }
        /// <summary>
        /// 修改数据
        /// </summary>
        /// <param name="sn">grn编码</param>
        /// <param name="materialid">物料编码</param>
        /// <param name="locationid">货位编码</param>
        /// <param name="oldno">修改前数量</param>
        /// <param name="currentno">修改后数量</param>
        /// <param name="reason">原因</param>
        /// <param name="userid">修改人</param>
        /// <returns></returns>
        public void Edit(string sn, string materialid, string locationid, string oldno, string currentno, string reason, string userid)
        {

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SN", SqlDbType.NVarChar),
                    new SqlParameter("@MaterialId", SqlDbType.NVarChar),
                    new SqlParameter("@LocationId", SqlDbType.NVarChar),
                    new SqlParameter("@OldNumber", SqlDbType.NVarChar),
                    new SqlParameter("@CurrentNumber", SqlDbType.NVarChar),
                    new SqlParameter("@Reason", SqlDbType.NVarChar),
                    new SqlParameter("@CreateBy", SqlDbType.NVarChar)
                };
            parms[0].Value = sn;
            parms[1].Value = materialid;
            parms[2].Value = locationid;
            parms[3].Value = oldno;
            parms[4].Value = currentno;
            parms[5].Value = reason;
            parms[6].Value = userid;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspWarehouseCheckHistoryInfoEdit", parms);
        }

        public void ChoosingCheckGrn(string grns,int ActType , string UserName ,int OrderId)
        {

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@Grns", SqlDbType.NVarChar,-1),
                    new SqlParameter("@ActType", SqlDbType.Int),
                    new SqlParameter("@UserName", SqlDbType.NVarChar,50),
                    new SqlParameter("@OrderId", SqlDbType.Int),
                };
            parms[0].Value = grns;
            parms[1].Value = ActType;
            parms[2].Value = UserName;
            parms[3].Value = OrderId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckMaterialUserTempAction", parms);
        }

        //创建快照临时表
        public void getWarehouseCheckSnap(int orderId, string userName , string mList)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@OrderId", SqlDbType.Int),
                    new SqlParameter("@USERNAME", SqlDbType.NVarChar,50),
                    new SqlParameter("@ItemList", SqlDbType.NVarChar,-1),
                };
            parms[0].Value = orderId;
            parms[1].Value = userName;
            parms[2].Value = mList;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspWarehouseCheckSnap", parms);
        }

        /// <summary>
        /// 盘点完成
        /// </summary>
        /// <returns></returns>
        public string CheckFinish()
        {

            return "";
        }

        //盘点单明细查询
        public string GetCheckOrderDetail(string  checkOrder)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@CheckOrder",SqlDbType.VarChar,50)
            };
            parms[0].Value = checkOrder;

            return ComMethod.GetList("uspGetCheckOrderDetail", parms);
        }
        #endregion
    }
}