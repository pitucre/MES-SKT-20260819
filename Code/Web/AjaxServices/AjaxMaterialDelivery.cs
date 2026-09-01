using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.MaterialDelivery.BLL;
using SKT.LeanMES.MaterialDelivery.Model;
using AjaxPro;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMaterialDelivery 
    {
        /// <summary>
        /// 获取备料单明细
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialPrepareDetailInfo> GetMaterialPrepareDetail(int prepareId)
        {
            List<MaterialPrepareDetailInfo> list = new List<MaterialPrepareDetailInfo>();

            try
            {
                list = (new MaterialPrepareDetail()).GetMaterialPrepareDetail(prepareId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return list;
        }


        /// <summary>
        /// 获取备料单变更明细
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialPrepareDetailInfo> GetMaPrepChangeDetail(int prepareId)
        {
            List<MaterialPrepareDetailInfo> list = new List<MaterialPrepareDetailInfo>();

            try
            {
                list = (new MaterialPrepareDetail()).GetMaPrepChangeDetail(prepareId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return list;
        }


        /// <summary>
        /// 获取备料单子项的变更历史
        /// </summary>
        /// <returns></returns>
        /// <param name="prepareSubId">备料子项Id</param>
        [AjaxMethod]
        public List<MaterialPrepareDetailInfo> GetSubitemChangeHistory(int prepareSubId)
        {
            List<MaterialPrepareDetailInfo> list = new List<MaterialPrepareDetailInfo>();

            try
            {
                list = (new MaterialPrepareDetail()).GetSubitemChangeHistory(prepareSubId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return list;
        }

        /// <summary>
        /// 格力博线边仓收料
        /// </summary>
        /// <param name="grn">物料条码</param>
        /// <param name="user">收料人</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> ReceiveMaterialList(string grn,Int32 edgeid)
        {
            List<MaterialUnitInfo> list = null;
            try
            {
                //list = (new MaterialUnit()).ReceiveMaterialList(grn, AccountController.GetCurrentUser().UserName, edgeid);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, false);
            }
            return list;
        }

        /// <summary>
        /// 格力博线边仓按分拣单发料
        /// </summary>
        /// <param name="sendDetailXml">发料明细</param>
        /// <returns></returns>
        [AjaxMethod]
        public void SendMaterial(String sendDetailXml, Int32 lineId, Int32 PickId, string userName)
        {
            try
            {
                //(new MaterialUnit()).SendMaterial(sendDetailXml, lineId, PickId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, false);
            }

        }

        /// <summary>
        /// 获取分检单单体信息
        /// </summary>
        /// <param name="pickId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<PickMaterialsInfo> GetPickDetailList(Int32 pickId)
        {
            List<PickMaterialsInfo> list = null;
            try
            {
                list = (new PickMaterials()).GetPickDetailList(pickId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        ///// <summary>
        ///// 检查grn是否可以发料
        ///// </summary>
        ///// <param name="grn"></param>
        ///// <param name="lineId"></param>
        ///// <param name="PickId"></param>
        ///// <returns>物料的ItemId  可用量</returns>
        //[AjaxMethod]
        //public string[] CheckGRN(String grn, Int32 lineId, Int32 pickId)
        //{
        //    string[] qty = new string[2];
        //    try
        //    {
        //        qty = (new MaterialUnit()).CheckGRN(grn, lineId, pickId);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException("", ex, false);
        //    }

        //    return qty;
        //}
    }
}