using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Report.Model;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;
using System.Xml.Linq;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Report.BLL
{
   public class Report
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 根据 TEMPLATEId 获取实体信息。
        /// </summary>
        /// <param name="tEMPLATEId">TEMPLATEId。</param>
        /// <returns>TEMPLATE 实体对象。</returns>
        public ReportInfo GetInfo(Int32 templateID)
        {
            ReportInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TemplateID", SqlDbType.Int)
            };

            parms[0].Value = templateID;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "REPORT_TEMPLATE_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ReportInfo();
                    entity.TemplateId = rdr.GetInt32(0);
                    entity.TemplateName = rdr.GetString(1);
                    entity.ReportCNName = rdr.GetString(2);
                    entity.ReportENName = rdr.GetString(3);
                    entity.RTDescription = rdr.GetString(4);
                    entity.TemplateContent = SKT.Common.Utility.EncryptHelper.Decrypt(rdr.GetString(5));
                    entity.ReportType = rdr.GetString(6);
                    entity.RTModuleCNValue = rdr.GetString(7);
                    entity.RTModuleENValue = rdr.GetString(8);
                    entity.ReportIcon = rdr.GetString(9);
                    entity.ReportUrl = rdr.GetString(10);
                    entity.ReportSequence = rdr.GetInt32(11);
                    entity.CreateBy = rdr.GetString(12);
                    entity.CreateDateTime = rdr.GetDateTime(13);
                    entity.ModifyBy = rdr.GetString(14);
                    entity.ModifyDateTime = rdr.GetDateTime(15);
                    entity.DesignJson = rdr["DesignJSON"].ToString();
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// 根据用户id,subSystem获取相关数据
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="subSystemName"></param>
        /// <param name="cultureType"></param>
        /// <returns></returns>
        public List<ReportInfo> GetModuleResources(int userId, string subSystemName, string cultureType)
        {
            List<ReportInfo> list = new List<ReportInfo>();
            ReportInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@SubSystemName",SqlDbType.VarChar,100),
                new SqlParameter("@CultureType",SqlDbType.VarChar,20)
            };

            parms[0].Value = userId;
            parms[1].Value = subSystemName;
            parms[2].Value = cultureType;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "uspGetModuleResources", parms))
            {
                while (rdr.Read())
                {
                    entity = new ReportInfo();
                    entity.RTModuleName = rdr.GetString(0);
                    entity.RTModuleCNValue = rdr.GetString(1);
                    entity.RTResourcesType = rdr.GetInt32(2);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 分页获取 TEMPLATE 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="tEMPLATECount">tEMPLATE 总数。</param>
        /// <returns>TEMPLATE 列表。</returns>
        public List<ReportInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ReportInfo> list = new List<ReportInfo>();
            ReportInfo entity = null;
            searchSettings.AddCondition("IsKanban", "0");
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwReportMember", "TemplateId",
                "[TemplateId], [TemplateName],[ReportCNName], [ReportENName], [TemplateDesc], [ReportType],[ReportTypeCNName],[ReportTypeENName], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime],[TemplateCategoryStr],[TemplateCategory]"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ReportInfo();
                    entity.TemplateId = rdr.GetInt32(0);
                    entity.TemplateName = rdr.GetString(1);
                    entity.ReportCNName = rdr.GetString(2);
                    entity.ReportENName = rdr.GetString(3);
                    entity.RTDescription = rdr.GetString(4);
                    entity.ReportType = rdr.GetString(5);
                    entity.RTModuleCNValue = rdr.GetString(6);
                    entity.RTModuleENValue = rdr.GetString(7);
                    entity.CreateBy = rdr.GetString(8);
                    entity.CreateDateTime = rdr.GetDateTime(9);
                    entity.ModifyBy = rdr.GetString(10);
                    entity.ModifyDateTime = rdr.GetDateTime(11);
                    entity.TemplateCategoryStr= rdr.GetString(12);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 根据 TEMPLATEId 字符串删除 TEMPLATE 信息。
        /// </summary>
        /// <param name="idString">TEMPLATEId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "REPORT_TEMPLATE_Delete", parms);
        }

        /// <summary>
        /// 查询数据
        /// </summary>
        /// <param name="reportTypeId"></param>
        /// <returns></returns>
        public ReportInfo GetReportTypeInfo(string reportTypeId)
        {
            ReportInfo reportInfo = new ReportInfo();

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ReportTypeId",SqlDbType.VarChar,100)
            };

            parms[0].Value = reportTypeId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Report_GetReportTypeInfo", parms))
            {
                if (rdr.Read())
                {
                    reportInfo.RTModuleCNValue = rdr.GetString(0);
                    reportInfo.RTModuleENValue = rdr.GetString(1);
                    reportInfo.RTDescription = rdr.GetInt32(2).ToString();
                }
                rdr.Close();
            }
            return reportInfo;
        }
        /// <summary>
        /// 删除报表类型
        /// </summary>
        /// <param name="reportTypeId"></param>
        /// <param name="username"></param>
        public void DeleteReportType(string reportTypeId, string username)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ReportTypeId",SqlDbType.VarChar,100),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = reportTypeId;
            parms[1].Value = username;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Report_ReportTypeDelete", parms);
        }
        /// <summary>
        ///查看报表类型
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ReportInfo> GetReportType(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ReportInfo> list = new List<ReportInfo>();
            ReportInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwReportModules", "Popedom",
                "[Name], [ReportCNValues], [ReportENValues], [Popedom],ModifyBy,ModifyDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ReportInfo();

                    entity.RTModuleName = rdr.GetString(0);
                    entity.RTModuleCNValue = rdr.GetString(1);
                    entity.RTModuleENValue = rdr.GetString(2);
                    entity.RTDescription = rdr.GetInt32(3).ToString();
                    entity.ModifyBy = rdr.GetString(4);
                    entity.ModifyDateTime = rdr.GetDateTime(5);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 编辑（添加或更新） TEMPLATE 信息。
        /// </summary>
        /// <param name="entity">TEMPLATE 实体对象。</param>
        /// <summary>
        /// 编辑（添加或更新） TEMPLATE 信息。
        /// </summary>
        /// <param name="entity">TEMPLATE 实体对象。</param>
        public Int32 Edit(ReportInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ReportId", SqlDbType.Int),
                new SqlParameter("@ReportName", SqlDbType.NVarChar, 100),
                new SqlParameter("@ReportCNName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ReportENName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ReportIcon", SqlDbType.NVarChar, 50),
                new SqlParameter("@ReportSequence", SqlDbType.Int),
                new SqlParameter("@ReportType", SqlDbType.NVarChar, 50),
                new SqlParameter("@ReportDes", SqlDbType.NVarChar, 50),
                new SqlParameter("@ReportContent", SqlDbType.NText),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@DesignJSON", SqlDbType.NVarChar, 20000),
                 new SqlParameter("@TemplateCategory", SqlDbType.Int),
            };
            
            parms[0].Value = entity.TemplateId;
            parms[1].Value = entity.TemplateName;
            parms[2].Value = entity.ReportCNName;
            parms[3].Value = entity.ReportENName;
            parms[4].Value = entity.ReportIcon;
            parms[5].Value = entity.ReportSequence;
            parms[6].Value = entity.ReportType;
            parms[7].Value = entity.TemplateDesc;
            parms[8].Value = SKT.Common.Utility.EncryptHelper.Encrypt(entity.TemplateContent);
            parms[9].Value = entity.CreateBy;
            parms[10].Value = entity.ModifyBy;
            parms[11].Value = entity.DesignJson??"";
            parms[12].Value = entity.TemplateCategory;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Report_Template_Edit", parms);

            return (Int32)parms[0].Value;
        }
        /// <summary>
        ///保存报表类型
        /// </summary>
        /// <param name="reportTypeName"></param>
        /// <param name="reportTypeNameEN"></param>
        /// <param name="seq"></param>
        /// <param name="reportTypeId"></param>
        /// <param name="userName"></param>
        public void EditReportType(string reportTypeName, string reportTypeNameEN, float seq, string reportTypeId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ReportTypeName",SqlDbType.VarChar,100),
                new SqlParameter("@ReportTypeReName",SqlDbType.NVarChar,100),
                new SqlParameter("@Seq",SqlDbType.Float),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@ReportTypeId",SqlDbType.VarChar,100)
            };

            parms[0].Value = reportTypeName;
            parms[1].Value = reportTypeNameEN;
            parms[2].Value = seq;
            parms[3].Value = userName;
            parms[4].Value = reportTypeId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCreateReportMenu", parms);
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        //通用的导出Excel
        public DataTable GetDataTableToExcel(String parmarStr, String parmarValueStr, String procName)
        {
            //获取参数
            string[] sArray = parmarStr.Split(',');
            string[] parmarValueArray = parmarValueStr.Split(',');
            string paramesLength = "";
            List<SqlParameter> ilistStr = new List<SqlParameter>();
            foreach (string i in sArray)
            {
                paramesLength = i.ToString();
                ilistStr.Add(new SqlParameter(paramesLength, ""));
            }
            SqlParameter[] param = ilistStr.ToArray();
            int j = 0;
            foreach (string i in parmarValueArray)
            {
                string paramValueLength = i.ToString();
                param[j].Value = paramValueLength;
                j++;
            }
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.ReportConnString, procName, param);
        }

        /// <summary>
        /// 分页获取列表数据--纯Html页面数据获取
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="strTb">表名或者视图</param>
        /// <param name="strKey">主键</param>
        /// <returns>AgingBasic 列表。</returns>
        public string GetPageList(Int32 startRow, Int32 maxRows, String sortExpression, string strJson, String strTb, string strConn = null)
        {
            return ComMethod.GetComListJson(startRow, startRow + maxRows, strTb, sortExpression, strJson, strConn);
        }

        /// <summary>
        /// 分页获取列表数据--纯Html页面数据获取 -- 存储过程分页
        /// </summary>
        /// <param name="strSpc">存储过程闽菜</param>
        /// <param name="strJson">参数字串</param>
        /// <param name="startRow">起始行</param>
        /// <param name="maxRows">每页总数</param>
        /// <returns></returns>
        public string GetPageSpcList(String strSpc, string strJson, Int32 startRow, Int32 maxRows, string strConn = null)
        {
            return ComMethod.GetPageList(strSpc, strJson, startRow, startRow + maxRows, strConn);
        }

        #region 报表自定义获取数据源

        /// <summary>
        /// 获取前N大不良报表数据信息
        /// </summary>
        /// <param name="StartTime"></param>
        /// <param name="EndTime"></param>
        /// <param name="ItemId"></param>
        /// <param name="ProdOrderId"></param>
        /// <param name="LineId"></param>
        /// <param name="OpeId"></param>
        /// <param name="TopN"></param>
        /// <returns></returns>
        public DataTable GetTopNCCode(DateTime StartTime, DateTime EndTime, int ItemId, int ProdOrderId, int LineId, int OpeId, int TopN)
        {
            DataTable dt = new DataTable();

            SqlParameter[] paramers = new SqlParameter[]{
                new SqlParameter("@StartTime",SqlDbType.DateTime),
                new SqlParameter("@EndTime",SqlDbType.DateTime),
                new SqlParameter("@ItemId",SqlDbType.Int),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@LineId",SqlDbType.Int),
                new SqlParameter("@OpeId",SqlDbType.Int),
                new SqlParameter("@TopN",SqlDbType.Int),
            };
            paramers[0].Value = StartTime;
            paramers[1].Value = EndTime;
            paramers[2].Value = ItemId;
            paramers[3].Value = ProdOrderId;
            paramers[4].Value = LineId;
            paramers[5].Value = OpeId;
            paramers[6].Value = TopN;

            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.ReportConnString, "ruspGetTopNCCode", paramers);

            return dt;
        }

        #endregion

        #region 获取IQC工作量分析汇总数据
        /// <summary>
        /// 获取IQC工作量分析汇总数据
        /// </summary>
        /// <param name="Year"></param>
        /// <param name="Month"></param>
        /// <returns></returns>
        public string GetIQCWorkload(string Year, string Month)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@Year",SqlDbType.NVarChar,50),
                  new SqlParameter("@Month",SqlDbType.NVarChar,50)
            };
            parms[0].Value = Year;
            parms[1].Value = Month;
            return ComMethod.GetList("uspIQCWorkloadReport", parms);
        }
        #endregion
    }
}
