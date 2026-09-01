using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.ExtensionTables.Model;
using SKT.LeanMES.ExtensionTables.BLL;


namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxExtensionFields
    {
        /// <summary>
        /// 编辑扩展字段信息
        /// </summary>
        /// <param name="entity">扩展字段信息</param>
        [AjaxMethod]
        public void ExtensionFieldsEdit(ExtensionFieldsInfo entity)
        {
            try
            {
                ExtensionFields bll = new ExtensionFields();
                if (entity.ExtensionFieldsId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}