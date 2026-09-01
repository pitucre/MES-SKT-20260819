using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxCheckOutProject
    {
        [AjaxMethod]
        public void CheckOutProjectEdit(CheckOutProjectInfo entity)
        {
            try
            {
                if (entity.CheckOutProjectId == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";

                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }

                    new CheckOutProject().Edit(entity);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}