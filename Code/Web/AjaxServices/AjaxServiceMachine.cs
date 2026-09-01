using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxServiceMachine
    {
        /// <summary>
        ///增加smt设备信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void AddMachine(MachineInfo entity)
        {
            try
            {
                Machine bllMachine = new Machine();
                if (entity.ID == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bllMachine.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        ///编辑smt设备状态
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditStatus(int Id, int table, byte Status)
        {
            try
            {
                Machine bllMachine = new Machine();
                string ModifyBy = AccountController.GetCurrentUser().UserName;
                bllMachine.EditStatus(Id, table, Status, ModifyBy);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public List<MachineInfo> GetMachine(string MachineID)
        {
            Machine bllmachine = new Machine();
            List<MachineInfo> Lsitentity = null;
            try
            {
                Lsitentity = bllmachine.GetInfo(MachineID);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
            }
            return Lsitentity;
        }

        [AjaxMethod]
        public List<MachineTableInfo> GetMachineTable(string MachineID)
        {
            try
            {
                MachineTable bllmachinetable = new MachineTable();
                List<MachineTableInfo> Lsitentity = bllmachinetable.GetInfo(MachineID);
                return Lsitentity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public List<MachineTableSlotInfo> GetMachineTableSlot(string MachineTableID)
        {
            try
            {
                MachineTableSlot bllmachinetableslot = new MachineTableSlot();
                List<MachineTableSlotInfo> Lsitentity = bllmachinetableslot.GetInfo(MachineTableID);
                return Lsitentity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
    }
}