using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.Kanban.BLL;
using SKT.LeanMES.Kanban.Model;
using AjaxPro;
using System.Data;
using SKT.Common.DAL.Marshal;
using System.Data.SqlClient;
using SKT.LeanMES.WorkShop.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxKanban
    {

        [AjaxMethod]
        public void EditReportType(string typeName, string typeNameEN, float seq, string typeId)
        {
            try
            {
                (new SKT.LeanMES.Kanban.BLL.Master()).EditKanbanType(typeName, typeNameEN, seq, typeId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 更新或者增加模板列表
        /// </summary>
        /// <param name="entity">模板列表实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public void EditKanbanTemplate(SKT.LeanMES.Kanban.Model.MasterInfo entity)
        {
            try
            {
                new SKT.LeanMES.Kanban.BLL.Master().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取master内的container
        /// </summary> 
        [AjaxMethod]
        public List<MasterInfo> GetMapMaster(int masterId)
        {
            try
            {
                List<MasterInfo> list = (new Master()).GetMapMaster(masterId);
                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }

        }

        /// <summary>
        /// 获取container内的控件component
        /// </summary> 
        [AjaxMethod]
        public List<MasterInfo> GetMapContainer(int containerId)
        {
            try
            {
                List<MasterInfo> list = (new Master()).GetMapContainer(containerId);
                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }

        }

        /// <summary>
        /// 获取container信息
        /// </summary> 
        [AjaxMethod]
        public List<MasterInfo> GetContainerInfo(int containerId)
        {
            //try
            //{
            //    List<MasterInfo> list = (new Master()).GetContainerinfo(containerId);
            //    return list;
            //}
            //catch (Exception ex)
            //{
            //    WebHelper.HandleException(ex);
            return null;
            //}

        }


        /// <summary>
        /// 获取数据源表格数据返回JSON
        /// </summary> 
        [AjaxMethod]
        public string GetDataJson(string uspName)
        {
            string str = "";
            try
            {
                str = (new PubItems.BLL.PubItems()).GetListJson(uspName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 表格分页获取数据，返回JSON
        /// </summary> 
        [AjaxMethod]
        public string GetTabelByPager(int startRow, int pageSize, string sourceName)
        {
            string str = "";
            try
            {
                str = (new LeanMES.Kanban.BLL.Master()).GetTabelByPager(startRow, pageSize, sourceName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }


        /// <summary>
        /// 更新或者增加控件列表
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public void EditComponent(SKT.LeanMES.Kanban.Model.MasterInfo entity)
        {
            try
            {
                new SKT.LeanMES.Kanban.BLL.Master().EditComponent(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 更新或者增加容器列表
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public void EditContainer(SKT.LeanMES.Kanban.Model.MasterInfo entity)
        {
            try
            {
                new SKT.LeanMES.Kanban.BLL.Master().EditContainer(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取容器布局HTML
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string GetContainerHtml(string layoutType)
        {
            try
            {
                return new SKT.LeanMES.Kanban.BLL.Master().GetContainerHtml(layoutType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }

        /// <summary>
        /// 获取容器布局HTML
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string GetContainerEditOption(int contId)
        {
            try
            {
                return new SKT.LeanMES.Kanban.BLL.Master().GetContainerEditOption(contId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }

        /// <summary>
        /// 获取生成看板控件预览所需的参数
        /// </summary>
        [AjaxMethod]
        public List<MasterInfo> GetCompParamById(int compId)
        {
            try
            {
                var entity = (new Master()).GetCompInfo(compId);
                var list = new List<MasterInfo>();
                list.Add(entity);
                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 编辑.新增容器类型
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public void EditContainerType(int cId, string cName, string hCode, string cRemark, string user, int posType)
        {
            try
            {
                new SKT.LeanMES.Kanban.BLL.Master().EditContainerType(cId, cName, hCode, cRemark, user, posType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取数据源表格数据返回JSON
        /// </summary> 
        [AjaxMethod]
        public string GetKanbanProcData(string uspName, string paras)
        {
            string str = "";
            try
            {
                str = (new Master()).GetKanbanProcData(uspName, paras);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        [AjaxMethod]
        public string GetKanbanName(string macAddress)
        {
            string kanbanName = "";
            try
            {
                string cmdTxt = string.Format("SELECT Remark FROM Kanban_DeviceMac WHERE MacAddress = '{0}'", macAddress);
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.ReportConnString, cmdTxt, null);
                if (dt != null && dt.Rows.Count > 0)
                {
                    kanbanName = dt.Rows[0][0].ToString();
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return kanbanName;
        }

        [AjaxMethod]
        public void AcrossKanban(string kanbanName, string macAddress)
        {
            try
            {
                string cmdTxt = string.Format("if not exists(select 1 from Kanban_DeviceMac) begin insert into Kanban_DeviceMac(MacAddress,Remark) values('{0}','{1}') end else begin update Kanban_DeviceMac set Remark = '{2}' where MacAddress = '{3}' end", macAddress, kanbanName, kanbanName, macAddress);
                SQLHelper.ExecuteNonQueryText(SQLHelper.ReportConnString, cmdTxt, null);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public string GetServerDateAndWeek()
        {
            string strWeek = "";

            switch (DateTime.Now.DayOfWeek.ToString("D"))
            {
                case "0":
                    strWeek = "星期日 ";
                    break;
                case "1":
                    strWeek = "星期一 ";
                    break;
                case "2":
                    strWeek = "星期二 ";
                    break;
                case "3":
                    strWeek = "星期三 ";
                    break;
                case "4":
                    strWeek = "星期四 ";
                    break;
                case "5":
                    strWeek = "星期五 ";
                    break;
                case "6":
                    strWeek = "星期六 ";
                    break;
            }
            return string.Concat(DateTime.Now.Year, "年", DateTime.Now.Month, "月", DateTime.Now.Day, "日", " ", strWeek);
        }

        #region 内置看板

        /// <summary>
        /// 获取看板欢迎词
        /// </summary>
        /// <param name="workshopId"></param>
        /// <param name="lineId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetWelcome(int workshopId, int lineId,int kanbanType)
        {
            string welcomeStr = "";
            try
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@WorkshopId",SqlDbType.Int),
                    new SqlParameter("@LineId",SqlDbType.Int),
                    new SqlParameter("@WelcomeStr",SqlDbType.VarChar,100),
                    new SqlParameter("@KanBanType",SqlDbType.Int),
                };

                param[0].Value = workshopId;
                param[1].Value = lineId;
                param[2].Direction = ParameterDirection.Output;
                param[3].Value = kanbanType;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.ReportConnString, "uspGetKanBanWelcome", param);

                welcomeStr = param[2].Value == null ? "" : param[2].Value.ToString();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return welcomeStr;
        }

        [AjaxMethod]
        public string GetServerDateAndWeekHour()
        {
            string strWeek = "";

            switch (DateTime.Now.DayOfWeek.ToString("D"))
            {
                case "0":
                    strWeek = "星期日 ";
                    break;
                case "1":
                    strWeek = "星期一 ";
                    break;
                case "2":
                    strWeek = "星期二 ";
                    break;
                case "3":
                    strWeek = "星期三 ";
                    break;
                case "4":
                    strWeek = "星期四 ";
                    break;
                case "5":
                    strWeek = "星期五 ";
                    break;
                case "6":
                    strWeek = "星期六 ";
                    break;
            }
            string month = DateTime.Now.Month > 9 ? DateTime.Now.Month.ToString() : "0" + DateTime.Now.Month;
            string day = DateTime.Now.Day > 9 ? DateTime.Now.Day.ToString() : "0" + DateTime.Now.Day;
            string hour = DateTime.Now.Hour > 9 ? DateTime.Now.Hour.ToString() : "0" + DateTime.Now.Hour;
            string minute = DateTime.Now.Minute > 9 ? DateTime.Now.Minute.ToString() : "0" + DateTime.Now.Minute;
            string second = DateTime.Now.Second > 9 ? DateTime.Now.Second.ToString() : "0" + DateTime.Now.Second;

            return string.Concat(DateTime.Now.Year, "年", month, "月", day, "日", " ", strWeek, "  ", hour, ":", minute, ":", second);
        }

        /// <summary>
        /// 获取SMT接料看板信息
        /// </summary>
        /// <param name="lineId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ReceivingMaterialKanBanInfo> GetReceivingMaterialKanBan(int lineId)
        {
            List<ReceivingMaterialKanBanInfo> list = new List<ReceivingMaterialKanBanInfo>();
            BuiltinKanBan bll = new BuiltinKanBan();
            try
            {
                list = bll.GetReceivingMaterialKanBan(lineId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        #endregion

        #region 看板轮播配置

        /// <summary>
        /// 看板轮播配置—新增/编辑
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="json"></param>
        [AjaxMethod]
        public void KanBanCarouselConfigEdit(KanBanCarouselConfigInfo entity, string json)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                (new SKT.LeanMES.Kanban.BLL.KanBanCarouselConfig()).Edit(entity, json);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 看板轮播配置—删除
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void KanBanCarouselConfigDelete(KanBanCarouselConfigInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                (new SKT.LeanMES.Kanban.BLL.KanBanCarouselConfig()).Delete(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取看板轮播配置明细
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public List<KanBanCarouselConfigDetailInfo> GetKanBanCarouselConfigDetailByCarouselConfigId(KanBanCarouselConfigInfo entity)
        {
            try
            {
                var setting = new Common.Model.SearchSettings
                {
                    ExtensionCondition = string.Format("kcd.CarouselConfigId = {0}", entity.CarouselConfigId)
                };
                return (new SKT.LeanMES.Kanban.BLL.KanBanCarouselConfigDetail()).GetAll(-1, -1, "Sequence", setting);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        #endregion

        /// <summary>
        /// 获取抛料率的解析时间
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public int GetRejectRateTime()
        {
            int AnalysisTime = 0;
            string shopText = "AnalysisTime";
            try
            {
                string cmdTxt = string.Format("SELECT ParaValue FROM dbo.SYS_GlobarParameter WHERE ParaName ='{0}'", shopText);
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.ReportConnString, cmdTxt, null);
                if (dt != null && dt.Rows.Count > 0)
                {
                    AnalysisTime = Convert.ToInt32(dt.Rows[0][0]);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return AnalysisTime;
        }
        [AjaxMethod]
        public SKT.LeanMES.WorkShop.Model.WorkShopInfo GetLineWorkShopInfo()
        {
            SKT.LeanMES.WorkShop.BLL.WorkShop bll = new LeanMES.WorkShop.BLL.WorkShop();
            SKT.LeanMES.WorkShop.Model.WorkShopInfo info = bll.GetLineWorkShopInfo();
            return info;
        }
        /// <summary>
        /// 获取贴片机抛料率(当天的) add by peter on 2019-1-3
        /// </summary>
        /// <param name="lineType"></param>
        /// <returns></returns>
        [AjaxMethod]
        public SKT.LeanMES.WorkShop.Model.WorkShopInfo GetLineRejectRate()
        {
            SKT.LeanMES.WorkShop.BLL.WorkShop bll = new LeanMES.WorkShop.BLL.WorkShop();
            SKT.LeanMES.WorkShop.Model.WorkShopInfo info = bll.GetLineRejectRate();
            return info;
        }
        /// <summary>
        /// 获取产线状态 返回状态字符串 1 正常 2 待产 3 停线 add by peter on 2018-10-30
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string GetLineStatusKanban()
        {
            string str = "";
            try
            {
                str = new Master().GetLineStatusKanban();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        /// <summary>
        /// 获取服务器时间
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetServerDate(int type)
        {
            DateTime dtNow = DateTime.Now;
            string str = string.Empty;
            //获取年月
            if (type == 10)
            {
                str = dtNow.ToString("yyyyMM");
            }

            return str;
        }

        /// <summary>
        /// 获取设备状态及生产信息看板
        /// </summary>
        /// <param name="workShopId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<EquipmentProductionInfo> GetEquipmentStatusKanban(int workShopId)
        {
            List<EquipmentProductionInfo> list = new List<EquipmentProductionInfo>();
            EquipmentProductionInfo entity = null;
            try
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@WorkShopId",SqlDbType.Int,4)

                };

                param[0].Value = workShopId;
                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspEquipmentStatusKanBan", param))
                {
                    while (rdr.Read())
                    {
                        entity = new EquipmentProductionInfo();
                        entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                        entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                        entity.StatusDesc = Convert.ToString(rdr["StatusDesc"]);
                        entity.FreeTimeRatio = Convert.ToDouble(rdr["FreeTimeRatio"]);
                        entity.SnInputCount = Convert.ToInt32(rdr["SnInputCount"]);
                        entity.SnOutputCount = Convert.ToInt32(rdr["SnOutputCount"]);
                        entity.RepariTimeMin = Convert.ToInt32(rdr["RepariTimeMin"]);

                        list.Add(entity);
                    }
                    rdr.Close();
                }

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        /// 获取xml Popedom集合
        /// </summary> 
        [AjaxMethod]
        public List<int> GetPopedoms()
        {
           
            var list= new BuiltinKanBan().GetPopedoms();
            if(list.Any())
            {
                return list.Select(x => x.Popedom).ToList();
            }
            return new List<int>();
        }
    }
    public class EquipmentProductionInfo
    {


        public int EquipmentId { get; set; }
        public string EquipmentCode { get; set; }
        public string EquipmentName { get; set; }

        public string StatusDesc { get; set; }

        public double FreeTimeRatio { get; set; }

        public int SnInputCount { get; set; }
        public int SnOutputCount { get; set; }
        public int RepariTimeMin { get; set; }
    }
}