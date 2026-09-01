using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.DataType.Model;
using SKT.LeanMES.ProductionCollection.Model;
using SKT.LeanMES.ProductionCollection.Client;

namespace SKT.LeanMES.Web.AjaxServices
{
    /******************************************************************************************
     * 类名：AajxJoin      
     * 功能描述：此类主要应用于开发内置UI类型为【关联】的Ajax方法
     * 创建人：zhiman.yuan
     * 创建时间：2017-7-3
     * 修改人：
     * 修改时间：
     ******************************************************************************************/
    public class AjaxJoin
    {

        /// <summary>
        /// 检查SN和CSN的数据是否可以关联
        /// </summary>
        /// <param name="SN">序列号</param>
        /// <param name="CSN">客户序列号</param>
        /// <returns></returns>
        [AjaxMethod]
        public string ValidateSNAndCSNJoin(string SN, string CSN)
        {
            string msg = "{\"result\": \"True\", \"message\": \"\" }";
            try
            {
                string messageType = "";
                string message = "";
                ProdCollectionCustomerSN customerBll = new ProdCollectionCustomerSN();
                customerBll.CheckSNAndCSNJoin(SN, CSN, ref messageType, ref message);
                if (messageType != "TRUE")
                {
                    msg = "{\"result\": \"" + messageType + "\", \"message\": \"" + message + "\" }";
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return msg;
        }

        /// <summary>
        /// 序列号和客户序列号关联
        /// </summary>
        /// <param name="SN">序列号</param>
        /// <param name="CSN">客户序列号</param>
        /// <returns></returns>
        [AjaxMethod]
        public bool SNAndCSNJoin(string SN, string CSN, int opeId, int resId, int userId, string assyDataChangeRecords, int joinType)
        {
            bool bResult = false;
            try
            {
                ProdCollectionCustomerSN customerBll = new ProdCollectionCustomerSN();
                bResult = customerBll.SNAndCSNJoin(SN, CSN, opeId, resId, AccountController.GetCurrentUser().UserId, assyDataChangeRecords, joinType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return true;
        }

        /// <summary>
        /// 获取工站上对应的无物料数据类型
        /// </summary>
        /// <param name="SN">产品序列号</param>
        /// <param name="stationId">工站</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<DataFieldInfo> GetStationDataField(string SN, int stationId)
        {
            SKT.LeanMES.DataType.BLL.DataField bllData = new LeanMES.DataType.BLL.DataField();
            List<DataFieldInfo> dataFields = bllData.uspGetDataFieldBySNAndOpeID(SN, stationId);
            return dataFields;
        }

        /// <summary>
        /// 检查客户条码关联工序扫描的产品序列号
        //确定客户条码关联的处理模式
        ///1、在线打印客户条码：有在路由中的工序设置需要打印客户条码。
        ///2、离线打印客户条码:系统后台管理模块先打印出客户条码 ,再在采集UI中扫描
        ///3、外购客户条码：供应商打好的客户条码，在工单或产品中维护掩码组进行客户条码验证
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] CheckJoinCustomerSN(string sn, int stationId, int resourceId)
        {
            string[] customerArr = new string[3];
            ProdCollectionCustomerSN customerBll = new ProdCollectionCustomerSN();
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                customerArr = customerBll.CheckJoinCustomerSN(sn, stationId, resourceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return customerArr;
        }

        /// <summary>
        /// 关联主条码与客户条码
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="customerSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        /// 
        [AjaxMethod]
        public bool CollectCustomerSN(string sn, string customerSN, int stationId, int resouceId)
        {
            ProdCollectionCustomerSN customerBll = new ProdCollectionCustomerSN();
            bool isPrint = true;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                isPrint = customerBll.CollectCustomerSN(sn, customerSN, stationId, resouceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return isPrint;
        }

        /// <summary>
        /// 扫描STBID（SN）带出烽火包装箱与客户条码对应关系中 最小的未绑定过STBID的客户条码信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="customerSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        [AjaxMethod]
        public string[] CollectAutoCustomerSN(string sn, int stationId, int resouceId)
        {
            string[] arr = new string[2];

            ProdCollectionCustomerSN customerBll = new ProdCollectionCustomerSN();
            
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                arr = customerBll.CollectAutoCustomerSN(sn, stationId, resouceId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return arr;
        }
    }
}