using SKT.LeanMES.Transfers.Model;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Web.Script.Serialization;

namespace SKT.LeanMES.Transfers.BLL
{

    /// <summary>
    /// 调拨单实例类 add by zhi.li 2018-06-08
    /// </summary>
    [Serializable]
    public class Transfers
    {

        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） TransfersInfo 信息。
        /// </summary>
        /// <param name="entity">Transfers 实体对象。</param>
        public Int32 Edit(TransfersInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TransfersId", SqlDbType.Int),
                new SqlParameter("@TransfersNo", SqlDbType.NVarChar, 50),
                new SqlParameter("@TransfersType", SqlDbType.Int),
                new SqlParameter("@SourceNo", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@VendorId", SqlDbType.Int),
                new SqlParameter("@DepCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@ArrivalDate", SqlDbType.DateTime),
                new SqlParameter("@SaleType", SqlDbType.Int),
                new SqlParameter("@InWhouse", SqlDbType.NVarChar, 50),
                new SqlParameter("@OutWhouse", SqlDbType.NVarChar, 50)
        };



            parms[0].Value = entity.TransfersId;
            parms[1].Value = entity.TransfersNo;
            parms[2].Value = entity.TransfersType;
            parms[3].Value = entity.SourceNo;
            parms[4].Value = entity.Remark;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.VendorId;
            parms[7].Value = entity.DepCode;
            parms[8].Value = entity.ArrivalDate;
            parms[9].Value = entity.SaleType;
            parms[9].Value = entity.InWhouse;
            parms[9].Value = entity.OutWhouse;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Transfers_Edit", parms);

            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 根据 TransfersId 获取实体信息。
        /// </summary>
        /// <param name="TransfersId">TransfersId。</param>
        /// <returns>Transfers 实体对象。</returns>
        public TransfersInfo GetInfo(Int32 TransfersId)
        {
            TransfersInfo entity = null;

            System.Data.SqlClient.SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = TransfersId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_Transfers_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new TransfersInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetString(9), rdr.GetString(10),
                        rdr.GetDateTime(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetDateTime(14), rdr.GetInt32(15), rdr.GetDateTime(16),
                        rdr.GetInt32(17), rdr.GetDateTime(18), rdr.GetString(19), rdr.GetString(20), rdr.GetString(21), rdr.GetDateTime(22));
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// 分页获取 Transfers 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="partsCount">parts 总数。</param>
        /// <returns>Parts 列表。</returns>
        public List<TransfersInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<TransfersInfo> list = new List<TransfersInfo>();
            TransfersInfo entity = null;
            sortExpression += "CreateDateTime DESC";
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwTransfersStorageSel", "TransfersId",
                "[TransfersTypeName],[TransfersNo], [SourceNo],[InWhouseName],[OutWhouseName],[BWhPos]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TransfersInfo();
                    entity.TransfersNo = Convert.ToString(rdr["TransfersNo"]);
                    entity.TransfersTypeName = Convert.ToString(rdr["TransfersTypeName"]);
                    entity.SourceNo = Convert.ToString(rdr["SourceNo"]);
                    entity.InWhouseName = Convert.ToString(rdr["InWhouseName"]);
                    entity.OutWhouseName = Convert.ToString(rdr["OutWhouseName"]);

                    if (Convert.ToString(rdr["BWhPos"]) == "True")
                    {
                        entity.IsBin = "是";
                    }
                    else
                    {
                        entity.IsBin = "否";
                    }

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 导出EXCEL获取数据的方法
        /// </summary>
        /// <param name="strWhere">查询条件</param>
        /// <returns></returns>
        public DataTable ImportToExcel(Int32 outOrIn, String beginDateTime, String endDateTime)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OutOrIn", SqlDbType.Int),
                new SqlParameter("@BeginCreateTime", SqlDbType.NVarChar),
                new SqlParameter("@EndCreateTime", SqlDbType.NVarChar)
            };
            parms[0].Value = outOrIn;
            parms[1].Value = beginDateTime;
            parms[2].Value = endDateTime;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Prod_TransfersImportToExcel", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        /// <summary>
        /// 获取调拨单列表(PDA)
        /// </summary>
        /// <returns></returns>
        public IList<TransfersInfo> GetTransfesOrderList()
        {
            string sql = "SELECT TransfersId,[TransfersTypeName],[TransfersNo], [SourceNo],[InWhouseName],[OutWhouseName],[BWhPos] FROM vwTransfersStorageSel";
            return ComMethod.GetListBySql<TransfersInfo>(sql, null);
        }

        /// <summary>
        /// 获取调拨单列表(PDA-出库)
        /// </summary>
        /// <returns></returns>
        public IList<TransfersInfo> GetTransfesOrderList(string value, int type)
        {
            SearchSettings searchSettings = new SearchSettings();
            value = value.Replace("'", string.Empty);
            string where = string.Empty;
            if (type == 0)
            {
                where = $"TransfersNo = '{value}'";
            }
            else
            {
                if (!string.IsNullOrEmpty(value))
                {
                    where = string.Format(" TransfersNo like '%{0}%'", value);
                }
            }
            if (!string.IsNullOrEmpty(where))
            {
                searchSettings.ExtensionCondition = where;
            }

            //表名或者视图
            string strTb = "vwTransfersStorageSel";
            //主键
            string strKey = "TransfersId";
            //查询栏位字串
            string strColumns = @"TransfersId,[TransfersTypeName],[TransfersNo], [SourceNo],[InWhouseName],[OutWhouseName],[BWhPos]";
            return ComMethod.GetComList<TransfersInfo>(ref recordCount, 0, 20, strTb, strKey, strColumns, "", searchSettings);
        }

        /// <summary>
        /// 获取调拨单列表(PDA-入库)
        /// </summary>
        /// <returns></returns>
        public IList<TransfersInfo> GetTransfesOrderInList(string value, int type)
        {
            SearchSettings searchSettings = new SearchSettings();
            value = value.Replace("'", string.Empty);
            string where = string.Empty;
            if (type == 0)
            {
                where = $"TransfersNo = '{value}'";
            }
            else
            {
                if (!string.IsNullOrEmpty(value))
                {
                    where = string.Format(" TransfersNo like '%{0}%'", value);
                }
            }
            if (!string.IsNullOrEmpty(where))
            {
                searchSettings.ExtensionCondition = where;
            }

            //表名或者视图
            string strTb = "vwTransfersInSel";
            //主键
            string strKey = "TransfersId";
            //查询栏位字串
            string strColumns = @"TransfersId,[TransfersTypeName],[TransfersNo], [SourceNo],[InWhouseName],[OutWhouseName],[BWhPos]";
            return ComMethod.GetComList<TransfersInfo>(ref recordCount, 0, 20, strTb, strKey, strColumns, "", searchSettings);
        }

        /// <summary>
        ///检查并获取GRN信息(PDA有单调拨)
        /// </summary>
        public string CheckGrnTransfer(int transfersId, int transfersDtlId, string grn,string GrnStrNew)
        {
            List<TransfersInfo> list = new List<TransfersInfo>();
            TransfersInfo entity = null;
            string strJson = "";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TransfersId", SqlDbType.Int),
                new SqlParameter("@TransfersDtlId", SqlDbType.Int),
                new SqlParameter("@Grn", SqlDbType.NVarChar,100),
                new SqlParameter("@GrnStrNew", SqlDbType.NVarChar,4000)
            };
            parms[0].Value = transfersId;
            parms[1].Value = transfersDtlId;
            parms[2].Value = grn;
            parms[3].Value = GrnStrNew;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckGrnCanTransfer", parms))
            {
                while (rdr.Read())
                {
                    entity = new TransfersInfo();
                    entity.SerialNumber = rdr["SerialNumber"].ToString();
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    entity.CBarCode = rdr["CBarCode"].ToString();
                    entity.BalanceQty = rdr["BalanceQty"].ToString();
                    entity.Flage = Convert.ToInt32(rdr["Flage"]);

                    list.Add(entity);
                }
                rdr.Close();
            }
            strJson = (new JavaScriptSerializer()).Serialize(list);
            return strJson;
        }

