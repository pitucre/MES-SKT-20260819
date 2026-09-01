using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.WorkShop.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.WorkShop.BLL
{
    public class WorkShop
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） WorkShop 信息。
        /// </summary>
        /// <param name="entity">WorkShop 实体对象。</param>
        public Int32 Edit(WorkShopInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WorkShopID", SqlDbType.Int),
                new SqlParameter("@WorkShopName", SqlDbType.NVarChar, 50),
                new SqlParameter("@WorkShopCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@FactoryId", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 1000),
                new SqlParameter("@ShiftId", SqlDbType.Int),
                new SqlParameter("@Principal", SqlDbType.Int),
                new SqlParameter("@Temperature", SqlDbType.NVarChar, 10),
                new SqlParameter("@Humidity", SqlDbType.NVarChar, 10),
            };

            parms[0].Value = entity.WorkShopID;
            parms[1].Value = entity.WorkShopName;
            parms[2].Value = entity.WorkShopCode;
            parms[3].Value = entity.FactoryId;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Remark;
            parms[7].Value = entity.ShiftId;
            parms[8].Value = entity.Principal;
            parms[9].Value = entity.Temperature;
            parms[10].Value = entity.Humidity;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_WorkShop_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 WorkShopId 字符串删除 WorkShop 信息。
        /// </summary>
        /// <param name="idString">WorkShopId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_WorkShop_Delete", parms);
        }

        /// <summary>
        /// 根据 WorkShopId 获取实体信息。
        /// </summary>
        /// <param name="workShopId">WorkShopId。</param>
        /// <returns>WorkShop 实体对象。</returns>
        public WorkShopInfo GetInfo(Int32 workShopId)
        {
            WorkShopInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = workShopId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_WorkShop_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WorkShopInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    entity.ShiftId = rdr.GetInt32(9);
                    entity.ShiftName = rdr.GetString(10);
                    entity.Principal = rdr.GetInt32(11);
                    entity.CName = rdr.GetString(12);
                    entity.Temperature = rdr.GetString(13);
                    entity.Humidity = rdr.GetString(14);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>WorkShop 实体对象。</returns>
        public WorkShopInfo GetInfo(String fieldValue)
        {
            WorkShopInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_WorkShop_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WorkShopInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                    entity.ShiftId = rdr.GetInt32(9);
                    entity.ShiftName = rdr.GetString(10);
                    entity.Principal = rdr.GetInt32(11);
                    entity.CName = rdr.GetString(12);
                    entity.Temperature = rdr.GetString(13);
                    entity.Humidity = rdr.GetString(14);
                }
                rdr.Close();
            }

            return entity;
        }

        public WorkShopInfo GetLineWorkShopInfo()
        {
            WorkShopInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = "";
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetLineWorkShopInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WorkShopInfo();
                    entity.WorkShopID = rdr.GetInt32(0);
                    entity.WorkShopName = rdr.GetString(1);
                    entity.Principal = rdr.GetInt32(2);
                    entity.CName = rdr.GetString(3);
                    entity.Temperature = rdr.GetString(4);
                    entity.Humidity = rdr.GetString(5);
                    entity.Remark = rdr.GetString(6);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 获取贴片机抛料率(当天的) add by peter on 2019-1-3
        /// </summary>
        /// <param name="lineType"></param>
        /// <returns></returns>
        public WorkShopInfo GetLineRejectRate()
        {
            WorkShopInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineType", SqlDbType.Int),
            };
            parms[0].Value = 0;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetLineRejectRateInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WorkShopInfo();
                    //抛料率
                    entity.RejectRate1 = rdr.GetString(0);
                    entity.RejectRate2 = rdr.GetString(1);
                    entity.RejectRate3 = rdr.GetString(2);
                    //利用率
                    entity.WorkRatio1 = rdr.GetString(3);
                    entity.WorkRatio2 = rdr.GetString(4);
                    entity.WorkRatio3 = rdr.GetString(5);
                    //生产效率
                    entity.ProdRatio1 = rdr.GetString(6);
                    entity.ProdRatio2 = rdr.GetString(7);
                    entity.ProdRatio3 = rdr.GetString(8);

                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 分页获取 WorkShop 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="workShopCount">workShop 总数。</param>
        /// <returns>WorkShop 列表。</returns>
        public List<WorkShopInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WorkShopInfo> list = new List<WorkShopInfo>();
            WorkShopInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetWorkShopList", "WorkShopId",
                "[WorkShopID], [WorkShopName], [WorkShopCode], [FactoryID], [CreateBy], [CreateTime], [ModifyBy], [ModifyDateTime], [Remark],[FactoryName],ShiftId,ShiftName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WorkShopInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9));
                    entity.ShiftId = rdr.GetInt32(10);
                    entity.ShiftName = rdr.GetString(11);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        //解析贴片机的抛料率 add by peter on 2019-1-7 (用于产线状态看板)
        public void SaveAnalysisRejectRate(string DeviceTotal1, string DeviceTotal2, string DeviceTotal3,
            string DeviceWaste1, string DeviceWaste2, string DeviceWaste3, string AutoTime1, string AutoTime2,
            string AutoTime3, string PlacementTime1, string PlacementTime2, string PlacementTime3, string Line)
        {

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DeviceTotal1", SqlDbType.NVarChar,10),
                new SqlParameter("@DeviceTotal2", SqlDbType.NVarChar, 10),
                new SqlParameter("@DeviceTotal3", SqlDbType.NVarChar, 10),
                new SqlParameter("@DeviceWaste1", SqlDbType.NVarChar,10),
                new SqlParameter("@DeviceWaste2", SqlDbType.NVarChar, 10),
                new SqlParameter("@DeviceWaste3", SqlDbType.NVarChar, 10),
                new SqlParameter("@AutoTime1", SqlDbType.NVarChar, 20),
                new SqlParameter("@AutoTime2", SqlDbType.NVarChar, 20),
                new SqlParameter("@AutoTime3", SqlDbType.NVarChar, 20),
                new SqlParameter("@PlacementTime1", SqlDbType.NVarChar, 20),
                new SqlParameter("@PlacementTime2", SqlDbType.NVarChar, 20),
                new SqlParameter("@PlacementTime3", SqlDbType.NVarChar, 20),
                new SqlParameter("@Line", SqlDbType.NVarChar, 20)
            };

            parms[0].Value = DeviceTotal1;
            parms[1].Value = DeviceTotal2;
            parms[2].Value = DeviceTotal3;
            parms[3].Value = DeviceWaste1;
            parms[4].Value = DeviceWaste2;
            parms[5].Value = DeviceWaste3;
            parms[6].Value = AutoTime1;
            parms[7].Value = AutoTime2;
            parms[8].Value = AutoTime3;
            parms[9].Value = PlacementTime1;
            parms[10].Value = PlacementTime2;
            parms[11].Value = PlacementTime3;
            parms[12].Value = Line;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveRejectRate", parms);
        }

        public string GetAnalysisIP()
        {
            string analysisIP = "";

            string shopText = "RejectRateIP";
            string cmdTxt = string.Format("SELECT ParaValue FROM dbo.SYS_GlobarParameter WHERE ParaName ='{0}'", shopText);
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.ReportConnString, cmdTxt, null);
            if (dt != null && dt.Rows.Count > 0)
            {
                analysisIP = dt.Rows[0][0].ToString();
            }
            return analysisIP;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}