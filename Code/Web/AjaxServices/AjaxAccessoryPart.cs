using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.MES.DAL.Marshal;
using System.Web.Script.Serialization;
using SKT.LeanMES.Accessories.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxAccessoryPart
    {
        [AjaxMethod]
        public Int32 EditAccessoryPart(AccessoryPartInfo entity)
        {
            int retvalue = -1;

            try
            {
                SKT.LeanMES.Accessories.BLL.AccessoryPart bll = new LeanMES.Accessories.BLL.AccessoryPart();
                retvalue = bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return -1;
            }
            return retvalue;
        }
    }
}