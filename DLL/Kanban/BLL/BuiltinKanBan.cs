using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Kanban.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Kanban.BLL
{
    /// <summary>
    /// 内置高级看板操作类
    /// </summary>
    public class BuiltinKanBan
    {

        /// <summary>
        /// SMT接料看板信息
        /// </summary>
        /// <param name="lineId"></param>
        /// <returns></returns>
        public List<ReceivingMaterialKanBanInfo> GetReceivingMaterialKanBan(int lineId)
        {
            List<ReceivingMaterialKanBanInfo> list = new List<ReceivingMaterialKanBanInfo>();
            ReceivingMaterialKanBanInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineId", SqlDbType.Int)
            };

            parms[0].Value = lineId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "uspSMTMaterialReceivingKanBan", parms))
            {
                while (rdr.Read())
                {
                    entity = new ReceivingMaterialKanBanInfo();
                    entity.LineName = rdr.GetString(0);
                    entity.PlanBillNo = rdr.GetString(1);
                    entity.EquipmentCode = rdr.GetString(2);
                    entity.Positon = rdr.GetString(3);
                    entity.PartNumber = rdr.GetString(4);
                    entity.SerialNumber = rdr.GetString(5);
                    entity.BalanceQty = Convert.ToDecimal(rdr["BalanceQty"]);
                    entity.BalanceMin = rdr.GetInt32(7);
                    entity.IsWarn = rdr.GetInt32(8);
                    list.Add(entity);
                }
            }

            return list;
        }
        /// <summary>
        /// 线体计划达成情况
        /// </summary>
        /// <param name="lineId"></param>
        /// <returns></returns>
        public List<PlanReached> GetDayLinePlanReachedKanBan(int lineId)
        {
            List<PlanReached> list = new List<PlanReached>();
            PlanReached entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineId", SqlDbType.Int)
            };

            parms[0].Value = lineId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "uspDayLinePlanReachedKanBan", parms))
            {
                while (rdr.Read())
                {
                    entity = new PlanReached();
                    entity.FName = rdr.GetString(0);
                    entity.LineName = rdr.GetString(1);
                    entity.OrderNO = rdr.GetString(2);
                    entity.ItemCode = rdr.GetString(3);
                    entity.ItemName = rdr.GetString(4);
                    entity.ItemSpec = rdr.GetString(5);
                    entity.PlanQty = rdr.GetInt32(6);
                    entity.PlanDatiTime = rdr.GetString(7);
                    entity.GrossOutput = rdr.GetInt32(8);
                    entity.GrossOutputRate =(decimal)(rdr.GetDouble(9));
                    entity.GrossOutputRateString = rdr.GetString(10);
                    list.Add(entity);
                }
            }

            return list;
        }


        /// <summary>
        /// PBA截料看板
        /// </summary>
        /// <param name="lineId"></param>
        /// <returns></returns>
        public List<PBABlankingKanBanInfo> GetPBABlankingKanBan(int lineId)
        {
            List<PBABlankingKanBanInfo> list = new List<PBABlankingKanBanInfo>();
            PBABlankingKanBanInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LineId", SqlDbType.Int)
            };

            parms[0].Value = lineId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "uspPBABlankingKanBan", parms))
            {
                while (rdr.Read())
                {
                    entity = new PBABlankingKanBanInfo();
                    entity.LineName = rdr.GetString(0);
                    entity.PlanBillNo = rdr.GetString(1);
                    //entity.EquipmentCode = rdr.GetString(2);
                    //entity.Positon = rdr.GetString(3);
                    entity.GroupCode = rdr.GetString(2);
                    entity.PartNumber = rdr.GetString(3);
                    //entity.SerialNumber = rdr.GetString(4);
                    entity.BalanceQty = Convert.ToDecimal(rdr["BalanceQty"]);
                    entity.BalanceMin = rdr.GetInt32(5);
                    entity.IsWarn = rdr.GetInt32(6);
                    list.Add(entity);
                }
            }

            return list;
        }

        /// <summary>
        /// 获取xml Popedom集合
        /// </summary> 
        public List<PopedomOutput> GetPopedoms()
        {
            string sql = @"select Popedom from SYS_popedom where PopedomGroup=70200000 and
                            Popedom not in 
                            (
                            70200205,
                            70200204,
                            70200203,
                            70200202,
                            70200201,
                            70200200,
                            70200100
                            )";
            return ComMethod.GetListBySql<PopedomOutput>(sql, null);
        }
        
        /// <summary>
        ///  add by feifeng.zhao 2023.06.08  K2-显示“今日产能”、“完成率”、“齐套率”、“工单数”、“生产计划数”
        /// </summary>
        /// <returns></returns>
        public DataTable K2_GetCapacityDay()
        {
            return ComMethod.GetDataTableList("uspK2_GetCapacityDay", null);
        }

        /// <summary>
        ///  add by feifeng.zhao 2023.06.08  K3-UPPH趋势图按照绕线和装配线每天UPPH数据连线展示。
        ///  绕线线体:取的是自动绕线A线、自动绕线B线、自动绕线C线以及手工绕线，这四条线的UPPH平均值。
        ///  装配线体：取的是自动装配A线、自动装配B线、自动装配C线以及手工装配B线，这四条线的UPPH平均值。
        ///  只有2个线体2条线，取绕线和装配线的计划达成率平均值。
        /// </summary>
        /// <returns></returns>
        public DataTable K3_GetLineOneUPPHDay()
        {
            return ComMethod.GetDataTableList("uspK3_GetLineOneUPPHDay", null);
        }

        /// <summary>
        ///  add by feifeng.zhao 2023.06.08  K4-线体看板 线体看板一共8条线  温度计
        /// </summary>
        /// <returns></returns>
        public DataTable K4_GetLineStatusPercent()
        {
            return ComMethod.GetDataTableList("uspK4_GetLineStatusPercent", null);
        }

        
        /// <summary>
        ///  add by feifeng.zhao 2023.06.08  K6-计划达成率按照车间每天计划达成率数据连线展示，
        ///  绕线线体：取的是自动绕线A线、自动绕线B线、自动绕线C线以及手工绕线 这四条线的计划达成率平均值。
        ///  装配线体：取的是自动装配A线、自动装配B线、自动装配C线以及手工装配B线这四条线的计划达成率平均值。
        ///  只有2个线体2条线，取绕线和装配线的计划达成率平均值。
        /// </summary>
        /// <returns></returns>
        public DataTable K6_GetLineUPPHAverageRateDay()
        {
            return ComMethod.GetDataTableList("uspK6_GetLineUPPHAverageRateDay", null);
        }

        
        /// <summary>
        ///  add by feifeng.zhao 2023.06.08  K8-日UPH按照车间每天UPH数据连线展示--8条线
        /// </summary>
        /// <returns></returns>
        public DataTable K8_GetLineUPHDay()
        {
            return ComMethod.GetDataTableList("uspK8_GetLineUPHDay", null);
        }

        /// <summary>
        ///  add by feifeng.zhao 2023.06.08  K9-9. 合格率按照车间线体每天日合格率数据连线展示，合格率按照车间每天合格率数据连线展示。
        ///  绕线线体：取的是自动绕线A线、自动绕线B线、自动绕线C线以及手工绕线 这四条线的合格率平均值。
        ///  装配线体，取的是自动装配A线、自动装配B线、自动装配C线以及手工装配B线这四条线的合格率平均值。
        ///  只有2个线体2条线，
        /// </summary>
        /// <returns></returns>
        public DataTable K9_GetLineQualityRateDay()
        {
            return ComMethod.GetDataTableList("uspK9_GetLineQualityRateDay", null);
        }
    }
    public class PopedomOutput
    {
        public int Popedom { get; set; }
    }
}
