using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.AccessoryManagement.BLL;
using SKT.LeanMES.AccessoryManagement.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxAccessoryItemRelationDtl
    {
        [AjaxMethod]
        public int Edit(AccessoryItemRelationDtlInfo entity)
        {
            try
            {
                return new AccessoryItemRelationDtl().Edit(entity);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}