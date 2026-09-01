using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Navigation.Model;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    
    public class AjaxNavigation
    {
        /// <summary>
        /// 导航组增加和编辑
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void NavigationGroupEdit(NavigationInfo entity)
        {
            try
            {
                SKT.LeanMES.Navigation.BLL.Navigation bll = new LeanMES.Navigation.BLL.Navigation();

                if (entity.ID == -1)
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
        /// <summary>
        /// 导航项增加和编辑
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]

        public void NavigationItemEdit(NavigationitemInfo entity)
        {
            try
            {
                SKT.LeanMES.Navigation.BLL.Navigationitem bll = new SKT.LeanMES.Navigation.BLL.Navigationitem();

                if (entity.ID == -1)
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

        [AjaxMethod]
        public List<NavigationInfo> GetNavigationALL()
        {
            SearchSettings searchSettings = new SearchSettings();
            SKT.LeanMES.Navigation.BLL.Navigation bll = new LeanMES.Navigation.BLL.Navigation();
            List<NavigationInfo>  list = bll.GetAll(0, int.MaxValue, "Sequence", searchSettings);
            return list;
        }

        [AjaxMethod]
        public List<NavigationitemInfo> GetNavigationItemALL()
        {
            SearchSettings searchSettings = new SearchSettings();
            SKT.LeanMES.Navigation.BLL.Navigationitem bll = new SKT.LeanMES.Navigation.BLL.Navigationitem();
            List<NavigationitemInfo> list = bll.GetAll(0, int.MaxValue, "Sequence", searchSettings);
            return list;
        }

        [AjaxMethod]
        public string GetSequence(Int32 id)
        {
            string strJson = "";
            try
            {
                strJson = new SKT.LeanMES.Navigation.BLL.Navigation().GetSequence(id);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return strJson;
        }

        [AjaxMethod]

        public string GetitemSequence(Int32 id)
        {
            string strJson = "";
            try
            {
                strJson = new SKT.LeanMES.Navigation.BLL.Navigationitem().GetmSequence(id);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return strJson;
        }        

    }
}