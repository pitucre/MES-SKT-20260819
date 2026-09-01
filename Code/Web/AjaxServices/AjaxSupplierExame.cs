using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Warehouse.Model;
using SKT.LeanMES.Warehouse.BLL;
using System.Data;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSupplierExame
    {
        [AjaxMethod]
        public void SupplierExameTypeEdit(SupplierExameTypeInfo entity)
        {
            try
            {
                SupplierExameType wht = new SupplierExameType();
                if (entity.SupplierExameTypeId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                wht.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public void SupplierExameContentEdit(SupplierExameContentInfo info)
        {
            try
            {
                info.Creater = AccountController.GetCurrentUser().UserName;
                new LeanMES.Warehouse.BLL.SupplierExameContent().Edit(info);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public List<SupplierExameContentInfo> GetSupplierExameContentTree(int ParentId = -1)
        {
            List<SupplierExameContentInfo> list = new LeanMES.Warehouse.BLL.SupplierExameContent().GetAllTree(ParentId);
            return list;
        }

        [AjaxMethod]
        public void SupplierExameContentDelete(int id)
        {
            string userName = AccountController.GetCurrentUser().UserName.ToString();
            new LeanMES.Warehouse.BLL.SupplierExameContent().Delete(id + "", userName);
        }

        [AjaxMethod]
        public void SaveExameTemplet(SupplierExameTempletInfo Info, List<SupplierExameTempletDtlInfo> TempletDtls, List<SupplierExameTempletVendorInfo> TempletVendors)
        {
            try
            {
                SupplierExameTemplet bll = new SupplierExameTemplet();                
                DataTable dtTempletDtls = PubItems.BLL.PubItems.ToDataTable(from q in TempletDtls select new { q.SupplierExameTempletID, q.SupplierExameContentId, q.SupplierExameName, q.SupplierExameType, q.SupplierExameCompute, q.AssessmentWeight });
                DataTable dtTempletVendors = PubItems.BLL.PubItems.ToDataTable(from q in TempletVendors select new { q.SupplierExameTempletID, q.SupplierID });
                Info.CreateBy= AccountController.GetCurrentUser().UserName.ToString();
                if(Info.SupplierExameTempletID>0)
                Info.ModifyBy = AccountController.GetCurrentUser().UserName.ToString();

                bll.SaveExameTemplet(Info, dtTempletDtls, dtTempletVendors);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public List<SupplierExameTempletDtlInfo> GetTemplateDtlById(int TemplaterId)
        {
            try
            {
                SupplierExameTemplet bll = new SupplierExameTemplet();
                return bll.GetTemplateDtlById(TemplaterId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        [AjaxMethod]
        public List<SupplierExameTempletVendorInfo> GetTemplateVendorById(int TemplaterId)
        {
            try
            {
                SupplierExameTemplet bll = new SupplierExameTemplet();
                return bll.GetTemplateVendorById(TemplaterId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        [AjaxMethod]
        public List<SupplierExameContentResultInfo> GenerateExamData(string ExamType, string ExamData)
        {
            try
            {
                SupplierExameResult bll = new SupplierExameResult();

                return bll.GenerateExamData(ExamType, ExamData, AccountController.GetCurrentUser().EmployeeCName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        [AjaxMethod]
        public List<SupplierExameContentResultInfo> SearchExamData(string ExamType, string ExamData)
        {
            try
            {
                SupplierExameResult bll = new SupplierExameResult();

                return bll.SearchExamData(ExamType, ExamData, false);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        [AjaxMethod]
        public void SaveExamChangeData(List<ExamChangeDataInfo> list)
        {
            try
            {
                SupplierExameResult bll = new SupplierExameResult();

                 bll.SaveExamChangeData(list);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        [AjaxMethod]
        public List<SupplierExameContentResultInfo> SearchExamDataSupplier(string ExamType, string ExamData, string VendorCode)
        {
            try
            {
                SupplierExameResult bll = new SupplierExameResult();

                return bll.SearchExamDataSupplier(ExamType, ExamData, VendorCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        [AjaxMethod]
        public void CheckSupplierExameCompute(string Proc)
        {
            try
            {
                SupplierExameResult bll = new SupplierExameResult();

                bll.CheckSupplierExameCompute(Proc);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}