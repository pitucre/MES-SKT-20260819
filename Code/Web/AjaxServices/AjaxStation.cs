using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.Station.BLL;
using SKT.LeanMES.Station.Model;

using AjaxPro;
using System.Data;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxStation
    {
        /// <summary>
        /// 工序类型新增/编辑保存
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditStationType(StationTypeInfo entity, string opeIdString)
        {
            try
            {
                StationType bll = new StationType();
                bll.Edit(entity, opeIdString);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
            }
        }

        [AjaxMethod]
        public void EditStation(StationInfo entity, string certIdString,string childStationId)
        {
            try
            {
                SKT.LeanMES.Station.BLL.Station bll = new LeanMES.Station.BLL.Station();
                bll.Edit(entity, certIdString, childStationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
            }
        }
        [AjaxMethod]
        public DataTable GetOperationByTypeId(int opeTypeId)
        {
            DataTable dt = null;
            try
            {
                dt = new SKT.LeanMES.Station.BLL.Station().GetOperationByTypeId(opeTypeId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
            }
            return dt;
        }

        [AjaxMethod]
        public void EdtiStationTestCount(StationTestCountInfo entity)
        {
            try
            {
                SKT.LeanMES.Station.BLL.StationTestCount bll = new LeanMES.Station.BLL.StationTestCount();
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public StationTypeInfo GetStationType(string fieldValue)
        {
            try
            {
                SKT.LeanMES.Station.BLL.StationType bll = new LeanMES.Station.BLL.StationType();
                return bll.GetInfo(fieldValue);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        [AjaxMethod]
        protected List<SKT.LeanMES.Station.Model.StationInfo> GetOperationStaiton()
        {
           
            List<SKT.LeanMES.Station.Model.StationInfo> list = (new SKT.LeanMES.Station.BLL.Station()).GetAll(0, -1, "StationId", null);
            
            return list;
        }
    }
}