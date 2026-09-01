using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.SMT.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSMTTransferMaterial
    {
        /// <summary>
        /// 获取工单转料原工单
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public Dictionary<int, string> GetOrderList(string value)
        {
            Dictionary<int, string> dicArr = new Dictionary<int, string>();
            TransferMaterial transferMaterialBll = new TransferMaterial();
            try
            {
                string where = "  ";
                if (value != "")
                {
                    where = string.Format(" and FBILLNO like '%{0}%'", value);
                }
                dicArr = transferMaterialBll.GetTOPOrderList(where);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dicArr;
        }

        /// <summary>
        /// 获取工单转料目标工单
        /// </summary>
        /// <param name="linePlanId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public Dictionary<int, string> GetTargetOrderList(int linePlanId)
        {
            Dictionary<int, string> dicArr = new Dictionary<int, string>();
            TransferMaterial transferMaterialBll = new TransferMaterial();
            try
            {
                dicArr = transferMaterialBll.GetTargetOrderList(linePlanId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dicArr;
        }
        
        /// <summary>
        /// SMT排产工单转料
        /// </summary>
        /// <param name="linePlanId"></param>
        /// <param name="targetLinePlanId"></param>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void ChangeSMTMaterial(int linePlanId, int targetLinePlanId,bool isChangeMuMap)
        {
            int userId = AccountController.GetCurrentUserInfo().UserId;
            string userName = AccountController.GetCurrentUserInfo().UserName;

            TransferMaterial transferMaterialBll = new TransferMaterial();
            try
            {
                transferMaterialBll.ChangeSMTMaterial(linePlanId,targetLinePlanId,userId,userName, isChangeMuMap);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}