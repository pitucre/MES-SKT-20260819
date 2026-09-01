using AjaxPro;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxCustomMenu
    {
        #region 编辑/添加模块信息
        /// <summary>
        /// 编辑/添加模块信息
        /// </summary>
        /// <param name="KeyCNValues"></param>
        /// <param name="KeyENValues"></param>
        /// <param name="seq"></param>
        /// <param name="FatherKey"></param>
        [AjaxMethod]
        public void EditCustomMenu(string KeyCNValues, string KeyENValues, float seq, string FatherKey,string Remark)
        {
            try
            {
                (new SKT.LeanMES.CustomMenu.BLL.CustomMenu()).EditCustomMenu(KeyCNValues, KeyENValues, seq, FatherKey, AccountController.GetCurrentUser().UserName, Remark);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 编辑/添加界面信息
        /// <summary>
        /// 编辑/添加模块信息
        /// </summary>
        /// <param name="KeyCNValues"></param>
        /// <param name="KeyENValues"></param>
        /// <param name="seq"></param>
        /// <param name="FatherKey"></param>
        [AjaxMethod]
        public void EditCustomPage(SKT.LeanMES.CustomMenu.Model.CustomMenuInfo entity)
        {
            try
            {
                new SKT.LeanMES.CustomMenu.BLL.CustomMenu().EditCustomPage(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion
    }
}