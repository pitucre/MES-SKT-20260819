using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Material.Model;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Utility;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Material.BLL
{
    /// <summary>
    /// add by peter.wang 2016-1-18
    /// 用于物料调拨
    /// </summary>
    public class TransferOut
    {

        private Int32 recordCount = 0;

        /// <summary>
        /// 通过物料条码把物料的信息显示出来
        ///  luwenyuan2016-02-25
        /// </summary>
        /// <param name="TransId"></param>
        /// <returns></returns>
        public List<TransferOutInfo> ShowTransfOutInfo(string SN)
        {
            List<TransferOutInfo> list = new List<TransferOutInfo>();
            TransferOutInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
            };
            parms[0].Value = SN;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "UspTransferOutMaterialUnit", parms))
            {
                for (int i = 0; i < dt.Rows.Count;i++ )
                {
                    entity = new TransferOutInfo();                   
                    entity.ItemCode = dt.Rows[i]["itemcode"].ToString();//物料编码
                    entity.ItemName = dt.Rows[i]["itemname"].ToString();//物料名称
                    entity.ApplyNumber = Convert.ToDecimal(dt.Rows[i]["quantity"].ToString());//总数量
                    entity.AdjustNumber = Convert.ToDecimal(dt.Rows[i]["balanceqty"].ToString());//可用数量 
                    entity.Code = dt.Rows[i]["cBarCode"].ToString();//调出存位
                    entity.WareHouseName = dt.Rows[i]["CWhName"].ToString();//调出仓库
                    entity.OutWarehouseId= Convert.ToInt64(dt.Rows[i]["OutWarehouseId"].ToString());//调出仓别ID
                    entity.ItemID = Convert.ToInt64(dt.Rows[i]["PartId"].ToString());//调出仓别ID
                    //增加字段 by zhi.li 20180609
                    entity.SerialNumber = dt.Rows[i]["SerialNumber"].ToString();//物料条码
                    list.Add(entity);
                }
            }
            return list;
        }

        /// <summary>
        /// 保存调拨信息 modified by zhi.li 2018-06-12
        /// </summary>
        public void SaveTransferOut(string strjson)
        {
            ComMethod.Edit(strjson, "Uspsavetransferout");
        }

        /// <summary>
        /// 生成ERP调拨
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="docNo"></param>
        /// <param name="docLineNoStr"></param>
        /// <param name="itemIdStr"></param>
        /// <param name="outWareId"></param>
        /// <param name="inWareId"></param>
        /// <param name="adjustQtyStr"></param>
        /// <param name="outLocationStr"></param>
        /// <param name="binLineNoStr"></param>
        /// <returns></returns>
        public String SaveGenerateERP(String userName, String docNo, String docLineNoStr,
          String itemIdStr, Int64 outWareId, Int64 inWareId, String adjustQtyStr, String outLocationStr, String binLineNoStr, String TransferNO)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                 
                   new SqlParameter("@UserName",SqlDbType.VarChar,50),
                   new SqlParameter("@DocNo",SqlDbType.NVarChar,100),
                   new SqlParameter("@DocLineNoStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@ItemIDStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@TransOutWhStr",SqlDbType.BigInt),  
                   new SqlParameter("@StoreUOMQtyStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@CostUOMQtyStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@TransInWhStr",SqlDbType.BigInt),
                   new SqlParameter("@PriceUOMQtyStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@RCVCostQtyStr",SqlDbType.NVarChar,8000),    
                   new SqlParameter("@TransOutSUQtyStr",SqlDbType.NVarChar,8000),  
                   new SqlParameter("@BinLineNoStr",SqlDbType.NVarChar,8000), 
                   new SqlParameter("@OutLocationStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@TransferOrder",SqlDbType.NVarChar,50),
                   new SqlParameter("@TransferNO",SqlDbType.NVarChar,50)
            };
            parms[0].Value = userName;
            parms[1].Value = docNo;
            parms[2].Value = docLineNoStr;
            parms[3].Value = itemIdStr;
            parms[4].Value = outWareId;
            parms[5].Value = adjustQtyStr;
            parms[6].Value = adjustQtyStr;
            parms[7].Value = inWareId;
            parms[8].Value = adjustQtyStr;
            parms[9].Value = adjustQtyStr;
            parms[10].Value = adjustQtyStr;
            parms[11].Value = binLineNoStr;
            parms[12].Value = outLocationStr;                //调出货位字符串
            parms[13].Direction = ParameterDirection.Output; //返回调拨单号
            parms[14].Value = TransferNO;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "WH_TransferOrder", parms);
            return Convert.ToString(parms[13].Value);
        }

        /// <summary>
        /// 分页获取 TransferOut 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="transferOutCount">transferOut 总数。</param>
        /// <returns>TransferOut 列表。</returns>
        public List<TransferOutInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<TransferOutInfo> list = new List<TransferOutInfo>();
            TransferOutInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[dbo].[vwTransferOut]", "TransferId",
                "[TransferId], [TransferOrder], [ErpTransferOrder], [WareInHouse], [WareOutHouse], [CreateBy], [CreateDateTime],ItemName, SerialNumber", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TransferOutInfo();
                    entity.TransferId = rdr.GetInt32(0);
                    entity.TransferOrder = rdr.GetString(1);
                    entity.ErpTransferOrder = rdr.GetString(2);
                    entity.WareInHouse = rdr.GetString(3);
                    entity.WareOutHouse = rdr.GetString(4);
                    entity.CreateBy = rdr.GetString(5);
                    entity.CreateDateTime = rdr.GetDateTime(6);
                    entity.ItemName = rdr.GetString(7);
                    entity.SerialNumber=rdr.GetString(8);
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取调拨单号
        /// </summary>
        /// <returns></returns>
        public String GetransferOrder()
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@TransferOrder",SqlDbType.NVarChar,50)
            };
            parms[0].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetransferOrder", parms);
            return Convert.ToString(parms[0].Value);
        }

        /// <summary>
        /// 获取仓库档案信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<TransferOutInfo> GetWareHouseTransferOut(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<TransferOutInfo> list = new List<TransferOutInfo>();
            TransferOutInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Warehouse", "WarehouseId",
                "WarehouseId, CWhCode, CWhName, BWhPos", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TransferOutInfo();
                    entity.ID = rdr.GetInt32(0);
                    entity.WareHouseCode = rdr.GetString(1);
                    entity.WareHouseName = rdr.GetString(2);
                    string str = "";
                    bool IsBin = rdr.GetBoolean(3);
                    if (IsBin == true)
                    {
                        str = "是";
                    }
                    else {
                        str = "否";
                    }
                    entity.IsBinStr = str;
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取物料信息列表
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<TransferOutInfo> GetU9ItemList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<TransferOutInfo> list = new List<TransferOutInfo>();
            TransferOutInfo entity = null;

            if (searchSettings.ExtensionCondition != "")
            {
                searchSettings.ExtensionCondition += " AND Org='1001209125678707' ";
            }
            else {
                searchSettings.ExtensionCondition = " Org='1001209125678707' ";
            }

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "U9_CBO_ItemMaster", "ID",
                "[ID], [Code],[Name]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TransferOutInfo();
                    entity.ID = rdr.GetInt64(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.ItemName = rdr.GetString(2);
                    //entity.InventoryNumber = rdr.GetDecimal(3);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 根据仓库编码获取货位名称
        /// </summary>
        public List<TransferOutInfo> GetU9LocationList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<TransferOutInfo> list = new List<TransferOutInfo>();
            TransferOutInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[dbo].[U9_CBO_Bin]", "ID",
                "[ID] ,[Code],[Warehouse]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TransferOutInfo();
                    entity.ID = rdr.GetInt64(0);
                    entity.Code = rdr.GetString(1);
                    entity.WarehouseId = rdr.GetInt64(2);
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

        //add by liyanping 2016/1/20 根据产品ID、调出仓库、调出库位获取库存数量
        public Decimal GetStoreQty(Int64 txtItemID, Int64 hdnOutWareId, String txtOutLocation)
        {
            Decimal storeQty = 0;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ItemID",SqlDbType.BigInt),
                new SqlParameter("@OutWareId",SqlDbType.BigInt),
                new SqlParameter("@OutLocation",SqlDbType.NVarChar,50)
            };

            parms[0].Value = txtItemID;
            parms[1].Value = hdnOutWareId;
            parms[2].Value = txtOutLocation;

            object obj = SQLHelper.ExecuteScalarStoredProcedure(SQLHelper.MESConnString, "uspGetStoreQty", parms);
            if (obj != null)
            {
                storeQty = Convert.ToDecimal(obj);
            }

            return storeQty;
        }

        //add by liyanping 2016/1/21 根据产品编码获取产品ID和Name
        public List<TransferOutInfo> GetItemInfo(String txtItemCode)
        {
            List<TransferOutInfo> list = new List<TransferOutInfo>();
            TransferOutInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@ItemCode",SqlDbType.VarChar,50),
            };
            parms[0].Value = txtItemCode;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetItemInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new TransferOutInfo();
                    entity.ItemID = rdr.GetInt64(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.ItemName = rdr.GetString(2);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;  
        }

        //add by liyanping 2016/1/27 验证输入的货位编码是否准确并带出仓库ID和Name等信息
        public List<TransferOutInfo> GetWarehouseInfo(String warehouseCode)
        {
            List<TransferOutInfo> list = new List<TransferOutInfo>();
            TransferOutInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@WarehouseCode",SqlDbType.VarChar,50),
            };
            parms[0].Value = warehouseCode;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetWarehouseInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new TransferOutInfo();
                    entity.ID = rdr.GetInt64(0);
                    entity.WareHouseCode = rdr.GetString(1);
                    entity.WareHouseName = rdr.GetString(2);
                    string str = "";
                    bool IsBin = rdr.GetBoolean(3);
                    if (IsBin == true)
                    {
                        str = "是";
                    }
                    else
                    {
                        str = "否";
                    }
                    entity.IsBinStr = str;
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
    }
}
