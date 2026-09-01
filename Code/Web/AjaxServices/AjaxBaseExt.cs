using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.ExtensionTables.Model;
using SKT.LeanMES.ExtensionTables.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxBaseExt
    {
        [AjaxMethod]
        public void BaseExtInfoEdit(Base_ExtInfo entity, String tableName)
        {
            try
            {
                Base_Ext bll = new Base_Ext();
                if (entity.ExtId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bll.Edit(entity, tableName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public List<Base_ExtInfo> GetExtsionInfoListByItemId(int tableDataId, String tableName)
        {
            List<Base_ExtInfo> list = null;
            try
            {
                Base_Ext bll = new Base_Ext();
                list = bll.GetExtsionInfoListByItemId(tableDataId, tableName);

                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return list;
            }
        }

        [AjaxMethod]
        public List<Base_ExtInfo> GenerialGetExtensionInfoListByDataId(int tableDataId, String tableName)
        {
            List<Base_ExtInfo> list = null;
            try
            {
                Base_Ext bll = new Base_Ext();
                list = bll.GenerialGetExtensionInfoListByDataId(tableDataId, tableName);

                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return list;
            }
        }

        [AjaxMethod]
        public void ExecGeneralMethod(String extIds, String extFieldsIds, String extFieldValues, Int32 tableDataId, String tableName)
        {
            try
            {
                Base_Ext bll = new Base_Ext();
                string createBy = AccountController.GetCurrentUser().UserName;
                string modifyBy = AccountController.GetCurrentUser().UserName;
                bll.ExecGeneralMethod(extIds, extFieldsIds, extFieldValues, tableDataId, modifyBy, createBy, tableName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void BaseExtInfoListEdit(String extIds, String extFieldsIds, String extFieldValues, Int32 tableDataId, String tableName)
        {
            try
            {
                Base_Ext bll = new Base_Ext();

                string createBy = AccountController.GetCurrentUser().UserName;
                string modifyBy = AccountController.GetCurrentUser().UserName;
                bll.BaseExtInfoListEdit(extIds, extFieldsIds, extFieldValues, tableDataId, modifyBy, createBy, tableName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}