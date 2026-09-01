using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Rework.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxRework
    {
        /// <summary>
        /// 生产中的返工
        /// </summary>
        /// <param name="prodId">工单Id</param>
        /// <param name="opeId">返回的工位Id</param>
        /// <param name="sn">主机号</param>
        /// <param name="userId">用户</param>
        /// <param name="tag">1 工单整批返工 2 主机返工</param>
        [AjaxMethod]
        public string[] InProductionRework(int prodId, int opeId, string sn, int userId, int tag,int isUnAss)
        {
            string[] arr = new string[4];

            try
            {
                arr = (new Reworks()).InProductionRework(prodId, opeId, sn, userId, tag, isUnAss);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return arr;
        }


        /// <summary>
        /// 成品返工
        /// </summary>
        /// <param name="prodId"></param>
        /// <param name="reProdId"></param>
        /// <param name="sn"></param>
        /// <param name="userId"></param>
        /// <param name="tag"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] FinishedProductRework(int prodId, int reProdId, string sn, int userId, int tag)
        {
            string[] arr = new string[4];

            try
            {
                arr = (new Reworks()).FinishedProductRework(prodId, reProdId, sn, userId, tag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return arr;
        }
    }
}