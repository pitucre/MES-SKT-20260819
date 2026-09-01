using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using AjaxPro;
using SKT.LeanMES.ProdAnormal.Model;
using SKT.LeanMES.ProdAnormal.BLL;
using SKT.Common.Model;
using FastJSON;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxAnormalConfig
    {
        /// <summary>
        /// 编辑
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditAnormalConfig(AnormalConfigInfo entity)
        {
            try
            {
                AnormalConfig AnormalConfig = new AnormalConfig();
                if (entity.AnormalConfigID == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                }
                AnormalConfig.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}