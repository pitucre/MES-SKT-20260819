using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEquipmentUseReasons
    {
        [AjaxMethod]
        public void EquipmentUseReasonsEdit(EquipmentUseReasonsInfo entity)
        {
            try
            {
                new EquipmentUseReasons().Edit(entity);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}