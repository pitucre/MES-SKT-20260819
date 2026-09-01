using System;
using System.Collections.Generic;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Synchronization.BLL;
using SKT.LeanMES.Synchronization.Model;
using SKT.Common.Model;
using SKT.LeanMES.CommonDataSource.Model;


namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSynchronization
    {
        [AjaxMethod]
        public int EidtSynchronization(SynchronizationInfo entity)
        {
            int affectRow = -1;
            try
            {
                SKT.LeanMES.Synchronization.BLL.Synchronization synchronization = new SKT.LeanMES.Synchronization.BLL.Synchronization();
                entity.CreateTime = DateTime.Now;
                entity.ModifyTime = DateTime.Now;
                affectRow = synchronization.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return affectRow;
        }

        [AjaxMethod]
        public List<ProcParameterInfo> GetAll(string procedureNames)
        {
            List<ProcParameterInfo> procParameterinfos = new List<ProcParameterInfo>();
            string[] procedureNameArr = procedureNames.Split(new char[]{'|'},StringSplitOptions.RemoveEmptyEntries);
            if (procedureNameArr.Length == 0)
            {
                WebHelper.ShowMessage("没有存储过程名称!");
                return null;
            }

            try
            {
                SKT.LeanMES.CommonDataSource.BLL.DataSource bll = new LeanMES.CommonDataSource.BLL.DataSource();
                procParameterinfos = bll.GetParameterInfoByProcNames(procedureNameArr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return procParameterinfos;
        }

        [AjaxMethod]
        public void ExecuteNonQuery(List<ProcParameterInfo> parms)
        {
            try
            {
                SKT.LeanMES.CommonDataSource.BLL.DataSource bll = new LeanMES.CommonDataSource.BLL.DataSource();
                bll.ExecuteProc(parms);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #region 保存手动同步信息
        /// <summary>
        /// 保存手动同步信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void SaveManualSync(int SyncID, string SyncType, string SyncContent)
        {
            try
            {

                SKT.LeanMES.Synchronization.BLL.Synchronization synchronization = new SKT.LeanMES.Synchronization.BLL.Synchronization();
                synchronization.SaveManualSync(SyncID, SyncType, SyncContent, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion
    }
}