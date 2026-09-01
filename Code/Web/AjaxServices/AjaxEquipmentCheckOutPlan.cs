using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEquipmentCheckOutPlan
    {
        [AjaxMethod]
        public void EquipmentCheckOutPlanEdit(EquipmentCheckOutPlanInfo entity)
        {
            try
            {
                if (entity.EquipmentCheckOutPlanId == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";

                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }

                new EquipmentCheckOutPlan().Edit(entity);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void Delete(string Id)
        {
            try
            {
                SKT.LeanMES.Equipment.BLL.EquipmentCheckOutPlan bll = new SKT.LeanMES.Equipment.BLL.EquipmentCheckOutPlan();
                bll.Delete(Id, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {

                throw;
            }
        }



        [AjaxMethod]
        public void CheckOut(EquipmentCheckOutHistoryInfo entity)
        {
            try
            {
                new EquipmentCheckOutHistory().Edit(entity);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}