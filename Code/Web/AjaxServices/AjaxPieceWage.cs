using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.PieceWage.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxPieceWage
    {
        /// <summary>
        /// 编辑设备类型
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void Edit(int pieceWageId, int txtStationId, int txtEquipmentId, int txtItemId, string txtPrice, string txtRemark, string NO)
        {
            try
            {
                SKT.LeanMES.PieceWage.BLL.PieceWage bll = new SKT.LeanMES.PieceWage.BLL.PieceWage();

                string CreateBy = null;
                string ModifyBy = null;
                if (pieceWageId == -1)
                {
                    CreateBy = AccountController.GetCurrentUser().UserName;
                    ModifyBy = "";
                }
                else
                {
                    ModifyBy = AccountController.GetCurrentUser().UserName;
                    CreateBy = "";
                }

                var num = bll.Edit(pieceWageId, txtStationId, txtEquipmentId, txtItemId, Convert.ToDecimal(txtPrice), txtRemark, CreateBy, ModifyBy, NO);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public void StationOutputRateEdit(string strJson)
        {
            try
            {
                SKT.LeanMES.PieceWage.BLL.StationOutputRate bll = new LeanMES.PieceWage.BLL.StationOutputRate();
                bll.Edit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void PieceworkCompensationEdit(PieceworkCompensationInfo entity)
        {
            try
            {
                SKT.LeanMES.PieceWage.BLL.PieceworkCompensation bll = new LeanMES.PieceWage.BLL.PieceworkCompensation();
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}