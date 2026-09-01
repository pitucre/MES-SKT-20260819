using AjaxPro;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMouldOperateRecord
    {

        [AjaxMethod]
        public long Edit(MouldOperateRecordInfo entity)
        {
            long OpearteReId = -1;
            try
            {
                OpearteReId = new MouldOperateRecord().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return OpearteReId;
        }

        /// <summary>
        /// 获取模具履历
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public List<MouldOperateRecordInfo> GetMouldOperateRecord(int id)
        {
            List<MouldOperateRecordInfo> list = new List<MouldOperateRecordInfo>();
            try
            {
                list = new MouldOperateRecord().GetMouldOperateRecord(id);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public void MouldMaintenanceUploadFile_PDA(string mouldCode, string Remark, string OperaType, string file)
        {
            try
            {
                string username = AccountController.GetCurrentUser().UserName;
                new MouldOperateRecord().MouldMaintenanceUploadFile_PDA(mouldCode, Remark, OperaType, file, username);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        [AjaxMethod]
        public void MouldMaintenanceCheck_PDA(string mouldCode)
        {
            try
            {
                new MouldOperateRecord().MouldMaintenanceCheck_PDA(mouldCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

    }
}