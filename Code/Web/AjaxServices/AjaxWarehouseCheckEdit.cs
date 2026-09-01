using AjaxPro;
using SKT.LeanMES.Material.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxWarehouseCheckEdit
    {
        /// <summary>
        /// 盘点修改功能
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="materialid"></param>
        /// <param name="locationid"></param>
        /// <param name="oldno"></param>
        /// <param name="currentno"></param>
        /// <param name="reason"></param>
        /// <param name="userid"></param>
        [AjaxMethod]
        public void Edit(string sn, string materialid, string locationid, string oldno, string currentno, string reason, string userid)
        {
            try
            {
                new WarehouseCheckOrder().Edit(sn, materialid, locationid, oldno, currentno, reason, userid);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}