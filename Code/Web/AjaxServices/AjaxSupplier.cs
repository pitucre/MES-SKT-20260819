using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Supplier.BLL;
using SKT.LeanMES.Supplier.Model;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.SerialNumber.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSupplier
    {
        /// <summary>
        /// 编辑供应商信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditSupplier(SuppliersInfo entity)
        {
            try
            {
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                (new Suppliers()).Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        //根据采购单号获取采购单详细
        [AjaxMethod]
        public string GetSupplierDeliveryItem(string poCode)
        {
            string strJson = "";
            try
            {
                strJson = new SupplierDelivery().GetSupplierDeliveryItem(poCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }
        /// <summary>
        /// 保存供应商交期维护
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string SaveSupplierDelivery(string strJson)
        {
            string str = "";
            try
            {
                str = (new SupplierDelivery()).Save(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        /// <summary>
        /// 编辑供应商交期维护-根据采购单号获取采购单详细
        /// </summary>
        /// <param name="supplierDeliveryId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string SupplierDeliveryEdit(string supplierDeliveryId)
        {
            string strJson = "";
            try
            {
                strJson = new SupplierDelivery().SupplierDeliveryEdit(supplierDeliveryId);
            } 
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }
        /// <summary>
        /// 供应商交期维护-根据登录用户名获取用户中文名
        /// </summary>
        /// <param name="supplierDeliveryId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetNameByUser(string userName)
        {
            string strJson = "";
            try
            {
                strJson = new SupplierDelivery().GetNameByUser(userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }
       

        /// <summary>
        /// 保存供应商送样信息
        /// </summary>
        /// <param name="strJson"></param>
        [AjaxMethod]
        public void SaveSendSample(string strJson)
        {
            try
            {
                new SupplierDelivery().SaveSendSample(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 根据产品ID获取产品的供应商送样信息
        /// </summary>
        /// <param name="itemId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public String GetSupplierSendSample(int itemId)
        {
            string strJson = "";
            try
            {
                strJson = new SupplierDelivery().GetSupplierSendSample(itemId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }
        /// <summary>
        /// 返回所有供应商
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SuppliersInfo> GetGetVendorCodeList(string value)
        {
            SuppliersInfo entity = null;
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            int userId = AccountController.GetCurrentUser().UserId;
            int userType= AccountController.GetCurrentUser().UserType;
            if (userType == -1)
            {
                searchSettings.ExtensionCondition = string.Format("   VendorCode like '%{0}%'   or   VendorName   like '%{1}%'  ", value, value);
            }
            else
            {
                entity = (new Suppliers()).GetVenCodeByUserId(userId);
                string VendorCode = "";
                if (entity != null)
                {
                    VendorCode = entity.VendorCode;
                }
                if (VendorCode !="")
                {
                    searchSettings.ExtensionCondition = string.Format("   VendorCode='{0}' and   VendorCode like '%{1}%'   or   VendorName   like '%{2}%'  ", VendorCode, value, value);
                }
                else
                {
                    searchSettings.ExtensionCondition = string.Format("   VendorCode like '%{0}%'   or   VendorName   like '%{1}%'  ", value, value);
                }
                
            }

            List <SuppliersInfo> list = new List<SuppliersInfo>();
            SKT.LeanMES.Supplier.BLL.Suppliers bll = new Suppliers();
            list=bll.GetAll(0, 20, "", searchSettings);
            return list;
        }

        /// <summary>
        /// 
        /// 验证GRN有效性
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="cartonsn"></param>
        /// <param name="vendorCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] FirstValidateGRN(string grn, string cartonsn, string vendorCode)
        {
            string[] str = new string[3];
            try
            {
                str = (new Suppliers()).FirstValidateGRN(grn, cartonsn, vendorCode, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
    }
}