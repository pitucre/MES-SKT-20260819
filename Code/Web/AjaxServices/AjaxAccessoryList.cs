using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.AccessoryManagement.Model;
using SKT.LeanMES.AccessoryManagement.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxAccessoryList
    {
        [AjaxMethod]
        public void AccessoryListEdit(AccessoryListInfo entity)
        {
            try
            {
                new AccessoryList().Edit(entity);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        /// <summary>
        /// 根据辅料Id获取辅料信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [AjaxMethod]
        public AccessoryListInfo GetInfo(int id)
        {
            try
            {
                return new AccessoryList().GetInfo(id);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}