using AjaxPro;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using System;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMoldFixtureItem
    {
        [AjaxMethod]
        public void Edit(int ItemId, int EquipmentId, decimal MoldCavity, decimal UseMoldCavity,int cid)
        {
            try
            {
                var bll = new MoldFixtureItem();
                var userName = AccountController.GetCurrentUser().UserName;
                bll.Edit(ItemId, EquipmentId, MoldCavity, UseMoldCavity,cid, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }
        [AjaxMethod]
        public MoldFixtureItemInfo GetInfo(int cid)
        {
            try
            {
                var bll = new MoldFixtureItem();
                return bll.GetInfo(cid);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }
        

        [AjaxMethod]
        public void Delete(string idString)
        {
            var userName = AccountController.GetCurrentUser().UserName;
            try
            {
                var bll = new MoldFixtureItem();
                bll.Delete(idString, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            
        }

    }
}