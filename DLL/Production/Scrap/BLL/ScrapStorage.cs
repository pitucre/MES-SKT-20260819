using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Scrap.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Scrap.BLL
{
    public class ScrapStorage
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 根据 ScrapId 获取信息。
        /// </summary>
        /// <param name="scrapId">ScrapId。</param>
        /// <returns>Scrap 实体对象。</returns>
        public string GetScrapStorageById(Int32 scrapId,String scrapDateTime, String cName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ScrapId", SqlDbType.NVarChar, 50),
                  new SqlParameter("@ScrapDateTime", SqlDbType.NVarChar, 50),
                  new SqlParameter("@CName", SqlDbType.NVarChar, 50),
            };

            parms[0].Value = scrapId;
            parms[1].Value = scrapDateTime;
            parms[2].Value = cName;

            return ComMethod.GetList("upsGetScrapStorageById", parms);
        }


        /// <summary>
        /// 确认接收
        /// </summary>
        /// <param name="scrapId">ScrapId。</param>
        /// <returns>Scrap 实体对象。</returns>
        public string ScrapOutListReceive(string scrapId, Int32 userId)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ScrapId", SqlDbType.NVarChar, 200),
                   new SqlParameter("@userId", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = scrapId;
            parms[1].Value = userId;

            return ComMethod.GetList("upsScrapOutListReceive", parms);
        }

        /// <summary>
        /// 分页获取 Scrap 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="partsCount">parts 总数。</param>
        /// <returns>Parts 列表。</returns>
        public List<ScrapStorageInfo> GetAllScrapStorageList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ScrapStorageInfo> list = new List<ScrapStorageInfo>();

            ScrapStorageInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwScrapStorageList", "ScrapId",
                @"[ScrapId],[ScrapNo],[CreateBy],[CreateDateTime],[ScrapDateTime],[ItemCode],[ItemName]
                ,[CName],[ErpCode],[ScrapQty],[ReceiveUser],[ReceiveData],[WhName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ScrapStorageInfo();
                    entity.ScrapId = Convert.ToInt32(rdr["ScrapId"]);
                    entity.ScrapNo = Convert.ToString(rdr["ScrapNo"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]);
                    entity.ScrapDateTime = Convert.ToDateTime(rdr["ScrapDateTime"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.CName = Convert.ToString(rdr["CName"]);
                    entity.ErpCode = Convert.ToString(rdr["ErpCode"]);
                    entity.ScrapQty = Convert.ToDecimal(rdr["ScrapQty"]);
                    entity.ReceiveUser = Convert.ToString(rdr["ReceiveUser"]);
                    entity.ReceiveData =Convert.ToDateTime(rdr["ReceiveData"]);
                    entity.WhName = Convert.ToString(rdr["WhName"]);

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
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Prod_ScrapImportToExcel", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        /// <summary>
        /// 报废单打印
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        public byte[] GetScrapPdfByte(int intId,  string strXmlFilePath, string strImgPath)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ScrapId",SqlDbType.Int)
            };
            parms[0].Value = intId;
      
            DataSet ds = ComMethod.GetListDataSet("upsGetScrapPrint", parms, "dtScrapForm");

            //PDF产生
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }

    }
}
