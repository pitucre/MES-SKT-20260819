using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.AccessoryManagement.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.AccessoryManagement.BLL
{
    public class Accessory
    {
        private Int32 recordCount = 0;
        private Int32 recordUseCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Accessory 信息。
        /// </summary>
        /// <param name="entity">Accessory 实体对象。</param>
        public Int32 Edit(AccessoryInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AccessoryId", SqlDbType.Int),
                new SqlParameter("@AccessoryCodoe", SqlDbType.VarChar, 50),
                new SqlParameter("@AccessoryName", SqlDbType.VarChar, 100),
                new SqlParameter("@Lot", SqlDbType.VarChar, 50),
                new SqlParameter("@SerialNumber", SqlDbType.VarChar, 300),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@UserTime", SqlDbType.Float),
                new SqlParameter("@LoseTime", SqlDbType.DateTime),
                new SqlParameter("@SupplierCode", SqlDbType.VarChar, 50),
                new SqlParameter("@InStockQty", SqlDbType.Float),
                new SqlParameter("@CurrentQty", SqlDbType.Float),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@AccessoryType", SqlDbType.Int),
                new SqlParameter("@ProdDateTime", SqlDbType.DateTime),
            };

            parms[0].Value = entity.AccessoryId;
            parms[1].Value = entity.AccessoryCodoe;
            parms[2].Value = entity.AccessoryName;
            parms[3].Value = entity.Lot;
            parms[4].Value = entity.SerialNumber;
            parms[5].Value = 1;
            parms[6].Value = 0M;
            parms[7].Value = entity.LoseTime;
            parms[8].Value = entity.SupplierCode;
            parms[9].Value = entity.InStockQty;
            parms[10].Value = entity.CurrentQty;
            parms[11].Value = entity.CreateBy;
            parms[12].Value = entity.AccessoryType;
            parms[13].Value = entity.ProdDateTime;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Accessory_Edit", parms);

            return (Int32)parms[0].Value;
        }
        /// <summary>
        /// 辅料条码打印
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="SumQty">打印数量</param>
        /// <param name="MinQty">最小包装数量</param>
        /// <returns></returns>
        public string[] PrintSerialNumber(AccessoryInfo entity, int SumQty, decimal MinQty)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AccessoryId", SqlDbType.Int),
                new SqlParameter("@AccessoryCodoe", SqlDbType.VarChar, 50),
                new SqlParameter("@AccessoryName", SqlDbType.VarChar, 100),
                new SqlParameter("@Lot", SqlDbType.VarChar, 50),
                new SqlParameter("@LoseTime", SqlDbType.DateTime),
                new SqlParameter("@SumQty", SqlDbType.Int),
                new SqlParameter("@MinQty", SqlDbType.Decimal),
                new SqlParameter("@SupplierCode", SqlDbType.VarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@AccessoryType", SqlDbType.Int),
                new SqlParameter("@ProdDateTime", SqlDbType.DateTime),
                new SqlParameter("@SerialNumberList", SqlDbType.VarChar,8000),

            };

            parms[0].Value = -1;
            parms[1].Value = entity.AccessoryCodoe;
            parms[2].Value = entity.AccessoryName;
            parms[3].Value = entity.Lot;
            parms[4].Value = entity.LoseTime;
            parms[5].Value = SumQty;
            parms[6].Value = MinQty;
            parms[7].Value = entity.SupplierCode;
            parms[8].Value = entity.CreateBy;
            parms[9].Value = entity.AccessoryType;
            parms[10].Value = entity.ProdDateTime;
            parms[11].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAccessoryPrintSerialNumber", parms);
            var resultstr = Convert.ToString(parms[11].Value).Split(',');
            return resultstr;
        }
        /// <summary>
        /// 根据 AccessoryId 字符串删除 Accessory 信息。
        /// </summary>
        /// <param name="idString">AccessoryId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Accessory_Delete", parms);
        }

        /// <summary>
        /// 根据 AccessoryId 获取实体信息。
        /// </summary>
        /// <param name="accessoryId">AccessoryId。</param>
        /// <returns>Accessory 实体对象。</returns>
        public AccessoryInfo GetInfo(Int32 accessoryId)
        {
            AccessoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = accessoryId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Accessory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AccessoryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetDouble(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDecimal(9),
                        rdr.GetDecimal(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetDateTime(14), rdr.GetString(15));
                    entity.SupplierName = rdr.GetString(16);
                    entity.AccessoryType = rdr.GetInt32(17);
                    entity.ProdDateTime = rdr.GetDateTime(18);
                    entity.ItemId = rdr.GetInt32(19);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Accessory 实体对象。</returns>
        public AccessoryInfo GetInfo(String fieldValue)
        {
            AccessoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Accessory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AccessoryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetDouble(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDecimal(9),
                        rdr.GetDecimal(10), rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetDateTime(14), rdr.GetString(15));
                    entity.SupplierName = rdr.GetString(16);
                    entity.AccessoryType = rdr.GetInt32(17);
                    entity.ProdDateTime = rdr.GetDateTime(18);
                    entity.ItemId = rdr.GetInt32(19);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Accessory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="accessoryCount">accessory 总数。</param>
        /// <returns>Accessory 列表。</returns>
        public List<AccessoryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {

            List<AccessoryInfo> list = new List<AccessoryInfo>();
            //表名或者视图
            string strTb = "vwPoAccessory";
            //主键
            string strKey = "AccessoryId";
            //查询栏位字串
            string strColumns = @"[AccessoryId], [AccessoryCodoe], [AccessoryName], [Lot], [SerialNumber], [Status], [UserTime], [LoseTime], [SupplierCode], [SupplierName],[InStockQty], [CurrentQty], [StartThawTime], [CreateBy], [CreateTime], [UnsealTime],[AccessoryTypeName],ReturnTime,ProdDateTime,StartStirTime,ModifyBy,ModifyTime";
            list = ComMethod.GetComList<AccessoryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            foreach (var item in list)
            {                
                switch (item.Status)
                {
                    case 1: item.StatusName = "在库"; break;
                    case 2: item.StatusName = "解冻"; break;
                    //case 3: item.StatusName = "在产线"; break;
                    case 4: item.StatusName = "使用中"; break;
                    //case 5: item.StatusName = "在库(退回)"; break;
                    case 6: item.StatusName = "报废"; break;
                    case 7: item.StatusName = "搅拌"; break;
                    case 8: item.StatusName = "用完"; break;
                    default: item.StatusName = string.Empty; break;
                }
            }
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        /// <summary>
        /// 分页获取 Accessory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="accessoryCount">accessory 总数。</param>
        /// <returns>Accessory 列表。</returns>
        public List<AccessoryUseInfo> GetUseAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {

            List<AccessoryUseInfo> list = new List<AccessoryUseInfo>();
            //表名或者视图
            string strTb = "vwSelectAccessoryHistoryInfo";
            //主键
            string strKey = "AccessoryId";
            //查询栏位字串
            string strColumns = @"[AccessoryId]
                                  ,[AccessoryCodoe]
                                  ,[AccessoryName]
                                  ,[OpType]
                                  ,[OpTypeName]
                                  ,[OrderNo]
                                  ,[LineId]
                                  ,[Station]
                                  ,[StationId]
                                  ,[LineName]
                                  ,[CreateBy]
                                  ,[CreateTime]
                                  ,[SerialNumber]
                                  ,[Status]
                                  ,[StatusName]";
            list = ComMethod.GetComList<AccessoryUseInfo>(ref recordUseCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }

        public Int32 GetUseCount(SearchSettings searchSettings)
        {
            return this.recordUseCount;
        }

        /// <summary>
        /// 分页获取 Accessory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="accessoryCount">accessory 总数。</param>
        /// <returns>Accessory 列表。</returns>
        public List<AccessoryInfo> GetAccessoryKanBan(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {

            List<AccessoryInfo> list = new List<AccessoryInfo>();
            //表名或者视图
            string strTb = "vwAccessoryKanBan";
            //主键
            string strKey = "AccessoryId";
            //查询栏位字串
            string strColumns = @"[AccessoryId], [AccessoryCodoe], [AccessoryName], [Lot], [SerialNumber], [Status],[pStatusName], [UserTime], [LoseTime], [SupplierCode], [SupplierName],[InStockQty], [CurrentQty], [StartThawTime], [CreateBy], [CreateTime], [UnsealTime],[AccessoryTypeName],ReturnTime,ProdDateTime,[OrderNo]";
            list = ComMethod.GetComList<AccessoryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }


        /// <summary>
        /// 辅料操作
        /// </summary>
        /// <param name="SN"></param>
        /// <param name="TYPE">1 解冻 2发料 3 上料 4 退回</param>
        /// <param name="USERNAME"></param>

        public void AccessoryOperation(string SN, int TYPE, string USERNAME)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@SN",SqlDbType.VarChar,500),
                new SqlParameter("@TYPE",SqlDbType.Int),
                new SqlParameter("@username",SqlDbType.VarChar,50),
            };
            param[0].Value = SN;
            param[1].Value = TYPE;
            param[2].Value = USERNAME;
            ComMethod.Edit("uspAccessoryOperation", param);
        }
        /****PDA*****/

        /// <summary>
        /// 获取排产工单信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<AccessoryInfo> GetPlanOrderList()
        {
            string str = @"SELECT ProdOrderID AS Code,OrderNO AS Name FROM dbo.vwOrderInfo";
            return ComMethod.GetListBySql<AccessoryInfo>(str, null);
        }
        /// <summary>
        /// 获取机台列表信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<AccessoryInfo> GetLineList()
        {
            string str = @"SELECT LineId AS Code,LineName AS Name FROM dbo.Basal_Line";
            return ComMethod.GetListBySql<AccessoryInfo>(str, null);
        }
        public List<AccessoryInfo> GetStationList()
        {
            string str = @"SELECT StationId AS Code,Station AS Name FROM dbo.Basal_Station";
            return ComMethod.GetListBySql<AccessoryInfo>(str, null);
        }
        /// <summary>
        /// 上料验证
        /// </summary>
        /// <param name="SN"></param>
        /// <param name="OrderNo"></param>
        /// <param name="LineId"></param>
        /// <param name="StatonId"></param>
        /// <param name="username"></param>
        public void Check(string SN, string OrderNo, int LineId, int StatonId, string username)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@SN",SqlDbType.VarChar,500),
                new SqlParameter("@OrderNo",SqlDbType.VarChar,500),
                new SqlParameter("@LineId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,500),
            };
            param[0].Value = SN;
            param[1].Value = OrderNo;
            param[2].Value = LineId;
            param[3].Value = StatonId;
            param[4].Value = username;
            ComMethod.Edit("uspAccessoryLoadingCheck", param);
        }
        public List<AccessoryInfo> PDASearch(string SN, string OrderNo)
        {
            string sqlstr = @"SELECT SerialNumber,InStockQty,t1.UnitName,AccessoryCodoe,t.AccessoryName,t4.OrderNO,t4.Qty_to_Build AS OrderQty,t5.ItemCode,t5.ItemName FROM dbo.Prod_Accessory t
                            JOIN dbo.Prod_AccessoryList t1 ON t1.AccessoryCode=t.AccessoryCodoe
                            JOIN dbo.Prod_AccessoryItemRelationDtl t2 ON t2.AccessoryCode=t1.AccessoryCode
                            JOIN Prod_AccessoryItemRelation t3 ON t3.Id=t2.Pid
                            JOIN dbo.Basal_Item t5 ON t5.ItemCode=t3.ItemCode
                            JOIN dbo.Prod_Order t4 ON t4.ItemId=t5.ItemID
                            WHERE SerialNumber='" + SN + "' AND OrderNO='" + OrderNo + "'";
            var list = ComMethod.GetListBySql<AccessoryInfo>(sqlstr, null);
            return list;
        }

        /// <summary>
        /// 空瓶管理 辅料用完管理
        /// </summary>
        /// <param name="SN"></param>
        public void Finish(string SN, string UserName)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@SN",SqlDbType.VarChar,500),
                new SqlParameter("@UserName",SqlDbType.VarChar),
            };
            param[0].Value = SN;
            param[1].Value = UserName;
            ComMethod.Edit("uspAccessoryFinish", param);
        }

        /// <summary>
        /// 辅料FIFO规则校验
        /// </summary>
        /// <returns></returns>
        public IList<AccessoryInfo> CheckGrnAccessoryPrepare(string grn)
        {
            IList<AccessoryInfo> list = new List<AccessoryInfo>();
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@Grn",SqlDbType.NVarChar),
            };
            parms[0].Value = grn;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckGrnAccessoryPrepare", parms))
            {
                while (rdr.Read())
                {
                    list.Add(new AccessoryInfo
                    {
                        SerialNumber = rdr.GetString(0),
                        AccessoryCodoe = rdr.GetString(1),
                        Flage = rdr.GetInt32(2)
                    });
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 辅料（锡膏）解冻校验
        /// </summary>
        /// <param name="sn"></param>
        public string AccessoryThawValidate(string sn)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,500),
                new SqlParameter("@Msg",SqlDbType.VarChar,50)
            };
            param[0].Value = sn;
            param[1].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckAccessoryThaw", param);
            return param[1].Value.ToString();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="itemCode"></param>
        /// <returns></returns>
        public List<MaterialPrint> GetItemInfo(string itemCode)
        {
            string str = string.Format(@" select ItemID,ItemCode,ItemName from Basal_Item  where ItemCode='{0}'  ", itemCode);
            return ComMethod.GetListBySql<MaterialPrint>(str, null);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="itemid"></param>
        /// <param name="pdate"></param>
        /// <returns></returns>
        public string SelectAccessoryExpiredDateByItemID(int itemid,DateTime pdate)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@ItemID",SqlDbType.Int),
                new SqlParameter("@PDateTime",SqlDbType.DateTime),
                new SqlParameter("@outDateTime",SqlDbType.DateTime)
            };
            param[0].Value = itemid;
            param[1].Value = pdate;
            param[2].Value = pdate;
            param[2].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSelectAccessoryExpiredDateByItemID", param);
            return DateTime.Parse(param[2].Value.ToString()).ToString("yyyy-MM-dd");
        }
        /// <summary>
        /// 注册
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="username"></param>
        public void AccessrySupplierMaterialRegister(string grn,string username)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.NVarChar,100),
                new SqlParameter("@UserName",SqlDbType.NVarChar,50)
            };
            param[0].Value = grn;
            param[1].Value = username;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAccessrySupplierMaterialRegister", param);
        }

        /// <summary>
        /// 获取辅料信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public AccessoryInfo GetAccessoryInfo(AccessoryInfo entity)
        {
            string sql = @"SELECT 
                               AccessoryId,AccessoryCodoe,AccessoryName,AccessoryType,Lot,SerialNumber,Status,UserTime,LoseTime,SupplierCode,InStockQty,CurrentQty,StartThawTime,CreateBy,CreateTime,UnsealTime,LoadingTime,ReturnTime,ProdDateTime,AccessoryTypeName,SupplierName,StartStirTime,ItemId
                           FROM vwPoAccessory  
                           WHERE SerialNumber = @SerialNumber";
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SerialNumber",SqlDbType.VarChar) { Value = entity.SerialNumber }
            };
            return ComMethod.GetBySql<AccessoryInfo>(sql, parms);
        }



        /// <summary>
        /// 空瓶管理 辅料用完管理
        /// </summary>
        /// <param name="SN"></param>
        public void AccessoryOfflineDal(string SN, string UserName)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@SN",SqlDbType.VarChar,500),
                new SqlParameter("@UserName",SqlDbType.VarChar),
            };
            param[0].Value = SN;
            param[1].Value = UserName;
            ComMethod.Edit("uspAccessoryOffline", param);
        }

    }
}