using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.SteelItem.Model;
using SKT.LeanMES.SteelMesh.Model;
using SKT.LeanMES.Lookup.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSteelItem
    {
        [AjaxMethod]
        public void SteelItemEdit(SteelItemInfo entity, String enterFactory)
        {
            try
            {
                SKT.LeanMES.SteelItem.BLL.SteelItem bll = new SteelItem.BLL.SteelItem();
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        //[AjaxMethod]
        //public void InsertItemSteel(String chooseId, Int32 hdfId, Int32 hdfPart)
        //{
        //    try
        //    {
        //        SKT.LeanMES.SteelItem.BLL.SteelItem bll = new SteelItem.BLL.SteelItem();
        //        String creater = AccountController.GetCurrentUser().UserName;
        //        Int32 createrid = AccountController.GetCurrentUser().UserId;
        //        //bll.InsertItemSteelInfo(chooseId, hdfId, hdfPart, creater, createrid);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //}

        //[AjaxMethod]
        //public void DeleteItemSteel(String chooseId, Int32 hdfId, Int32 hdfPart)
        //{
        //    try
        //    {
        //        SKT.LeanMES.SteelItem.BLL.SteelItem bll = new SteelItem.BLL.SteelItem();
        //        String creater = AccountController.GetCurrentUser().UserName;
        //        Int32 createrid = AccountController.GetCurrentUser().UserId;
        //        bll.DeleteItemSteelInfo(chooseId, hdfId, hdfPart, creater, createrid);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //}

        [AjaxMethod]
        public void SteelCofigEdit(string SteelConfigCode, string Result, string Remark)
        {
            Lookup.BLL.Lookup Bll = new Lookup.BLL.Lookup();
            Dictionary<string, object> lookCondition = new Dictionary<string, object>();
            lookCondition.Add("Alpha2", SteelConfigCode);
            List<LookupInfo> list = Bll.GetLookupByCondition("SYS_SteelConfig", lookCondition);
            if (list.Count > 0)
            {
                list[0].Alpha3 = Result;
                list[0].Alpha5 = Remark;
                list[0].Modifier = AccountController.GetCurrentUser().UserName;
                list[0].ModifyDate = DateTime.Now;
                try
                {
                    Bll.Edit(list[0]);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                }
            }
            else
            {
                WebHelper.HandleException(new Exception("更新失败!"));
            }
        }
    }
}