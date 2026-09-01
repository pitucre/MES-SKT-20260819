using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxItemMouldRelation
    {
        [AjaxMethod]
        public void ItemMouldRelationEdits(ItemMouldRelationInfo entity)
        {
            try
            {
                new LeanMES.Equipment.BLL.ItemMouldRelation().Edit(entity);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        /// <summary>
        /// 删除模具产品关系
        /// </summary>
        /// <param name="mouldId">模具Id</param>

        /// <param name="itemString">机种</param>
        [AjaxMethod]
        public void RemoveMouldOutItem(int mouldId, string itemString)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                var bll = new LeanMES.Equipment.BLL.ItemMouldRelation();
                bll.RemoveMouldOutItem(mouldId, itemString, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        ///保存机种与产品关系
        /// </summary>
        /// <param name="mouldId">模具Id</param>
        /// <param name="itemString">产品Id</param>
        /// <returns></returns>
        [AjaxMethod]
        public string SaveMouldInItem(int mouldId, string itemString,int type)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                var bll = new LeanMES.Equipment.BLL.ItemMouldRelation();
                return bll.SaveMouldInItem(mouldId, itemString, userName,type);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return "";
        }

    }
}