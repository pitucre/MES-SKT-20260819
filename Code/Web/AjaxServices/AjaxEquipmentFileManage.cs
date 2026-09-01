using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEquipmentFileManage
    {
        [AjaxMethod]
        public void EquipmentFileManageEdit(EquipmentFileManageInfo entity)
        {
            try
            {
                new EquipmentFileManage().Edit(entity);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}