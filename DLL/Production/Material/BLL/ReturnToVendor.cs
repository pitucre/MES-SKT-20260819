using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Material.Model;
using System.Text.RegularExpressions;
using Dapper;
using SKT.LeanMES.ERP;

namespace SKT.LeanMES.Material.BLL
{
    public class ReturnToVendor
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ReturnToVendor 信息。
        /// </summary>
        /// <param name="entity">ReturnToVendor 实体对象。</param>
        public Int32 Edit(ReturnToVendorInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ReturnToVendorID", SqlDbType.Int),
                new SqlParameter("@ReturnOrder", SqlDbType.VarChar, 30),
                new SqlParameter("@FactoryCode", SqlDbType.VarChar, 10),
                new SqlParameter("@ReturnDate", SqlDbType.DateTime),
                new SqlParameter("@CusCode", SqlDbType.VarChar, 30),
                new SqlParameter("@VenCode", SqlDbType.VarChar, 30),
                new SqlParameter("@ReturnOrderStatus", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500),
                new SqlParameter("@Default_1", SqlDbType.VarChar, 30),
                new SqlParameter("@Default_2", SqlDbType.VarChar, 30),
                new SqlParameter("@Default_3", SqlDbType.VarChar, 30),
                new SqlParameter("@Default_4", SqlDbType.VarChar, 30),
                new SqlParameter("@Default_5", SqlDbType.VarChar, 30),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateTime", SqlDbType.DateTime),
                new SqlParameter("@UpdateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@UpdateTime", SqlDbType.DateTime),
                new SqlParameter("@RdType", SqlDbType.VarChar, 50),
                new SqlParameter("@ERPState", SqlDbType.Int),
                new SqlParameter("@MESState", SqlDbType.Int)
            };

