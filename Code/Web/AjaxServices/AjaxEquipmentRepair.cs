using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEquipmentRepair
    {
        /// <summary>
        /// 新增
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EquipmentRepairEdit(EquipmentRepairInfo entity,string name)
        {
            try
            {
                new EquipmentRepair().Edit(entity, name);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 检验设备号是否存在未完成的维修单
        /// </summary>
        /// <param name="eqCode"></param>
        [AjaxMethod]
        public int CheckEquimentRepair(string eqCode)
        {
            try
            {
               return  new EquipmentRepair().CheckEquimentRepair(eqCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }
        
    }
}