using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Material.Model;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Utility;
using SKT.LeanMES.CommonHelper.BLL;
using System.Linq;
using System.Text.RegularExpressions;

namespace SKT.LeanMES.Material.BLL
{
    public class MaterialUnit
    {
        private Int32 recordCount = 0;
        private Int32 recordCountGRNCarton = 0;
        private Int32 recordVendorItemCount = 0;
        private Int32 recordPickingListCount = 0;
        private Int32 recordGRNCartonCount = 0;
        private Int32 recordDelPckCount = 0;

        /// <summary>
        /// 保存发料
        /// </summary>
        /// <param name="ItemStr"></param>
        /// <param name="Grn"></param>
        /// <returns></returns>
        public void CheckSendMaterial(string RequestId, Int32 selLocation, String grnStr, String userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@RequestId",SqlDbType.NVarChar,50),
                  new SqlParameter("@selLocation",SqlDbType.Int),
                  new SqlParameter("@GrnStr",SqlDbType.NVarChar,8000),
                  new SqlParameter("@userName",SqlDbType.NVarChar,20)

            };
            parms[0].Value = RequestId;
            parms[1].Value = selLocation;
            parms[2].Value = grnStr;
            parms[3].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveSendMaterial", parms);
        }
        /// <summary>
        /// 获取产品id
        /// </summary>
        /// <param name="Grn"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetItemIdByMaterialGRN(String Grn)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@Grn",SqlDbType.NVarChar,100)
            };
            parms[0].Value = Grn;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetItemIdByMaterialGRN", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.PartId = rdr.GetInt32(2);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list; 
        }
        /// <summary>
        /// 查看发料信息
        /// </summary>
        /// <param name="formId"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> CheckSendMaterialNew(String ItemStr, String Grn,Int32 flage,String grnStr)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@ItemStr",SqlDbType.NVarChar,500),
                  new SqlParameter("@Grn",SqlDbType.NVarChar,100),
                  new SqlParameter("@Flage",SqlDbType.Int),
                  new SqlParameter("@GrnStr",SqlDbType.NVarChar,2000)
            };
            parms[0].Value = ItemStr;
            parms[1].Value = Grn;
            parms[2].Value = flage;
            parms[3].Value = grnStr;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckSendMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.PartId = rdr.GetInt32(2);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 查看领料单信息
        /// </summary>
        /// <param name="formId"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> sendMaterialInfo(String fromNumber)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@RequestNo",SqlDbType.NVarChar,100)
            };
            parms[0].Value = fromNumber;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspSendMaterialInfo", parms))
            {
                for (int i = 0; i < dt.Rows.Count;i++ )
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialRequestId = Convert.ToInt32(dt.Rows[i]["PMID"]);
                    entity.ItemName =dt.Rows[i]["ItemName"].ToString();
                    entity.RequestQty =Convert.ToInt32(dt.Rows[i]["AuxQtyPick"]);
                    entity.ResponseQty =Convert.ToInt32(dt.Rows[i]["stockqty"]);
                    entity.ItemId =Convert.ToInt32(dt.Rows[i]["ItemId"]);
                    entity.ItemDesc = dt.Rows[i]["Description"].ToString();
                    entity.ItemCode = dt.Rows[i]["ItemCode"].ToString();
                    list.Add(entity);
                }
            }
            recordCount = list.Count;
            return list;
        }
        /// <summary>
        /// 保存物料合并
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> SaveCombineMaterial(String grn, String waitGRN, String userName)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
                  new SqlParameter("@waitCombineSN",SqlDbType.NVarChar,500),
                  new SqlParameter("@userName",SqlDbType.NVarChar,20)

            };
            parms[0].Value = grn;
            parms[1].Value = waitGRN;
            parms[2].Value = userName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSaveCombineMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.ItemId = rdr.GetInt32(4);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 验证物料合并
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> CheckMaterialCombine(String grn)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@GRN",SqlDbType.VarChar,100)
            };
            parms[0].Value = grn;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckCombineMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.PartId = rdr.GetInt32(2);
                    entity.Status = rdr.GetInt32(3);
                    entity.ItemDesc = rdr.GetString(4);
                    entity.ItemName = rdr.GetString(5);
                    entity.POorder = rdr["POrder"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 更新入库信息  add by weixia on 2015/5/18
        /// </summary>
        public void SaveInStorageInfo(Int32 erpVouchId,String cBarCode, Int32 itemId, String IQCBatchNo, String userName,String lotCode)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                   new SqlParameter("@cBarCode",SqlDbType.NVarChar,200),
                   new SqlParameter("@ItemId",SqlDbType.Int),
                   new SqlParameter("@IQCBatchNo",SqlDbType.NVarChar,200),
                   new SqlParameter("@userName",SqlDbType.NVarChar,20),
                   new SqlParameter("@erpVouchId",SqlDbType.Int),
                   new SqlParameter("@LotCode",SqlDbType.VarChar,100)
            };
            parms[0].Value = cBarCode;
            parms[1].Value = itemId;
            parms[2].Value = IQCBatchNo;
            parms[3].Value = userName;
            parms[4].Value = erpVouchId;
            parms[5].Value = lotCode;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveInStorageInfo", parms);
        }
        /// <summary>
        /// 根据grn或者IQC检验单号获取信息
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="IQCNo"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetInStorageItemInfo(Int32 flage,String grn, String IQCNo)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@Flage",SqlDbType.Int),
                  new SqlParameter("@GRN",SqlDbType.VarChar,200),
                  new SqlParameter("@BatchNo",SqlDbType.NVarChar,200)
            };
            parms[0].Value = flage;
            parms[1].Value = grn;
            parms[2].Value = IQCNo;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetMaterialInStorage", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.ItemId = rdr.GetInt32(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.ItemDesc = rdr.GetString(2);
                    entity.BalanceQty = rdr.GetDecimal(3);
                    entity.IqcBatchNo = rdr.GetString(4);
                    entity.RowId = rdr.GetInt32(5);
                    entity.ErpArrivalVouchsId = rdr.GetInt32(6);
                   /* entity.ItemId = rdr.GetInt32(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.BalanceQty = rdr.GetDecimal(2);
                    entity.IqcBatchNo = rdr.GetString(3);
                    entity.RowId = rdr.GetInt32(4);
                    entity.ErpArrivalVouchsId = rdr.GetInt32(5);*/

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// add by weixia on 2015/4/28 
        /// 验证物料入库
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="wareCode"></param>
        public List<MaterialUnitInfo> InStorageMaterial(String grn, String wareCode, String userName)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
                  new SqlParameter("@WareCode",SqlDbType.VarChar,100),
                  new SqlParameter("@UserName",SqlDbType.NVarChar,50),
            };
            parms[0].Value = grn;
            parms[1].Value = wareCode;
            parms[2].Value = userName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckMaterialInStorage", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.CBarCode = rdr.GetString(2);
                    entity.Quantity = rdr.GetDecimal(3);
                    entity.ModifyBy = rdr.GetString(4);
                    entity.PackTime = rdr.GetDateTime(5).ToString("yyyy-MM-dd HH:mm:ss");

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 根据GRN和库位条码获取数量
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="wareCode"></param>
        /// <param name="qty"></param>
        /// <returns></returns>
        public Decimal GetQuantityByQty(string grn,string  wareCode, int flag) 
        {
            SqlParameter[] parms = new SqlParameter[] { 
                   new SqlParameter("@GRN",SqlDbType.VarChar,50),
                   new SqlParameter("@BarCode",SqlDbType.VarChar,200),
                   new SqlParameter("@Quantiy",SqlDbType.Decimal,18),
                   new SqlParameter("@Flag",SqlDbType.Int)
            };
            parms[0].Value = grn;
            parms[1].Value = wareCode;
            parms[2].Direction = ParameterDirection.Output;
            parms[2].Precision = 18;
            parms[2].Scale = 6;
            parms[3].Value = flag;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetQuantiyByGrn", parms);
            return Convert.ToDecimal(parms[2].Value);
        }
        /// <summary>
        /// 物料退料
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="wareCode"></param>
        /// <param name="qty"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> ReturnMaterial(String grn, String wareCode, Decimal qty, String userName,Int32 deptId)
        {

            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
                  new SqlParameter("@WareCode",SqlDbType.VarChar,100),
                  new SqlParameter("@Qty",SqlDbType.Decimal),
                  new SqlParameter("@UserName",SqlDbType.NVarChar,50),
                  new SqlParameter("@DeptId",SqlDbType.Int)
            };
            parms[0].Value = grn;
            parms[1].Value = wareCode;
            parms[2].Value = qty;
            parms[3].Value = userName;
            parms[4].Value = deptId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckReturnMaterial", parms))
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
                    entity.ItemDesc =rdr.GetString(6);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }


        /// <summary>
        /// 编辑（添加或更新） MaterialUnit 信息。
        /// </summary>
        /// <param name="entity">MaterialUnit 实体对象。</param>
        public void Edit(MaterialUnitInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaterialUnitId", SqlDbType.Int),
                new SqlParameter("@LotCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@DateCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy",SqlDbType.VarChar,20),
                new SqlParameter("@ModifyBy",SqlDbType.VarChar,20)
            };

            parms[0].Value = entity.MaterialUnitId;
            parms[1].Value = entity.LotCode;
            parms[2].Value = entity.DateCode;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialUnit_Edit", parms);
        }

        /// <summary>
        /// 根据 MaterialUnitId 字符串删除 MaterialUnit 信息
        /// </summary>
        /// <param name="idString">Id 字符串</param>
        /// <param name="Type">类型(1供应商删除GRN、2仓库删除GRN)</param>
        /// <param name="userName"></param>
        public void Delete(String idString, int Type, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar){ Value = idString},
                new SqlParameter("@Type", SqlDbType.Int){ Value = Type },
                new SqlParameter("@UserName", SqlDbType.VarChar){ Value = userName}
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteGRN", parms);
        }

        /// <summary>
        /// 根据 MaterialUnitId 获取实体信息。
        /// </summary>
        /// <param name="uNITId">MaterialUnitId。</param>
        /// <returns>MaterialUnit 实体对象。</returns>
        public MaterialUnitInfo GetMateialUnitById(long uNITId,string serialNumber="")
        {
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@unitID", SqlDbType.BigInt),
                new SqlParameter("@SerialNumber", SqlDbType.NVarChar)
            };

            parms[0].Value = uNITId;
            parms[1].Value = serialNumber;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetMaterialUnitById", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitId = rdr.GetInt64(0);
                    entity.SerialNumber = rdr.GetString(1);
                    entity.PartId = rdr.GetInt32(2);
                    entity.ItemName = rdr.GetString(3);
                    entity.ItemDesc = rdr.GetString(4);
                    entity.CBarCode = rdr.GetString(5);
                    entity.VendorCode = rdr.GetString(6);
                    entity.BalanceQty = rdr.GetDecimal(7);
                    entity.Status = rdr.GetInt32(8);
                    entity.WOStatus = rdr.GetString(9);
                    entity.CreateDateTime = rdr.GetDateTime(10);
                    entity.CreateBy = rdr.GetString(11);
                    entity.PackTime = rdr.GetDateTime(12).ToString("yyyy-MM-dd HH:mm:ss"); //针对入库日期
                    entity.DateCode = rdr.GetString(13);
                    entity.MPN = rdr.GetString(14);
                    entity.LotCode = rdr.IsDBNull(15) ? null:rdr.GetString(15);
                    entity.Quantity = rdr.GetDecimal(16);
                    entity.ItemId = rdr.GetInt32(17);
                }
                rdr.Close();
            }

            return entity;

        }
        /// <summary>
        /// 获取批次信息管理
        /// </summary>
        /// <returns></returns>
        public Int32 GetInvBatchByItemName(String  itemName) 
        {
            int batchNo = 0;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemName", SqlDbType.NVarChar, 100), 
                new SqlParameter("@BatchNo", SqlDbType.Int)
            };
            parms[0].Value = itemName;
            parms[1].Value = batchNo;
            parms[1].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetInvBatchByItemName", parms);
            return (Int32)parms[1].Value;
        }
        /// <summary>
        /// 根据 字段值 获取实体MaterialUnit信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaterialUnit 实体对象。</returns>
        public MaterialUnitInfo GetInfo(String fieldValue)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            return ComMethod.Get<MaterialUnitInfo>("Prod_MaterialUnit_GetInfo", parms);
        }

        /// <summary>
        /// 根据物料条码查是否是包装箱，如果是返回包装箱条码，如果不是返回物料条码
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public MaterialUnitInfo GetSelectSerialNumberBySerialNumber(string grn)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumber", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = grn;
            return ComMethod.Get<MaterialUnitInfo>("uspSelectSerialNumberBySerialNumber", parms);
        }


        /// <summary>
        /// 根据SerialNumber 查询所有采购单号
        /// </summary>
        /// <param name="SerialNumber"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetMaterialUnitPoCode(string SerialNumber)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,2000)
            };

            parms[0].Value = SerialNumber;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialUnit_GetPoCode", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.PoCode = rdr.GetString(0);
                    list.Add(entity);
                }

                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 获取分料截料物料信息  add by weixia  on 2015/6/29
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetSplitMaterialInfo(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSplitMaterialMember", "MaterialUnitId",
               "[MaterialUnitId], [SerialNumber], [ItemName], [Description], [cBarCode], [VendorCode], [BalanceQty],[Status],[StatusName], [CreateDateTime], [CreateBy]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitId = rdr.GetInt32(0);
                    entity.SerialNumber = rdr.GetString(1);
                    entity.ItemName = rdr.GetString(2);
                    entity.ItemDesc = rdr.GetString(3);
                    entity.CBarCode = rdr.GetString(4);
                    entity.VendorCode = rdr.GetString(5);
                    entity.BalanceQty = rdr.GetDecimal(6);
                    entity.Status = rdr.GetInt32(7);
                    entity.WOStatus = rdr.GetString(8);
                    entity.CreateDateTime = rdr.GetDateTime(9);
                    entity.CreateBy = rdr.GetString(10);

                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 获取物料数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetMaterialInfoAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProMaterialMember", "MaterialUnitId",
               "[MaterialUnitId], [SerialNumber], [PartId], [ItemName], [Description], [cBarCode]," +
               " [VendorCode], [BalanceQty], [Status], [StatusName], [CreateDateTime], [CreateBy], " +
               " [StorageDate],[LotCode],[Quantity], itemCode,[POrder],DateCode,ItemModel,ShelfLife,ApplyNo,CWhName,IQCOrder,MPN,WeekCode,ExpiredDate,SOCode,[DeliveryOrder],Remark,VendorName,BoxGrn,SupplierOrderNumber,Units,SaleReturnCustomerCode,SaleReturnCustomerName,SaleReturnNo"
               , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspMaterialCommonGetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitId = rdr.GetInt64(0);
                    entity.SerialNumber = rdr.GetString(1);
                    entity.PartId = rdr.GetInt32(2);
                    entity.ItemName = rdr.GetString(3);
                    entity.ItemDesc = rdr.GetString(4);
                    entity.CBarCode = rdr.GetString(5);
                    entity.VendorCode = rdr.GetString(6);
                    entity.BalanceQty = rdr.GetDecimal(7);
                    entity.Status = rdr.GetInt32(8);
                    entity.Statusname= rdr.GetString(9);
                    entity.WOStatus = rdr.GetString(9);
                    entity.CreateDateTime = rdr.GetDateTime(10);
                    if (!rdr.IsDBNull(rdr.GetOrdinal("CreateBy"))) {
                        entity.CreateBy = rdr.GetString(11);
                    }
                    if (rdr.GetDateTime(12).ToString("yyyy-MM-dd") == "9999-12-31")
                    {
                        entity.PackTime = SKT.Common.Utility.TypeHelper.ToShortDateString(rdr.GetDateTime(12));
                    }
                    else
                    {
                        entity.PackTime = rdr.GetDateTime(12).ToString("yyyy-MM-dd HH:mm:ss"); //针对入库日期
                    }
                    entity.LotCode = rdr.GetString(13);
                    entity.Quantity = rdr.GetDecimal(14);
                    entity.ItemCode = rdr.GetString(15);
                    entity.POorder = rdr.GetString(16);
                    entity.DateCode = rdr.GetString(17);
                    entity.ItemModel = rdr.GetString(18);
                    entity.ShelfLife = rdr.GetInt32(19);
                    entity.ApplyNo = rdr.GetString(20);
                    entity.CWhName = rdr.GetString(21);
                    entity.IqcBatchNo = rdr["IQCOrder"].ToString();
                    entity.MPN= rdr["MPN"].ToString();
                    entity.WeekCode = rdr["WeekCode"].ToString();
                    entity.ExpiredDate =Convert.ToDateTime(rdr["ExpiredDate"]);
                    entity.SOCode = rdr["SOCode"].ToString();
                    entity.DeliveryOrder = rdr["DeliveryOrder"].ToString();
                    entity.Remark = rdr["Remark"].ToString(); 
                    entity.VendorName = rdr["VendorName"].ToString();
                    entity.BoxGrn = rdr["BoxGrn"].ToString();
                    entity.SupplierOrderNumber = rdr["SupplierOrderNumber"].ToString();
                    entity.Units = rdr["Units"].ToString();
                    entity.SaleReturnCustomerCode = rdr["SaleReturnCustomerCode"].ToString();
                    entity.SaleReturnCustomerName = rdr["SaleReturnCustomerName"].ToString();
                    entity.SaleReturnNo = rdr["SaleReturnNo"].ToString();

                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 分页获取 MaterialUnit 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="MaterialUnitCount">MaterialUnit 总数。</param>
        /// <returns>MaterialUnit 列表。</returns>
        public List<MaterialUnitInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaterialUnitItem", "MaterialUnitId",
                "[MaterialUnitId], [SerialNumber], [PartId], [MaterialUnitStatusId], [MaterialTypeId], [StationId], [EmployeeId], [LotCode], [DateCode], [TraceCode], [MPN], [VendorCode],  [Quantity] ,  [BalanceQty], [LooperCount], [CreationTime], [FinishTime], [LineId], [LastUpdate], [ProcessNameId], [ItemName], [CreateBy], [Status],[PID],[ItemDesc],[ItemSpec],[StorageDate],[cBarCode]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo(rdr.GetInt64(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetByte(3), rdr.GetByte(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetInt32(14),
                        rdr.GetDateTime(15), rdr.GetDateTime(16), rdr.GetInt32(17), rdr.GetDateTime(18), rdr.GetInt32(19), rdr.GetInt32(22));            
             
                    entity.ItemName = rdr.GetString(20);
                    entity.CreateBy = rdr.GetString(21);
                    entity.PID = rdr.GetInt32(23);
                    entity.ItemDesc = rdr.GetString(24);
                    entity.ItemSpec = rdr.GetString(25);
                    entity.PackTime = rdr.GetDateTime(26).ToString("yyyy-MM-dd HH:mm:ss"); //针对入库日期
                    entity.CBarCode = rdr.GetString(27);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取物料数量
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        /// <summary>
        /// 生成物料条码 //wenshun 20170908 增加到货单号，创维需要生成的Grn如果是到货单来的，记录到货单的编号
        /// </summary>
        /// <param name="ItemId"></param>
        /// <param name="GRNQty"></param>
        /// <param name="MinQty"></param>
        /// <param name="LotCode"></param>
        /// <param name="DateCode"></param>
        /// <param name="TraceCode"></param>
        /// <param name="MPN"></param>
        /// <param name="VendorCode"></param>
        /// <param name="UserName"></param>        
        public string[] GenerateGRN(int ItemId, decimal GRNQty, decimal MinQty, decimal bigCartonQty, decimal itemAllQty, decimal aPrintQty
            , string LotCode, string DateCode, string VendorCode, string UserName, string poCode
            , string factory, string remark, int RowId, bool isSupplyPrint, string WeekCode, string MPN, string iqcOrder = "") //,string POInStockNo=""//到货单打印功能，创维专利，正式版本不需要
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ItemID",SqlDbType.Int),
                new SqlParameter("@GRNQty",SqlDbType.Decimal),
                new SqlParameter("@MinQty",SqlDbType.Decimal),
                new SqlParameter("@BigCartonQty",SqlDbType.Decimal),
                new SqlParameter("@ItemAllQty",SqlDbType.Decimal),
                new SqlParameter("@AlreadyPrintQty",SqlDbType.Decimal),
                new SqlParameter("@LotCode",SqlDbType.NVarChar,50),
                new SqlParameter("@DateCode",SqlDbType.NVarChar,50),
                new SqlParameter("@VendorCode",SqlDbType.NVarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@POorder",SqlDbType.NVarChar,50),
                new SqlParameter("@FactoryCode",SqlDbType.VarChar,20),
                new SqlParameter("@Remark",SqlDbType.NVarChar,100),
                new SqlParameter("@RowID",SqlDbType.Int),
                new SqlParameter("@IsSupplyPrint",SqlDbType.Bit),
                new SqlParameter("@GRNString",SqlDbType.VarChar,-1),
                new SqlParameter("@CartonString",SqlDbType.VarChar,-1),
                new SqlParameter("@IqcOrder",SqlDbType.VarChar,50),

                new SqlParameter("@WeekCode",SqlDbType.VarChar,50),
                new SqlParameter("@MPN",SqlDbType.VarChar,50)
               // new SqlParameter("@POInStockNo",SqlDbType.VarChar,200),//到货单打印功能，创维专利，正式版本不需要
            };

            parms[0].Value = ItemId;
            parms[1].Value = GRNQty;
            parms[2].Value = MinQty;
            parms[3].Value = bigCartonQty;
            parms[4].Value = itemAllQty;
            parms[5].Value = aPrintQty;
            parms[6].Value = LotCode;
            parms[7].Value = DateCode;
            parms[8].Value = VendorCode;
            parms[9].Value = UserName;
            parms[10].Value = poCode;
            parms[11].Value = factory;
            parms[12].Value = remark;
            parms[13].Value = RowId;
            parms[14].Value = isSupplyPrint;
            parms[15].Direction = ParameterDirection.Output;
            parms[16].Direction = ParameterDirection.Output;
            parms[17].Value = iqcOrder;

            parms[18].Value = WeekCode;
            parms[19].Value = MPN;
            //parms[20].Value = POInStockNo; //到货单打印功能，创维专利，正式版本不需要
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateGRN", parms);

            string[] str = new string[2];
            str[0] = Convert.ToString(parms[15].Value);
            str[1] = Convert.ToString(parms[16].Value);
            return str;
        }
        
        /// <summary>
        /// 生成退货物料条码
        /// </summary>
      
        public string[] SaleReturnGenerateGRN(int ItemId, decimal GRNQty, decimal MinQty, decimal bigCartonQty, decimal itemAllQty, decimal aPrintQty
            , string LotCode, string DateCode, string CustomerCode, string UserName, string SaleReturnNo
            , string factory, string remark, int SaleReturnRowId, bool isSupplyPrint, string WeekCode, string MPN, string iqcOrder = "") //,string POInStockNo=""//到货单打印功能，创维专利，正式版本不需要
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ItemID",SqlDbType.Int),
                new SqlParameter("@GRNQty",SqlDbType.Decimal),
                new SqlParameter("@MinQty",SqlDbType.Decimal),
                new SqlParameter("@BigCartonQty",SqlDbType.Decimal),
                new SqlParameter("@ItemAllQty",SqlDbType.Decimal),
                new SqlParameter("@AlreadyPrintQty",SqlDbType.Decimal),
                new SqlParameter("@LotCode",SqlDbType.NVarChar,50),
                new SqlParameter("@DateCode",SqlDbType.NVarChar,50),
                new SqlParameter("@CustomerCode",SqlDbType.NVarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@SaleReturnNo",SqlDbType.NVarChar,50),
                new SqlParameter("@FactoryCode",SqlDbType.VarChar,20),
                new SqlParameter("@Remark",SqlDbType.NVarChar,100),
                new SqlParameter("@SaleReturnRowId",SqlDbType.Int),
                new SqlParameter("@IsSupplyPrint",SqlDbType.Bit),
                new SqlParameter("@GRNString",SqlDbType.VarChar,-1),
                new SqlParameter("@CartonString",SqlDbType.VarChar,-1),
                new SqlParameter("@IqcOrder",SqlDbType.VarChar,50),

                new SqlParameter("@WeekCode",SqlDbType.VarChar,50),
                new SqlParameter("@MPN",SqlDbType.VarChar,50)
               // new SqlParameter("@POInStockNo",SqlDbType.VarChar,200),//到货单打印功能，创维专利，正式版本不需要
            };

            parms[0].Value = ItemId;
            parms[1].Value = GRNQty;
            parms[2].Value = MinQty;
            parms[3].Value = bigCartonQty;
            parms[4].Value = itemAllQty;
            parms[5].Value = aPrintQty;
            parms[6].Value = LotCode;
            parms[7].Value = DateCode;
            parms[8].Value = CustomerCode;
            parms[9].Value = UserName;
            parms[10].Value = SaleReturnNo;
            parms[11].Value = factory;
            parms[12].Value = remark;
            parms[13].Value = SaleReturnRowId;
            parms[14].Value = isSupplyPrint;
            parms[15].Direction = ParameterDirection.Output;
            parms[16].Direction = ParameterDirection.Output;
            parms[17].Value = iqcOrder;

            parms[18].Value = WeekCode;
            parms[19].Value = MPN;
            //parms[20].Value = POInStockNo; //到货单打印功能，创维专利，正式版本不需要
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaleReturnGenerateGRN", parms);

            string[] str = new string[2];
            str[0] = Convert.ToString(parms[15].Value);
            str[1] = Convert.ToString(parms[16].Value);
            return str;
        }

        /// <summary>
        /// 离线登记GRN
        /// </summary>
        /// <param name="ItemId"></param>
        /// <param name="GRNQty"></param>
        /// <param name="MinQty"></param>
        /// <param name="bigCartonQty"></param>
        /// <param name="itemAllQty"></param>
        /// <param name="aPrintQty"></param>
        /// <param name="LotCode"></param>
        /// <param name="DateCode"></param>
        /// <param name="VendorCode"></param>
        /// <param name="UserName"></param>
        /// <param name="poCode"></param>
        /// <param name="factory"></param>
        /// <param name="remark"></param>
        /// <param name="RowId"></param>
        /// <param name="isSupplyPrint"></param>
        /// <param name="WeekCode"></param>
        /// <param name="MPN"></param>
        /// <param name="iqcOrder"></param>
        /// <returns></returns>
        public string[] OfflineGenerateGRN(int ItemId, int GRNQty, decimal MinQty, decimal bigCartonQty, decimal itemAllQty, decimal aPrintQty
            , string LotCode, string DateCode, string VendorCode, string UserName, string poCode
            , string factory, string remark, int RowId, bool isSupplyPrint, string WeekCode, string MPN, string GRNString, string iqcOrder = "")
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ItemID",SqlDbType.Int),
                new SqlParameter("@GRNQty",SqlDbType.Int),
                new SqlParameter("@MinQty",SqlDbType.Decimal),
                new SqlParameter("@BigCartonQty",SqlDbType.Decimal),
                new SqlParameter("@ItemAllQty",SqlDbType.Decimal),
                new SqlParameter("@AlreadyPrintQty",SqlDbType.Decimal),
                new SqlParameter("@LotCode",SqlDbType.NVarChar,50),
                new SqlParameter("@DateCode",SqlDbType.NVarChar,50),
                new SqlParameter("@VendorCode",SqlDbType.NVarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@POorder",SqlDbType.NVarChar,50),
                new SqlParameter("@FactoryCode",SqlDbType.VarChar,20),
                new SqlParameter("@Remark",SqlDbType.NVarChar,100),
                new SqlParameter("@RowID",SqlDbType.Int),
                new SqlParameter("@IsSupplyPrint",SqlDbType.Bit),
                new SqlParameter("@GRNString",SqlDbType.VarChar,-1),
                new SqlParameter("@CartonString",SqlDbType.VarChar,8000),
                new SqlParameter("@IqcOrder",SqlDbType.VarChar,50),
                new SqlParameter("@WeekCode",SqlDbType.VarChar,50),
                new SqlParameter("@MPN",SqlDbType.VarChar,50)
            };

            parms[0].Value = ItemId;
            parms[1].Value = GRNQty;
            parms[2].Value = MinQty;
            parms[3].Value = bigCartonQty;
            parms[4].Value = itemAllQty;
            parms[5].Value = aPrintQty;
            parms[6].Value = LotCode;
            parms[7].Value = DateCode;
            parms[8].Value = VendorCode;
            parms[9].Value = UserName;
            parms[10].Value = poCode;
            parms[11].Value = factory;
            parms[12].Value = remark;
            parms[13].Value = RowId;
            parms[14].Value = isSupplyPrint;
            parms[15].Value = GRNString;
            parms[16].Direction = ParameterDirection.Output;
            parms[17].Value = iqcOrder;

            parms[18].Value = WeekCode;
            parms[19].Value = MPN;
            //parms[20].Value = POInStockNo; //到货单打印功能，创维专利，正式版本不需要
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOfflineGenerateGRN", 2000000, parms);//添加超时时间 解决数据库连接超时问题 zhuchenglong 2017-11-29

            string[] str = new string[2];
            str[0] = Convert.ToString(parms[15].Value);
            str[1] = Convert.ToString(parms[16].Value);
            return str;
        }


        /// <summary>
        /// 离线条码登记扫描GRN校验GRN是否存在
        /// </summary>
        /// <param name="grn">扫描的GRN</param>
        /// <returns>返回空字符串，则表示验证OK，否则返回具体的错误消息</returns>
        public string OfflineValidateGRN(string grn) {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@Msg",SqlDbType.VarChar,500)
            };
            parms[0].Value = grn;
            parms[1].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOfflineValidateGRN", parms);
            return parms[1].Value == null ? string.Empty : parms[1].Value.ToString();
        }

        /// <summary>
        /// 发料
        /// </summary>
        /// <param name="location"></param>
        /// <param name="grn"></param>
        /// <param name="username"></param>
        public List<MaterialUnitInfo> StoreIssue(int location, string grn, string pickingNo, string username)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();

            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@Location",SqlDbType.Int),
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@Pkd_pk",SqlDbType.VarChar,20)
            };

            parms[0].Value = location;
            parms[1].Value = grn;
            parms[2].Value = username;
            parms[3].Value = pickingNo;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspIssueMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.ItemName = rdr.GetString(0);
                    entity.GRNStr = rdr.GetDecimal(1).ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
                    entity.SerialNumber = rdr.GetString(2);
                    entity.GRNQty = rdr.GetInt32(3);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 退料
        /// </summary>
        /// <param name="qty"></param>
        /// <param name="grn"></param>
        /// <param name="loc"></param>
        /// <param name="username"></param>
        public void ReturnMaterial(decimal qty, string grn, int loc, string wonumber, string username)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@Quantity",SqlDbType.Decimal),
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@Location",SqlDbType.Int),
                new SqlParameter("@WONumber",SqlDbType.VarChar,50)
            };

            parms[0].Value = qty;
            parms[1].Value = grn;
            parms[2].Value = username;
            parms[3].Value = loc;
            parms[4].Value = wonumber;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReturnMaterial", parms);
        }

        /// <summary>
        /// 获取可分料/截料的信息
        /// </summary>
        /// <param name="qty"></param>
        /// <param name="batch"></param>
        /// <param name="grn"></param>
        /// <param name="username"></param>
        public List<MaterialUnitInfo> GetPrintMaterialInfo(string  materialUnitStr)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@MaterialIdString",SqlDbType.NVarChar,2000)
            };

            parms[0].Value = materialUnitStr;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspPrintSplitMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.ItemDesc = rdr.GetString(2);
                    entity.LotCode = rdr.GetString(3);
                    entity.VendorCode = rdr.GetString(4);
                    entity.BalanceQty = rdr.GetDecimal(5);
                    entity.ItemId = rdr.GetInt32(6);
                    list.Add(entity);
                }

                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 分料、截料
        /// </summary>
        /// <param name="qty"></param>
        /// <param name="batch"></param>
        /// <param name="grn"></param>
        /// <param name="username"></param>
        public List<MaterialUnitInfo> SplitMaterial(decimal qty, string grn, string username)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@Quantity",SqlDbType.Decimal),               
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = qty;
            parms[1].Value = grn;
            parms[2].Value = username;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSplitMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.GRNStr = rdr.GetDecimal(1).ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
                    entity.VendorCode = rdr.GetString(2);
                    entity.ItemName = rdr.GetString(3);
                    entity.MPN = rdr.GetString(4);
                    entity.SplitTime = TypeHelper.ToShortDateString(rdr.GetDateTime(5)) + " " + TypeHelper.ToTimeString(rdr.GetDateTime(5));
                    entity.DateCode = rdr.GetString(6);
                    entity.LotCode = rdr.GetString(7);
                    entity.ItemId = rdr.GetInt32(8);
                    entity.DetailContent = rdr.GetString(9);
                    entity.CreateBy= rdr.GetString(10);
                    list.Add(entity);
                }

                rdr.Close();
            }
            return list;
        }

        public List<MaterialUnitInfo> SplitMaterialUDP(string qty, string grn, string NewGrn, string username)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]
               {
                  new SqlParameter("@Quantity",SqlDbType.Decimal),
                  new SqlParameter("@GRN",SqlDbType.NVarChar),
                  new SqlParameter("@UserName",SqlDbType.VarChar),
                  new SqlParameter("@NewGRN",SqlDbType.NVarChar)
               };
            parms[0].Value = qty;
            parms[1].Value = grn;
            parms[2].Value = username;
            parms[3].Value = NewGrn;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSplitMaterial_UDP", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.GRNStr = rdr.GetDecimal(1).ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
                    entity.VendorCode = rdr.GetString(2);
                    entity.ItemName = rdr.GetString(3);
                    entity.MPN = rdr.GetString(4);
                    entity.SplitTime = TypeHelper.ToShortDateString(rdr.GetDateTime(5)) + " " + TypeHelper.ToTimeString(rdr.GetDateTime(5));
                    entity.DateCode = rdr.GetString(6);
                    entity.LotCode = rdr.GetString(7);
                    entity.ItemId = rdr.GetInt32(8);
                    list.Add(entity);
                }

                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 获取GRN最小包装数量
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public object[] GetGRNQuantity(string grn)
        {
            object[] obj = new object[2];
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@ReturnValue",SqlDbType.Float)
            };

            parms[0].Value = grn;
            parms[1].Direction = ParameterDirection.Output;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetGRNQuantity", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.GRNStr = rdr.GetDecimal(1).ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.VendorCode = rdr.GetString(2);
                    entity.ItemName = rdr.GetString(3);
                    entity.MPN = rdr.GetString(4);
                    entity.SplitTime = rdr.GetDateTime(5).ToString("yyyy-MM-dd HH:mm:ss");//TypeHelper.ToShortDateString(rdr.GetDateTime(5)) + " " + TypeHelper.ToTimeString(rdr.GetDateTime(5));
                    entity.LotCode = rdr.GetString(6);
                    entity.ItemId = rdr.GetInt32(7);
                    entity.CreateBy = rdr.GetString(8);
                    list.Add(entity);
                }
                rdr.Close();
            }
            obj[0] = (parms[1].Value.ToString().IndexOf(".") > -1) ? parms[1].Value.ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' }) : parms[1].Value.ToString();
            obj[1] = list;
            return obj;
        }

        /// <summary>
        /// 用于退料时获取GRN剩余数量
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="flag"></param>
        /// <returns></returns>
        public int GetGrnQuantity(string grn, int flag)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@GrnQty",SqlDbType.Decimal),
                new SqlParameter("@Flag",SqlDbType.Int)
            };

            parms[0].Value = grn;
            parms[1].Direction = ParameterDirection.Output;
            parms[2].Value = flag;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetGrnQuantityToReturnVendor", parms);
            return Convert.ToInt32(parms[1].Value);
        }


        /// <summary>
        /// 物料是否和工单匹配，以及是否在相应工位使用
        /// </summary>
        /// <returns></returns>
        public int MaterialMatchOrder(string strOrder, string strGRN, Int32 intOpeID)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@Result",SqlDbType.Int),
                new SqlParameter("@OrderNO",SqlDbType.VarChar,50),
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@OpeID",SqlDbType.Int)
            };
            parms[0].Value = 0;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = strOrder;
            parms[2].Value = strGRN;
            parms[3].Value = intOpeID;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaterialMatchOrder", parms);

            return Convert.ToInt32(parms[0].Value.ToString());
        }

        /// <summary>
        /// 通过GRN得到PCB板序号
        /// </summary>       
        /// <param name="grnID">物料GRNID</param>        
        public DataTable ReturnPCBSNByGRN(Int64 grnID)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRNID",SqlDbType.BigInt)                
            };

            parms[0].Value = grnID;
            string strCMD = "Select PanelID,s.[UID],s.[Value] From [Unit] u with (nolock) Inner Join Serial_number s with (nolock) on u.[uid]=s.[uid] and s.SNTypeID=0 " +
                            "Where u.[uid] in(select uid from unit_component where materialunitid=@GRNID) order by u.[uid]";
            return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, strCMD, parms);
        }

        /// <summary>
        /// 验证包装的GRN条码是否合法
        /// </summary>
        /// <param name="grn"></param>
        /// <returns>
        /// 数组，str[0]: 错误类型：
        /// -1 - 有错误信息，
        ///  0 - 数据库中没有未关闭的包装箱，系统生成carton箱条码并成功包装GRN，
        ///  1 - 数据库中还有未关闭的包装箱，用户需在前台页面弹出窗口中选择carton箱进行包装GRN
        /// </returns>
        public string[] ValidateGRN(string grn, string cartonsn, string vendorCode, string username, string firstGrn = "")
        {
            string[] str = new string[4];
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@ErrorType",SqlDbType.Int),
                new SqlParameter("@ErrorMessage",SqlDbType.NVarChar,200),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50),
                new SqlParameter("@VendorCode",SqlDbType.VarChar,50),
                new SqlParameter("@returnVendorCode",SqlDbType.VarChar,50),
                new SqlParameter("@PackQty",SqlDbType.Decimal,13),
                new SqlParameter("@FirstGrn",SqlDbType.VarChar,50),
            };

            parms[0].Value = grn;
            parms[1].Direction = ParameterDirection.Output;
            parms[2].Direction = ParameterDirection.Output;
            parms[3].Value = username;
            parms[4].Value = cartonsn;
            parms[5].Value = vendorCode;
            parms[6].Direction = ParameterDirection.Output;
            parms[7].Direction = ParameterDirection.Output;
            parms[7].Precision = 28;
            parms[7].Scale = 6;
            parms[8].Value = firstGrn;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspValidatePackingGRN", parms);

            str[0] = parms[1].Value.ToString();
            str[1] = parms[2].Value.ToString();
            str[2] = parms[6].Value.ToString();
            str[3] = parms[7].Value.ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });

            return str;
        }

        /// <summary>
        /// 获取某一供应商对应的所有没有关闭的GRN包装箱
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetAllOpenGRNCarton(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwOpenedGRNCartonSN", "ID",
                "ID, SerialNumber, PartId, ItemName, Vendor, CreateDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitId = rdr.GetInt64(0);
                    entity.SerialNumber = rdr.GetString(1);
                    entity.PartId = rdr.GetInt32(2);
                    entity.ItemName = rdr.GetString(3);
                    entity.VendorCode = rdr.GetString(4);
                    entity.CreateDateTime = rdr.GetDateTime(5);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCountGRNCarton = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 取得记录数
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public Int32 GetGRNCartonCount(SearchSettings searchSettings)
        {
            return this.recordCountGRNCarton;
        }

        /// <summary>
        /// 包装GRN到数据库中未关闭的包装箱内
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="cartonsn"></param>
        /// <param name="username"></param>
        public void PackIntoOldCarton(string grn, string cartonsn, string username)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = grn;
            parms[1].Value = cartonsn;
            parms[2].Value = username;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPackGRNIntoOpenedCarton", parms);
        }

        /// <summary>
        /// 生成新的物料包装箱条码并包装
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="isBigCarton">1 - 产生新的中箱， 2 - 产生新的大箱</param>
        /// <param name="username"></param>
        /// <returns></returns>
        public string GenerateNewCartonSNAndPack(string grn, int isBigCarton, string username)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@IsBigCarton",SqlDbType.Int)
            };

            parms[0].Value = grn;
            parms[1].Direction = ParameterDirection.Output;
            parms[2].Value = username;
            parms[3].Value = isBigCarton;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateNewCartonSNAndPack", parms);
            return Convert.ToString(parms[1].Value);
        }


        /// <summary>
        /// 收料 Add   weilin.Liu  2016-02-02  按到货单收料
        /// </summary>
        /// <param name="entity">物料收料信息的实体entity</param>
        /// <returns>生成的GRN信息对象列表</returns>
        public int ReceiveMaterial(string Id,string userName)
        {
            List<GRNLabelsInfo> list = new List<GRNLabelsInfo>();
            GRNLabelsInfo model = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ViewId",SqlDbType.VarChar,50) ,
                new SqlParameter("@ReceivePerson",SqlDbType.VarChar,20),
                new SqlParameter("@result",SqlDbType.Int)
            };


            parms[0].Value = Id;
            parms[1].Value = userName;
            parms[2].Direction = ParameterDirection.Output;


            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReceiveMaterial", parms);

            return Convert.ToInt32(parms[2].Value);
        }

        /// <summary>
        /// add by weixia on 2015.10.28
        /// 打印历史物料
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="grnQty"></param>
        /// <param name="minQty"></param>
        /// <param name="lotCode"></param>
        /// <param name="dateCode"></param>
        /// <param name="vendorCode"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public List<GRNLabelsInfo> PrintHistoryGRN(Int32 itemId,Decimal grnQty,Decimal minQty, String lotCode,String dateCode,String vendorCode,String userName,String cBarCode)
        {
            List<GRNLabelsInfo> list = new List<GRNLabelsInfo>();
            GRNLabelsInfo model = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ItemID",SqlDbType.Int),
                new SqlParameter("@GRNQty",SqlDbType.Decimal,18),
                new SqlParameter("@MinQty",SqlDbType.Decimal,18),
                new SqlParameter("@LotCode",SqlDbType.NVarChar,50),
                new SqlParameter("@DateCode",SqlDbType.NVarChar,50),
                new SqlParameter("@VendorCode",SqlDbType.NVarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@cBarCode",SqlDbType.VarChar,20)
            };

            parms[0].Value = itemId;
            parms[1].Value = grnQty;
            parms[2].Value = minQty;
            parms[3].Value = lotCode;
            parms[4].Value = dateCode;
            parms[5].Value = vendorCode;
            parms[6].Value = userName;
            parms[7].Value = cBarCode;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGenerateOldMaterialGRN", parms))
            {
                while (rdr.Read())
                {
                    model = new GRNLabelsInfo();
                    model.GRN = rdr.GetString(0);
                    model.ItemCode = rdr.GetString(1);
                    model.ItemName = rdr.GetString(2);
                    model.ItemSepc = rdr.GetString(3);
                    model.LotCode = rdr.GetString(4);
                    model.Supplier = rdr.GetString(5);
                    model.Qty = rdr.GetDecimal(6);
                    list.Add(model);
                }
                rdr.Close();
            }

            return list;
        }
        /// <summary>
        /// IQC检验通过之后 打印物料条码  add by zhibin.chen  2015-05-29
        /// </summary>
        /// <param name="printQty">打印数量</param>
        /// <param name="autoId">U8到货单子表Id</param>
        /// <param name="userName">打印人</param>
        /// <returns>待打印的物料条码信息</returns>
        public List<GRNLabelsInfo> GRNPrint(int printQty, int autoId, string userName, decimal minPackQty,string lotCode,string dataCode)
        {
            List<GRNLabelsInfo> list = new List<GRNLabelsInfo>();
            GRNLabelsInfo model = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@PrintQty",SqlDbType.Int),
                new SqlParameter("@AutoId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@MinPackQty",SqlDbType.Decimal),
                new SqlParameter("@LotCode",SqlDbType.NVarChar,50),
                new SqlParameter("@DataCode",SqlDbType.NVarChar,50)
            };

            parms[0].Value = printQty;
            parms[1].Value = autoId;
            parms[2].Value = userName;
            parms[3].Value = minPackQty;
            parms[4].Value = lotCode;
            parms[5].Value = dataCode;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGRNPrintByIQCPass", parms))
            {
                while (rdr.Read())
                {
                    model = new GRNLabelsInfo(rdr.GetString(0), rdr.GetString(1), rdr.GetDecimal(2), rdr.GetDateTime(3), rdr.GetDateTime(4), rdr.GetString(5));
                    model.ZPLId = rdr.GetInt32(6);
                    model.ItemDesc = rdr.GetString(7);
                    model.LotCode = rdr.GetString(8);
                    list.Add(model);
                }
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 订单选择后，获取订单的订购数量，已收数量，订购物料以及物料的相应信息。
        /// add by zhibin.chen  2015-04-29
        /// </summary>
        /// <param name="orderFormNO"></param>
        /// <returns></returns>
        public MaterialReceiveInfo OrderFormSelect(string orderFormNO)
        {
            MaterialReceiveInfo model = new MaterialReceiveInfo();

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@OrderFormNO",SqlDbType.VarChar,50)
            };

            parms[0].Value = orderFormNO;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetOrderFormInfoForRecMaterial", parms))
            {
                if (rdr.HasRows)
                {
                    rdr.Read();
                    model.MaterialName = rdr.GetString(0);
                    model.Qty = rdr.GetDecimal(1);
                    model.ReceivedQty = rdr.GetDecimal(2);
                    model.Supplier = rdr.GetString(3);
                    model.IQCType = rdr.GetInt32(4);

                }
                rdr.Close();
            }

            return model;
        }


        /// <summary>
        /// 获取可收料的订单列表。
        /// add by zhibin.chen  2015-04-29
        /// </summary>
        /// <returns>可收料的订单信息列表</returns>
        public List<MaterialReceiveInfo> GetOrderFormList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialReceiveInfo> list = new List<MaterialReceiveInfo>();
            MaterialReceiveInfo model = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwOrderFormList", "ERPOrderFormId",
                "[ERPOrderFormId], [OrderFormNO], [MaterialName], [Supplier], [Qty]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    model = new MaterialReceiveInfo();
                    model.ERPOrderFormId = rdr.GetInt32(0);
                    model.OrderFormNO = rdr.GetString(1);
                    model.MaterialName = rdr.GetString(2);
                    model.Supplier = rdr.GetString(3);
                    model.Qty = rdr.GetDecimal(4);

                    list.Add(model);

                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取可收料订单的数量 add by zhibin.chen  2015-04-29
        /// </summary>
        /// <returns></returns>
        public Int32 GetOrderFormCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 获取待打印 的 IQC检验单 物料列表
        /// add  luwenyuan 2016-02-23
        /// </summary>
        /// <param name="code">检验单单号</param>
        /// <returns></returns>
        public List<ERPArrivalVouchsInfo> GetIQCFormDetailForPrint(string code)
        {
            List<ERPArrivalVouchsInfo> list = new List<ERPArrivalVouchsInfo>();
            ERPArrivalVouchsInfo model = null;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@Code",SqlDbType.VarChar,60)
            };
            parms[0].Value = code;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetIQCFormDetailForPrint", parms))
            {
                for (int i = 0; i < dt.Rows.Count;i++ )
                {
                    model = new ERPArrivalVouchsInfo();
                    model.AutoId = Convert.ToInt32(dt.Rows[i]["autoid"]);
                    model.InvCode = dt.Rows[i]["cinvcode"].ToString();
                    model.VouchRowNO = Convert.ToInt32(dt.Rows[i]["ivouchrowno"]);
                    model.PrintGrossQty = Convert.ToInt32(dt.Rows[i]["printgrossqty"]);
                    model.PrintedQty = Convert.ToInt32(dt.Rows[i]["printedqty"]);
                    model.MinPackQty = Convert.ToInt32(dt.Rows[i]["minpackqty"]);
                    model.Description = dt.Rows[i]["Description"].ToString();
                    list.Add(model);
                }                
            }
            return list;
        }

        /// <summary>
        /// 获取客供物料
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetAllItemByKVendor(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "erp_item", "ID",
                "ID, ItemName, itemspec", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitId = rdr.GetInt32(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.VendorCode = "";
                    entity.ItemDesc = rdr.GetString(2);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordVendorItemCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 供应商物料数量
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public Int32 GetVendorItemCount(SearchSettings searchSettings)
        {
            return this.recordVendorItemCount;
        }

        /// <summary>
        /// 根据供应商用户的ID获取供应商代码
        /// </summary>
        /// <param name="userId"></param>
        /// <returns>返回供应商代码</returns>
        public string GetVendorCode(int userId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@VendorCode",SqlDbType.VarChar,20)
            };

            parms[0].Value = userId;
            parms[1].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetVendorCodeByUserId", parms);

            return parms[1].Value.ToString();
        }

        public List<MaterialUnitInfo> GetPickingList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwPkdDet", "PkdId",
                "distinct PkdId, pkd_pk, pkd_wo_nbr,wo_status", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitId = rdr.GetInt32(0);
                    entity.PkdPK = rdr.GetString(1);
                    entity.PkdWoNbr = rdr.GetString(2);
                    entity.WOStatus = rdr.GetString(3);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordPickingListCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetPickingListCount(SearchSettings searchSettings)
        {
            return this.recordPickingListCount;
        }

        /// <summary>
        /// 获取工单物料
        /// </summary>
        /// <param name="pickingListNO"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetPickingListLine(string wo)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@WO",SqlDbType.VarChar,50)
            };

            parms[0].Value = wo;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPickingListLine", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.PkdWoNbr = rdr.GetString(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.ItemDesc = rdr.GetString(2);
                    entity.GRNStr = rdr.GetString(3);
                    entity.PkdQtyIss = rdr.GetDecimal(4).ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
                    entity.MaterialUnitId = rdr.GetInt32(5);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        public List<MaterialUnitInfo> GetPackedItemList(string cartonsn)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50)
            };

            parms[0].Value = cartonsn;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPackedGRNByCartonSN", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitId = Convert.ToInt32(rdr["MaterialUnitId"]);
                    entity.SerialNumber = Convert.ToString(rdr["SerialNumber"]);
                    entity.BalanceQty = Convert.ToDecimal(rdr["BalanceQty"]);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 包装箱条码列表
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetAllGRNCarton(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGRNPackList", "Id",
                "cartonid as PIDID, cartonsn, grnid, grnsn, partid, status, vendorcode, quantity, balanceqty, itemname, flag, lastupdate,cartoncreatetime,ItemCode,UserId,CreateBy,Id,FBillNO", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCartonMaterialCommonGetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.PIDID = rdr.GetInt64(0);
                    entity.GRNStr = rdr.GetString(1);
                    entity.MaterialUnitId = rdr.GetInt64(2);
                    entity.SerialNumber = rdr.GetString(3);
                    entity.PartId = rdr.GetInt32(4);
                    entity.Status = rdr.GetInt32(5);
                    entity.VendorCode = rdr.GetString(6);
                    entity.Quantity = rdr.GetDecimal(7);
                    entity.BalanceQty = rdr.GetDecimal(8);
                    entity.ItemName = rdr.GetString(9);
                    entity.PkdLoc = rdr.GetInt32(10).ToString();
                    entity.PackTime = TypeHelper.ToShortDateString(rdr.GetDateTime(11)) + " " + TypeHelper.ToTimeString(rdr.GetDateTime(11));
                    entity.CreateDateTime = rdr.GetDateTime(12);
                    entity.ItemCode = rdr.GetString(13);
                    entity.CreateBy = rdr.GetString(15);
                    entity.Id = rdr.GetInt64(16);
                    entity.FBillNO = rdr["FBillNO"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordGRNCartonCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public List<MaterialUnitInfo> GetAllEmptyCarton(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwEmptyCartonList", "id",
                "id, serialnumber, partid, status, vendorcode, itemname, createdatetime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitId = rdr.GetInt64(0);
                    entity.SerialNumber = rdr.GetString(1);
                    entity.PartId = rdr.GetInt32(2);
                    entity.Status = rdr.GetInt32(3);
                    entity.VendorCode = rdr.GetString(4);
                    entity.ItemName = rdr.GetString(5);
                    entity.CreateDateTime = rdr.GetDateTime(6);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordGRNCartonCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetPackedGRNCartonCount(SearchSettings searchSettings)
        {
            return this.recordGRNCartonCount;
        }

        public void ClosePack(string cartonsn, string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CartonSN",SqlDbType.NVarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = cartonsn;
            parms[1].Value = username;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCloseGrnPack", parms);
        }

        public void UnPack(string cartonsn, string username, int IsSuply)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CartonSN",SqlDbType.NVarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@IsSuply",SqlDbType.Int)
            };

            parms[0].Value = cartonsn;
            parms[1].Value = username;
            parms[2].Value = IsSuply;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUnPackGRNCarton", parms);
        }

        public void RemoveGRN(string cartonsn, string grnsn, string userName, bool isAuto = false)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50),
                new SqlParameter("@GRNSN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@IsAuto",SqlDbType.Bit)
            };

            parms[0].Value = cartonsn;
            parms[1].Value = grnsn;
            parms[2].Value = userName;
            parms[3].Value = isAuto;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspRemoveGRNFromCarton", parms);
        }

        public int GetCartonStatus(string cartonsn, string username)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@CartonStatus",SqlDbType.Int)
            };

            parms[0].Value = cartonsn;
            parms[1].Value = username;
            parms[2].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetGrnCartonStatus", parms);

            return Convert.ToInt32(parms[2].Value);
        }

        public void DeleteCarton(int cartonId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@CartonID",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = cartonId;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteGrnCartonById", parms);
        }

        public List<MaterialUnitInfo> GetDeletePckList(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwDeletePickingList", "ID",
                "distinct Pkd_pk, pkd_wo_nbr, CreateDateTime, ID", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.PkdPK = rdr.GetString(0);
                    entity.PkdWoNbr = rdr.GetString(1);
                    entity.CreateDateTime = rdr.GetDateTime(2);
                    entity.MaterialUnitId = rdr.GetInt32(3);
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordDelPckCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetDeletePckListCount(SearchSettings searchSettings)
        {
            return this.recordDelPckCount;
        }

        public void ReUsePickingList(string idStr, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@IdStr",SqlDbType.VarChar,200),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = idStr;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReUsePickingList", parms);
        }

        public void DeletePkdGrn(int id, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ID",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = id;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeletePickingListGrn", parms);

        }

        public List<MaterialUnitInfo> GetRecHistory(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Material_Unit_RecHistory", "ID",
                "ItemName, Grn, Qty, CreateBy, CreateDateTime", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.ItemName = rdr.GetString(0);
                    entity.GRNStr = rdr.GetString(1);
                    entity.Quantity = rdr.GetDecimal(2);
                    entity.CreateBy = rdr.GetString(3);
                    entity.PackTime = rdr.GetDateTime(4).ToString("yyyy-MM-dd HH:mm:ss");

                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public List<MaterialUnitInfo> GetWOMaterialList(string wo)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@WO",SqlDbType.VarChar,50)
            };

            parms[0].Value = wo;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetWOMaterialList", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.ItemName = rdr.GetString(0);
                    entity.ItemDesc = rdr.GetString(1);
                    entity.PkdQtyIss = rdr.GetInt32(2).ToString();

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 库位转移
        /// add by weixia on 2015.10.22
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="Code"></param>
        /// <param name="flag"></param>
        public string  StorageTransfer(String sn, String Code, String  userName,Int32 flag)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
                  new SqlParameter("@cBarCode",SqlDbType.NVarChar,50),
                  new SqlParameter("@UserName",SqlDbType.VarChar,20),
                  new SqlParameter("@flag",SqlDbType.Int)
            };
            parms[0].Value = sn;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = Code;
            parms[2].Value = userName;
            parms[3].Value = flag;
           

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspStorageTransfer", parms);

            return parms[0].Value.ToString();
        }

        /// <summary>
        /// PDA成品库位转移
        /// add by weixia on 2015.10.22
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="Code"></param>
        /// <param name="userName"></param>
        public void SaveStorageTransferProd(String sn, String Code, String userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@SN",SqlDbType.VarChar,3000),
                  new SqlParameter("@cBarCode",SqlDbType.NVarChar,50),
                  new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };
            parms[0].Value = sn;
            parms[1].Value = Code;
            parms[2].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveProdStorageTransfer", parms);
        }

        /// <summary>
        /// 成品库位转移
        /// add by weixia on 2015.10.22
        /// </summary>
        /// <param name="sn"></param>
        public DataTable StorageTransferProd(String sn)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@SN",SqlDbType.VarChar,100)
            };
            parms[0].Value = sn;
            DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetProdStorageTransferProd", parms);
            return dt;
        }


        /// <summary>
        /// 修改GRN数量
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public int EditGRNQuanty(Int32 MaterialUnitId, decimal Quantity, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@MaterialUnitId",SqlDbType.Int),
                new SqlParameter("@Quantity",SqlDbType.Decimal),
                new SqlParameter("@UserName",SqlDbType.NVarChar,50),
                new SqlParameter("@Result",SqlDbType.Int)
            };

            parms[0].Value = MaterialUnitId;
            parms[1].Value = Quantity;
            parms[2].Value = userName;
            parms[3].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "[uspEditGRNQuanty]", parms);
            return Convert.ToInt32(parms[3].Value);
        }

        /// <summary>
        /// 获取物料条码状态
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetMaterialAllStatus(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaterialStatus", "[RowId]",
                "[ID],[MaterialStatus],[RowId]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.StatusId = rdr.GetInt32(0);
                    entity.MaterialStatus = rdr.GetString(1);
                    entity.RowId = rdr.GetInt32(2);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 MaterialUnit 资料
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="MaterialUnitCount">MaterialUnit 总数。</param>
        /// <returns>MaterialUnit 列表。</returns>
        public List<MaterialUnitInfo> GetAllGRN(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[vw_MaterialUnit]", "MaterialUnitId",
                "[MaterialUnitId], [SerialNumber], [PartId], [MaterialUnitStatusId], [MaterialTypeId], [StationId], [EmployeeId], [LotCode], [DateCode], [TraceCode], [MPN], [VendorCode],  [Quantity] ,  [BalanceQty], [LooperCount], [CreationTime], [FinishTime], [LineId], [LastUpdate], [ProcessNameId], [ItemName], [CreateBy], [Status],[PID],[ItemDesc],[ItemSpec],[StorageDate],[ItemCode],flag_cn,CreateDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo(rdr.GetInt64(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetByte(3), rdr.GetByte(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetInt32(14),
                        rdr.GetDateTime(15), rdr.GetDateTime(16), rdr.GetInt32(17), rdr.GetDateTime(18), rdr.GetInt32(19), rdr.GetInt32(22));

                    entity.ItemName = rdr.GetString(20);
                    entity.CreateBy = rdr.GetString(21);
                    entity.PID = rdr.GetInt32(23);
                    entity.ItemDesc = rdr.GetString(24);
                    entity.ItemSpec = rdr.GetString(25);
                    entity.PackTime = rdr.GetDateTime(26).ToString("yyyy-MM-dd HH:mm:ss"); //针对入库日期
                    entity.ItemCode = rdr.GetString(27);
                    entity.Flag_CN = rdr.GetString(28);
                    entity.CreationTime = rdr.GetDateTime(29);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 获取物料数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetMaterialInfoAllSuply(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwProMaterialMemberSuply", "MaterialUnitId",
               "[MaterialUnitId], [SerialNumber], [PartId],[ItemCode],[ItemName], [ItemSpec], [cBarCode], [VendorCode], [BalanceQty], [Status], [StatusName], [CreateDateTime], [CreateBy],  [StorageDate],[LotCode],[Quantity],[VendorName],[POorder],[Status],[Statusname],MPN,WeekCode,DeliveryOrder", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSuplyMaterialCommonGetPageRecords", parms))
            {
                list = ComMethod.ToListEntity<MaterialUnitInfo>(rdr);
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取物料条码状态
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetMaterialStaus(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_MaterialStatus", "ID",
               "[ID], [MaterialStatus]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                list = ComMethod.ToListEntity<MaterialUnitInfo>(rdr);
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 分页获取 MaterialUnit 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="MaterialUnitCount">MaterialUnit 总数。</param>
        /// <returns>MaterialUnit 列表。</returns>
        public List<MaterialUnitInfo> GetErpModtlPrepareMat(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vw_erpmodtlpreparemat", "Id",
                "id,MOCode, ItemCode,ItemName, auxqtypick,stockqty,moid,modtlid,modtlno,ItemId", searchSettings, sortExpression);
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                for (int i = 0; i < dt.Rows.Count;i++ )
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialRequestId =Convert.ToInt32(dt.Rows[i]["id"]);
                    entity.MOCode = dt.Rows[i]["MOCode"].ToString();
                    entity.ItemCode = dt.Rows[i]["ItemCode"].ToString();
                    entity.ItemName =dt.Rows[i]["ItemName"].ToString();
                    entity.RequestQty =Convert.ToInt32(dt.Rows[i]["AuxQtyPick"]);
                    entity.ResponseQty =Convert.ToInt32(dt.Rows[i]["stockqty"]);
                    entity.Moid = Convert.ToInt32(dt.Rows[i]["Moid"]);
                    entity.ModtlId = Convert.ToInt32(dt.Rows[i]["ModtlId"]);
                    entity.ModtlNo = Convert.ToInt32(dt.Rows[i]["ModtlNo"]);
                    entity.ItemId = Convert.ToInt32(dt.Rows[i]["ItemId"]);
                    list.Add(entity);
                }
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        //add by weixia on 2016.8.19获取物料信息  
        public MaterialUnitInfo GetMaterialInfoByField(Int32 searchType, String serialNumber)
        {
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SearchType", SqlDbType.Int),
                new SqlParameter("@SerialNumber", SqlDbType.VarChar,200)
            };

            parms[0].Value = searchType;
            parms[1].Value = serialNumber;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetMaterialInfoByField", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.CBarCode = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                }
                rdr.Close();
            }
            return entity;

        }

        /// <summary>
        /// 条码报废 add by weixia on 2016.8.19
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="wareCode"></param>
        /// <param name="qty"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> ScrapMaterial(String grn, String wareCode, String userName)
        {

            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
                  new SqlParameter("@WareCode",SqlDbType.VarChar,100),
                  new SqlParameter("@UserName",SqlDbType.NVarChar,50)
            };
            parms[0].Value = grn;
            parms[1].Value = wareCode;
            parms[2].Value = userName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckScrapMaterial", parms))
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
        /// 页面加载时，获取批次号
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        public string GetLotCode()
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@SN",SqlDbType.VarChar,50)
            };
            parms[0].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateItemSNDel", parms);
            return parms[0].Value.ToString();
        }

        //供应商打印条码：选择采购订单，带出物料信息
        /// 获取供应商对应的物料列表
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetAllItemByVendor(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwVendorPart", "ItemId",
                "ItemId, ItemName, VenCode,ItemCode,POorder,BuyQty,RowID,MinPackQty,ItemSpec", searchSettings, "RowID");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.ItemId = rdr.GetInt32(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.VendorCode = rdr.GetString(2);
                    entity.ItemCode = rdr.GetString(3);
                    entity.POorder = rdr.GetString(4);
                    entity.BuyQty = decimal.Parse(rdr.GetDecimal(5).ToString("0.######"));
                    entity.RowId = rdr["RowID"].ToString();
                    entity.MinPackQty =decimal.Parse(rdr.GetDecimal(7).ToString("0.######"));
                    entity.ItemSpec = rdr.GetString(8);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordVendorItemCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 根据PO，物料获取该PO的已打印总数量
        /// add weixia on 2016.9.8
        /// </summary>
        /// <param name="PoCode"></param>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        public Decimal GetPrintQty(String PoCode, String ItemCode, int rowID)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@PoCode",SqlDbType.VarChar,100),
                new SqlParameter("@ItemCode",SqlDbType.VarChar,100),
                new SqlParameter("@RowID",SqlDbType.Int),
                new SqlParameter("@PrintQty",SqlDbType.Float)
            };

            parms[0].Value = PoCode;
            parms[1].Value = ItemCode;
            parms[2].Value = rowID;
            parms[3].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetPrintQty", parms);
            return Convert.ToDecimal(parms[3].Value);

        }


        /// <summary>
        /// 物料报废 add by weixia on  2016.9.10
        /// </summary>
        /// <param name="userType"></param>
        /// <param name="userName"></param>
        /// <param name="idString"></param>
        public void FailGrnByVencode(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 

                new SqlParameter("@IdString",SqlDbType.VarChar,1000),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)

            };
            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGRNFailedByVenCode", parms);
        }

        /// <summary>
        /// 获取所有未关闭的包装箱条码
        /// add by weixia on 2016.9.10
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="vendorCode"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetOldCartonGRNList(string grn)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRN",SqlDbType.VarChar,50)
            };
            parms[0].Value = grn;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetOldCartonGRNList", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.ItemName = rdr.GetString(2);
                    entity.VendorName = rdr.GetString(3);
                    entity.LotCode = rdr.GetString(4);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 获取未关闭的包装箱条码并对其进行包装
        /// add by  weixia on 2016.9.10
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="vendorCode"></param>
        /// <returns></returns>
        public void GetOldCartonGRN(string grn, string vendorCode, string oldCartonSN, string username)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@VendorCode",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50)
            };

            parms[0].Value = grn;
            parms[1].Value = vendorCode;
            parms[2].Value = username;
            parms[3].Value = oldCartonSN;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetOldCartonGRN", parms);
        }

        /// <summary>
        /// 获取入库单号
        /// </summary>
        /// <returns></returns>
        public string GetMaterialStorageNo(int serialNumberType)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@NextNumberType", SqlDbType.Int),
                    new SqlParameter("@ItemId", SqlDbType.Int),
					new SqlParameter("@WOID", SqlDbType.Int),
                    new SqlParameter("@SN",SqlDbType.VarChar,50)
				};
            parms[0].Value = serialNumberType;
            parms[1].Value = -1;
            parms[2].Value = -1;
            parms[3].Value = -1;
            parms[3].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateItemSN", parms);

            return parms[3].Value.ToString();
        }

        public List<MaterialUnitInfo> GetMaterialAllAction(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_MaterialActionType", "[RID]",
                "[RID],[ActionId],[ActionType]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.RowId = rdr.GetInt32(0);
                    entity.StatusId = rdr.GetInt32(1);
                    entity.MaterialStatus = rdr.GetString(2);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public List<MaterialUnitInfo> GetHistoryActionInfoAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwMaterialHistoryAction"
                , "MaterialUnitHistoryId",
               @"MaterialUnitHistoryId,MaterialUnitId,SerialNumber,ActionType,ActionDesc
                ,OperateOrder,Description,CreateBy,CreateDateTime,ItemCode,ItemName,ItemID,Qty"
               , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitHistoryId = rdr.GetString(0);
                    entity.MaterialUnitId = rdr.GetInt64(1);
                    entity.SerialNumber = rdr.GetString(2);
                    entity.ActionType = rdr.GetString(3);
                    entity.ActionDesc = rdr.GetString(4);
                    entity.OperateOrder = rdr.GetString(5);
                    entity.Description = rdr.GetString(6); 
                    entity.CreateBy = rdr.GetString(7);
                    entity.CreateDateTime = rdr.GetDateTime(8);
                    entity.ItemCode = rdr.GetString(9);
                    entity.ItemName = rdr.GetString(10);
                    entity.ItemId = rdr.GetInt64(11);
                    entity.Quantity = rdr.GetDecimal(12);
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        public List<MaterialUnitInfo> GetMaterialDateCode(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo model = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaterialUnitDateCode", "MaterialUnitId",
                "[DateCode]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    model = new MaterialUnitInfo();
                    model.DateCode = rdr.GetString(0);
                    list.Add(model);
                }
                rdr.Close();
            }
            list = list.Where((x, i) => list.FindIndex(z => z.DateCode == x.DateCode) == i).ToList();
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        public List<MaterialUnitInfo> GetMaterialLotCode(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo model = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaterialUnitLotCode", "MaterialUnitId",
                "[LotCode]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    model = new MaterialUnitInfo();
                    model.LotCode = rdr.GetString(0);
                    list.Add(model);
                }
                rdr.Close();
            }
            list = list.Where((x, i) => list.FindIndex(z => z.LotCode == x.LotCode) == i).ToList();
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 获取QHold使用的供应商信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetMaterialVendorCode(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo model = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaterialUnitVendorCode", "MaterialUnitId",
                "[VendorCode],VendorName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    model = new MaterialUnitInfo();
                    model.VendorCode = rdr.GetString(0);
                    model.VendorName = rdr.GetString(1);
                    list.Add(model);
                }
                rdr.Close();
            }
            list = list.Where((x, i) => list.FindIndex(z => z.VendorCode == x.VendorCode) == i).ToList();
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        #region 根据供应商ID获取标准离线标签设置信息
        /// <summary>
        /// 根据供应商ID获取标准离线标签设置信息
        /// </summary>
        /// <param name="VendorID"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetVendorOffLineLabel(string VendorCode)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@VendorCode",SqlDbType.VarChar,50)
            };
            parms[0].Value = VendorCode;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetVendorOffLineLabel", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.Delimiter = rdr.GetString(0);
                    entity.DetailContent = rdr.GetString(1);
                    entity.Paragraph = rdr.GetInt32(2);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        #endregion

        #region 标准离线条码登记
        /// <summary>
        /// 标准离线条码登记
        /// </summary>
        /// <param name="GRNInfoList"></param>
        /// <param name="ItemId"></param>
        /// <param name="GRNQty"></param>
        /// <param name="MinQty"></param>
        /// <param name="bigCartonQty"></param>
        /// <param name="itemAllQty"></param>
        /// <param name="aPrintQty"></param>
        /// <param name="LotCode"></param>
        /// <param name="DateCode"></param>
        /// <param name="VendorCode"></param>
        /// <param name="UserName"></param>
        /// <param name="poCode"></param>
        /// <param name="factory"></param>
        /// <param name="remark"></param>
        /// <param name="RowId"></param>
        /// <param name="isSupplyPrint"></param>
        /// <param name="WeekCode"></param>
        /// <param name="MPN"></param>
        /// <param name="GRNString"></param>
        /// <param name="iqcOrder"></param>
        /// <returns></returns>
        public string[] SaveBZOfflineGenerateGRN(String GRNInfoList, int ItemId, decimal GRNQty, decimal MinQty, decimal bigCartonQty, decimal itemAllQty, decimal aPrintQty
            , string LotCode, string DateCode, string VendorCode, string UserName, string poCode
            , string factory, string remark, int RowId, bool isSupplyPrint, string WeekCode, string MPN, string GRNString, string iqcOrder = "")
        {
            DataTable dt = JsonToDataTable(GRNInfoList);
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ItemID",SqlDbType.Int),
                new SqlParameter("@GRNQty",SqlDbType.Decimal),
                new SqlParameter("@MinQty",SqlDbType.Decimal),
                new SqlParameter("@BigCartonQty",SqlDbType.Decimal),
                new SqlParameter("@ItemAllQty",SqlDbType.Decimal),
                new SqlParameter("@AlreadyPrintQty",SqlDbType.Decimal),
                new SqlParameter("@LotCode",SqlDbType.NVarChar,50),
                new SqlParameter("@DateCode",SqlDbType.NVarChar,50),
                new SqlParameter("@VendorCode",SqlDbType.NVarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@POorder",SqlDbType.NVarChar,50),
                new SqlParameter("@FactoryCode",SqlDbType.VarChar,20),
                new SqlParameter("@Remark",SqlDbType.NVarChar,100),
                new SqlParameter("@RowID",SqlDbType.Int),
                new SqlParameter("@IsSupplyPrint",SqlDbType.Bit),
                new SqlParameter("@GRNString",SqlDbType.VarChar,40),
                new SqlParameter("@CartonString",SqlDbType.VarChar,8000),
                new SqlParameter("@IqcOrder",SqlDbType.VarChar,50),
                new SqlParameter("@WeekCode",SqlDbType.VarChar,50),
                new SqlParameter("@MPN",SqlDbType.VarChar,50),
                new SqlParameter("@ListGRNInfo",SqlDbType.Structured)
            };

            parms[0].Value = ItemId;
            parms[1].Value = GRNQty;
            parms[2].Value = MinQty;
            parms[3].Value = bigCartonQty;
            parms[4].Value = itemAllQty;
            parms[5].Value = aPrintQty;
            parms[6].Value = LotCode;
            parms[7].Value = DateCode;
            parms[8].Value = VendorCode;
            parms[9].Value = UserName;
            parms[10].Value = poCode;
            parms[11].Value = factory;
            parms[12].Value = remark;
            parms[13].Value = RowId;
            parms[14].Value = isSupplyPrint;
            parms[15].Value = GRNString;
            parms[16].Direction = ParameterDirection.Output;
            parms[17].Value = iqcOrder;

            parms[18].Value = WeekCode;
            parms[19].Value = MPN;
            parms[20].Value = dt;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveBZOfflineGenerateGRN", 2000000, parms);

            string[] str = new string[2];
            str[0] = Convert.ToString(parms[15].Value);
            str[1] = Convert.ToString(parms[16].Value);
            return str;
        }
        #endregion

        #region 保存导入GRN信息
        /// <summary>
        /// 保存导入GRN信息
        /// </summary>
        /// <param name="GRNInfoList"></param>
        /// <param name="UserName"></param>
        /// <returns></returns>
        public void SaveImportGRN(String OfflineGRNList, string UserName)
        {
            DataTable dt = JsonToDataTable(OfflineGRNList);
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@OfflineGRNList",SqlDbType.Structured)
            };
            parms[0].Value = UserName;
            parms[1].Value = dt;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveImportGRN", 2000000, parms);
        }
        #endregion

        #region 将 Json 解析成 DateTable
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
        #endregion

        #region 保存数据到数据库
        /// <summary>
        /// 保存数据到数据库
        /// </summary>
        /// <param name="dt"></param>
        public List<OfflineGRNInfo> VerifyOfflineGRN(DataTable dt)
        {
            List<OfflineGRNInfo> list = new List<OfflineGRNInfo>();
            OfflineGRNInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@OfflineGRNList",SqlDbType.Structured)
            };
            parms[0].Value = dt;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspVerifyOfflineGRN", parms))
            {
                while (rdr.Read())
                {
                    entity = new OfflineGRNInfo();
                    entity.SignId = rdr.GetInt32(0);
                    entity.SerialNumber = rdr.GetString(1);
                    entity.Qty = rdr.GetDecimal(2);
                    entity.PoCode = rdr.GetString(3);
                    entity.VendorCode = rdr.GetString(4);
                    entity.VendorName = rdr.GetString(5);
                    entity.ItemCode = rdr.GetString(6);
                    entity.RowId = rdr.GetInt32(7);
                    entity.LotCode = rdr.GetString(8);
                    entity.DateCode = rdr.GetString(9);
                    entity.WeekCode = rdr.GetString(10);
                    entity.MPN = rdr.GetString(11);
                    entity.States = rdr.GetString(12);
                    entity.ErrorMessage = rdr.GetString(13);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        #endregion

        #region 物料条码以及箱号打印
        /// <summary>
        /// 物料条码以及箱号打印
        /// 黄亮 2018.08.21
        /// </summary>
        /// <param name="ItemId"></param>
        /// <param name="GRNQty"></param>
        /// <param name="MinQty"></param>
        /// <param name="bigCartonQty"></param>
        /// <param name="itemAllQty"></param>
        /// <param name="aPrintQty"></param>
        /// <param name="LotCode"></param>
        /// <param name="DateCode"></param>
        /// <param name="VendorCode"></param>
        /// <param name="UserName"></param>
        /// <param name="poCode"></param>
        /// <param name="factory"></param>
        /// <param name="remark"></param>
        /// <param name="RowId"></param>
        /// <param name="isSupplyPrint"></param>
        /// <param name="WeekCode"></param>
        /// <param name="MPN"></param>
        /// <param name="PackGrnQty"></param>
        /// <param name="iqcOrder"></param>
        /// <returns></returns>
        public string[] GenerateGRNAndPack(int ItemId, decimal GRNQty, decimal MinQty, decimal bigCartonQty, decimal itemAllQty, decimal aPrintQty
            , string LotCode, string DateCode, string VendorCode, string UserName, string poCode
            , string factory, string remark, int RowId, bool isSupplyPrint, string WeekCode, string MPN, int PackGrnQty, string iqcOrder = "")
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ItemID",SqlDbType.Int),
                new SqlParameter("@GRNQty",SqlDbType.Decimal),
                new SqlParameter("@MinQty",SqlDbType.Decimal),
                new SqlParameter("@BigCartonQty",SqlDbType.Decimal),
                new SqlParameter("@ItemAllQty",SqlDbType.Decimal),
                new SqlParameter("@AlreadyPrintQty",SqlDbType.Decimal),
                new SqlParameter("@LotCode",SqlDbType.NVarChar,50),
                new SqlParameter("@DateCode",SqlDbType.NVarChar,50),
                new SqlParameter("@VendorCode",SqlDbType.NVarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@POorder",SqlDbType.NVarChar,50),
                new SqlParameter("@FactoryCode",SqlDbType.VarChar,20),
                new SqlParameter("@Remark",SqlDbType.NVarChar,100),
                new SqlParameter("@RowID",SqlDbType.Int),
                new SqlParameter("@IsSupplyPrint",SqlDbType.Bit),
                new SqlParameter("@GRNString",SqlDbType.VarChar,-1),
                new SqlParameter("@CartonString",SqlDbType.VarChar,-1),
                new SqlParameter("@IqcOrder",SqlDbType.VarChar,50),
                new SqlParameter("@WeekCode",SqlDbType.VarChar,50),
                new SqlParameter("@MPN",SqlDbType.VarChar,50),
                new SqlParameter("@PackGrnQty",SqlDbType.Int)
            };

            parms[0].Value = ItemId;
            parms[1].Value = GRNQty;
            parms[2].Value = MinQty;
            parms[3].Value = bigCartonQty;
            parms[4].Value = itemAllQty;
            parms[5].Value = aPrintQty;
            parms[6].Value = LotCode;
            parms[7].Value = DateCode;
            parms[8].Value = VendorCode;
            parms[9].Value = UserName;
            parms[10].Value = poCode;
            parms[11].Value = factory;
            parms[12].Value = remark;
            parms[13].Value = RowId;
            parms[14].Value = isSupplyPrint;
            parms[15].Direction = ParameterDirection.Output;
            parms[16].Direction = ParameterDirection.Output;
            parms[17].Value = iqcOrder;
            parms[18].Value = WeekCode;
            parms[19].Value = MPN;
            parms[20].Value = PackGrnQty;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateGRNAndPack", parms);

            string[] str = new string[2];
            str[0] = Convert.ToString(parms[15].Value);
            str[1] = Convert.ToString(parms[16].Value);
            return str;
        }
        #endregion

        #region 查询可生成送货单的GRN
        /// <summary>
        /// 查询可生成送货单的GRN
        /// </summary>
        /// <param name="VendorCode"></param>
        /// <param name="DateFrom"></param>
        /// <param name="DateTo"></param>
        /// <param name="ItemId"></param>
        /// <param name="Carton"></param>
        /// <param name="GRN"></param>
        /// <param name="CreateBy"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> QueryDeliverGrn(string VendorCode, string DateFrom, string DateTo, int ItemId, string Carton, string GRN, string CreateBy)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@VendorCode",SqlDbType.VarChar,100),
                  new SqlParameter("@DateFrom",SqlDbType.VarChar,50),
                  new SqlParameter("@DateTo",SqlDbType.VarChar,50),
                  new SqlParameter("@ItemId",SqlDbType.Int),
                  new SqlParameter("@Carton",SqlDbType.VarChar,100),
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
                  new SqlParameter("@CreateBy",SqlDbType.VarChar,50)
            };
            parms[0].Value = VendorCode;
            parms[1].Value = DateFrom;
            parms[2].Value = DateTo;
            parms[3].Value = ItemId;
            parms[4].Value = Carton;
            parms[5].Value = GRN;
            parms[6].Value = CreateBy;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspQueryDeliverGrn", parms))
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    entity = new MaterialUnitInfo();
                    entity.SignId = int.Parse(dt.Rows[i]["SignId"].ToString());
                    entity.ItemCode = dt.Rows[i]["ItemCode"].ToString();
                    entity.ItemName = dt.Rows[i]["ItemName"].ToString();
                    entity.ItemSpec = dt.Rows[i]["ItemSpec"].ToString();
                    entity.SerialNumber = dt.Rows[i]["SerialNumber"].ToString();
                    entity.CBarCode = dt.Rows[i]["cBarCode"].ToString();
                    entity.Quantity = decimal.Parse(dt.Rows[i]["Quantity"].ToString());
                    entity.CreateDateTime = DateTime.Parse(dt.Rows[i]["CreateDateTime"].ToString());
                    entity.CreateBy = dt.Rows[i]["CreateBy"].ToString();
                    list.Add(entity);
                }
            }
            return list;
        }
        #endregion

        #region 生成送货单并打印
        /// <summary>
        /// 生成送货单并打印
        /// </summary>
        /// <param name="VendorCode"></param>
        /// <param name="SerialNumberStr"></param>
        /// <param name="UserName"></param>
        public string SaveAndPrintDeliver(string VendorCode, string SerialNumberStr, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@SerialNumberStr",SqlDbType.VarChar,-1),
                new SqlParameter("@VendorCode",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,50),
                new SqlParameter("@DeliverId",SqlDbType.Int)
            };
            parms[0].Value = SerialNumberStr;
            parms[1].Value = VendorCode;
            parms[2].Value = UserName;
            parms[3].Value = -1;
            parms[3].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveAndPrintDeliver", 2000000, parms);
            return parms[3].Value.ToString();
        }
        #endregion

        #region 客供料生成并打印
        /// <summary>
        /// 客供料生成并打印
        /// </summary>
        /// <param name="GRNInfoList"></param>
        /// <param name="ItemId"></param>
        /// <param name="VendorCode"></param>
        /// <param name="UserName"></param>
        /// <returns></returns>
        public string[] SupplierMaterialPrint(String GRNInfoList, int ItemId, string VendorCode, string UserName)
        {
            DataTable dt = JsonToDataTable(GRNInfoList);
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ItemID",SqlDbType.Int),
                new SqlParameter("@VendorCode",SqlDbType.NVarChar,100),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@GRNString",SqlDbType.VarChar,-1),
                new SqlParameter("@CartonString",SqlDbType.VarChar,-1),
                new SqlParameter("@ListGRNInfo",SqlDbType.Structured)
            };

            parms[0].Value = ItemId;
            parms[1].Value = VendorCode;
            parms[2].Value = UserName;
            parms[3].Direction = ParameterDirection.Output;
            parms[4].Direction = ParameterDirection.Output;
            parms[5].Value = dt;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSupplierMaterialPrint", parms);

            string[] str = new string[2];
            str[0] = Convert.ToString(parms[3].Value);
            str[1] = Convert.ToString(parms[4].Value);
            return str;
        }
        #endregion

        #region 查询可生成虚拟PO单的GRN
        /// <summary>
        /// 查询可生成虚拟PO单的GRN
        /// </summary>
        /// <param name="VendorCode"></param>
        /// <param name="DateFrom"></param>
        /// <param name="DateTo"></param>
        /// <param name="CreateBy"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> QueryVirtualPoGrn(string VendorCode, string DateFrom, string DateTo, string CreateBy)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@VendorCode",SqlDbType.VarChar,100),
                  new SqlParameter("@DateFrom",SqlDbType.VarChar,50),
                  new SqlParameter("@DateTo",SqlDbType.VarChar,50),
                  new SqlParameter("@CreateBy",SqlDbType.VarChar,50)
            };
            parms[0].Value = VendorCode;
            parms[1].Value = DateFrom;
            parms[2].Value = DateTo;
            parms[3].Value = CreateBy;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspQueryVirtualPoGrn", parms))
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    entity = new MaterialUnitInfo();
                    entity.SignId = int.Parse(dt.Rows[i]["SignId"].ToString());
                    entity.ItemCode = dt.Rows[i]["ItemCode"].ToString();
                    entity.ItemName = dt.Rows[i]["ItemName"].ToString();
                    entity.ItemSpec = dt.Rows[i]["ItemSpec"].ToString();
                    entity.SerialNumber = dt.Rows[i]["SerialNumber"].ToString();
                    entity.Quantity = decimal.Parse(dt.Rows[i]["Quantity"].ToString());
                    entity.CreateDateTime = DateTime.Parse(dt.Rows[i]["CreateDateTime"].ToString());
                    entity.CreateBy = dt.Rows[i]["CreateBy"].ToString();
                    list.Add(entity);
                }
            }
            return list;
        }
        #endregion

        #region 生成虚拟采购订单
        /// <summary>
        /// 生成虚拟采购订单
        /// </summary>
        /// <param name="VenID"></param>
        /// <param name="VendorCode"></param>
        /// <param name="ReceiveType"></param>
        /// <param name="SerialNumberStr"></param>
        /// <param name="UserName"></param>
        /// <returns></returns>
        public string SaveVirtualPo(int VenID, string VendorCode, string ReceiveType,string Remark, string SerialNumberStr, string UserName,string SOCode)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@VenID",SqlDbType.Int),
                new SqlParameter("@VendorCode",SqlDbType.VarChar,100),
                new SqlParameter("@ReceiveType",SqlDbType.VarChar,50),
                new SqlParameter("@Remark",SqlDbType.VarChar,50),
                new SqlParameter("@SerialNumberStr",SqlDbType.VarChar,-1),
                new SqlParameter("@UserName",SqlDbType.VarChar,50),
                new SqlParameter("@Po",SqlDbType.VarChar,50),
                new SqlParameter("@SOCode",SqlDbType.VarChar,50)
            };
            parms[0].Value = VenID;
            parms[1].Value = VendorCode;
            parms[2].Value = ReceiveType;
            parms[3].Value = Remark;
            parms[4].Value = SerialNumberStr;
            parms[5].Value = UserName;
            parms[6].Direction = ParameterDirection.Output;
            parms[7].Value = SOCode;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveVirtualPo", 2000000, parms);
            return Convert.ToString(parms[6].Value);
        }
        #endregion

        #region 校验物料编码并且返回物料ID
        /// <summary>
        /// 校验物料编码并且返回物料ID
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        public string VerifyItemCode(string ItemCode)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ItemCode",SqlDbType.VarChar,50),
                new SqlParameter("@ItemId",SqlDbType.Int)
            };

            parms[0].Value = ItemCode;
            parms[1].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspVerifyItemCode", parms);
            return Convert.ToString(parms[1].Value);
        }
        #endregion

        #region 生成客供料
        /// <summary>
        /// 生成客供料
        /// </summary>
        /// <param name="ItemId"></param>
        /// <param name="GRNQty"></param>
        /// <param name="MinQty"></param>
        /// <param name="bigCartonQty"></param>
        /// <param name="itemAllQty"></param>
        /// <param name="aPrintQty"></param>
        /// <param name="LotCode"></param>
        /// <param name="DateCode"></param>
        /// <param name="VendorCode"></param>
        /// <param name="UserName"></param>
        /// <param name="poCode"></param>
        /// <param name="factory"></param>
        /// <param name="remark"></param>
        /// <param name="RowId"></param>
        /// <param name="isSupplyPrint"></param>
        /// <param name="WeekCode"></param>
        /// <param name="MPN"></param>
        /// <param name="iqcOrder"></param>
        /// <returns></returns>
        public string[] GenerateSupplierMaterial(int ItemId, decimal GRNQty, decimal MinQty ,
            string LotCode, string DateCode, string VendorCode, string UserName, string poCode,string remark,string WeekCode, string MPN)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ItemID",SqlDbType.Int),
                new SqlParameter("@GRNQty",SqlDbType.Decimal),
                new SqlParameter("@MinQty",SqlDbType.Decimal),
                new SqlParameter("@LotCode",SqlDbType.NVarChar,50),
                new SqlParameter("@DateCode",SqlDbType.NVarChar,50),
                new SqlParameter("@VendorCode",SqlDbType.NVarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@POorder",SqlDbType.NVarChar,50),
                new SqlParameter("@Remark",SqlDbType.NVarChar,100),
                new SqlParameter("@GRNString",SqlDbType.VarChar,-1),
                new SqlParameter("@CartonString",SqlDbType.VarChar,-1),
                new SqlParameter("@WeekCode",SqlDbType.VarChar,50),
                new SqlParameter("@MPN",SqlDbType.VarChar,50)
            };

            parms[0].Value = ItemId;
            parms[1].Value = GRNQty;
            parms[2].Value = MinQty;
            parms[3].Value = LotCode;
            parms[4].Value = DateCode;
            parms[5].Value = VendorCode;
            parms[6].Value = UserName;
            parms[7].Value = poCode;
            parms[8].Value = remark;
            parms[9].Direction = ParameterDirection.Output;
            parms[10].Direction = ParameterDirection.Output;
            parms[11].Value = WeekCode;
            parms[12].Value = MPN;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateSupplierMaterial", parms);
            string[] str = new string[2];
            str[0] = Convert.ToString(parms[9].Value);
            str[1] = Convert.ToString(parms[10].Value);
            return str;
        }
        #endregion

        #region 修改GRN状态
        /// <summary>
        /// 修改GRN状态
        /// </summary>
        /// <param name="GRN"></param>
        /// <param name="UserName"></param>
        public void UpdateGRNState(String GRN, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,100),
                new SqlParameter("@UserName",SqlDbType.VarChar,50)
            };
            parms[0].Value = GRN;
            parms[1].Value = UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUpdateGRNState", 2000000, parms);
        }
        #endregion

        /// <summary>
        /// 根据物料条码获取物料详细信息
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        public DataTable GetMaterialDetailInfo(string val) {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@VAL",SqlDbType.VarChar)
            };

            parms[0].Value = val;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetMaterialDetailInfo", parms);
        }

        public DataTable SearchWarehouseInfo(int type,string val)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@type",SqlDbType.Int),
                new SqlParameter("@code",SqlDbType.VarChar)
            };
            parms[0].Value = type;
            parms[1].Value = val;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspSearchWarehouseInfo", parms);
        }

        /// <summary>
        /// 供应商打印条码：选择到货单，带出物料信息 //到货单打印功能，创维专利，正式版本不需要
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        //public List<MaterialUnitInfo> GetAllItemByPOInStockNo(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        //{
        //    List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
        //    MaterialUnitInfo entity = null;

        //    SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwPOInStockPart", "ItemId",
        //        "ItemId, ItemName, VenCode,ItemCode,POorder,BuyQty,RowID,MinPackQty,ItemSpec,RequestQty,LotCode", searchSettings, "RowID");

        //    using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
        //    {
        //        while (rdr.Read())
        //        {
        //            entity = new MaterialUnitInfo();
        //            entity.ItemId = rdr.GetInt32(0);
        //            entity.ItemName = rdr.GetString(1);
        //            entity.VendorCode = rdr.GetString(2);
        //            entity.ItemCode = rdr.GetString(3);
        //            entity.POorder = rdr.GetString(4);
        //            entity.BuyQty = rdr.GetDouble(5);
        //            entity.RowId = rdr["RowID"].ToString();
        //            entity.MinPackQty = rdr.GetDecimal(7);
        //            entity.ItemSpec = rdr.GetString(8);
        //            entity.POQty = rdr.GetDouble(9);
        //            entity.LotCode = rdr.GetString(10);
        //            list.Add(entity);
        //        }
        //        rdr.Close();
        //    }

        //    recordVendorItemCount = Convert.ToInt32(parms[parms.Length - 1].Value);
        //    return list;
        //}

        #region 转移GRN数量
        /// <summary>
        /// 修改GRN状态
        /// </summary>
        /// <param name="GRN"></param>
        /// <param name="UserName"></param>
        public void GRNTransfer(string GRN,string TragetGRN,decimal Qty, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,100),
                new SqlParameter("@TragetGRN",SqlDbType.VarChar,100),
                new SqlParameter("@Qty",SqlDbType.Decimal),
                new SqlParameter("@UserName",SqlDbType.VarChar,50)
            };
            parms[0].Value = GRN;
            parms[1].Value = TragetGRN;
            parms[2].Value = Qty;
            parms[2].Precision = 18;
            parms[2].Scale = 6;
            parms[3].Value = UserName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGRNTransfer", parms);
        }

        #endregion

        /// <summary>
        /// 锡膏条码转印，加打印份数
        /// </summary>
        /// <param name="ItemId"></param>
        /// <param name="GRNQty"></param>
        /// <param name="MinQty"></param>
        /// <param name="LotCode"></param>
        /// <param name="DateCode"></param>
        /// <param name="VendorCode"></param>
        /// <param name="UserName"></param>
        /// <param name="poCode"></param>
        /// <param name="remark"></param>
        /// <param name="WeekCode"></param>
        /// <param name="MPN"></param>
        /// <param name="QRCodeText"></param>
        /// <param name="txtSCode"></param>
        /// <param name="txtlNumber"></param>
        /// <param name="txtstopTime"></param>
        /// <returns></returns>
        public string[] AccessrySupplierMaterialGenerateCount(int ItemId, decimal GRNQty, decimal MinQty,
    string LotCode, string DateCode, string VendorCode, string UserName, string poCode, string remark, string WeekCode, string MPN, string QRCodeText, string txtSCode, string txtlNumber, string txtstopTime
            , int GenerateCount)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ItemID",SqlDbType.Int),
                new SqlParameter("@GRNQty",SqlDbType.Decimal),
                new SqlParameter("@MinQty",SqlDbType.Decimal),
                new SqlParameter("@LotCode",SqlDbType.NVarChar,50),
                new SqlParameter("@DateCode",SqlDbType.NVarChar,50),
                new SqlParameter("@VendorCode",SqlDbType.NVarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@POorder",SqlDbType.NVarChar,50),
                new SqlParameter("@Remark",SqlDbType.NVarChar,100),
                new SqlParameter("@GRNString",SqlDbType.VarChar,-1),
                new SqlParameter("@CartonString",SqlDbType.VarChar,-1),
                new SqlParameter("@WeekCode",SqlDbType.VarChar,50),
                new SqlParameter("@MPN",SqlDbType.VarChar,50),
                new SqlParameter("@QRCodeText",SqlDbType.NVarChar,100),
                new SqlParameter("@SupplierCode",SqlDbType.NVarChar,100),
                new SqlParameter("@QRSerialNumber",SqlDbType.NVarChar,100),
                new SqlParameter("@ExpiryDate",SqlDbType.NVarChar,100),
                new SqlParameter("@GenerateCount",SqlDbType.Int)
            };

            parms[0].Value = ItemId;
            parms[1].Value = GRNQty;
            parms[2].Value = MinQty;
            parms[3].Value = LotCode;
            parms[4].Value = DateCode;
            parms[5].Value = VendorCode;
            parms[6].Value = UserName;
            parms[7].Value = poCode;
            parms[8].Value = remark;
            parms[9].Direction = ParameterDirection.Output;
            parms[10].Direction = ParameterDirection.Output;
            parms[11].Value = WeekCode;
            parms[12].Value = MPN;
            parms[13].Value = QRCodeText;
            parms[14].Value = txtSCode;
            parms[15].Value = txtlNumber;
            parms[16].Value = txtstopTime;
            parms[17].Value = GenerateCount;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAccessrySupplierMaterialGenerateCount", parms);
            string[] str = new string[2];
            str[0] = Convert.ToString(parms[9].Value);
            str[1] = Convert.ToString(parms[10].Value);
            return str;
        }

        /// <summary>
        /// 根据 供应商代码  获取 客供料默认供应商名称
        /// </summary>
        /// <param name="SupplierCode"></param>
        /// <returns></returns>
        public CustomerSupplierInfo CustomerSupplierInfoBySupplierCode(String SupplierCode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SupplierCode", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = SupplierCode;
            return ComMethod.Get<CustomerSupplierInfo>("uspCustomerSupplierInfoBySupplierCode", parms);
        }

        /// <summary>
        /// 验证查询条码是否有包装箱
        /// </summary>
        /// <param name="idString"></param>
        public DataTable CheckGrnIsPacking(String idString)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@IdString",SqlDbType.VarChar,1000)
            };
            parms[0].Value = idString;
            DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspCheckGrnIsPacking", parms);
            return dt;
        }
        /// <summary>
        /// 判断物料GRN是否在仓库：恒温箱、烘烤箱中
        /// </summary>
        /// <param name="idString"></param>
        public void GRNCheckOperation(string idString)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@IdString",SqlDbType.VarChar,1000),
                new SqlParameter("@CheckType",SqlDbType.Bit)
            };
            parms[0].Value = idString;
            parms[1].Value = 0;
            ComMethod.Get("uspGRNCheckOperation", parms);
        }
        /// <summary>
        /// 获取物料状态
        /// </summary>
        /// <param name="serialNumber">物料条码</param>
        /// <returns></returns>
        public string GetMateriaStatus(string serialNumber)
        {
            string str = @" select status from  vwProMaterialMember where serialnumber=@SN";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN", SqlDbType.NVarChar, 512)
            };
            parms[0].Value = serialNumber;
            string result = "";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, str, parms))
            {
                if (rdr.Read())
                {
                    result = rdr.GetInt32(0).ToString();
                }
            }
            return result;
        }

        /// <summary>
        /// 查询入库 用户扫描暂存
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        public List<ReturnToWarehouseDtlTemp> SelectReturnToWarehouseDtlTemp(string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UserName", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = username;
            return ComMethod.GetList<ReturnToWarehouseDtlTemp>("uspSelectReturnToWarehouseDtlTemp", parms);
        }
        /// <summary>
        /// 生产退料入库 暂存Grn
        /// </summary>
        /// <param name="orderNo"></param>
        /// <param name="grn"></param>
        /// <param name="username"></param>
        public void SaveReturnToWarehouseDtlTemp(string orderNo, string grn, string username, string station)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNO", SqlDbType.NVarChar, 80),
                new SqlParameter("@GRN", SqlDbType.NVarChar, 80),
                new SqlParameter("@UserName",SqlDbType.NVarChar, 80),
                new SqlParameter("@station",SqlDbType.NVarChar, 80)
            };
            parms[0].Value = orderNo;
            parms[1].Value = grn;
            parms[2].Value = username;
            parms[3].Value = station;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveReturnToWarehouseDtlTemp", parms);
        }
        /// <summary>
        /// 移转GRN
        /// </summary>
        /// <param name="orderNo"></param>
        /// <param name="grn"></param>
        /// <param name="username"></param>
        /// <returns></returns>
        public List<ReturnToWarehouseDtlTemp> DeleteReturnToWarehouseDtlTempGRN(string orderNo, string grn, string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNO", SqlDbType.NVarChar, 80),
                new SqlParameter("@GRN", SqlDbType.NVarChar, 80),
                new SqlParameter("@UserName",SqlDbType.NVarChar, 80)
            };
            parms[0].Value = orderNo;
            parms[1].Value = grn;
            parms[2].Value = username;
            return ComMethod.GetList<ReturnToWarehouseDtlTemp>("uspDeleteReturnToWarehouseDtlTempGRN", parms);
        }
        /// <summary>
        /// 生产退料入库 删除Grn
        /// </summary>
        /// <param name="username"></param>
        public void DeleteReturnToWarehouseDtlTemp(string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UserName", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = username;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteReturnToWarehouseDtlTemp", parms);
        }
        /// <summary>
        /// 生产退料入库 查询单号是否存在录入中
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        public List<ReturnToWarehouseDtlTemp> SelectReturnToWarehouseDtlTempHave(string number)
        {
            string str = string.Format(@"SELECT [PRWDTId]
                                      ,[PRWDTReturnOrder]
                                      ,[PRWDTSerialNumber]
                                      ,[PRWDTUesrName]
                                      ,[PRWDTMSDTstation]
                                      ,[PRWDTDateTime]
                                      ,[PRWDTRem]
                                  FROM [dbo].[Prod_ReturnToWarehouseDtl_Temp] where PRWDTReturnOrder='{0}'", number);
            return ComMethod.GetListBySql<ReturnToWarehouseDtlTemp>(str, null);
        }

        /// <summary>
        /// 查询库位，退料入库
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        public List<MaterialCbarcode> GetCbarcodeListbyGrn(string grn)
        {
            string str = string.Format(@" select serialnumber,cbarcode,POrder,SOCode,ApplyNo,IQCOrder,StorageDate from vwProMaterialMemberNew 
 where storagedate<>'9999-12-31 00:00:00.000'  and    partid in (select top 1 partid from vwProMaterialMemberNew where  serialnumber='{0}' )  order by  storagedate desc  ", grn);
            return ComMethod.GetListBySql<MaterialCbarcode>(str, null);
        }
        /// <summary>
        /// 根据退料单查询物料信息
        /// </summary>
        /// <param name="ReturnNo"></param>
        /// <returns></returns>
        public List<MaterialWhReturn> SelectMaterialWhReturnByNo(string ReturnNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ReturnOrderNo", SqlDbType.VarChar, 100)
            };
            parms[0].Value = ReturnNo;
            return ComMethod.GetList<MaterialWhReturn>("uspSelectMaterialWhReturnByNo", parms);
        }

        /// <summary>
        /// PDA库存查询
        /// </summary>
        /// <param name="CWhCode">仓库编码</param>
        /// <param name="ItemCode">物料编码</param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetWarseHouseQty(string CWhCode,string ItemCode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CWhCode", SqlDbType.NVarChar){ Value = CWhCode},
                new SqlParameter("@ItemCode", SqlDbType.NVarChar){ Value = ItemCode}
            };
            return ComMethod.GetList<MaterialUnitInfo>("uspGetWarseHouseQty", parms);
        }

        /// <summary>
        /// 判断物料GRN是料把还是粉碎料。
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public string CheckGRNIsIsLineMaterial(string grn)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@GRNType",SqlDbType.NVarChar,50)
            };
            parms[0].Value = grn;
            parms[1].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckGRNIsIsLineMaterial", parms);
            return Convert.ToString(parms[1].Value);
        }
    }
}

