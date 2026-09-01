using Dapper;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.ERP;
using SKT.LeanMES.Scrap.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;



namespace SKT.LeanMES.Scrap.BLL
{
    public class Scraps
    {

        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新）
        /// </summary>
        /// <param name="strJson"></param>
        public void ScrapApplyEdit(string strJson)
        {
            ComMethod.Edit<ScrapInfo>(strJson, "Prod_Scrap_Edit");
        }

        /// <summary>
        /// 根据 ScrapId 字符串删除 Scrap 信息
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void ScrapApplyDelete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Prod_Scrap_Delete");
        }

        /// <summary>
        /// 根据 ScrapId 获取信息。
        /// </summary>
        /// <param name="scrapId">ScrapId。</param>
        /// <returns>Scrap 实体对象。</returns>
        public string GetScrapInfoById(Int32 scrapId)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50)
            };

            parms[0].ParameterName = "@ScrapId";
            parms[0].Value = scrapId;
        
            return ComMethod.GetList("upsGetScrapById", parms);
        }


        /// <summary>
        /// 根据scrapNo获取物料信息。
        /// </summary>
        /// <param name="scrapNo">scrapNo。</param>
        /// <returns>Scrap 实体对象。</returns>
        public string GetScrapItemByNo(string  scrapNo)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ScrapNo", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = scrapNo;

            return ComMethod.GetList("uspGetScrapItemByNo", parms);
        }


        /// <summary>
        /// 根据报废单明细ID获取物料信息。
        /// </summary>
        /// <param name="scrapDtlId">scrapNo。</param>
        /// <returns>Scrap 实体对象。</returns>
        public string GetScrapGRN(Int32 scrapDtlId)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@scrapDtlId", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = scrapDtlId;

            return ComMethod.GetList("uspGetScrapGRN", parms);
        }

        /// <summary>
        /// 检验扫描GRN信息是否正确
        /// </summary>
        /// <param name="scrapId"></param>
        /// <param name="grn"></param>
        /// <param name="grnStr"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public string CheckScrapGrnPosCode(Int32 scrapId, String grn,String grnStr, String userName)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@scrapId", SqlDbType.NVarChar, 50),
                  new SqlParameter("@Grn", SqlDbType.NVarChar, 50),
                    new SqlParameter("@GrnStr", SqlDbType.NVarChar, 50),
                      new SqlParameter("@UserName", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = scrapId;
            parms[1].Value = grn;
            parms[2].Value = grnStr;
            parms[3].Value = userName;

            return ComMethod.GetList("uspCheckScrapGrnPosCode", parms);
        }

        /// <summary>
        /// 扫描GRN获取已扫描的物料信息
        /// </summary>
        /// <param name="scrapDtlId"></param>
        /// <param name="grn"></param>
        /// <returns></returns>
        public string GetScrapPosCodeByGrn(String grn)
        {

            SqlParameter[] parms = new SqlParameter[]{
                //new SqlParameter("@scrapDtlId", SqlDbType.NVarChar, 50),
                  new SqlParameter("@Grn", SqlDbType.NVarChar, 50)
            };
            //parms[0].Value = scrapDtlId;
            parms[0].Value = grn;
            return ComMethod.GetList("upsGetScrapPosCodeByGrn", parms);
        }

        /// <summary>
        /// 审核报废申请
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userId"></param>
        public void ScrapApplyAuditing(String idString, String userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
               new SqlParameter("@ScrapId", SqlDbType.NVarChar, 50),
               new SqlParameter("@UserId", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = idString;
            parms[1].Value = userId;

            ComMethod.Edit("upsScrapApplyAudi", parms);

        }

        /// <summary>
        /// 结束报废申请
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userId"></param>
        public void ScrapApplyEnd(String idString, String userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
               new SqlParameter("@ScrapId", SqlDbType.NVarChar, 50),
               new SqlParameter("@UserId", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = idString;
            parms[1].Value = userId;

            ComMethod.Edit("upsScrapApplyEnd", parms);

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
        public List<ScrapInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ScrapInfo> list = new List<ScrapInfo>();
               
            ScrapInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwScrapApply", "ScrapId",
                @"[ScrapId],[ScrapNo],[DepartName],[WhName],[StatueName],[StatueName],[CreateDateTime],[EName],[AuditingName]
                ,[AuditingStatue],[Remark],[EndUserName],[EndDate],[CreateBy],ModifyBy,ModifyDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ScrapInfo();
                    entity.ScrapId = Convert.ToInt32(rdr["ScrapId"]);
                    entity.ScrapNo = Convert.ToString(rdr["ScrapNo"]);
                    entity.DepartName = Convert.ToString(rdr["DepartName"]);
                    entity.WhName = Convert.ToString(rdr["WhName"]);
                    entity.StatueName = Convert.ToString(rdr["StatueName"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]);
                    entity.EName = Convert.ToString(rdr["EName"]);
                    entity.AuditingName = Convert.ToString(rdr["AuditingName"]);
                    entity.AuditingStatue = Convert.ToString(rdr["AuditingStatue"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.EndUserName = Convert.ToString(rdr["EndUserName"]);
                    entity.EndDate1 = (Convert.ToDateTime(rdr["EndDate"]).ToString("yyyy-MM-dd")== "9999-12-31" ||
                        Convert.ToDateTime(rdr["EndDate"]).ToString("yyyy-MM-dd")== "1900-01-01") ? "": Convert.ToDateTime(rdr["EndDate"]).ToString("yyyy-MM-dd HH:MM:sss");
                    entity.CreateBy= Convert.ToString(rdr["CreateBy"]);

                    entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr["ModifyDateTime"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 分页获取 Scrap 资料。报废出库选择的报废单
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="partsCount">parts 总数。</param>
        /// <returns>Parts 列表。</returns>
        public List<ScrapInfo> GetAllScanOut(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ScrapInfo> list = new List<ScrapInfo>();

            ScrapInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwScrapOut", "ScrapId",
                @"[ScrapId],[ScrapNo],[WhName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ScrapInfo();
                    entity.ScrapId = Convert.ToInt32(rdr["ScrapId"]);
                    entity.ScrapNo = Convert.ToString(rdr["ScrapNo"]);
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


        /// <summary>
        /// 报废出库-保存
        /// </summary>
        /// <param name="strJson"></param>
        public void SaveScrap(string strJson)
        {
            //ComMethod.Edit<ScrapInfo>(strJson, "InterfaceScrap");
            ScrapInfo entity = (new JavaScriptSerializer()).Deserialize<ScrapInfo>(strJson);
            var msg = string.Empty;
            string erpNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.ScrapStorage;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            //List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();

            DataTable Grndt = ComMethod.ToDataTable(entity.GrnList);
            DataTable whDt = ComMethod.ToDataTable(entity.WhList);

            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@ScrapId", entity.ScrapId);
                    dp.Add("@UserName", entity.UserName);
                    dp.Add("@EmployeeCName", entity.EmployeeCName);
                    if (Grndt != null && Grndt.Rows.Count > 0)
                    {
                        dp.Add("@GrnList", Grndt.AsTableValuedParameter("dbo.ScrapGrnDtl"));
                    }
                    else
                    {
                        dp.Add("@GrnList", DBNull.Value);
                    }
                    if (whDt != null && whDt.Rows.Count > 0)
                    {
                        dp.Add("@WhList", whDt.AsTableValuedParameter("dbo.ScrapItemDtl"));
                    }

                    reader = conn.ExecuteReader("InterfaceScrap", dp, tran, null, CommandType.StoredProcedure);

                    dtWrite.Load(reader);

                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                    //是否需要回写
                    //isWriteBack = WriteBackERP.IsWriteBack(em);
                    //if (isWriteBack)
                    //{
                    //    if (dtWrite != null || dtWrite.Rows.Count > 0)
                    //    {
                    //        var returnOrderNo = Convert.ToString(dtWrite.Rows[0]["billCode"]);

                    //        //调用接口
                    //        var info = WriteBackERP.HttpPostU9Api<CreateSaleRcvResponse>(em, dtWrite, returnOrderNo, entity.ModifyBy, dtEnterTime, dtAfterExecProcTime);

                    //        if (info.ResCode != 0 || !info.Data[0].IsSucess)
                    //        {
                    //            //回写失败
                    //            throw new Exception(info.ResMsg ?? info.Data[0].ErrorMsg);
                    //        }
                    //        //更新ERP单据号
                    //        var obj = new { ERPNo = info.Data[0].Code, ScrapNo = returnOrderNo };
                    //        int i = conn.Execute(@"UPDATE a SET ErpCode = @ERPNo FROM dbo.Prod_ScrapStorage a INNER JOIN dbo.Prod_Scrap b ON a.ScrapId = b.ScrapId WHERE b.ScrapNo = @ScrapNo", obj, tran);
                    //    }
                    //}

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
                    //foreach (var log in logList)
                    //{
                    //    WriteBackERP.AddWriteBackLog(conn, log);
                    //}
                    conn.Close();
                }
            }

        }



        /// <summary>
        /// 获取报废单列表(PDA)
        /// </summary>
        /// <returns></returns>
        public IList<ScrapInfo> GetScrapOrderList()
        {
            string sql = "SELECT [ScrapId],[ScrapNo],[WhName] FROM vwScrapOut";
            return ComMethod.GetListBySql<ScrapInfo>(sql, null);
        }

        /// <summary>
        ///检查并获取GRN信息(PDA有单报废)
        /// </summary>
        public string CheckGrnScrap(int scrapId, string grn)
        {
            List<ScrapInfo> list = new List<ScrapInfo>();
            ScrapInfo entity = null;
            string strJson = "";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ScrapId", SqlDbType.Int),
                new SqlParameter("@Grn", SqlDbType.NVarChar,100)
            };
            parms[0].Value = scrapId;
            parms[1].Value = grn;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckGrnCanScrap", parms))
            {
                if (rdr.Read())
                {
                    entity = new ScrapInfo();
                    entity.SerialNumber = rdr["SerialNumber"].ToString();
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    entity.CBarCode = rdr["CBarCode"].ToString();
                    entity.BalanceQty = rdr["BalanceQty"].ToString();

                    list.Add(entity);
                }
                rdr.Close();
            }
            strJson = (new JavaScriptSerializer()).Serialize(list);
            return strJson;
        }

        /// <summary>
        /// 确认报废（PDA报废出库）
        /// </summary>
        public void SaveScrapOut(int scrapId, string grns, string userName, string scrapNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ScrapId", SqlDbType.Int),
                new SqlParameter("@GrnStr", SqlDbType.NVarChar,-1),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar,50),
                new SqlParameter("@ScrapNo", SqlDbType.NVarChar,50)
            };
            parms[0].Value = scrapId;
            parms[1].Value = grns;
            parms[2].Value = userName;
            parms[3].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveScrapOut", parms);

        }

    }
}
