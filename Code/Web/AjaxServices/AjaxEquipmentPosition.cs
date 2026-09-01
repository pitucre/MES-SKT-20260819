using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEquipmentPosition
    {
        [AjaxMethod]
        public void EquipmentPositionEdit(EquipmentPositionInfo entity)
        {
            try
            {
                new EquipmentPosition().Edit(entity);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}