using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.ProductChange.BLL;
using SKT.LeanMES.ProductChange.Model;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSN
    {
        SNScrapDelete snsrd = new SNScrapDelete();
        SNScrapDeleteInfo snsrdinfo = new SNScrapDeleteInfo();

        [AjaxMethod]
        public void SNScrap(String sn)
        {
            if (SKT.Common.Account.BLL.Users.CheckUserIsWarrantted(AccountController.GetCurrentUser().UserId, 30450101))
            {
                try
                {
                    snsrdinfo.SNVALUE = sn;
                    snsrdinfo.REMARK = "Scrap";
                    snsrdinfo.CreateBy = AccountController.GetCurrentUser().UserName;
                    snsrdinfo.ModifyBy = AccountController.GetCurrentUser().UserName;

                    snsrd.SNScrap(snsrdinfo);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                }
            }
            else
            {
                throw new Exception(Resources.Messages.NotWarranttedToOperater);
            }
        }

        [AjaxMethod]
        public void SNRetore(String sn)
        {
            if (SKT.Common.Account.BLL.Users.CheckUserIsWarrantted(AccountController.GetCurrentUser().UserId, 30450101))
            {
                try
                {
                    snsrdinfo.SNVALUE = sn;
                    snsrdinfo.REMARK = "Restore";
                    snsrdinfo.CreateBy = AccountController.GetCurrentUser().UserName;
                    snsrdinfo.ModifyBy = AccountController.GetCurrentUser().UserName;

                    snsrd.SNRestore(snsrdinfo);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                }
            }
            else
            {
                throw new Exception(Resources.Messages.NotWarranttedToOperater);
            }
        }

        [AjaxMethod]
        public void SNDelete(String sn)
        {
            if (SKT.Common.Account.BLL.Users.CheckUserIsWarrantted(AccountController.GetCurrentUser().UserId, 30450101))
            {
                try
                {
                    snsrdinfo.SNVALUE = sn;
                    snsrdinfo.REMARK = "Delete";
                    snsrdinfo.CreateBy = AccountController.GetCurrentUser().UserName;
                    snsrdinfo.ModifyBy = AccountController.GetCurrentUser().UserName;

                    snsrd.SNDelete(snsrdinfo);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                }
            }
            else
            {
                throw new Exception(Resources.Messages.NotWarranttedToOperater);
            }
        }

        [AjaxMethod]
        public List<SNScrapDeleteInfo> GetOrderSnList(String orderSn)
        {
            return snsrd.GetOrderSnList(orderSn);
        }


        /// <summary>
        /// 将数据插入临时表
        /// </summary>
        /// <param name="batchId">导入的批次号</param>
        /// <param name="val">导入的内容，用逗号隔开</param>
        /// <param name="type">导入内容的数据类型：0：int 1:varchar</param>
        [AjaxMethod]
        public void AddBatchTmp(string batchId, string val, int type)
        {
            try
            {
                snsrd.AddBatchTmp(batchId, val, type, AccountController.GetCurrentUser().UserId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

    }
}