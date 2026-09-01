using System;
using System.Collections.Generic;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Station.Model;
using SKT.LeanMES.Station.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxLogin
    {
        /// <summary>
        /// 获取所有的Operation Type
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<StationInfo> GetOperationTypeByUser(string username, int id, bool isGetOperationType)
        {
            List<StationInfo> list = null;
            try
            {
                list = (new StationType()).GetOperationTypeByUser(username, id, isGetOperationType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 根据UI获取配置了该UI的工序,如('FAIInspection,AgeingCollection')老化开始/老化结束
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<StationInfo> GetStationsByFixedUI(string UIModuleStr)
        {
            List<StationInfo> list = null;
            try
            {
                list = (new StationType()).GetStationsByFixedUI(UIModuleStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取有权限的Operation Type
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<StationInfo> GetOperationTypeByUserRole(string username, int id, bool isGetOperationType)
        {
            List<StationInfo> list = null;
            try
            {
                list = (new StationType()).GetOperationTypeByUserRole(username, id, isGetOperationType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 根据Operation Id 取得资源
        /// </summary>
        /// <param name="oprId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SKT.LeanMES.Resource.Model.ResourceInfo> GetResourcesByOprId(int oprId, string username)
        {
            List<SKT.LeanMES.Resource.Model.ResourceInfo> list = null;
            try
            {
                list = (new SKT.LeanMES.Resource.BLL.Resource()).GetResourcesByOprId(oprId, username);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 根据Operation Id 取得默认资源ID
        /// </summary>
        /// <param name="oprId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int GetDefResByOprId(int opeId)
        {
            try
            {
                return (new SKT.LeanMES.Resource.BLL.Resource()).GetDefResourcesByOprId(opeId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return -1;
            }

        }


    }
}