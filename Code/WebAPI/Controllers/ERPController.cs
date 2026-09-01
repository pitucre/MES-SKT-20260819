using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebAPI.Controllers
{
    public class ERPController : Controller
    {

        // GET: ERPSyncList
        public ActionResult SyncList()
        {
            return View();
        }

        /// <summary>
        /// 获取数据同步列表
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult GetList()
        {
            var sql = @"SELECT 
	                        es.SyncId,es.SyncCode,es.SyncName,es.IsFullSync,es.InitCompleteFlag,es.IncrementalValue,es.LastSyncResult,es.LastSyncMsg,es.LastSyncTime,es.Remark,es.EnableFlag,es.CreateBy,es.CreateDateTime,es.ModifyBy,es.ModifyDateTime,es.Api,es.MiddleTableName
                        FROM dbo.ERP_Sync es";

            var list = Utility.SqlHelper.GetList<Models.MES.ERPSyncInfo>(sql);

            return Json(list, JsonRequestBehavior.AllowGet);
        }



        // GET: SyncLog
        public ActionResult SyncLog()
        {
            return View();
        }

        ///// <summary>
        ///// 获取数据同步日志列表
        ///// </summary>
        ///// <returns></returns>
        //[HttpPost]
        //public JsonResult GetLogList(QualityInspectionOrderInfo entity)
        //{

        //InspectionOrderDal dal = new InspectionOrderDal();
        //IList<QualityInspectionOrderInfo> list = null;
        //long count = 0;
        //string msg = string.Empty;
        //int code = 0;
        //try
        //{

        //    int pageIndex = Request.QueryString["page"] == null ? 1 : Convert.ToInt32(Request.QueryString["page"]);//页码
        //    int pageSize = Request.QueryString["limit"] == null ? 10 : Convert.ToInt32(Request.QueryString["limit"]);//每页显示总数

        //    entity.BasePageIndex = pageIndex;
        //    entity.BasePageSize = pageSize;
        //    list = dal.GetInspectionIPQCList(entity);
        //    count = dal.RecordCount;
        //}
        //catch (Exception ex)
        //{
        //    CloudMes.Common.SYS.SysLog.WriteException(ex, System.Reflection.MethodBase.GetCurrentMethod());
        //    msg = ex.Message;
        //    code = 1;
        //}
        //return Json(new
        //{
        //    code = code,
        //    msg = msg,
        //    data = list,
        //    count = count
        //});
        //}

    }
}
