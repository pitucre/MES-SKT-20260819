using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// Summary description for AjaxServiceContainer
    /// </summary>
    public class AjaxServiceMachineModel
    {
        /// <summary>
        ///更新或者增加设备
        /// </summary>
        /// <param name="entity">容器实体类</param>
        [AjaxMethod]
        public void EditMachineMode(MachineModelInfo entity)
        {
            try
            {
                MachineModel bllMachineModel = new MachineModel();
                if (entity.ModelID == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bllMachineModel.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        ///更新或者增加设备组
        /// </summary>
        /// <param name="entity">容器实体类</param>
        [AjaxMethod]
        public void EditMachineModelFamily(MachineModelFamilyInfo entity)
        {
            try
            {
                MachineModelFamily bllMachineModelFamily = new MachineModelFamily();
                if (entity.ModelFamilyID == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bllMachineModelFamily.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        ///更新或者增加设备属性
        /// </summary>
        /// <param name="entity">容器实体类</param>
        [AjaxMethod]
        public void EditMachineModelAttribute(MachineModelAttributeInfo entity)
        {
            try
            {
                MachineModelAttribute bllMachineModelAttribute = new MachineModelAttribute();
                if (entity.ModelAttrID == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bllMachineModelAttribute.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}