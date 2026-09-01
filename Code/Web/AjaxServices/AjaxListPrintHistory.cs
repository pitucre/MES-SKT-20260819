using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.PackPrint.Model;
using SKT.LeanMES.PackPrint.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxListPrintHistory
    {
        /// <summary>
        /// 获取容器信息包装信息列表
        /// </summary>
        /// <param name="ContainerId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int Edit(int ItemId, int listType)
        {
            try
            {
                ListPrintHistory bll = new ListPrintHistory();
                ListPrintHistoryInfo entity = new ListPrintHistoryInfo();
                entity.ItemId = ItemId;
                entity.ListingTypeId = listType;
                entity.Opertor = AccountController.GetCurrentUser().UserName;

                int result= bll.Edit(entity);
                return result;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }
    }
}