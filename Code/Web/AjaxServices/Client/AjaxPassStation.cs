using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.ProductionCollection.Client;

namespace SKT.LeanMES.Web.AjaxServices
{
    /******************************************************************************************
     * 类名：AjaxPassStation      
     * 功能描述：此类主要应用于开发内置UI类型为【过站】的Ajax方法
     * 创建人：zhiman.yuan
     * 创建时间：2017-7-3
     * 修改人：
     * 修改时间：
     ******************************************************************************************/
    public class AjaxPassStation
    {
        
        /// <summary>
        /// 验证扫描条码是否为不良，如果为不良则验证不良并返回不良描述信息，否则返回空字串
        /// </summary>
        /// <param name="nccode"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetNCCodeInfo(string nccode, int stationId)
        {
            string[] nccodeArr = new string[2];
            ProdCollectionPassStation passStationBll = new ProdCollectionPassStation();
            try
            {
                nccodeArr = passStationBll.GetNCCodeInfo(nccode, stationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return nccodeArr;
        }

        /// <summary>
        /// 过站采集UI 可采集不良（单个不良、拼版不良）
        /// </summary>
        /// <param name="panelId"></param>
        /// <param name="sn"></param>
        /// <param name="resId"></param>
        /// <param name="stationId"></param>
        /// <param name="userId"></param>
        /// <param name="nccodeXML"></param>
        [AjaxMethod]
        public void CollectPassStation(Int64 panelId, string sn, int resId, int stationId, string nccodeXML)
        {
            int userId = AccountController.GetCurrentUser().UserId;
            ProdCollectionPassStation passStationBll = new ProdCollectionPassStation();

            try
            {
                passStationBll.CollectPassStation(panelId,sn,resId,stationId,userId,nccodeXML);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 过站采集UI 可采集不良（单个不良、拼版不良）----启益PDA
        /// </summary>
        /// <param name="panelId"></param>
        /// <param name="sn"></param>
        /// <param name="resId"></param>
        /// <param name="stationId"></param>
        /// <param name="userId"></param>
        /// <param name="nccodeXML"></param>
        [AjaxMethod]
        public void CollectPassStationNEW(Int64 panelId, string sn, int resId, int stationId, string nccodeXML)
        {
            int userId = AccountController.GetCurrentUser().UserId;
            ProdCollectionPassStation passStationBll = new ProdCollectionPassStation();

            try
            {
                passStationBll.CollectPassStationNEW(panelId, sn, resId, stationId, userId, nccodeXML);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 离线生产采集UI（可采集不良信息 只记录采集历史 不进行过站操作）
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="nccodeArr"></param>
        /// <param name="resId"></param>
        /// <param name="stationId"></param>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void OfflineProCollect(string sn, string nccodeArr, int resId, int stationId)
        {
            ProdCollectionPassStation passStationBll = new ProdCollectionPassStation();
            int userId = AccountController.GetCurrentUser().UserId;

            try
            {
                passStationBll.OfflineProCollect(sn, nccodeArr, resId, stationId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 不良采集UI 验证 SN Pass最大允许次数
        /// </summary>
        [AjaxMethod]
        public void CheckPassCountStation(string sn, int stationId)
        {
            try
            {
                ProdCollectionPassStation passStationBll = new ProdCollectionPassStation();
                passStationBll.CheckPassCountStation(sn, stationId);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);

            }
        }
    }
}