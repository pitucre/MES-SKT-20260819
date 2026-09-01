using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Report.Model;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Data;
using SKT.LeanMES.CommonLibrary.Common;


namespace SKT.LeanMES.Report.BLL
{
    public class AssembleReport
    {
        private Int32 recordCount = 0;
        public List<AssembleReportInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AssembleReportInfo> list = new List<AssembleReportInfo>();
            AssembleReportInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwReportMember", "TemplateId",
                "[TemplateId], [TemplateName],[ReportCNName], [ReportENName], [TemplateDesc], [ReportType],[ReportTypeCNName],[ReportTypeENName], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AssembleReportInfo();
                    entity.MoCode = rdr.GetString(0);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        #region 获取工单产品信息
        /// <summary>
        /// 获取工单产品信息
        /// </summary>
        /// <param name="ProductBarCode"></param>
        /// <param name="ProductCode"></param>
        /// <param name="MoCode"></param>
        /// <returns></returns>
        public DataSet GetMoProductInfo(string ProductCode, string ProductBarCode, string MoCode, string TurnoverBar)
        {
            DataSet ds = new DataSet();
            DataSqlParamters dPsrams = new DataSqlParamters();
            dPsrams.Commandtype = CommandType.StoredProcedure;
            dPsrams.CommandText = "uspGetMoProductInfos";
            dPsrams.Add(new SqlParameter("@ProductBarCode", SqlDbType.VarChar, 100), ProductBarCode);
            dPsrams.Add(new SqlParameter("@ProductCode", SqlDbType.VarChar, 100), ProductCode);
            dPsrams.Add(new SqlParameter("@MoCode", SqlDbType.VarChar, 100), MoCode);
            dPsrams.Add(new SqlParameter("@TurnoverBar", SqlDbType.VarChar, 100), TurnoverBar);
            SqlDataReaderAPI.DataSqlSelect(ref ds, dPsrams);
            return ds;
        }

        #endregion

        #region 获取流转板报表的结果集
        /// <summary>
        /// 获取流转板报表的结果集
        /// </summary>
        /// <param name="usn"></param>
        /// <returns></returns>
        public DataSet GetAssembleReportDs(string usn)
        {
            DataSet ds = new DataSet();
            DataSqlParamters dPsrams = new DataSqlParamters();
            dPsrams.Commandtype = CommandType.StoredProcedure;
            dPsrams.CommandText = "uspGetAssembleReportDs";
            dPsrams.Add(new SqlParameter("@usn", SqlDbType.VarChar, 50), usn);
            SqlDataReaderAPI.DataSqlSelect(ref ds, dPsrams);
            return ds;
        }

        #endregion

        #region 获取质量报表数据信息
        /// <summary>
        /// 获取质量报表数据信息
        /// </summary>
        /// <param name="MoCode"></param>
        /// <param name="ItemCode"></param>
        /// <param name="GetType"></param>
        /// <param name="AnalyzeType"></param>
        /// <param name="Station"></param>
        /// <param name="NCGroupName"></param>
        /// <param name="StartTime"></param>
        /// <param name="EndTime"></param>
        /// <returns></returns>
        public DataSet GetProductQuality(string MoCode, string ItemCode, string GetType, string AnalyzeType, string QValue, string StartTime, string EndTime)
        {
            DataSet ds = new DataSet();
            DataSqlParamters dPsrams = new DataSqlParamters();
            dPsrams.Commandtype = CommandType.StoredProcedure;
            dPsrams.CommandText = "uspGetProductQuality";
            dPsrams.Add(new SqlParameter("@MoCode", SqlDbType.VarChar, 100), MoCode);
            dPsrams.Add(new SqlParameter("@ItemCode", SqlDbType.VarChar, 100), ItemCode);
            dPsrams.Add(new SqlParameter("@GetType", SqlDbType.VarChar, 100), GetType);
            dPsrams.Add(new SqlParameter("@AnalyzeType", SqlDbType.VarChar, 100), AnalyzeType);
            dPsrams.Add(new SqlParameter("@QValue", SqlDbType.VarChar, 100), QValue);
            dPsrams.Add(new SqlParameter("@StartTime", SqlDbType.VarChar, 100), StartTime);
            dPsrams.Add(new SqlParameter("@EndTime", SqlDbType.VarChar, 100), EndTime);
            SqlDataReaderAPI.DataSqlSelect(ref ds, dPsrams);
            return ds;
        }

        #endregion

