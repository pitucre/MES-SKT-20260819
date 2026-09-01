using AjaxPro;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEquipmentPressureTest
    {
        [AjaxMethod]
        public void Edit(EquipmentPressureTestInfo entity)
        {
            try
            {
                new EquipmentPressureTest().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void EditDtl(EquipmentPressureTestInfo entity)
        {
            try
            {
                new EquipmentPressureTest().EditDtl(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public List<EquipmentPressureTestInfo> GetInfoDtl(int equipmentPressureTestId)
        {
            List<EquipmentPressureTestInfo> list = new List<EquipmentPressureTestInfo>();
            try
            {
                list = new EquipmentPressureTest().GetInfoDtl(equipmentPressureTestId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
         
    }
}