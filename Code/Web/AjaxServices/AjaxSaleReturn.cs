using SKT.LeanMES.SaleReturn.Model;
using SKT.LeanMES.SaleReturn.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSaleReturn
    {
        /// <summary>
        /// 获取退货单列表
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SaleReturnInfo> GetSaleReturnList(SaleReturnInfo entity)
        {
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                var ss = new Common.Model.SearchSettings();
                var where = " Status < 2";
                if (!string.IsNullOrEmpty(entity.SaleReturnNo) && entity.SaleReturnNo.Replace("'", "").Length > 0)
                {
                    where += $" AND SaleReturnNo LIKE '%{entity.SaleReturnNo.Replace("'", "")}%'";
                }
                ss.ExtensionCondition = where;
                return bll.GetAll(0, 10, "SaleReturnNo", ss);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 获取退货单列表
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SaleReturnExInfo> GetSaleReturnListEx(SaleReturnExInfo entity)
        {
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                var ss = new Common.Model.SearchSettings();
                var where = " Status < '2' AND IsClosed = 0";
                if (!string.IsNullOrEmpty(entity.DocNo) && entity.DocNo.Replace("'", "").Length > 0)
                {
                    where += $" AND DocNo LIKE '%{entity.DocNo .Replace("'", "")}%'";
                }
                ss.ExtensionCondition = where;
                return bll.GetAllEx(0, 10, "DocNo", ss);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 获取退货单信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public SaleReturnInfo GetSaleReturnInfo(SaleReturnInfo entity)
        {
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                var ss = new Common.Model.SearchSettings();
                var where = $" Status < 2 AND SaleReturnNo = '{entity.SaleReturnNo.Replace("'", "")}'";
                ss.ExtensionCondition = where;
                var list = bll.GetAll(0, 1, "SaleReturnNo", ss);
                return list == null ? null : list[0];
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 获取退货单信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public SaleReturnExInfo GetSaleReturnExInfo(SaleReturnExInfo entity)
        {
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                var ss = new Common.Model.SearchSettings();
                var where = $" Status < 2 AND IsClosed = 0 AND DocNo = '{entity.DocNo.Replace("'", "")}'";
                ss.ExtensionCondition = where;
                var list = bll.GetAllEx(0, 1, "DocNo", ss);
                return list == null || list.Count ==0 ? null : list[0];
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 获取退货单明细列表
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SaleReturnDtlInfo> GetSaleReturnDetail(SaleReturnDtlInfo entity)
        {
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                var ss = new Common.Model.SearchSettings();
                var where = " 1 = 1";
                if (!string.IsNullOrEmpty(entity.SaleReturnNo) && entity.SaleReturnNo.Replace("'", "").Length > 0)
                {
                    where += $" AND SaleReturnNo = '{entity.SaleReturnNo.Replace("'", "")}'";
                }
                ss.ExtensionCondition = where;
                return bll.GetSaleReturnDtlList(-1, int.MaxValue, "SaleReturnNo", ss);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public List<SaleReturnDtlInfo> GetSaleReturnDetailByDtlId(int SaleReturnDtlId)
        {
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                var ss = new Common.Model.SearchSettings();
                var where = " 1 = 1";
                if (SaleReturnDtlId >0)
                {
                    where += $" AND SaleReturnDtlId = '{ SaleReturnDtlId }'";
                }
                ss.ExtensionCondition = where;
                return bll.GetSaleReturnDtlList(-1, int.MaxValue, "SaleReturnNo", ss);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 获取退货单明细列表
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SaleReturnDtlExInfo> GetSaleReturnDetailEx(SaleReturnDtlExInfo entity)
        {
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                var ss = new Common.Model.SearchSettings();
                var where = " 1 = 1";
                if (!string.IsNullOrEmpty(entity.DocNo) && entity.DocNo.Replace("'", "").Length > 0)
                {
                    where += $" AND DocNo = '{entity.DocNo.Replace("'", "")}'";
                }
                ss.ExtensionCondition = where;
                return bll.GetSaleReturnDtlExList(-1, int.MaxValue, "DocNo", ss);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        /// <summary>
        /// 成品退货扫描记录
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SaleReturnScanInfo> GetSaleReturnScanList(SaleReturnScanInfo entity)
        {
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                return bll.GetSaleReturnScanList(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }


        /// <summary>
        /// 成品退货扫描记录
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SaleReturnScanExInfo> GetSaleReturnScanExList(SaleReturnScanExInfo entity)
        {
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                return bll.GetSaleReturnScanExList(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 成品退货—扫描SN、客户SN、包装箱号、栈板号、GRN  
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public List<SaleReturnScanInfo> SaleReturnScanSN(SaleReturnScanInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;

                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                return bll.SaleReturnScanSN(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }


        /// <summary>
        /// 成品退货—扫描SN、客户SN、包装箱号、栈板号、GRN  
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public List<SaleReturnScanExInfo> SaleReturnScanSNEx(SaleReturnScanExInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;

                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                return bll.SaleReturnScanSNEx(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 成品退货—扫描SN、客户SN、包装箱号、栈板号、GRN  
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void SaleReturnDeleteSN(SaleReturnScanInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;

                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                bll.SaleReturnDeleteSN(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void SaleReturnDeleteSNEx(SaleReturnScanExInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;

                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                bll.SaleReturnDeleteSNEx(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 成品退货-保存
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void SaleReturnSave(SaleReturnInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;

                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                bll.SaleReturnSave(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 成品退货-保存
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void SaleReturnExSave(SaleReturnExInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;

                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                bll.SaleReturnExSave(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取成品退货详情列表
        /// </summary>
        /// <param name="SaleReturnId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SaleReturnDetailExInfo> GetSaleReturnDetailExAll(long SaleReturnId)
        {
            List<SaleReturnDetailExInfo> list = new List<SaleReturnDetailExInfo>();
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                SearchSettings search = new SearchSettings();
                search.ExtensionCondition = string.Format("  DocId='{0}' ", SaleReturnId);
                list = bll.GetSaleReturnDetailExAll(0, int.MaxValue, "", search);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public List<SaleReturnDetailExInfo> GetSaleReturnDetailExById(long saleReturnDtlId)
        {
            List<SaleReturnDetailExInfo> list = new List<SaleReturnDetailExInfo>();
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                SearchSettings search = new SearchSettings();
                search.ExtensionCondition = string.Format("  Id='{0}' ", saleReturnDtlId);
                list = bll.GetSaleReturnDetailExAll(0, int.MaxValue, "", search);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public List<SaleReturnDetailExInfo> GetSaleReturnDetailExByDocNo(string DocNo)
        {
            List<SaleReturnDetailExInfo> list = new List<SaleReturnDetailExInfo>();
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                SearchSettings search = new SearchSettings();
                search.ExtensionCondition = string.Format("  DocNo='{0}' ", DocNo);
                list = bll.GetSaleReturnDetailExAll(0, int.MaxValue, "", search);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 根据
        /// </summary>
        /// <param name="saleReturnDtlId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<Prod_SaleReturn> GetSaleReturnByDel(int saleReturnDtlId)
        {
            List<Prod_SaleReturn> list = new List<Prod_SaleReturn>();
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                list = bll.GetSaleReturnByDel(saleReturnDtlId);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        /// <summary>
        /// 成品退货新增编辑
        /// </summary>
        /// <param name="strjosn"></param>
        [AjaxMethod]
        public void SaleReturnEdit(string strjosn)
        {
            try
            {
                var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                bll.SaleReturnEdit(strjosn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

    }
}