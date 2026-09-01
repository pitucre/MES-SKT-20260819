using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.AccessoryManagement.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxAccessoryItemRelation
    {
        [AjaxMethod]
        public int Edit(int Id,string ItemCode, string Machine, string username)
        {
            try
            {
               return new AccessoryItemRelation().Edit(Id,ItemCode, Machine, username);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}