using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEquipmentLineRelation
    {
        [AjaxMethod]
        public void EquipmentLineRelationEdit(EquipmentLineRelationInfo m)
        {
            try
            {
                new EquipmentLineRelation().Edit(m);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}