using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEquipmentMouldRelation
    {
        [AjaxMethod]
        public void EquipmentMouldRelationEdits(EquipmentMouldRelationInfo entity)
        {
            try
            {
                new LeanMES.Equipment.BLL.EquipmentMouldRelation().Edit(entity);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        /// <summary>
        /// 删除模具设备关系
        /// </summary>
        /// <param name="mouldId">模具Id</param>

        /// <param name="itemString">机种</param>
        [AjaxMethod]
        public void RemoveMouldOutEquipment(int mouldId, string itemString)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                var bll = new LeanMES.Equipment.BLL.EquipmentMouldRelation();
                bll.RemoveMouldOutEquiment(mouldId, itemString, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        ///保存机种与设备关系
        /// </summary>
        /// <param name="mouldId">模具Id</param>
        /// <param name="equimentString">设备Id</param>
        /// <returns></returns>
        [AjaxMethod]
        public string SaveMouldInEquiment(int mouldId, string equimentString)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                var bll = new LeanMES.Equipment.BLL.EquipmentMouldRelation();
                return bll.SaveMouldInEquiment(mouldId, equimentString, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return "";
        }

    }
}