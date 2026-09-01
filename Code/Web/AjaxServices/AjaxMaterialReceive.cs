using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Supplier.Model;
using SKT.Common.Model;
using System.Threading;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMaterialReceive
    {

        [AjaxMethod]
        public string MaterialGRNDel(Int32 receiveType, string POCode, int orderDetailId,string GRN)
        {
            string strJson = "";
            try
            {
                if (!string.IsNullOrEmpty(GRN)) {
                    orderDetailId = -1;
                }
                string userName = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
                strJson = new SKT.LeanMES.Material.BLL.Material().MaterialGRNDel(receiveType, POCode, orderDetailId, userName,GRN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }
        /// <summary>
        /// 根据送货单获取可收料的送货单明细
        /// </summary>
        /// <param name="deliverCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetMaterialDeliverDtl(string deliverCode, string grnCode, int choosePageId, bool isScanGRN)
        {
            string strJson = "";
            try
            {
                strJson = new MaterialIQC().GetMaterialDeliverDtl(deliverCode, grnCode, choosePageId, isScanGRN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }

        [AjaxMethod]
        public string GetGRNInfoByReceive(Int32 receiveType, String grn, String poCode, Int32 poDetailId)
        {
            string strJson = "";
            try
            {
                string userName = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
                strJson = new SKT.LeanMES.Material.BLL.Material().GetGRNInfoByReceive(receiveType, grn, poCode, poDetailId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }
       
        [AjaxMethod]
        public string SaveReceiveMaterial(String strJson)
        {
            string iqcId = "";
            try
            {
               
                    iqcId = new SKT.LeanMES.Material.BLL.Material().SaveReceiveMaterial(strJson);
              
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return iqcId;
        }

        [AjaxMethod]
        public void OnCancelGRN(String mydeliverOrder)
        {
            try
            {
                new SKT.LeanMES.Material.BLL.Material().OnCancelGRN(mydeliverOrder);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public List<SupplierDeliveryInfo> GetShowOrder(int typeId, string charsets)
        {
            try
            {
                List<SupplierDeliveryInfo> list = null;
                SearchSettings s = new SearchSettings();
                if (typeId == 103)
                {
                    s.ExtensionCondition += " POCode like '%" + charsets + "%' ";
                    list = new SKT.LeanMES.Supplier.BLL.SupplierDelivery().SupplierDeliveryPO(0, 20, "", s);
                }
                else if (typeId == 104)
                {
                    s.ExtensionCondition += " POCode like '%" + charsets + "%' ";
                    list = new SKT.LeanMES.Supplier.BLL.SupplierDelivery().ReceiveInStock(0, 20, "", s);
                }
                else if (typeId == 105)
                {
                    s.ExtensionCondition += " POCode like '%" + charsets + "%' ";
                    list = new SKT.LeanMES.Supplier.BLL.SupplierDelivery().ReceiveDeliverPO(0, 20, "", s);
                }
                return list;
            }
            catch (Exception ex)
            {
                throw;
            }
           
        }
        [AjaxMethod]
        public List<SupplierDeliveryInfo> GetShowOrderPDA(int typeId,int Vender,int IsSupplierPeriod, string charsets)
        {
            try
            {
                List<SupplierDeliveryInfo> list = null;
                SearchSettings s = new SearchSettings();
                if (typeId == 103)
                {
                    var SearchCondition = Vender == -1 ? "1=1" : ("SupplierId =" + Vender);
                    //if (IsSupplierPeriod == 1)
                    //{ //需要交期维护
                    //    SearchCondition = SearchCondition + " AND IsPeriod = 1 ";
                    //}
                    //else
                    //{
                    //    SearchCondition = SearchCondition + " AND IsPeriod = 0 ";
                    //}
                    s.ExtensionCondition += SearchCondition + " AND  POCode like '%" + charsets + "%' ";

                    list = new SKT.LeanMES.Supplier.BLL.SupplierDelivery().SupplierDeliveryPOMaterialDeliver(0, 20, "", s);
                }
                return list;
            }
            catch (Exception ex)
            {
                throw;
            }

        }


        [AjaxMethod]
        public string GetReceiveOrderBySN(string grnCode,int choosePageId)
        {
            string strJson = "";
            try
            {
                strJson = new MaterialIQC().GetReceiveOrderBySNDal(grnCode, choosePageId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }

    }
}