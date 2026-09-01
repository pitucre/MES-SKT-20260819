using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Collections;
using SKT.LeanMES.ERP;
using Dapper;

namespace SKT.LeanMES.Material.BLL
{
    public class Material
    {
        private int recordCount = 0;

        /// <summary>
        /// 清除物料已经扫描GRN
        /// </summary>
        /// <param name="deliverCode"></param>
        /// <returns></returns>
        public string MaterialGRNDel(Int32 receiveType, String POCode, Int32 DeliverDtlId, String userName, string GRN)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ReceiveType",SqlDbType.Int),
                  new SqlParameter("@POCode",SqlDbType.VarChar,100),
                  new SqlParameter("@DeliverDtlId",SqlDbType.Int),
                  new SqlParameter("@UserName",SqlDbType.VarChar,20),
                  new SqlParameter("@GRN",SqlDbType.VarChar,100)
            };
            parms[0].Value = receiveType;
            parms[1].Value = POCode;
            parms[2].Value = DeliverDtlId;
            parms[3].Value = userName;
            parms[4].Value = GRN;
            return ComMethod.GetList("uspRNByReceiveDel", parms);
        }
        /// <summary>
        /// 通过物料编码获取物料id
        /// </summary>
        /// <param name="materialNo"></param>
        /// <returns></returns>
        public Int32 GetMaterialId(string materialNo)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@MaterialNo",SqlDbType.NVarChar),
                new SqlParameter("@MaterialId",SqlDbType.Int)
            };

            parms[0].Value = materialNo;
            parms[1].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetMaterialIdByMaterialNo", parms);
            return Convert.ToInt32(parms[1].Value);
        }


        /// <summary>
        /// 根据 MaterialNO 获取实体信息。
        /// </summary>
        /// <param name="materialId">materialNO。</param>
        /// <returns>Material 实体对象。</returns>
        public MaterialInfo GetInfo(string materialNO)
        {
            MaterialInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaterialNO", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = materialNO;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Material_GetInfoByMaterialNO", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetString(14),
                        rdr.GetString(15), rdr.GetString(16), rdr.GetString(17), rdr.GetString(18));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 PartNo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="partNoCount">partNo 总数。</param>
        /// <returns>PartNo 列表。</returns>
        public List<ERPPartNoInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ERPPartNoInfo> list = new List<ERPPartNoInfo>();
            ERPPartNoInfo entity = null;

            //Add By Alen 2015-08-11 增加Site的过滤，如果site为空则获取全部数据，否则根据site过滤
            string site = System.Configuration.ConfigurationManager.AppSettings["Site"];
            if (!String.IsNullOrEmpty(site))
            {
                searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? " [Site] = '" + site + "' " : " and [Site] = '" + site + "' ";
            }

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "ERP_Item", "ErpItemId",
                " ErpItemId, Site, ItemCode, ItemName, ItemModel, StatusNo, Status, CreateDateTime, CreateBy, ModifyDateTime, ModifyBy, LastUpdateTime, Remark", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ERPPartNoInfo();
                    entity.ErpItemId = rdr.GetInt32(0);
                    entity.Site = rdr.GetString(1);
                    entity.ItemCode = rdr.GetString(2);
                    entity.ItemName = rdr.GetString(3);
                    entity.ItemModel = rdr.GetString(4);


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
        /// 根据扫描物料条码/包装箱条码带出明细信息
        /// </summary>
        /// <param name="deliverCode"></param>
        /// <returns></returns>
        public string GetGRNInfoByReceive(Int32 receiveType, String grn, String poCode, Int32 poDetailId, String userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ReceiveType",SqlDbType.Int),
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
                  new SqlParameter("@PoCode",SqlDbType.VarChar,100),
                  new SqlParameter("@PoDetailId",SqlDbType.Int),
                  new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };
            parms[0].Value = receiveType;
            parms[1].Value = grn;
            parms[2].Value = poCode;
            parms[3].Value = poDetailId;
            parms[4].Value = userName;
            return ComMethod.GetList("uspCheckGRNByReceive", parms);
        }


        /// <summary>
        /// 仓库收料
        /// </summary>
        /// <param name="strJson"></param>
        public string SaveReceiveMaterial(string strJson)
        {
            #region 不回写时代码
            //SqlParameter[] parms = new SqlParameter[]{
            //    new SqlParameter("@ReceiveType", SqlDbType.Int),
            //    new SqlParameter("@IsScanGRN", SqlDbType.Bit),
            //    new SqlParameter("@PoCode", SqlDbType.VarChar,100),
            //    new SqlParameter("@UserName", SqlDbType.VarChar, 20),
            //    new SqlParameter("@UrgentLevel", SqlDbType.Int),
            //    new SqlParameter("@POTabDtl", SqlDbType.Structured),
            //    new SqlParameter("@InspectionIdStr",SqlDbType.VarChar,4000),
            //    new SqlParameter("@WarehouseBarCode", SqlDbType.VarChar,100)
            //};
            //MaterialInfo entity = Newtonsoft.Json.JsonConvert.DeserializeObject<MaterialInfo>(strJson);
            //DataTable dt = ComMethod.JsonToDataTable(entity.POTabDtl);
            //parms[0].Value = entity.ReceiveType;
            //parms[1].Value = entity.IsScanGRN;
            //parms[2].Value = entity.PoCode;
            //parms[3].Value = entity.UserName;
            //parms[4].Value = entity.UrgentLevel;
            //parms[5].Value = dt;
            //parms[6].Value = "";
            //parms[7].Value = entity.Remark1;
            //parms[6].Direction = ParameterDirection.InputOutput;

            //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveMaterialReceive", parms);
            //return Convert.ToString(parms[6].Value); 
            #endregion
            string inspectionIdStr = string.Empty;
            MaterialInfo entity = Newtonsoft.Json.JsonConvert.DeserializeObject<MaterialInfo>(strJson);
            DataTable dt = ComMethod.JsonToDataTable(entity.POTabDtl);

            var msg = string.Empty;
            string erpNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.WarehouseReceipt;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）

            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@ReceiveType", entity.ReceiveType);
                    dp.Add("@IsScanGRN", entity.IsScanGRN);
                    dp.Add("@PoCode", entity.PoCode);
                    dp.Add("@UserName", entity.UserName);
                    dp.Add("@UrgentLevel", entity.UrgentLevel);
                    dp.Add("@POTabDtl", dt, DbType.Object);
                    dp.Add("@InspectionIdStr", "", DbType.String, ParameterDirection.Output);
                    dp.Add("@WarehouseBarCode", entity.Remark1);

                    reader = conn.ExecuteReader("uspSaveMaterialReceive", dp, tran, null, CommandType.StoredProcedure);
                    dtWrite.Load(reader);

                    inspectionIdStr = dp.Get<string>("InspectionIdStr");

                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    //是否需要回写
                    isWriteBack = WriteBackERP.IsWriteBack(em);
                    if (isWriteBack)
                    {
                        if (dtWrite == null || dtWrite.Rows.Count <= 0)
                        {
                            msg = "未获取到需要回写ERP数据";
                            throw new Exception(msg);
                        }
                        //var poType = dtWrite.Rows[0]["POType"].ToString();   //采购收料及委外采购收料时，才需要回写
                        //if (poType == "1" || poType == "2")
                        //{
                        DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                        //调用接口
                        ERPReturnInfo info = WriteBackERP.SendPost(em, dtWrite, entity.PoCode, entity.UserName, dtEnterTime, dtAfterExecProcTime);
                        if (!info.Result)
                        {
                            //回写失败
                            throw new Exception(info.msg);
                        }
                        else
                        {
                            erpNo = info.ERPNo;
                            //更新收料通知单号
                            var sql = $@"UPDATE pm SET pm.SendOrder = @SendOrder
                                            FROM dbo.Prod_MaterialUnitMember pm WITH (NOLOCK) 
                                            INNER JOIN dbo.Prod_MaterialIQC iqc WITH (NOLOCK) ON pm.IQCOrder = iqc.InspectionNo
                                            WHERE iqc.InspectionId IN ({inspectionIdStr.TrimEnd(',')})";
                            conn.Execute(sql, new { SendOrder = erpNo }, tran);
                        }
                        //}
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
                    conn.Close();
                }
            }
            return inspectionIdStr;
        }


        /// <summary>
        /// 重新扫描
        /// </summary>
        /// <param name="strJson"></param>
        public void OnCancelGRN(string mydeliverOrder)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PoCode", SqlDbType.VarChar,100)
            };
            parms[0].Value = mydeliverOrder;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCancelGRNByReceive", parms);
        }

        /// <summary> 
        /// 有GRN情况下  保存 物料备料
        /// </summary>
        /// <param name="ItemStr"></param>
        /// <param name="Grn"></param>
        /// <param name="prepareMaterialNo">备料单号</param>
        /// <returns></returns>
        public string SaveMaterialPrepare(Int32 RequestId, Int32 selLocation, string locDesc, String grnStr, String userName, string prepareMaterialNo, string FLGrnStr, int ProductMinNumType, int Isexceed)
        {

            var msg = string.Empty;
            string erpApplyNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            var returnFLGrnStr = string.Empty;
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@RequestId", RequestId);
                    dp.Add("@selLocation", selLocation);
                    dp.Add("@GrnStr", grnStr);
                    dp.Add("@userName", userName);
                    dp.Add("@LocDesc", locDesc);
                    dp.Add("@PrepareMaterialNo", prepareMaterialNo);
                    dp.Add("@ProductMinNumType", ProductMinNumType);
                    dp.Add("@Isexceed", Isexceed);
                    dp.Add("@FLGrnStrInput", FLGrnStr);
                    dp.Add("@FLGrnStr", FLGrnStr, direction: ParameterDirection.Output);
                    reader = conn.ExecuteReader("uspSaveMaterialPrepareGrn", dp, tran, null, CommandType.StoredProcedure);

                    dtWrite.Load(reader);

                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                    returnFLGrnStr = dp.Get<string>("@FLGrnStr").ToString();
                    if (dtWrite.Rows.Count > 0)
                    {

                        string IsStock = Convert.ToString(dtWrite.Rows[0]["IsStock"]);
                        //判断是否全部备料
                        if (IsStock == "1")
                        {
                            WriteBackEnum em = WriteBackEnum.MaterialPrepare;
                            //是否需要回写
                            isWriteBack = WriteBackERP.IsWriteBack(em);
                            if (isWriteBack)
                            {
                                if (dtWrite == null || dtWrite.Rows.Count <= 0)
                                {
                                    msg = "未获取到需要回写ERP数据";
                                    throw new Exception(msg);
                                }
                                var materialStorageNo = dtWrite.Rows[0]["billCode"].ToString();//MES领料单号
                                var applyType = dtWrite.Rows[0]["ApplyType"].ToString();//领料单类型（0：杂发审核(其他出库)  1：工单领料  2：委外领料  3：工单补料  4：委外补料）

                                //杂发
                                if (applyType == "0")
                                {
                                    em = WriteBackEnum.MiscellaneousOutStorage;
                                }

                                DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                                //调用接口
                                ERPU9ReturnInfo info = WriteBackERP.SendPostU9(conn, em, dtWrite, materialStorageNo, userName, dtEnterTime, dtAfterExecProcTime);

                                logList.Add(new WriteBackLogInfo
                                {
                                    WriteBackCode = em.ToString(),
                                    ERPMsg = info.Msg,
                                    ERPResult = info.Result ? 1 : 0,
                                    ERPNo = info.ERPNo,
                                    MESBillNo = materialStorageNo,
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

            return returnFLGrnStr;
        }

        /// <summary> 
        ///  无GRN情况下  保存 物料备料
        /// </summary>
        /// <param name="ItemStr"></param>
        /// <param name="Grn"></param>
        /// <returns></returns>
        public void SaveMaterialPrepare(String strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RequestId",SqlDbType.Int),
                new SqlParameter("@userName",SqlDbType.NVarChar,20),
                new SqlParameter("@PrepareMaterialNo",SqlDbType.NVarChar,200),
                new SqlParameter("@tbDtl", SqlDbType.Structured)
            };
            ComMethod.Edit<MaterialStorageInfo>(strJson, "uspSaveMaterialPrepare", parms);
        }

        /// <summary>
        /// 根据GRN获取数量
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public Decimal GetGrnQuantiyByGrn(string grn)
        {
            SqlParameter[] parms = new SqlParameter[] {
                   new SqlParameter("@GRN",SqlDbType.VarChar,50),
                   new SqlParameter("@Quantiy",SqlDbType.Float)
            };
            parms[0].Value = grn;
            parms[1].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetGrnQuantiyByGrn", parms);
            return Convert.ToDecimal(parms[1].Value);
        }

        /// <summary>
        /// 根据GRN获取信息
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public string GetInfoByGrnReturn(string grn)
        {
            SqlParameter[] parms = new SqlParameter[] {
                   new SqlParameter("@GRN",SqlDbType.VarChar,50)
            };
            parms[0].Value = grn;
            //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetInfoByGrnReturn", parms);

            return ComMethod.GetList("uspGetInfoByGrnReturn", parms); //返回JSON信息
        }

        /// <summary>
        /// 生产退料-生成退料单8.5
        /// </summary>
        /// <param name="grns">物料条码</param>
        public void SaveMaterialReturn(string Grns, string DepId, string User)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@GRNs",SqlDbType.VarChar,int.MaxValue)
                ,new SqlParameter("@DepId",SqlDbType.VarChar,20)
                ,new SqlParameter("@UserName",SqlDbType.VarChar,50)
            };
            parms[0].Value = Grns;
            parms[1].Value = DepId;
            parms[2].Value = User;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveGrnReturn", parms);

        }

        /// <summary>
        /// 生产退料-退料入库到仓库货位8.5
        /// </summary>
        /// <param name="grns">物料条码</param>
        public void SaveReturn2Warehouse(string Grns, string StoreCode, string User)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@GRNs",SqlDbType.VarChar,int.MaxValue)
                ,new SqlParameter("@BarCode",SqlDbType.VarChar,20)
                ,new SqlParameter("@UserName",SqlDbType.VarChar,50)
            };
            parms[0].Value = Grns;
            parms[1].Value = StoreCode;
            parms[2].Value = User;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGrnsReturn2Warehouse", parms);

        }

        /// <summary>
        /// 生产退料-生成退料单
        /// </summary>
        /// <param name="serialNumber">物料条码</param>
        /// <param name="qty">数量</param>
        /// <param name="depId">部门ID</param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> SaveMaterialReturn(String serialNumber, Decimal qty, int depId, String userName)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@GRN",SqlDbType.NVarChar,200),
                  new SqlParameter("@Qty",SqlDbType.Decimal),
                  new SqlParameter("@DepId",SqlDbType.Int),
                  new SqlParameter("@UserName",SqlDbType.NVarChar,50)
            };
            parms[0].Value = serialNumber;
            parms[1].Value = qty;
            parms[2].Value = depId;
            parms[3].Value = userName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialReturn_Edit", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.CBarCode = rdr.GetString(2);
                    entity.BalanceQty = rdr.GetDecimal(3);
                    entity.ModifyBy = rdr.GetString(4);
                    entity.PackTime = rdr.GetDateTime(5).ToString("yyyy-MM-dd HH:mm:ss");

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据GRN和库位获取数量
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public String GetGrnQuantiyByGrnBar(string grn, string barCode)
        {
            SqlParameter[] parms = new SqlParameter[] {
                   new SqlParameter("@GRN",SqlDbType.VarChar,50),
                   new SqlParameter("@BarCode",SqlDbType.VarChar,50)
            };
            parms[0].Value = grn;
            parms[1].Value = barCode;
            return ComMethod.Get("uspGetGrnQuantiyByGrnBar", parms);
        }

        /// <summary>
        /// 仓库退料-确认退料操作
        /// </summary>
        /// <param name="serialNumber"></param>
        /// <param name="qty"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> SureMaterialReturn(String serialNumber, String warCode, Decimal qty, String userName)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@GRN",SqlDbType.NVarChar,200),
                  new SqlParameter("@BarCode",SqlDbType.NVarChar,200),
                  new SqlParameter("@Qty",SqlDbType.Decimal),
                  new SqlParameter("@UserName",SqlDbType.NVarChar,50)
            };
            parms[0].Value = serialNumber;
            parms[1].Value = warCode;
            parms[2].Value = qty;
            parms[3].Value = userName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSureMaterialReturn", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.CBarCode = rdr.GetString(2);
                    entity.BalanceQty = rdr.GetDecimal(3);
                    entity.ModifyBy = rdr.GetString(4);
                    entity.PackTime = rdr.GetDateTime(5).ToString("yyyy-MM-dd HH:mm:ss");

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        public string GetMaterialPrepareGrn(int applyId, int itemId)
        {
            //var strSQL = " SELECT SerialNumber,BalanceQty FROM Prod_MaterialUnit " +
            //             "WHERE ApplyId  =" + applyId + " AND PartId=" + itemId;
            //return ComMethod.GetListBySql(strSQL, null, SQLHelper.MESConnString);
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@ApplyId",SqlDbType.Int),
                new SqlParameter("@ItemID",SqlDbType.Int),
            };
            param[0].Value = applyId;
            param[1].Value = itemId;
            string str = ComMethod.GetList("uspSearchPrepareDtl", param);
            return str;
        }

        //用于获取备料接收地
        public String GetPrepareLoc()
        {
            var strSQL = " SELECT 99+RID as RID,[PrepareDesc] FROM Prod_PrepareToOther " +
                         "WHERE [EnableFlag]  = 1";
            return ComMethod.GetListBySql(strSQL, null, SQLHelper.MESConnString);
        }

        //用于获取物料历史记录
        public String GetMaterialHistory(int MaterialId)
        {
            var strSQL = " SELECT * FROM vwMaterialHistory" +
                         " WHERE [MaterialUnitId] = " + MaterialId;
            return ComMethod.GetListBySql(strSQL, null, SQLHelper.MESConnString);
        }

        /// <summary>
        /// 分页获取 PartNo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="partNoCount">partNo 总数。</param>
        /// <returns>PartNo 列表。</returns>
        public List<ERPPartNoInfo> GetItemCodeInWarehouse(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ERPPartNoInfo> list = new List<ERPPartNoInfo>();
            ERPPartNoInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwItemCodeInWarehouse"
                , "ItemID",
                " ItemID, ItemCode, ItemName,ItemSpec", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ERPPartNoInfo();
                    entity.ErpItemId = rdr.GetInt32(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.ItemName = rdr.GetString(2);
                    entity.ItemSpec = rdr.GetString(3);
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public void EditProdReturnOrder(string ReturnNo, string ItemList, int DeptId, string UserName, String ProdOrderNo)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ReturnOrderNo",SqlDbType.NVarChar,50),
                  new SqlParameter("@ItemList",SqlDbType.NVarChar,-1),
                  new SqlParameter("@DeptId",SqlDbType.Int),
                  new SqlParameter("@UserName",SqlDbType.NVarChar,50),
                  new SqlParameter("@ProdOrderNo",SqlDbType.NVarChar,50)
            };
            parms[0].Value = ReturnNo;
            parms[1].Value = ItemList;
            parms[2].Value = DeptId;
            parms[3].Value = UserName;
            parms[4].Value = ProdOrderNo;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspNewProdReturn2Warehouse", parms);

        }


        public List<MaterialInfo> GetProdReturnOrder(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialInfo> list = new List<MaterialInfo>();
            //表名或者视图
            string strTb = "vwProdReturnOrderList";
            //主键
            string strKey = "ReturnId";
            //查询栏位字串
            string strColumns = @"ReturnOrderNo,DepartName,CreateDateTime,CWhName";
            list = ComMethod.GetComList<MaterialInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public string GetProdRtItemInfo(string ProdReturnNo)
        {
            MaterialInfo entity = null;
            List<MaterialInfo> list = new List<MaterialInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProdReturnNo", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = ProdReturnNo;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ReturnToWarehouse_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialInfo();
                    entity.ReturnOrderNo = rdr["ReturnOrderNo"].ToString();
                    entity.Remark = (string)rdr["Remark"];
                    //entity.ItemId = (int)rdr["ItemId"];
                    entity.ItemCode = (string)rdr["ItemCode"];
                    entity.ItemName = (string)rdr["ItemName"];
                    entity.ReturnQty = Convert.ToDecimal(rdr["ReturnQty"]);
                    entity.ReceiveQty = Convert.ToDecimal(rdr["ReceiveQty"]);
                    entity.PoCode = (string)rdr["ProdOrder"];
                    entity.ERPReBillID = (int)rdr["ERPReBillID"];
                    list.Add(entity);
                }
                rdr.Close();
            }
            var strJson = (new JavaScriptSerializer()).Serialize(list);
            return strJson;
        }

        public List<MaterialInfo> GetReturnOrderDetail(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            MaterialInfo entity = null;
            List<MaterialInfo> list = new List<MaterialInfo>();
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "Prod_ReturnToWarehouse"
                , "ReturnToWarehouseID",
                " ReturnToWarehouseID,ReturnOrderNo,ItemCode,ReturnQty,ReceiveQty,ERPReBillID", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialInfo();
                    entity.ReturnOrderNo = rdr["ReturnOrderNo"].ToString();
                    entity.ItemCode = (string)rdr["ItemCode"];
                    entity.ReturnQty = Convert.ToDecimal(rdr["ReturnQty"]);
                    entity.ReceiveQty = Convert.ToDecimal(rdr["ReceiveQty"]);
                    entity.ERPReBillID = (int)rdr["ERPReBillID"];
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 检查扫入的GRN并返回信息。
        /// </summary>
        public string CheckGrnReturnWarehouse(string returnOrder, string grn)
        {
            MaterialUnitInfo entity = new MaterialUnitInfo();
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            string strJson = "";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ReturnOrder", SqlDbType.NVarChar,50),
                new SqlParameter("@Grn", SqlDbType.NVarChar,100)
            };

            parms[0].Value = returnOrder;
            parms[1].Value = grn;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckGrnCanRTW", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr["SerialNumber"].ToString();
                    entity.BalanceQty = (decimal)rdr["BalanceQty"];
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    entity.ItemName = rdr["ItemName"].ToString();
                    entity.ApplyNo = rdr["ApplyNo"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            strJson = (new JavaScriptSerializer()).Serialize(list);
            return strJson;
        }

        /// <summary>
        /// 确认退货。
        /// </summary>
        public string SaveGrnReturnWarehouse(string returnNo, string strGrns, string cBarcode, string userName)
        {
            //SqlParameter[] parms = new SqlParameter[]{
            //    new SqlParameter("@ReturnNo", SqlDbType.NVarChar,50),
            //    new SqlParameter("@GrnStr", SqlDbType.NVarChar,-1),
            //    new SqlParameter("@cBarcode", SqlDbType.NVarChar,200),
            //    new SqlParameter("@CreateBy", SqlDbType.NVarChar,50)
            //};
            //parms[0].Value = returnNo;
            //parms[1].Value = strGrns;
            //parms[2].Value = cBarcode;
            //parms[3].Value = userName;
            //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveRTW", parms);

            var msg = string.Empty;
            string erpReturnNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.ProductReturn;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）

            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@ReturnNo", returnNo);
                    dp.Add("@GrnStr", strGrns);
                    dp.Add("@cBarcode", cBarcode);
                    dp.Add("@CreateBy", userName);
                    reader = conn.ExecuteReader("uspSaveRTW", dp, tran, null, CommandType.StoredProcedure);
                    dtWrite.Load(reader);
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    //是否需要回写
                    isWriteBack = WriteBackERP.IsWriteBack(em);
                    if (isWriteBack)
                    {
                        if (dtWrite == null || dtWrite.Rows.Count <= 0)
                        {
                            msg = "未获取到需要回写ERP数据";
                            throw new Exception(msg);
                        }

                        DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                        //调用接口
                        ERPReturnInfo info = WriteBackERP.SendPost(em, dtWrite, returnNo, userName, dtEnterTime, dtAfterExecProcTime);
                        if (!info.Result)
                        {
                            //回写失败
                            throw new Exception(info.msg);
                        }
                        else
                        {
                            erpReturnNo = info.ERPNo;
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
                }
            }
            return erpReturnNo;

        }

        public List<MaterialInfo> GetProdReturnOrderAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialInfo> list = new List<MaterialInfo>();
            //表名或者视图
            string strTb = "[vwProdReturnOrderAll]";
            //主键
            string strKey = "DeptID";
            //查询栏位字串
            string strColumns = @"ReturnOrderNo,DeptID,DepartName,CreateBy,CreateDateTime,UpdateBy,ModifyDateTime 
                                ,StatusDesc,ItemCode,ItemName,ReturnQty,ReceiveQty
                                ,ERPReBillID,SourceBillNo,CWhName,ProdOrderNo,VendorName,VendorCode,StatusName,case ModifyDateTime when '1900-01-27 00:00:00' then CreateDateTime else ModifyDateTime end as ModifyByTime2";
            list = ComMethod.GetComList<MaterialInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 取消退货单。
        /// </summary>
        public void CancelProdReturn(string returnNo, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ReturnNo", SqlDbType.NVarChar,50),
                new SqlParameter("@Username", SqlDbType.NVarChar,50)
            };
            parms[0].Value = returnNo;
            parms[1].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCancelRTW", parms);

        }

        //用于获取生产退料扫描记录
        public String GetProdReturnGrn(string returnNo)
        {
            var strSQL = " SELECT * FROM [vwProdReturnGrn]" +
                         " WHERE [ReturnOrderNo] = '" + returnNo + "'";
            return ComMethod.GetListBySql(strSQL, null, SQLHelper.MESConnString);
        }

        //用于供应商退料扫描记录
        public String GetReturnToVendorGrn(string returnNo, string itemCode)
        {
            var strSQL = " SELECT * FROM [vwReturnToVendorGrn]" +
                         " WHERE [ReturnOrder] = '" + returnNo + "' AND ItemCode = '" + itemCode + "' ";
            return ComMethod.GetListBySql(strSQL, null, SQLHelper.MESConnString);
        }

        public List<MaterialInfo> GetReturnToVendorAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialInfo> list = new List<MaterialInfo>();
            //表名或者视图
            string strTb = "vwReturnToVendorAll";
            //主键
            string strKey = "RtvDtlID";
            //查询栏位字串
            string strColumns = @"[ReturnOrder],[ReturnDate]
                                ,[VenCode],[ItemCode],[ItemId],[ItemName]
                                ,[ReturnQty],[ReceiveQty],[FinishStatus]
                                ,[CreateDateTime],[CreateBy],[UpdateTime],[UpdateBy]
                                ,[ERPReBillID],[SourceBillNo],[AutoID],[VendorName],[VendorCode]";
            list = ComMethod.GetComList<MaterialInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 检查扫入的GRN并返回信息。PDA
        /// </summary>
        public string CheckGrnReturnWarehousePDA(string returnOrder, string grn)
        {
            MaterialUnitInfo entity = new MaterialUnitInfo();
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            string strJson = "";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ReturnOrder", SqlDbType.NVarChar,50),
                new SqlParameter("@Grn", SqlDbType.NVarChar,100)
            };

            parms[0].Value = returnOrder;
            parms[1].Value = grn;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckGrnCanRTWPDA", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr["SerialNumber"].ToString();
                    entity.BalanceQty = (decimal)rdr["BalanceQty"];
                    entity.ItemId = (int)rdr["ItemId"];
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    entity.ItemName = rdr["ItemName"].ToString();
                    entity.ApplyNo = rdr["ApplyNo"].ToString();
                    entity.CBarCode = rdr["CBarCode"].ToString();
                    //entity.ERPRecordsAutoID = (int)rdr["ERPRecordsAutoID"];
                    //entity.ERPReBillID = (int)rdr["ERPReBillID"];
                    list.Add(entity);
                }
                rdr.Close();
            }
            strJson = (new JavaScriptSerializer()).Serialize(list);
            return strJson;
        }

        /// <summary>
        /// 确认退货。PDA
        /// </summary>
        public void SaveGrnReturnWarehousePDA(string returnNo, string strGrns, string cBarcode, string userName)
        {
            /*
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ReturnNo", SqlDbType.NVarChar,50),
                new SqlParameter("@GrnStr", SqlDbType.NVarChar,-1),
                new SqlParameter("@cBarcode", SqlDbType.NVarChar,200),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar,50)
            };
            parms[0].Value = returnNo;
            parms[1].Value = strGrns;
            parms[2].Value = cBarcode;
            parms[3].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveRTWPDA", parms);
            */
            var msg = string.Empty;
            string erpNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.ProductReturn;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@ReturnNo", returnNo);
                    dp.Add("@GrnStr", strGrns);
                    dp.Add("@cBarcode", cBarcode);
                    dp.Add("@CreateBy", userName);

                    reader = conn.ExecuteReader("uspSaveRTWPDA", dp, tran, null, CommandType.StoredProcedure);

                    dtWrite.Load(reader);

                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                    //判断是否全退
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
                    // 捕获到异常，准备回滚事务  
                    try
                    {
                        tran.Rollback();
                        throw new Exception("事务处理失败，已回滚。", ex);
                    }
                    catch (Exception rollbackEx)
                    {

                        throw ex;
                    }

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
        }

        /// <summary>
        /// 仓库退供应商退货数量验证
        /// </summary>
        /// <param name="poCode">采购单号</param>
        /// <param name="itemCode">物料编码</param>
        /// <param name="lineID">行号</param>
        /// <param name="itemQty">物料总数</param>
        /// <param name="returnQty">退料数</param>
        public void ValidReturnMaterialUnit(string poCode, string itemCode, int lineID, decimal itemQty, decimal returnQty)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@poCode", SqlDbType.NVarChar,50),
                new SqlParameter("@itemCode", SqlDbType.NVarChar,50),
                new SqlParameter("@lineID", SqlDbType.Int),
                new SqlParameter("@itemQty", SqlDbType.Decimal),
                new SqlParameter("@returnQty", SqlDbType.Decimal)
            };
            parms[0].Value = poCode;
            parms[1].Value = itemCode;
            parms[2].Value = lineID;
            parms[3].Value = itemQty;
            parms[4].Value = returnQty;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "validReturnMaterialUnit", parms);
        }


        public void SaveStationMaterialPrepar(int areainfo, string stationinfo, string planOrder, string grnStr)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Area", SqlDbType.NVarChar,50),
                new SqlParameter("@Positon", SqlDbType.NVarChar,200),
                new SqlParameter("@MoCode", SqlDbType.VarChar,50),
                new SqlParameter("@GrnStr", SqlDbType.VarChar,int.MaxValue)
            };
            parms[0].Value = areainfo;
            parms[1].Value = stationinfo;
            parms[2].Value = planOrder;
            parms[3].Value = grnStr;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "usp_SaveStationMaterialPrepar", parms);
        }

        /// <summary>
        /// 获取检验单收料明细列表信息
        /// </summary>
        /// <param name="returnNo"></param>
        /// <returns></returns>
        public string GetMaterialReceiveDtl(int InspectionId)
        {
            string strSql = " SELECT * FROM [vWGetMaterialReceiveDtl] WHERE [InspectionId] = " + InspectionId + "";
            return ComMethod.GetListBySql(strSql, null, SQLHelper.MESConnString);
        }
        
    }
}