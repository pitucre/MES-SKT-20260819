using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEquipmentCheckOutHistory
    {
        [AjaxMethod]
        public void EquipmentCheckOutHistoryEdit(EquipmentCheckOutHistoryInfo entity)
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