            parms[0].Value = entity.ReturnToVendorID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ReturnOrder;
            parms[2].Value = entity.FactoryCode;
            parms[3].Value = entity.ReturnDate;
            parms[4].Value = entity.CusCode;
            parms[5].Value = entity.VenCode;
            parms[6].Value = entity.FinishStatus;
            parms[7].Value = entity.Remark;
            parms[8].Value = entity.Default_1;
            parms[9].Value = entity.Default_2;
            parms[10].Value = entity.Default_3;
            parms[11].Value = entity.Default_4;
            parms[12].Value = entity.Default_5;
            parms[13].Value = entity.CreateBy;
            parms[14].Value = entity.CreateDateTime;
            parms[15].Value = entity.UpdateBy;
            parms[16].Value = entity.UpdateTime;
            parms[17].Value = entity.RdType;
            parms[18].Value = entity.ERPState;
            parms[19].Value = entity.MESState;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ReturnToVendor_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ReturnToVendorId 字符串删除 ReturnToVendor 信息。
        /// </summary>
        /// <param name="idString">ReturnToVendorId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ReturnToVendor_Delete", parms);
        }

        /// <summary>
        /// 根据 ReturnToVendorId 获取实体信息。
        /// </summary>
        /// <param name="returnToVendorId">ReturnToVendorId。</param>
        /// <returns>ReturnToVendor 实体对象。</returns>
        public ReturnToVendorInfo GetInfo(Int32 returnToVendorId)
        {
            ReturnToVendorInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = returnToVendorId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ReturnToVendor_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ReturnToVendorInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetDateTime(14),
                        rdr.GetString(15), rdr.GetDateTime(16), rdr.GetString(17), rdr.GetInt32(18), rdr.GetInt32(19));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ReturnToVendor 实体对象。</returns>
        public ReturnToVendorInfo GetInfo(String fieldValue)
        {
            ReturnToVendorInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ReturnToVendor_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ReturnToVendorInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetDateTime(14),
                        rdr.GetString(15), rdr.GetDateTime(16), rdr.GetString(17), rdr.GetInt32(18), rdr.GetInt32(19));
                }
                rdr.Close();
            }

            return entity;
        }


        /// <summary>
        /// 根据 ReturnToVendorId 获取实体信息。
        /// </summary>
        /// <param name="returnToVendorId">ReturnToVendorId。</param>
        /// <returns>ReturnToVendor 实体对象。</returns>
        public string GetRtvItemInfo(Int32 returnToVendorId)
        {
            ReturnToVendorInfo entity = null;
            List<ReturnToVendorInfo> list = new List<ReturnToVendorInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = returnToVendorId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ReturnToVendor_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new ReturnToVendorInfo();
                    entity.ReturnToVendorID = (int)rdr["ReturnToVendorId"];
                    entity.RtvDtlID = (int)rdr["RtvDtlID"];
                    entity.ReturnOrder = rdr["ReturnOrder"].ToString();
                    entity.ReturnDateStr = rdr["ReturnDate"].ToString();
                    entity.VenCode = (string)rdr["VenCode"];
                    entity.Remark = (string)rdr["Remark"];
                    entity.ItemId = (int)rdr["ItemId"];
                    entity.ItemCode = (string)rdr["ItemCode"];
                    entity.ItemName = (string)rdr["ItemName"];
                    entity.Quantity = (decimal)rdr["Quantity"];
                    entity.ReQty = (decimal)rdr["ReQty"];
                    entity.CreateTimeStr = rdr["CreateDateTime"].ToString();
                    entity.RdType = (string)rdr["RdType"];
                    entity.SourceBillNo = (string)rdr["SourceBillNo"];
                    entity.ERPReBillID = (string)rdr["ERPReBillID"];
                    entity.SourceEntryID = (string)rdr["SourceEntryID"];
                    entity.SerialNumber = (string)rdr["SerialNumber"];
                    entity.ReturnQty = Math.Round(Convert.ToDecimal(rdr["ReturnQty"]));
                    list.Add(entity);
                }
                rdr.Close();
            }
            var strJson = (new JavaScriptSerializer()).Serialize(list);
            return strJson;
        }

        /// <summary>
        /// 分页获取 ReturnToVendor 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="returnToVendorCount">returnToVendor 总数。</param>
        /// <returns>ReturnToVendor 列表。</returns>
        public List<ReturnToVendorInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ReturnToVendorInfo> list = new List<ReturnToVendorInfo>();
            ReturnToVendorInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_ReturnToVendor", "ReturnToVendorId",
                "[ReturnToVendorID], [ReturnOrder], [FactoryCode], [ReturnDate], [CusCode], [VenCode], [ReturnOrderStatus], [Remark], [Default_1], [Default_2], [Default_3], [Default_4], [Default_5], [CreateBy], [CreateTime], [UpdateBy], [UpdateTime], [RdType], [ERPState], [MESState]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ReturnToVendorInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetDateTime(14),
                        rdr.GetString(15), rdr.GetDateTime(16), rdr.GetString(17), rdr.GetInt32(18), rdr.GetInt32(19));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public List<ReturnToVendorInfo> GetRtvOrderList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ReturnToVendorInfo> list = new List<ReturnToVendorInfo>();
            //表名或者视图
            string strTb = "vwRtvOrderList";
            //主键
            string strKey = "ReturnToVendorID";
            //查询栏位字串
            string strColumns = @"ReturnToVendorID,ReturnOrder,VenCode,CreateBy,CreateDateTime";
            list = ComMethod.GetComList<ReturnToVendorInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;

        }

        /// <summary>
        /// 获取退料单列表
        /// </summary>
        /// <returns></returns>
        public IList<ReturnToVendorInfo> GetRtvOrderList()
        {
            string sql = "SELECT ReturnToVendorID,ReturnOrder,VenCode,CreateBy,CreateDateTime FROM vwRtvOrderList";
            return ComMethod.GetListBySql<ReturnToVendorInfo>(sql, null);
        }

        /// <summary>
        /// 获取退料单列表
        /// </summary>
        /// <returns></returns>
        public IList<ReturnToVendorInfo> GetRtvOrderList(SearchSettings searchSettings)
        {
            //string sql = "SELECT ReturnToVendorID,ReturnOrder,VenCode,CreateBy,CreateDateTime FROM vwRtvOrderList";
            //return ComMethod.GetListBySql<ReturnToVendorInfo>(sql, null);

            //表名或者视图
            string strTb = "vwRtvOrderList";
            //主键
            string strKey = "ReturnToVendorID";
            //查询栏位字串
            string strColumns = @"ReturnToVendorID,ReturnOrder,VenCode,CreateBy,CreateDateTime";
            return ComMethod.GetComList<ReturnToVendorInfo>(ref recordCount, 0, 20, strTb, strKey, strColumns, "", searchSettings);
        }

        /// <summary>
        /// 确认退货。
        /// </summary>
        public string SaveGrnReturn(int returnOrderId, string grns, string userName, string returnDtl)
        {
            DataTable dt = JsonToDataTable(returnDtl);

            var msg = string.Empty;
            string erpNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.WarehouseReturnSupplier;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@ReturnID", returnOrderId);
                    dp.Add("@GrnStr", grns);
                    dp.Add("@CreateBy", userName);
                    dp.Add("@ReturnDtls", dt, DbType.Object);

                    reader = conn.ExecuteReader("uspSaveRTV", dp, tran, null, CommandType.StoredProcedure);

                    dtWrite.Load(reader);

                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                    var IsReturn = Convert.ToString(dtWrite.Rows[0]["IsReturn"]);
                    if (IsReturn == "1")
                    {
                        //是否需要回写
                        isWriteBack = WriteBackERP.IsWriteBack(em);
                        if (isWriteBack)
                        {
                            if (dtWrite == null || dtWrite.Rows.Count <= 0)
                            {
                                msg = "未获取到需要回写ERP数据";
                                throw new Exception(msg);
                            }
                            var returnOrderNo = Convert.ToString(dtWrite.Rows[0]["billCode"]);//MES退料单号

                            //调用接口
                            ERPU9ReturnInfo info = WriteBackERP.SendPostU9(conn, em, dtWrite, returnOrderNo, userName, dtEnterTime, dtAfterExecProcTime);

                            logList.Add(new WriteBackLogInfo
                            {
                                WriteBackCode = em.ToString(),
                                ERPMsg = info.Msg,
                                ERPResult = info.Result ? 1 : 0,
                                ERPNo = info.ERPNo,
                                MESBillNo = returnOrderNo,
                                WriteBackData = info.SendInfo,
                                ReceiveData = info.ReceiveData,
                                EnterTime = dtEnterTime,
                                AfterExecProcTime = dtAfterExecProcTime,
                                AfterExecERPTime = info.dtAfterExecERPTime,
                                CreateDateTime = DateTime.Now
                            });

                            if (!info.Result)
                            {
                                //回写失败
                                throw new Exception(info.Msg);
                            }
                        }
                    }
                    tran.Commit();
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    throw ex;
                }
                finally
                {
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                    foreach (var log in logList)
                    {
                        WriteBackERP.AddWriteBackLog(conn, log);
                    }
                    conn.Close();
                }
            }

            return erpNo;
        }



        /// <summary>    
        /// 将 Json 解析成 DateTable   
        /// Json 数据格式如:  
        ///{table:[{column1:1,column2:2,column3:3},{column1:1,column2:2,column3:3}]} 
        /// </summary>    
        /// <param name="strJson">要解析的 Json 字符串</param>    
        /// <returns>返回 DateTable</returns>    
        public static DataTable JsonToDataTable(string strJson)
        {
            // 取出表名    
            var rg = new Regex(@"(?<={)[^:]+(?=:\[)", RegexOptions.IgnoreCase);
            string strName = rg.Match(strJson).Value;
            DataTable tb = null;
            // 去除表名    
            strJson = strJson.Substring(strJson.IndexOf("[") + 1);
            strJson = strJson.Substring(0, strJson.IndexOf("]"));
            // 获取数据    
            rg = new Regex(@"(?<={)[^}]+(?=})");
            MatchCollection mc = rg.Matches(strJson);
            for (int i = 0; i < mc.Count; i++)
            {
                string strRow = mc[i].Value;
                string[] strRows = strRow.Split(',');
                // 创建表    
                if (tb == null)
                {
                    tb = new DataTable();
                    tb.TableName = strName;
                    foreach (string str in strRows)
                    {
                        var dc = new DataColumn();
                        string[] strCell = str.Split(':');
                        dc.ColumnName = strCell[0].Replace("\"", "");
                        tb.Columns.Add(dc);
                    }
                    tb.AcceptChanges();
                }
                // 增加内容    
                DataRow dr = tb.NewRow();
                for (int j = 0; j < strRows.Length; j++)
                {
                    dr[j] = strRows[j].Split(':')[1].Replace("\"", "");
                }
                tb.Rows.Add(dr);
                tb.AcceptChanges();
            }
            return tb;
        }

        /// <summary>
        /// 检查扫入的GRN。
        /// </summary>
        public string CheckGrnReturn(int returnOrderId, string grn)
        {
            MaterialUnitInfo entity = new MaterialUnitInfo();
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            string strJson = "";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ReturnOrderID", SqlDbType.Int),
                new SqlParameter("@Grn", SqlDbType.NVarChar,100)
            };

            parms[0].Value = returnOrderId;
            parms[1].Value = grn;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckGrnCanRTV", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr["SerialNumber"].ToString();
                    entity.BalanceQty = (decimal)rdr["BalanceQty"];
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    entity.VendorCode = rdr["VendorCode"].ToString();
                    entity.VendorName = rdr["VendorName"].ToString();
                    entity.POorder = rdr["POrder"].ToString();
                    entity.AutoId = int.Parse(rdr["AutoId"].ToString());
                    list.Add(entity);
                }
                rdr.Close();
            }
            strJson = (new JavaScriptSerializer()).Serialize(list);
            return strJson;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        /// <summary>
        /// 退料单信息
        /// </summary>
        /// <param name="entity"></param>
        public ReturnToVendorInfo GetReturnToVendorInfo(ReturnToVendorInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ReturnOrder", SqlDbType.VarChar,50),
                new SqlParameter("@UserName", SqlDbType.VarChar,20)
            };
            parms[0].Value = entity.ReturnOrder;
            parms[1].Value = entity.UpdateBy;
            return ComMethod.Get<ReturnToVendorInfo>("uspGetReturnToVendorInfo", parms);
        }

        /// <summary>
        /// 退料单明细信息
        /// </summary>
        /// <param name="entity"></param>
        public IList<ReturnToVendorDtlInfo> GetReturnToVendorDetailList(ReturnToVendorInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ReturnOrder", SqlDbType.VarChar,50),
                new SqlParameter("@UserName", SqlDbType.VarChar,20)
            };
            parms[0].Value = entity.ReturnOrder;
            parms[1].Value = entity.UpdateBy;
            return ComMethod.GetList<ReturnToVendorDtlInfo>("uspGetReturnToVendorDetailInfo", parms);
        }

        /// <summary>
        /// 编辑退料单信息
        /// </summary>
        /// <param name="json"></param>
        public void WarehouseReturnSupplierEdit(string json)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ReturnOrder", SqlDbType.VarChar,50),
                new SqlParameter("@VenCode", SqlDbType.VarChar,50),
                new SqlParameter("@WarehouseCode", SqlDbType.VarChar,50),
                new SqlParameter("@ReturnDetail", SqlDbType.Structured),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar,20)
            };
            ComMethod.Edit<MaterialStorageInfo>(json, "uspWarehouseReturnSupplierEdit", parms);
        }


        /// <summary>
        /// 删除退料单信息
        /// </summary>
        /// <param name="entity"></param>
        public void WarehouseReturnSupplierDelete(ReturnToVendorInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ReturnOrder", SqlDbType.VarChar,50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar,20)
            };
            parms[0].Value = entity.ReturnOrder;
            parms[1].Value = entity.UpdateBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspWarehouseReturnSupplierDelete", parms);
        }
        /// <summary>
        /// 根据 ReturnToVendorId 获取实体信息。
        /// </summary>
        /// <param name="returnToVendorId">ReturnToVendorId。</param>
        /// <returns>ReturnToVendor 实体对象。</returns>
        public string GetRtvItemInfo(string returnToVendorId, bool IsByID = true)
        {
            ReturnToVendorInfo entity = null;
            List<ReturnToVendorInfo> list = new List<ReturnToVendorInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = returnToVendorId;
            parms[1].Value = IsByID;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ReturnToVendor_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new ReturnToVendorInfo();
                    entity.ReturnToVendorID = (int)rdr["ReturnToVendorId"];
                    entity.RtvDtlID = (int)rdr["RtvDtlID"];
                    entity.ReturnOrder = rdr["ReturnOrder"].ToString();
                    entity.ReturnDateStr = rdr["ReturnDate"].ToString();
                    entity.VenCode = (string)rdr["VenCode"];
                    entity.Remark = (string)rdr["Remark"];
                    entity.ItemId = (int)rdr["ItemId"];
                    entity.ItemCode = (string)rdr["ItemCode"];
                    entity.ItemName = (string)rdr["ItemName"];
                    entity.Quantity = (decimal)rdr["Quantity"];
                    entity.ReQty = (decimal)rdr["ReQty"];
                    entity.CreateTimeStr = rdr["CreateDateTime"].ToString();
                    entity.RdType = (string)rdr["RdType"];
                    entity.SourceBillNo = (string)rdr["SourceBillNo"];
                    entity.ERPReBillID = (string)rdr["ERPReBillID"];
                    entity.SourceEntryID = (string)rdr["SourceEntryID"];
                    entity.FinishStatus = (int)rdr["FinishStatus"]; //dl.liang 20230828 加退货至供应商 状态，前段判断是否可以继续退
                    //entity.SerialNumber = (string)rdr["SerialNumber"];
                    //entity.ReturnQty = Math.Round(Convert.ToDecimal(rdr["ReturnQty"]));
                    list.Add(entity);
                }
                rdr.Close();
            }
            var strJson = (new JavaScriptSerializer()).Serialize(list);
            return strJson;
        }
    }
}
