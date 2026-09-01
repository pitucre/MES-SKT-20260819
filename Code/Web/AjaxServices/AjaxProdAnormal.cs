using SKT.Common.DAL.Marshal;
using SKT.LeanMES.ProdAnormal.Model;
using SKT.LeanMES.ProdAnormal.BLL;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxProdAnormal
    {
        private string user = AccountController.GetCurrentUser().UserName;
        [AjaxMethod]
        public int Editdata(AnormalInfo2 entity, bool isSendMsg = false, int flag = 0)
        {
            int id = -1;
            try
            {
                entity.CreateDateTime = DateTime.Now;
                entity.CreateBy = user;
                entity.StartTime = DateTime.Now;
                entity.EndTime = DateTime.Now;
                entity.LineStopTime = DateTime.Now;
                entity.ActionTime = DateTime.Now;

                SKT.LeanMES.ProdAnormal.BLL.Anormal bll = new SKT.LeanMES.ProdAnormal.BLL.Anormal();
                id = bll.Edit(entity, isSendMsg, flag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(user, ex);
            }
            return id;
        }

        [AjaxPro.AjaxMethod]
        public List<LeanMES.Anormal.Model.AnormalTypeInfo> GetAnormalList(int anormalTypeId)
        {
            List<LeanMES.Anormal.Model.AnormalTypeInfo> list = null;
            try
            {
                SKT.LeanMES.Anormal.BLL.AnormalType bll = new LeanMES.Anormal.BLL.AnormalType();

                SKT.Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();
                searchSettings.ExtensionCondition = " AnormalGroupId = " + anormalTypeId;
                list = bll.GetAll(0, -1, "", searchSettings);
                
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxPro.AjaxMethod]
        public void AuditAnormal(int anormalId,string remark)
        {
            try
            {
                var cmdTxt = " update prod_anormal set status = 3, AuditPerson = @AuditPerson, AuditTime = @AuditTime, AuditRemark = @AuditRemark where anormalId = @AnormalId";
                SqlParameter[] parms = new SqlParameter[] {
                    new SqlParameter("@AnormalId", System.Data.SqlDbType.Int),
                    new SqlParameter("@AuditPerson",System.Data.SqlDbType.NVarChar,50),
                    new SqlParameter("@AuditTime",System.Data.SqlDbType.DateTime),
                    new SqlParameter("@AuditRemark",System.Data.SqlDbType.NVarChar,200)
                };
                parms[0].Value = anormalId;
                parms[1].Value = AccountController.GetCurrentUser().EmployeeCName;
                parms[2].Value = DateTime.Now;
                parms[3].Value = remark;
                
                SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, cmdTxt, parms);
            }
            catch(Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// IPQC确认
        /// </summary>
        /// <param name="anormalId"></param>
        [AjaxPro.AjaxMethod]
        public void AnormalIPQCConfirm(int anormalId)
        {
            try
            {
                var cmdTxt = " update Prod_AnormalSolution set IPQCConfirmer = @IPQCConfirmer, status = 2 where anormalId = @AnormalId";
                SqlParameter[] parms = new SqlParameter[] {
                    new SqlParameter("@AnormalId", System.Data.SqlDbType.Int),
                    new SqlParameter("@IPQCConfirmer",System.Data.SqlDbType.NVarChar,50)
                };
                parms[0].Value = anormalId;
                parms[1].Value = AccountController.GetCurrentUser().EmployeeCName;

                SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, cmdTxt, parms);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        //根据工单id获取获取已投产数、不良数、不良率
        [AjaxPro.AjaxMethod]
        public List<LeanMES.ProdAnormal.Model.AnormalInfo2> GetStatistic(int orderId)
        {
            List<LeanMES.ProdAnormal.Model.AnormalInfo2> list = null;
            try
            {
                SKT.LeanMES.ProdAnormal.BLL.Anormal bll = new LeanMES.ProdAnormal.BLL.Anormal();
                list = bll.GetStatistic(orderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
    }
}