        #region 根据生产工单获取产品详细信息
        /// <summary>
        /// 根据生产工单获取产品详细信息
        /// </summary>
        /// <param name="MoCode">生产工单</param>
        /// <returns></returns>
        public AssembleReportInfo GetProductInfo(string MoCode)
        {
            AssembleReportInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MoCode", SqlDbType.VarChar,50)
            };
            parms[0].Value = MoCode;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Basal_GetProductItemInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AssembleReportInfo();
                    entity.ProductCode = rdr.GetString(0);
                    entity.ProductName = rdr.GetString(1);
                    entity.ClientShort = rdr.IsDBNull(2) ? "" : rdr.GetString(2);
                }
                else
                {
                    entity = new AssembleReportInfo();
                    entity.ProductCode = "";
                    entity.ProductName = "";
                }
                rdr.Close();
            }
            return entity;
        }
        #endregion

        #region 保存生产数据维护信息
        /// <summary>
        /// 保存生产数据维护信息
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="userName"></param>
        public void SaveProductDataMaintain(AssembleReportInfo entity, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@MaintainDate", SqlDbType.VarChar, 50),
                new SqlParameter("@MoCode", SqlDbType.VarChar, 50),
                new SqlParameter("@ProductName", SqlDbType.VarChar, 200),
                new SqlParameter("@ProductCode", SqlDbType.VarChar,50),
                new SqlParameter("@PeopleNumber", SqlDbType.Int),
                new SqlParameter("@PlanOutputQty", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.VarChar,4000),
                new SqlParameter("@userName", SqlDbType.VarChar, 20),
                new SqlParameter("@StartTime", SqlDbType.VarChar, 20),
                new SqlParameter("@EndTime", SqlDbType.VarChar, 20),
                new SqlParameter("@LineID", SqlDbType.Int),
                new SqlParameter("@ImpactPeople", SqlDbType.Int),
                new SqlParameter("@TimeQty", SqlDbType.Int),
                new SqlParameter("@TimeSum", SqlDbType.Int),
                new SqlParameter("@AnormalCause", SqlDbType.VarChar, 100),
                new SqlParameter("@CauseType", SqlDbType.VarChar, 50),
                new SqlParameter("@AnormalTypeId", SqlDbType.Int),
                new SqlParameter("@DutyDept", SqlDbType.VarChar, 50),
                new SqlParameter("@WaitMaterialTime", SqlDbType.Int),
                new SqlParameter("@ProcessQualityTime", SqlDbType.Int),
                new SqlParameter("@RedoTime", SqlDbType.Int),
                new SqlParameter("@PartsQualityTime", SqlDbType.Int),
                new SqlParameter("@ChangeModelTime", SqlDbType.Int),
                new SqlParameter("@TechnologyTime", SqlDbType.Int),
                new SqlParameter("@CustomerInfoTime", SqlDbType.Int),
                new SqlParameter("@WaitingTime", SqlDbType.Int),
                new SqlParameter("@CustomerName", SqlDbType.VarChar, 50),
                new SqlParameter("@Sequence", SqlDbType.Int),
                new SqlParameter("@PSequence", SqlDbType.Int)
            };
            parms[0].Value = entity.MaintainID;
            parms[1].Value = entity.MaintainDate;
            parms[2].Value = entity.MoCode;
            parms[3].Value = entity.ProductName;
            parms[4].Value = entity.ProductCode;
            parms[5].Value = entity.PeopleNumber;
            parms[6].Value = entity.PlanOutputQty;
            parms[7].Value = entity.Remark;
            parms[8].Value = userName;
            parms[9].Value = entity.StartTime.Replace('：', ':');
            parms[10].Value = entity.EndTime.Replace('：', ':');
            parms[11].Value = entity.LineID;
            parms[12].Value = entity.ImpactPeople;
            parms[13].Value = entity.TimeQty;
            parms[14].Value = entity.TimeSum;
            parms[15].Value = entity.AnormalCause;
            parms[16].Value = entity.CauseType;
            parms[17].Value = entity.AnromalTypeId;
            parms[18].Value = entity.DutyDept;
            parms[19].Value = entity.WaitMaterialTime;
            parms[20].Value = entity.ProcessQualityTime;
            parms[21].Value = entity.RedoTime;
            parms[22].Value = entity.PartsQualityTime;
            parms[23].Value = entity.ChangeModelTime;
            parms[24].Value = entity.TechnologyTime;
            parms[25].Value = entity.CustomerInfoTime;
            parms[26].Value = entity.WaitingTime;
            parms[27].Value = entity.ClientShort;
            parms[28].Value = entity.Sequence;
            parms[29].Value = entity.PSequence;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveProductDataMaintain", parms);
        }

        #endregion

        #region 获取生产数据维护信息
        /// <summary>
        /// 获取生产数据维护信息
        /// </summary>
        /// <param name="MaintainDate"></param>
        /// <param name="MoCode"></param>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        public DataSet GetProductDataMaintain(string MaintainDate, string MoCode, string ItemCode)
        {
            DataSet ds = new DataSet();
            DataSqlParamters dPsrams = new DataSqlParamters();
            dPsrams.Commandtype = CommandType.StoredProcedure;
            dPsrams.CommandText = "uspGetProductDataMaintain";
            dPsrams.Add(new SqlParameter("@MaintainDate", SqlDbType.VarChar, 100), MaintainDate);
            dPsrams.Add(new SqlParameter("@MoCode", SqlDbType.VarChar, 100), MoCode);
            dPsrams.Add(new SqlParameter("@ItemCode", SqlDbType.VarChar, 100), ItemCode);
            SqlDataReaderAPI.DataSqlSelect(ref ds, dPsrams);
            return ds;
        }

        #endregion

        #region 删除生产数据维护信息
        /// <summary>
        /// 删除生产数据维护信息
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void DeleteDataMaintain(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000)
            };
            parms[0].Value = idString;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteDataMaintain", parms);
        }
        #endregion

        #region 获取生产数据维护信息
        /// <summary>
        /// 获取生产数据维护信息
        /// </summary>
        /// <param name="MaintainID"></param>
        /// <returns></returns>
        public AssembleReportInfo GetProductDataMaintainInfo(int MaintainID)
        {
            AssembleReportInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaintainID", SqlDbType.Int)
            };
            parms[0].Value = MaintainID;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "uspGetProductDataMaintainInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AssembleReportInfo();
                    entity.MaintainID = rdr.GetInt32(0);
                    entity.MaintainDate = rdr.GetString(1);
                    entity.MoCode = rdr.GetString(2);
                    entity.ProductName = rdr.GetString(3);
                    entity.ProductCode = rdr.GetString(4);
                    entity.PeopleNumber = rdr.GetInt32(5);
                    entity.PlanOutputQty = rdr.GetInt32(6);
                    entity.Remark = rdr.GetString(7);
                }
                rdr.Close();
            }
            return entity;
        }
        #endregion
    }

}
