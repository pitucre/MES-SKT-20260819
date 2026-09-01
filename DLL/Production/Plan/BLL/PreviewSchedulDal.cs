using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Plan.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Plan.BLL
{
    public class PreviewSchedulDal
    {
        private Int32 recordCount = 0;


        /// <summary>
        /// 获取线别车间工作日历时长
        /// </summary>
        /// <returns></returns>
        public List<WorkShopLineHourInfo> GetWorkShopLineWorkHourList()
        {
            List<WorkShopLineHourInfo> list = new List<WorkShopLineHourInfo>();
            WorkShopLineHourInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetWorkShopHour", null))
            {
                while (rdr.Read())
                {
                    entity = new WorkShopLineHourInfo();
                    entity.LineId = Convert.ToInt32(rdr["LineId"]);
                    entity.WorkMinute = Convert.ToInt32(rdr["WorkMinute"]);
                    entity.WorkShopId = Convert.ToInt32(rdr["WorkShopId"]);
                    entity.WorkShopName = Convert.ToString(rdr["WorkShopName"]);
                    entity.ShiftId = Convert.ToInt32(rdr["ShiftId"]);

                    entity.ResName = Convert.ToString(rdr["ResName"]);
                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }


        /// <summary>
        /// 获取所有线别工作日历时长
        /// </summary>
        /// <returns></returns>
        public List<PreviewSchedulModel> GetAllList()
        {
            List<PreviewSchedulModel> list = new List<PreviewSchedulModel>();
            PreviewSchedulModel entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetLineSchedulCalendarWorkTimeList", null))
            {
                while (rdr.Read())
                {
                    entity = new PreviewSchedulModel();
                    entity.LineId = Convert.ToInt32(rdr["LineId"]);
                    entity.WorkMinute = Convert.ToInt32(rdr["WorkMinute"]);
                    entity.DayTime = Convert.ToString(rdr["DayTime"]);
                    entity.ShiftId = Convert.ToInt32(rdr["ShiftId"]);
                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 获取已排计划列表
        /// </summary>
        /// <returns></returns>
        public List<PreviewSchedulRecordInfo> GetPreviewSchedulRecordList()
        {
            List<PreviewSchedulRecordInfo> list = new List<PreviewSchedulRecordInfo>();
            PreviewSchedulRecordInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPreviewSchedulRecordList", null))
            {
                while (rdr.Read())
                {
                    entity = new PreviewSchedulRecordInfo();
                    entity.LineId = Convert.ToInt32(rdr["LineId"]);
                    entity.ProdOrderId = Convert.ToInt32(rdr["ProdOrderId"]);
                    entity.DayTime = Convert.ToString(rdr["DayTime"]);
                    entity.PlanNumber = Convert.ToDecimal(rdr["PlanNumber"]);
                    entity.TableName = Convert.ToString(rdr["TableName"]);
                    entity.State = Convert.ToInt32(rdr["State"]);
                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }



        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

       
    }
}