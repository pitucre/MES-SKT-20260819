using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Scrap.Model;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Scrap.BLL
{
    /// <summary>
    /// add by zhi.li 2018702
    /// 用于物料报废
    /// </summary>
    public class ScrapNoBillOut
    {

        private Int32 recordCount = 0;

        /// <summary>
        /// 通过物料条码把物料的信息显示出来
        ///  luwenyuan2016-02-25
        /// </summary>
        /// <param name="ScrapId"></param>
        /// <returns></returns>
        public List<ScrapNoBillOutInfo> ShowScrapNoBillOutInfo(string SN)
        {
            List<ScrapNoBillOutInfo> list = new List<ScrapNoBillOutInfo>();
            ScrapNoBillOutInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
            };
            parms[0].Value = SN;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspScrapNoBillOutMaterialUnit", parms))
            {
                for (int i = 0; i < dt.Rows.Count;i++ )
                {
                    entity = new ScrapNoBillOutInfo();                   
                    entity.ItemCode = dt.Rows[i]["itemcode"].ToString();//物料编码
                    entity.ItemName = dt.Rows[i]["itemname"].ToString();//物料名称
                    entity.ApplyNumber = Convert.ToDecimal(dt.Rows[i]["quantity"].ToString());//总数量
                    entity.AdjustNumber = Convert.ToDecimal(dt.Rows[i]["balanceqty"].ToString());//可用数量 
                    entity.Code = dt.Rows[i]["cBarCode"].ToString();//存位
                    entity.WareHouseName = dt.Rows[i]["CWhName"].ToString();//仓库
                    entity.WarehouseId= Convert.ToInt64(dt.Rows[i]["WarehouseId"].ToString());//仓别ID
                    entity.ItemID = Convert.ToInt64(dt.Rows[i]["PartId"].ToString());//仓别ID
                    entity.SerialNumber = dt.Rows[i]["SerialNumber"].ToString();//物料条码
                    list.Add(entity);
                }
            }
            return list;
        }

        /// <summary>
        /// 保存无单报废信息 
        /// </summary>
        public void SaveScrapNoBillOut(string strjson)
        {
            ComMethod.Edit(strjson, "uspSaveScrapNoBillOut");
        }

        /// <summary>
        /// 生成ERP报废
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
            parms[13].Direction = ParameterDirection.Output; //返回报废单号
            parms[14].Value = TransferNO;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "WH_TransferOrder", parms);
            return Convert.ToString(parms[13].Value);

        }

        /// <summary>
        /// 分页获取 ScrapNoBillOut 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="scrapNoBillOutCount">scrapNoBillOutCount 总数。</param>
        /// <returns>ScrapNoBillOut 列表。</returns>
        public List<ScrapNoBillOutInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ScrapNoBillOutInfo> list = new List<ScrapNoBillOutInfo>();
            ScrapNoBillOutInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[dbo].[vwScrapNoBillOut]", "ScrapId",
                "[ScrapId], [ScrapOrder], [ErpScrapOrder], [WareHouse], [CreateBy], [CreateDateTime],ItemName, SerialNumber,StatueName", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ScrapNoBillOutInfo();
                    entity.ScrapId = rdr.GetInt32(0);
                    entity.ScrapOrder = rdr.GetString(1);
                    entity.ErpScrapOrder = rdr.GetString(2);
                    entity.WareHouse = rdr.GetString(3);
                    entity.CreateBy = rdr.GetString(4);
                    entity.CreateDateTime = rdr.GetDateTime(5);
                    entity.ItemName = rdr.GetString(6);
                    entity.SerialNumber=rdr.GetString(7);
                    entity.StatueName = rdr.GetString(8);
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

      
    }
}
