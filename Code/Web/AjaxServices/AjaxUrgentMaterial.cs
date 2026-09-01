using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// 急料
    /// </summary>
    public class AjaxUrgentMaterial
    {
        [AjaxMethod]
        public void UrgentMaterialEdit(UrgentMaterialInfo model)
        {
            try
            {
                new UrgentMaterial().Edit(model);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}