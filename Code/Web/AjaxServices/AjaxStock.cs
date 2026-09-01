using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Turnover.BLL;
using SKT.LeanMES.Turnover.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxStock
    {
        [AjaxMethod]
        public void EditStockType(StockCarTypeInfo entity)
        {
            try
            {
                StockCarType bll = new StockCarType();

                if (entity.StockTypeId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }

                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 保存StockCar
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditStockCar(StockCarInfo  entity)
        {
            try
            {
                StockCar bll = new StockCar();

                if (entity.StockCarId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }

                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}