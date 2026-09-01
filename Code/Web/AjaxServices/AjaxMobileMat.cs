using System;
using System.Collections.Generic;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Material.BLL;


namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMobileMat
    {
        /// <summary>
        /// 物料入库   add by weixia on 2015/4/28
        /// </summary>
        [AjaxMethod]
        public List<MaterialUnitInfo> InStorageMaterial(String grn, String wareCode)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                list = bllUnit.InStorageMaterial(grn, wareCode, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        /// <summary>
        /// 保存发料方法
        /// </summary>
        [AjaxMethod]
        public void SaveSendMaterial(string RequestId, Int32 selLocation, String grnStr, String userName)
        {
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                bllUnit.CheckSendMaterial(RequestId, selLocation, grnStr, userName);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 获取发料信息
        /// </summary>
        /// <param name="formId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> CheckSendMaterial(String ItemStr, String grn, Int32 flage, String grnStr)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                list = bllUnit.CheckSendMaterialNew(ItemStr, grn, flage, grnStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        /// <summary>
        /// 获取领料信息
        /// </summary>
        /// <param name="formId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> sendMaterialInfo(String formNumber)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                list = bllUnit.sendMaterialInfo(formNumber);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 生产退料
        /// </summary>
        /// <param name="grn">物料条码</param>
        /// <param name="wareCode">库位条码</param>
        /// <param name="qty">退料数量</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> ReturnMaterial(String grn, String wareCode, Decimal qty, Int32 deptId)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                list = bllUnit.ReturnMaterial(grn, wareCode, qty, AccountController.GetCurrentUser().UserName, deptId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }



        /// <summary>
        /// 获取先进先出列表   zhibin.chen   2015-05-11
        /// </summary>
        /// <param name="itemId">ItemId</param>
        /// <param name="startRow">开始行</param>
        /// <param name="maxRow">获取多少行</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SKT.LeanMES.MobileMat.Model.MaterialInfo> GetFirstInFirstOutList(int itemId, int startRow, int maxRow)
        {
            List<SKT.LeanMES.MobileMat.Model.MaterialInfo> list = null;
            try
            {
                SKT.LeanMES.MobileMat.BLL.Material bll = new SKT.LeanMES.MobileMat.BLL.Material();
                list = bll.GetFirstInFirstOutList(itemId, startRow, maxRow);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        /// <summary>
        /// 获取入库信息  add by weixia on 2015/5/18
        /// </summary>
        [AjaxMethod]
        public List<MaterialUnitInfo> GetInStorageItemInfo(Int32 flag, String grn, String wareCode)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                list = bllUnit.GetInStorageItemInfo(flag, grn, wareCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 物料入库 add by weixia on 2015/5/18
        /// </summary>
        [AjaxMethod]
        public void SaveInStorageInfo(Int32 erpVouchId, String cBarCode, Int32 itemId, String IQCBatchNo, String userName, String lotCode)
        {
            try
            {
                MaterialUnit bllUnit = new MaterialUnit();
                bllUnit.SaveInStorageInfo(erpVouchId, cBarCode, itemId, IQCBatchNo, userName, lotCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 库位转移
        /// add by weixia on 2015.10.22
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="Code"></param>
        /// <param name="userName"></param>
        /// <param name="flag"></param>
        [AjaxPro.AjaxMethod]
        public void StorageTransfer(String sn, String Code, String userName, Int32 flag)
        {
            try
            {
                MaterialUnit bll = new MaterialUnit();
                bll.StorageTransfer(sn, Code, userName, flag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}