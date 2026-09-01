using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Warehouse.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Linq;

namespace SKT.LeanMES.Warehouse.BLL
{
    public class WarehouseLocation
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） WarehouseLocation 信息。
        /// </summary>
        /// <param name="entity">WarehouseLocation 实体对象。</param>
        public Int32 Edit(WarehouseLocationInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WarehouseLocationId", SqlDbType.Int) { Value = entity.WarehouseLocationId},
                new SqlParameter("@cStoreCode", SqlDbType.VarChar, 20){ Value = entity.CStoreCode},
                new SqlParameter("@cStoreName", SqlDbType.NVarChar, 30){ Value = entity.CStoreName},
                new SqlParameter("@cPosCode", SqlDbType.VarChar, 20){ Value = entity.CPosCode},
                new SqlParameter("@cPosName", SqlDbType.NVarChar, 30){ Value = entity.CPosName},
                new SqlParameter("@CProperty", SqlDbType.VarChar, 20){ Value = entity.CProperty},
                new SqlParameter("@cWhCode", SqlDbType.NVarChar, 10){ Value = entity.CWhCode},
                new SqlParameter("@MOrder", SqlDbType.VarChar, 10){ Value = entity.MOrder},
                new SqlParameter("@POrder", SqlDbType.VarChar, 10){ Value = entity.POrder},
                new SqlParameter("@iPosGrade", SqlDbType.SmallInt){ Value = entity.IPosGrade},
                new SqlParameter("@bPosEnd", SqlDbType.SmallInt){ Value = entity.BPosEnd},
                new SqlParameter("@cBarCode", SqlDbType.VarChar, 50){ Value = entity.CBarCode},
                new SqlParameter("@iMaxCubage", SqlDbType.Decimal){ Value = entity.IMaxCubage},
                new SqlParameter("@iMaxWeight", SqlDbType.Decimal){ Value = entity.IMaxWeight},
                new SqlParameter("@CreateBy", SqlDbType.VarChar){ Value = entity.CreateBy},
                new SqlParameter("@ModifyBy", SqlDbType.VarChar){ Value = entity.ModifyBy},
                new SqlParameter("@Remark", SqlDbType.NVarChar, 100){ Value = entity.Remark},
                new SqlParameter("@WMSWarehouseId", SqlDbType.Int){ Value = entity.WMSWarehouseId},
                new SqlParameter("@ProductIsOnly", SqlDbType.Int){ Value = entity.ProductIsOnly},
                new SqlParameter("@LocationType", SqlDbType.NVarChar,10){ Value = entity.LocationType},
                new SqlParameter("@ShiftCode", SqlDbType.NVarChar,50){Value = entity.ShiftCode },
                new SqlParameter("@InOrder", SqlDbType.Int){Value = entity.InOrder },
                new SqlParameter("@AGVLandmarkCode", SqlDbType.VarChar,50){Value = entity.AGVLandmarkCode },
                new SqlParameter("@IsUniPakPos", SqlDbType.Int){Value = entity.IsUniPakPos }
            };

             
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseLocation_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 WarehouseLocationId 字符串删除 WarehouseLocation 信息。
        /// </summary>
        /// <param name="idString">WarehouseLocationId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseLocation_Delete", parms);
        }

        /// <summary>
        /// 根据 WarehouseLocationId 获取实体信息。
        /// </summary>
        /// <param name="warehouseLocationId">WarehouseLocationId。</param>
        /// <returns>WarehouseLocation 实体对象。</returns>
        public WarehouseLocationInfo GetInfo(Int32 warehouseLocationId)
        {
            /*
            WarehouseLocationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = warehouseLocationId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseLocation_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseLocationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetInt16(9),
                        rdr.GetInt16(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetString(14),
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetDateTime(17), rdr.GetString(18), rdr.GetString(19), rdr.GetString(20), rdr.GetInt32(21));
                    entity.LocationType = rdr.GetString(22);
                    entity.ShiftCode = rdr.GetString(23);

                }
                rdr.Close();
            }

            return entity;
            */

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar) { Value = warehouseLocationId},
                new SqlParameter("@IsByID", SqlDbType.Bit) { Value = true}
            };

            return ComMethod.GetList<WarehouseLocationInfo>("Basal_WarehouseLocation_GetInfo", parms).FirstOrDefault();
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>WarehouseLocation 实体对象。</returns>
        public WarehouseLocationInfo GetInfo(String fieldValue)
        {
            /*
            WarehouseLocationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseLocation_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseLocationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetInt16(9),
                        rdr.GetInt16(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetString(14),
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetDateTime(17), rdr.GetString(18), rdr.GetString(19), rdr.GetString(20), rdr.GetInt16(21));

                    entity.LocationType = rdr.GetString(22);
                    entity.ShiftCode = rdr.GetString(23);
                }
                rdr.Close();
            }

            return entity;
            */

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar) { Value = fieldValue},
                new SqlParameter("@IsByID", SqlDbType.Bit) { Value = false}
            };

            return ComMethod.GetList<WarehouseLocationInfo>("Basal_WarehouseLocation_GetInfo", parms).FirstOrDefault();
        }

        /// <summary>
        /// 分页获取 WarehouseLocation 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warehouseLocationCount">warehouseLocation 总数。</param>
        /// <returns>WarehouseLocation 列表。</returns>
        public List<WarehouseLocationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            /*
            List<WarehouseLocationInfo> list = new List<WarehouseLocationInfo>();
            WarehouseLocationInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwWarehouseLocation", "WarehouseLocationId",
                @"[WarehouseLocationId], [cStoreCode], [cStoreName], [cPosCode], [cPosName], [CProperty], [WarehouseId], [MOrder], [POrder], [iPosGrade],
                [bPosEnd], [cBarCode], [iMaxCubage], [iMaxWeight], [CreateBy], [CreateDateTime], [ModifyBy], 
                [ModifyDateTime], [Remark],[CWhCode],[CWhName],LocationType,ShiftCode", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarehouseLocationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetInt16(9),
                        rdr.GetInt16(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetString(14),
                        rdr.GetDateTime(15), rdr.GetString(16), rdr.GetDateTime(17), rdr.GetString(18), rdr.GetString(19), rdr.GetString(20), rdr.GetInt16(10));

                    entity.LocationType = rdr.GetString(21);
                    entity.ShiftCode = rdr.GetString(22);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
            */

            List<WarehouseLocationInfo> list = new List<WarehouseLocationInfo>();
            //表名或者视图
            string strTb = "vwWarehouseLocation"; 
            //主键
            string strKey = "WarehouseLocationId"; 
            //查询栏位字串
            string strColumns = @"[WarehouseLocationId], [cStoreCode], [cStoreName], [cPosCode], [cPosName], [CProperty], [WarehouseId], [MOrder], [POrder], [iPosGrade],
                [bPosEnd], [cBarCode], [iMaxCubage], [iMaxWeight], [CreateBy], [CreateDateTime], [ModifyBy], 
                [ModifyDateTime], [Remark],[CWhCode],[CWhName],LocationType,ShiftCode,InOrder,AGVLandmarkCode";
            list = ComMethod.GetComList<WarehouseLocationInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        /// <summary>
        /// 判断货架层码是否存在
        /// </summary>
        /// <returns></returns>
        public void ScanCposcode(string cposcode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@cposcode", SqlDbType.VarChar, 50)
            };
            parms[0].Value = cposcode;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInStorage_ScanCposcode", parms))
            {
                rdr.Close();
            }
        }

        /// <summary>
        /// 扫描GRN ，绑定货位
        /// </summary>
        /// <returns></returns>
        public InStorageDtl ScanGRN(string cposcode, string username, string grn)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@cposcode", SqlDbType.VarChar, 50),
                new SqlParameter("@username", SqlDbType.NVarChar,20),
                new SqlParameter("@grn", SqlDbType.VarChar, 50)
            };
            parms[0].Value = cposcode;
            parms[1].Value = username;
            parms[2].Value = grn;
            InStorageDtl dtl = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspInStorage_ScanGRN", parms))
            {
                while (rdr.Read())
                {
                    dtl = new InStorageDtl()
                    {
                        order = rdr["IQCBatchNO"].ToString(),
                        itemcode = rdr["ItemCode"].ToString(),
                        qualifiedqty = Convert.ToDecimal(rdr["qualifiedqty"]),
                        storageqty = Convert.ToDecimal(rdr["ERPQty"]),
                        cbarcode = rdr["cbarcode"].ToString(),
                        iscbarcode = Convert.ToInt32(rdr["iscbarcode"])
                    };
                }
                rdr.Close();
            }
            return dtl;
        }

        public List<AgeOfStorageDtl> QueryAgeOfStorage(string code, int day)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@code", SqlDbType.VarChar, 50),
                new SqlParameter("@day", SqlDbType.Int)
            };
            parms[0].Value = code;
            parms[1].Value = day;
            List<AgeOfStorageDtl> list = new List<AgeOfStorageDtl>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspAgeOfStorage_Query", parms))
            {
                while (rdr.Read())
                {
                    list.Add(new AgeOfStorageDtl()
                    {
                        ItemCode = rdr["ItemCode"].ToString(),
                        SerialNumber = rdr["SerialNumber"].ToString(),
                        StorageDays = Convert.ToInt32(rdr["StorageDays"]),
                        cbarcode = rdr["cbarcode"].ToString()
                    });
                }
                rdr.Close();
            }
            return list;
        }
        public void AgeOfStorageScanGRN(string grn, string cbarcode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@grn", SqlDbType.VarChar, 50),
                new SqlParameter("@cbarcode", SqlDbType.VarChar, 50)
            };
            parms[0].Value = grn;
            parms[1].Value = cbarcode;
            List<AgeOfStorageDtl> list = new List<AgeOfStorageDtl>();
            SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspAgeOfStorage_ScanGRN", parms);
        }
        public List<string> QueryDateCode(string itemcode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@itemcode", SqlDbType.VarChar, 50)
            };
            parms[0].Value = itemcode;
            List<string> list = new List<string>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, @"select distinct t1.DateCode from Prod_MaterialUnit t1
   inner join basal_item t2 on t1.PartId=t2.ItemID 
   where t2.ItemCode=@itemcode and t1.Status=0 and t1.DateCode!='' and t1.DateCode is not null
   order by t1.DateCode", parms))
            {
                while (rdr.Read())
                {
                    list.Add(rdr["DateCode"].ToString());
                }
                rdr.Close();
            }
            return list;
        }
        public List<QueryMaterialUnitDtl> QueryMaterialUnit(string itemcode, string datecode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@itemcode", SqlDbType.VarChar, 50),
                new SqlParameter("@datecode",SqlDbType.VarChar, 50)
            };
            parms[0].Value = itemcode;
            parms[1].Value = datecode;
            List<QueryMaterialUnitDtl> list = new List<QueryMaterialUnitDtl>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspQueryMaterialUnit_Mobile", parms))
            {
                while (rdr.Read())
                {
                    list.Add(new QueryMaterialUnitDtl()
                    {
                        ItemName = rdr["ItemName"].ToString(),
                        SerialNumber = rdr["SerialNumber"].ToString(),
                        balanceqty = Convert.ToDecimal(rdr["balanceqty"]),
                        VendorName = rdr["VendorName"].ToString(),
                        cBarCode = rdr["cBarCode"].ToString()
                    });
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 获取grn 备料的库位灯灭灯
        /// </summary>
        /// <returns></returns>
        public string GetCbarcode(string grn)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@grn", SqlDbType.VarChar, 50)
            };
            parms[0].Value = grn;
            string code = "";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, "select cbarcode from Prod_MaterialUnit where SerialNumber=@grn and lockcode is not null and lockcode!='' and cbarcode is not null and cbarcode!=''", parms))
            {
                if (rdr.Read())
                {
                    code = rdr["cbarcode"].ToString();
                }
                rdr.Close();
            }
            return code;
        }
        /// <summary>
        /// 扫描GRN ，移动货位
        /// </summary>
        /// <returns></returns>
        public string MoveMaterialScanGRN(string cposcode, string grn, ref int iscbarcode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@cposcode", SqlDbType.VarChar, 50),
                new SqlParameter("@grn", SqlDbType.VarChar, 50),
                new SqlParameter("@result", SqlDbType.VarChar, 50),
                new SqlParameter("@iscbarcode", SqlDbType.Int)

            };
            parms[0].Value = cposcode;
            parms[1].Value = grn;
            parms[2].Direction = ParameterDirection.Output;
            parms[3].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspMoveMaterial_ScanGRN", parms);
            iscbarcode = Convert.ToInt32(parms[3].Value);
            return parms[2].Value.ToString();
        }

        /// <summary>
        /// 盘点移库：支持盘点锁定(Status=14)物料，按配置911决定处理方式(1-当场执行同仓移库/跨仓记录 2-只记录实际库位,平帐统一处理)
        /// </summary>
        /// <param name="cposcode">实际库位条码</param>
        /// <param name="grn">物料条码</param>
        /// <param name="checkNo">盘点单号</param>
        /// <param name="userName">操作人</param>
        /// <returns>处理结果信息</returns>
        public string WarehouseCheckMoveMaterial(string cposcode, string grn, string checkNo, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@cposcode", SqlDbType.VarChar, 50),
                new SqlParameter("@grn", SqlDbType.VarChar, 50),
                new SqlParameter("@checkNo", SqlDbType.VarChar, 50),
                new SqlParameter("@userName", SqlDbType.VarChar, 50),
                new SqlParameter("@result", SqlDbType.VarChar, 200)
            };
            parms[0].Value = cposcode;
            parms[1].Value = grn;
            parms[2].Value = checkNo;
            parms[3].Value = userName;
            parms[4].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspWarehouseCheckMoveMaterial_Program", parms);
            return parms[4].Value.ToString();
        }


        public List<ExpiredMaterialDtl> QueryExpiredMaterial(string code)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@code", SqlDbType.VarChar, 50)
            };
            parms[0].Value = code;
            List<ExpiredMaterialDtl> list = new List<ExpiredMaterialDtl>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspExpiredMaterial_Query", parms))
            {
                while (rdr.Read())
                {
                    list.Add(new ExpiredMaterialDtl()
                    {
                        ItemCode = rdr["ItemCode"].ToString(),
                        SerialNumber = rdr["SerialNumber"].ToString(),
                        Overdue = Convert.ToInt32(rdr["Overdue"]),
                        cBarCode = rdr["cBarCode"].ToString()
                    });
                }
                rdr.Close();
            }
            return list;
        }
        public List<string> GetRecord()
        {
            List<string> list = new List<string>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, @"select sheet_no  from  [ERP_Record] where Sheet_type in ('SCM1001','SCM1002') and Sheet_sta=0", null))
            {
                while (rdr.Read())
                {
                    list.Add(rdr["sheet_no"].ToString());
                }
                rdr.Close();
            }
            return list;
        }
        public List<string> GetLoadOrder()
        {
            List<string> list = new List<string>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, @"select FBILLNO from Prod_LinePlan  order by FBILLNO", null))
            {
                while (rdr.Read())
                {
                    list.Add(rdr["FBILLNO"].ToString());
                }
                rdr.Close();
            }
            return list;
        }
        public List<string> GetRequestOrder()
        {
            List<string> list = new List<string>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, @"select t1.FormNO from Prod_MaterialRequest t1 WHERE DATEDIFF(MM,t1.ERPDateTime,GETDATE())<=0", null))
            {
                while (rdr.Read())
                {
                    list.Add(rdr["FormNO"].ToString());
                }
                rdr.Close();
            }
            return list;
        }
        public List<TakeMaterialGRNDtl> GetTakeGRNInfo(int type, string code, int lockgrn, string username, string itemcode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@type", SqlDbType.Int),
                new SqlParameter("@code", SqlDbType.VarChar,50),
                new SqlParameter("@lockgrn", SqlDbType.Int),
                new SqlParameter("@username", SqlDbType.NVarChar,20),
                new SqlParameter("@itemcodestr", SqlDbType.VarChar,50),
            };
            parms[0].Value = type;
            parms[1].Value = code;
            parms[2].Value = lockgrn;
            parms[3].Value = username;
            parms[4].Value = itemcode;
            List<TakeMaterialGRNDtl> list = new List<TakeMaterialGRNDtl>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspTakeMaterialGRN", parms))
            {
                while (rdr.Read())
                {
                    list.Add(new TakeMaterialGRNDtl()
                    {
                        NeedQty = Convert.ToDecimal(rdr["NeedQty"]),
                        ItemCode = rdr["ItemCode"].ToString(),
                        SerialNumber = rdr["SerialNumber"].ToString(),
                        cBarCode = rdr["cBarCode"].ToString(),
                        LockCode = rdr["LockCode"] == DBNull.Value ? "" : rdr["LockCode"].ToString(),
                        BalanceQty = Convert.ToDecimal(rdr["BalanceQty"]),
                        Cut = Convert.ToInt32(rdr["Cut"]),
                        ColorCode = rdr["ColorCode"].ToString()
                    });
                }
                rdr.Close();
            }
            return list;
        }
        public string CancelTakeGRNInfo(int type, string code)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@type", SqlDbType.Int),
                new SqlParameter("@code", SqlDbType.VarChar,50)
            };
            parms[0].Value = type;
            parms[1].Value = code;
            string cbarcodes = "";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, @"
                        update Prod_MaterialUnit set lockcode = null from Prod_MaterialUnit where lockcode = @code
                        select top(1) CBarCodes from Prod_TakeMaterialLockInfo where[type] = @type and code = @code
                        delete Prod_TakeMaterialLockInfo where[type] = @type and code = @code", parms))
            {
                if (rdr.Read())
                {
                    cbarcodes = rdr["CBarCodes"].ToString();
                }
                rdr.Close();
            }
            return cbarcodes;
        }
        /// <summary>
        /// 确认备料
        /// </summary>
        /// <param name="type"></param>
        /// <param name="code"></param>
        /// <returns></returns>
        public string SaveCancelTakeGRNInfo(int type, string code)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@type", SqlDbType.Int),
                new SqlParameter("@code", SqlDbType.VarChar,50)
            };
            parms[0].Value = type;
            parms[1].Value = code;
            string cbarcodes = "";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, @"
                        update Prod_MaterialUnit set lockcode = null,cBarCode=''  from Prod_MaterialUnit where lockcode = @code
                        select top(1)CBarCodes from Prod_TakeMaterialLockInfo where[type] = @type and code = @code
                        delete Prod_TakeMaterialLockInfo where[type] = @type and code = @code", parms))
            {
                if (rdr.Read())
                {
                    cbarcodes = rdr["CBarCodes"].ToString();
                }
                rdr.Close();
            }
            return cbarcodes;
        }
        public List<CheckMaterialDtl> QueryCheckMaterial(string code)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@code", SqlDbType.VarChar, 50)
            };
            parms[0].Value = code;
            List<CheckMaterialDtl> list = new List<CheckMaterialDtl>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckMaterial_Query", parms))
            {
                while (rdr.Read())
                {
                    list.Add(new CheckMaterialDtl()
                    {
                        ItemID = Convert.ToInt32(rdr["ItemID"]),
                        ItemCode = rdr["ItemCode"].ToString(),
                        Type = rdr["Type"].ToString(),
                        BalanceQty = Convert.ToDecimal(rdr["BalanceQty"])
                    });
                }
                rdr.Close();
            }
            return list;
        }
        public decimal CheckMaterialScanGRN(int itemId, string grn)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@itemid", SqlDbType.Int),
                new SqlParameter("@grn", SqlDbType.VarChar, 50),
                new SqlParameter("@qty", SqlDbType.Decimal)
            };
            parms[0].Value = itemId;
            parms[1].Value = grn;
            parms[2].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckMaterial_ScanGRN", parms);
            return Convert.ToDecimal(parms[2].Value);
        }
        public string CheckMaterialConfirm(int itemId, string grn, decimal qty, string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@itemid", SqlDbType.Int),
                new SqlParameter("@grn", SqlDbType.VarChar, 50),
                new SqlParameter("@qty", SqlDbType.Decimal),
                new SqlParameter("@username", SqlDbType.NVarChar,20),
                new SqlParameter("@cBarCode", SqlDbType.VarChar,50),
            };
            parms[0].Value = itemId;
            parms[1].Value = grn;
            parms[2].Value = qty;
            parms[3].Value = username;
            parms[4].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckMaterial_Confirm", parms);
            return parms[4].Value.ToString();
        }
        public Tuple<string, string> CheckMaterial(int itemId, int type, string name)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@itemId", SqlDbType.Int),
                new SqlParameter("@type", SqlDbType.Int),
                new SqlParameter("@username", SqlDbType.NVarChar,20)
            };
            parms[0].Value = itemId;
            parms[1].Value = type;
            parms[2].Value = name;
            Tuple<string, string> t = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckMaterial", parms))
            {
                if (rdr.Read())
                {
                    t = new Tuple<string, string>(rdr["colorcode"].ToString(), rdr["cbarcodes"].ToString());
                }
                rdr.Close();
            }
            return t;
        }
        /// <summary>
        /// 0 上架入库，1 物料库龄  2 超期物料  3物料盘点 4物料备料  5物料移库   6物料查询
        /// </summary>
        /// <param name="type"></param>
        /// <param name="orderid"></param>
        /// <returns></returns>
        public WarehouseLightColorInfo TaskColorCode(int type)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@type", SqlDbType.Int),
                new SqlParameter("@color", SqlDbType.VarChar,10),
                new SqlParameter("@fId", SqlDbType.Int),
                new SqlParameter("@colorDesc", SqlDbType.VarChar,50)
            };
            parms[0].Value = type;
            parms[1].Direction = ParameterDirection.Output;
            parms[2].Direction = ParameterDirection.Output;
            parms[3].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspTaskColorCode", parms);

            return new WarehouseLightColorInfo
            {
                FunctionId = Convert.ToInt32(parms[2].Value),
                ColorCode = parms[1].Value.ToString(),
                ColorDescription = parms[3].Value.ToString()
            };
        }

        /// <summary>
        /// 判断产品是否能放入当前库位
        /// </summary>
        /// <param name="grn">GRN条码</param>
        /// <param name="itemCode">产品编码</param>
        /// <param name="cBarCode">库位条码</param>
        /// <returns></returns>
        public bool IsItemCanPlacedInWarehouseLocation(string grn, string itemCode, string cBarCode)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@GRN", SqlDbType.VarChar, 100),
                new SqlParameter("@ItemCode", SqlDbType.VarChar,50),
                new SqlParameter("@CBarCode", SqlDbType.VarChar,50),
                new SqlParameter("@Result", SqlDbType.Bit),
            };
            parms[0].Value = grn;
            parms[1].Value = itemCode;
            parms[2].Value = cBarCode;
            parms[3].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspIsItemCanPlacedInWarehouseLocation", parms);
            return Convert.ToBoolean(parms[3].Value);
        }
        public void WritLog(string name, string content)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@username", SqlDbType.NVarChar,20),
                    new SqlParameter("@content", SqlDbType.VarChar,8000)
                };
                parms[0].Value = name;
                parms[1].Value = content;
                SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, "insert into Prod_MAESWEBServiceLog(UserName, LogTime, Content) values(@username, getdate(), @content)", parms);
            }
            catch (Exception)
            {

            }
        }

    }
}