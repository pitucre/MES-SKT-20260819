using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEquipmentItemRelation
    {
        [AjaxMethod]
        public void EquipmentItemRelationEdits(EquipmentItemRelationInfo entity)
        {
            try
            {
                new LeanMES.Equipment.BLL.EquipmentItemRelation().Edit(entity);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        /// <summary>
        /// 删除机种设备关系
        /// </summary>
        /// <param name="eqCode">设备Code</param>

        /// <param name="itemString">机种</param>
        [AjaxMethod]
        public void RemoveItemOutEquipment(string eqCode, string itemString)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                var bll = new LeanMES.Equipment.BLL.EquipmentItemRelation();
                bll.RemoveItemOutEquiment(eqCode, itemString, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        ///保存机种与设备关系
        /// </summary>
        /// <param name="eqCode">设备Code</param>
        /// <param name="itemString">机种</param>
        /// <returns></returns>
        [AjaxMethod]
        public string SaveItemInEquiment(string eqCode, string itemString)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                var bll = new LeanMES.Equipment.BLL.EquipmentItemRelation();
                return bll.SaveItemInEquiment(eqCode, itemString, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return "";
        }

    }
}