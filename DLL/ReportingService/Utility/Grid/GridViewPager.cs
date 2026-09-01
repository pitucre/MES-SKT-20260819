using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using Newtonsoft.Json;
using SKT.MES.ReportingService.Utility.Common.Helpers;
using SKT.MES.ReportingService.Utility.DataBase;
using SKT.MES.ReportingService.Utility.JSON;
using SKT.MES.ReportingService.Utility.View;

namespace SKT.MES.ReportingService.Utility.Grid
{
	/// <summary>
    /// 表翻页
    /// </summary>
	public class GridViewPager : DataBasePager
	{
		/// <summary>
        /// 
        /// </summary>
		private static IList<ViewInfo> _views;

		/// <summary>
        /// 构造函数初始化
        /// </summary>
		public GridViewPager()
		{ 
			HttpContext httpContext = HttpContext.Current;
			GridViewPager._views.Add(new ViewInfo(CommonHelper.ObjToStr(httpContext.Request.Params["gridviewname"]), CommonHelper.ObjToStr(httpContext.Request.Params["sortname"])));
		}

		/// <summary>
        /// 
        /// </summary>
		public override IList<ViewInfo> Views
		{
			get
			{
				return GridViewPager._views;
			}
		}

		/// <summary>
        /// 获取Json格式数据
        /// </summary>
        /// <returns></returns>
		public string GetDataJSON()
		{
			HttpContext httpContext = HttpContext.Current;
			string a = CommonHelper.ObjToStr(httpContext.Request.Params["dataAction"]);
			int pageNo = CommonHelper.ObjToInt(httpContext.Request.Params["page"]);
			int pageSize = CommonHelper.ObjToInt(httpContext.Request.Params["pagesize"]);
			string sortname = CommonHelper.ObjToStr(httpContext.Request.Params["sortname"]);
			string sortorder = CommonHelper.ObjToStr(httpContext.Request.Params["sortorder"]);
			string gridViewName = CommonHelper.ObjToStr(httpContext.Request.Params["gridviewname"]);
			string searchConditions = CommonHelper.ObjToStr(httpContext.Request.Params["conditions"]);
			bool isPROC = !(a == "TABLE");
			List<ParamInfo> lists = CommonHelper.ObjToParamList(httpContext.Request.Params["paramters"]);
			return this.GetDataJSON(gridViewName, pageNo, pageSize, sortname, sortorder, isPROC, lists, searchConditions);
		}

        /// <summary>
        /// 获取Json格式数据
        /// </summary>
        /// <param name="GridViewName"></param>
        /// <param name="pageNo"></param>
        /// <param name="pageSize"></param>
        /// <param name="sortname"></param>
        /// <param name="sortorder"></param>
        /// <param name="isPROC"></param>
        /// <param name="lists"></param>
        /// <param name="searchConditions"></param>
        /// <returns></returns>
        public string GetDataJSON(string GridViewName, int pageNo, int pageSize, string sortname, string sortorder, bool isPROC, List<ParamInfo> lists, string searchConditions)
		{
			int recordCount = 0;
			sortorder = ((sortorder.ToLower() == "asc") ? "Asc" : "Desc");
			string orderStr = "order by " + sortname + " " + sortorder;
			DataTable gridView = base.GetGridView(GridViewName, pageNo, pageSize, orderStr, searchConditions, ref recordCount, isPROC, lists);
			return this.GetJSONFromDataTable(gridView, recordCount);
		}

		/// <summary>
        /// Table转Json字符串
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="recordCount"></param>
        /// <returns></returns>
		public string GetJSONFromDataTable(DataTable dt, int recordCount)
		{
			string result;
			try
			{
				string text = JsonConvert.SerializeObject(dt, new JsonConverter[]
				{
					new DataTableConverter()
				});
				string text2 = string.Concat(new object[]
				{
					"{\"Rows\":",
					text,
					",\"Total\":\"",
					recordCount,
					"\"}"
				});
				result = text2;
			}
			catch
			{
				result = "{\"Rows\":[],\"Total\":\"0\"}";
			}
			return result;
		}

        /// <summary>
        /// 静态构造函数 初始化
        /// </summary>
        static GridViewPager()
		{ 
			GridViewPager._views = new List<ViewInfo>();
		}
	}
}