        public string CheckSNTransfer(int transfersId, string grn)
        {
            List<TransfersInfo> list = new List<TransfersInfo>();
            TransfersInfo transfersInfo = null;
            string text = "";
            SqlParameter[] array = new SqlParameter[2]
            {
                new SqlParameter("@TransfersId", SqlDbType.Int),
                new SqlParameter("@Grn", SqlDbType.NVarChar, 100)
            };
            array[0].Value = transfersId;
            array[1].Value = grn;
            using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckSNCanTransfer", array))
            {
                if (sqlDataReader.Read())
                {
                    transfersInfo = new TransfersInfo();
                    transfersInfo.SerialNumber = sqlDataReader["SerialNumber"].ToString();
                    transfersInfo.ItemCode = sqlDataReader["ItemCode"].ToString();
                    transfersInfo.CBarCode = sqlDataReader["CBarCode"].ToString();
                    transfersInfo.BalanceQty = sqlDataReader["BalanceQty"].ToString();
                    list.Add(transfersInfo);
                }

                sqlDataReader.Close();
            }

            return new JavaScriptSerializer().Serialize(list);
        }


        /// <summary>
        /// 确认调拨（PDA调拨出库）
        /// </summary>
        public void SaveTransfer(int transfersId, string grns, string userName, string inWhouseName, string outWhouseName, string inBarCode, string transfersNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TransfersId", SqlDbType.Int),
                new SqlParameter("@GrnStr", SqlDbType.NVarChar,-1),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar,50),
                new SqlParameter("@InWhouseName", SqlDbType.NVarChar,50),
                new SqlParameter("@OutWhouseName", SqlDbType.NVarChar,50),
                new SqlParameter("@InBarCode", SqlDbType.NVarChar,50),
                new SqlParameter("@TransfersNo", SqlDbType.NVarChar,50)
            };
            parms[0].Value = transfersId;
            parms[1].Value = grns;
            parms[2].Value = userName;
            parms[3].Value = inWhouseName;
            parms[4].Value = outWhouseName;
            parms[5].Value = inBarCode;
            parms[6].Value = transfersNo;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveTransfer", parms);

        }

        public string SaveTransferSN(int transfersId, string grns, string Deletegrns, string userName, string inWhouseName, string outWhouseName, string inBarCode, string transfersNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TransfersId", SqlDbType.Int),
                new SqlParameter("@GrnStr", SqlDbType.NVarChar,-1),
                new SqlParameter("@DeleteGrnStr", SqlDbType.NVarChar,-1),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar,50),
                new SqlParameter("@InWhouseName", SqlDbType.NVarChar,50),
                new SqlParameter("@OutWhouseName", SqlDbType.NVarChar,50),
                new SqlParameter("@InBarCode", SqlDbType.NVarChar,50),
                new SqlParameter("@TransfersNo", SqlDbType.NVarChar,50)
            };
            parms[0].Value = transfersId;
            parms[1].Value = grns;
            parms[2].Value = Deletegrns;
            parms[3].Value = userName;
            parms[4].Value = inWhouseName;
            parms[5].Value = outWhouseName;
            parms[6].Value = inBarCode;
            parms[7].Value = transfersNo;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveTransferSN", parms);

            return "";
        }


        /// <summary>
        /// 获取仓库档案信息(PDA无单调拨出库)
        /// </summary>
        /// <returns></returns>
        public IList<TransfersInfo> GetWareHouseList()
        {
            string sql = "SELECT WarehouseId,[CWhCode],[CWhName], [BWhPos] FROM Basal_Warehouse";
            return ComMethod.GetListBySql<TransfersInfo>(sql, null);
        }

    }
}
