using Newtonsoft.Json;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Kanban.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Kanban 的摘要说明
    /// </summary>
    public class Kanban : IHttpHandler
    {
        HttpResponse response;
        string result = "";

        public void ProcessRequest(HttpContext context)
        {
            SqlInjectableHelper.Validation(context);

            response = context.Response;
            context.Response.ContentType = "text/plain";
            var api = context.Request["api"];
            switch (api)
            {
                //IQC合格率及不良分布看板—IQC来料合格率
                case "GetIQCPassRateAndBadDistributionKanbanInCome": GetIQCPassRateAndBadDistributionKanbanInCome(); break;
                //IQC合格率及不良分布看板—来料不良分布
                case "GetIQCPassRateAndBadDistributionKanbanNGDistribute": GetIQCPassRateAndBadDistributionKanbanNGDistribute(); break;
                //获取看板轮播配置信息
                case "GetKanbanCarouselConfigDetail": GetKanbanCarouselConfigDetail(context.Request["carouselConfigId"]); break;

                //获取服务器日期
                case "GetLineInfoLineID":
                    {
                        var lineId = context.Request["lineId"] == null ? -1 : Convert.ToInt32(context.Request["lineId"]);
                        GetLineInfoLineID(lineId);
                    }
                    break;

                //获取服务器日期
                case "GetServerDateAndWeek": GetServerDateAndWeek(); break;
                //获取服务器日期
                case "GetServerTime": GetServerTime(context.Request["fmt"]); break;
                //获取看板欢迎词 int workshopId, int lineId, int kanbanType
                case "GetWelcome":
                    {
                        var workshopId = context.Request["workshopId"] == null ? -1 : Convert.ToInt32(context.Request["workshopId"]);
                        var lineId = context.Request["lineId"] == null ? -1 : Convert.ToInt32(context.Request["lineId"]);
                        var kanbanType = context.Request["kanbanType"] == null ? -1 : Convert.ToInt32(context.Request["kanbanType"]);
                        GetWelcome(workshopId, lineId, kanbanType);
                    };
                    break;
                #region 新盛世九宫格看板
                //2.今日产能
                case "K2_GetCapacityDay": K2_GetCapacityDay(); break;
                //3. 日UPPH按照车间每天UPPH数据连线展示，只有一个电机车间只有一条线。
                case "K3_GetLineOneUPPHDay": K3_GetLineOneUPPHDay(); break;

                //K4-线体看板 线体看板一共8条线  温度计
                case "K4_GetLineStatusPercent": K4_GetLineStatusPercent(); break;

                //K6-日合格率按照车间线体每天日合格率数据连线展示
                case "K6_GetLineUPPHAverageRateDay": K6_GetLineUPPHAverageRateDay(); break;

                //K8-日合格率按照车间线体每天日合格率数据连线展示
                case "K8_GetLineUPHDay": K8_GetLineUPHDay(); break;
                //K9-日合格率按照车间线体每天日合格率数据连线展示
                case "K9_GetLineQualityRateDay": K9_GetLineQualityRateDay(); break;
                #endregion             


                //获取首件看板列表
                case "FirstInspectionKanbanList": GetFirstInspectionKanbanList(); break;
            }
        }
        #region 新盛世九宫格看板
        /// <summary>
        /// 2.今日产能
        /// </summary>
        public void K2_GetCapacityDay()
        {
            var bll = new SKT.LeanMES.Kanban.BLL.BuiltinKanBan();
            var dt = bll.K2_GetCapacityDay();
            if (dt != null)
            {
                result = JsonConvert.SerializeObject(dt);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }

        /// <summary>
        /// 3. 日UPPH按照车间每天UPPH数据连线展示，只有一个电机车间只有一条线。
        /// </summary>
        public void K3_GetLineOneUPPHDay()
        {
            var bll = new SKT.LeanMES.Kanban.BLL.BuiltinKanBan();
            var dt = bll.K3_GetLineOneUPPHDay();
            if (dt != null)
            {
                result = JsonConvert.SerializeObject(dt);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }

        /// <summary>
        /// 4. K4-线体看板 线体看板一共8条线  温度计
        /// </summary>
        public void K4_GetLineStatusPercent()
        {
            var bll = new SKT.LeanMES.Kanban.BLL.BuiltinKanBan();
            var dt = bll.K4_GetLineStatusPercent();
            if (dt != null)
            {
                result = JsonConvert.SerializeObject(dt);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }

        /// <summary>
        /// K6-日合格率按照车间线体每天日合格率数据连线展示
        /// </summary>
        public void K6_GetLineUPPHAverageRateDay()
        {
            var bll = new SKT.LeanMES.Kanban.BLL.BuiltinKanBan();
            var dt = bll.K6_GetLineUPPHAverageRateDay();
            if (dt != null)
            {
                result = JsonConvert.SerializeObject(dt);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }

        /// <summary>
        /// K8-日合格率按照车间线体每天日合格率数据连线展示
        /// </summary>
        public void K8_GetLineUPHDay()
        {
            var bll = new SKT.LeanMES.Kanban.BLL.BuiltinKanBan();
            var dt = bll.K8_GetLineUPHDay();
            if (dt != null)
            {
                result = JsonConvert.SerializeObject(dt);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }

        /// <summary>
        /// K9-日合格率按照车间线体每天日合格率数据连线展示
        /// </summary>
        public void K9_GetLineQualityRateDay()
        {
            var bll = new SKT.LeanMES.Kanban.BLL.BuiltinKanBan();
            var dt = bll.K9_GetLineQualityRateDay();
            if (dt != null)
            {
                result = JsonConvert.SerializeObject(dt);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }

        #endregion

        /// <summary>
        /// IQC合格率及不良分布看板—IQC来料合格率
        /// </summary>
        public void GetIQCPassRateAndBadDistributionKanbanInCome()
        {
            var bll = new SKT.LeanMES.Material.BLL.MaterialIQC();
            var dt = bll.GetIQCPassRateAndBadDistributionKanbanInCome();
            if (dt != null)
            {
                result = JsonConvert.SerializeObject(dt);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }


        /// <summary>
        /// IQC合格率及不良分布看板—来料不良分布
        /// </summary>
        public void GetIQCPassRateAndBadDistributionKanbanNGDistribute()
        {
            var bll = new SKT.LeanMES.Material.BLL.MaterialIQC();
            var dt = bll.GetIQCPassRateAndBadDistributionKanbanNGDistribute();
            if (dt != null)
            {
                result = JsonConvert.SerializeObject(dt);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }


        /// <summary>
        /// 获取看板轮播配置信息
        /// </summary>
        public void GetKanbanCarouselConfigDetail(string id)
        {
            var bll = new SKT.LeanMES.Kanban.BLL.KanBanCarouselConfigDetail();
            var list = bll.GetAll(-1, -1, "Sequence", new Common.Model.SearchSettings { ExtensionCondition = string.Format("kcd.CarouselConfigId = {0}", Convert.ToInt32(id)) });
            if (list != null)
            {
                result = JsonConvert.SerializeObject(list);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }

        /// <summary>
        /// 获取线别信息
        /// </summary>
        /// <param name="lineId"></param>
        /// <returns></returns>
        public void GetLineInfoLineID(int lineId)
        {
            SKT.LeanMES.Resource.BLL.Line lineBll = new LeanMES.Resource.BLL.Line();
            SKT.LeanMES.Resource.Model.LineInfo info = lineBll.GetInfo(lineId);
            response.Write(JsonConvert.SerializeObject(info));
        }

        /// <summary>
        /// 获取看板欢迎词
        /// </summary>
        /// <param name="workshopId"></param>
        /// <param name="lineId"></param>
        /// <returns></returns>
        public void GetWelcome(int workshopId, int lineId, int kanbanType)
        {
            string welcomeStr = "";

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
            response.Write(welcomeStr);
        }

        /// <summary>
        /// 获取服务器日期
        /// </summary>
        /// <returns></returns>
        public void GetServerDateAndWeek()
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
            var str = string.Concat(DateTime.Now.Year, "年", DateTime.Now.Month, "月", DateTime.Now.Day, "日", " ", strWeek);
            response.Write(str);
        }

        /// <summary>
        /// 获取服务器时间
        /// </summary>
        /// <returns></returns>
        public void GetServerTime(string fmt)
        {
            string str = string.Empty;
            if (fmt == "0")
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
                str = string.Concat(DateTime.Now.Year, "年", DateTime.Now.Month, "月", DateTime.Now.Day, "日", " ", strWeek);
            }
            else
            {
                str = DateTime.Now.ToString(fmt);
            }
            response.Write(str);
        }

        /// <summary>
        /// 获取首件检验看板
        /// </summary>
        public void GetFirstInspectionKanbanList()
        {
            string json = ComMethod.GetListJson("uspGetFirstInspectionKanbanList", "{}");
            response.Write(json);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}