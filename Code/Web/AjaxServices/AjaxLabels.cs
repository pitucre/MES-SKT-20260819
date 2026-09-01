using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using SKT.LeanMES.Labels.BLL;
using SKT.LeanMES.Labels.Model;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.Labels.Pdf;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxLabels
    {
        /// <summary>
        ///获取打印机组
        /// </summary>
        [AjaxMethod]
        public List<string> GetPrinterGroup()
        {
            try
            {
                return new Printer().GetGroupName();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return new List<string>();
        }
        /// <summary>
        /// 添加打印机
        /// </summary>
        /// <param name="model"></param>
        [AjaxMethod]
        public void AddPrinter(string ip, int port, string mac, string printers)
        {
            try
            {
                new Printer().Add(ip, port, mac, printers, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 编辑打印机
        /// </summary>
        /// <param name="model"></param>
        [AjaxMethod]
        public void EditPrinter(PrinterInfo entity)
        {
            try
            {
                new Printer().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 编辑标签字段
        /// </summary>
        /// <param name="model"></param>
        [AjaxMethod]
        public void EditLabelDef(LabelFieldInfo model, string s)
        {
            try
            {
                (new LabelField()).Edit(model, s);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取字段定义内容
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [AjaxMethod]
        public DataTable GetInfo(int id)
        {
            DataTable dt = null;
            try
            {
                dt = (new LabelField()).GetInfo(id);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dt;
        }

        [AjaxMethod]
        public List<LabelDocumentInfo> GetAllDocumentBySN(String SN, int isPackSN)
        {
            List<LabelDocumentInfo> list = null;
            try
            {
                list = (new LabelDocument()).GetAllDocumentBySN(SN, isPackSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        /// 获取文档标签
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<LabelDocumentInfo> GetLabels()
        {
            List<LabelDocumentInfo> list = null;
            try
            {
                list = (new LabelDocument()).GetAll(0, -1, "", null);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public DataTable GetLabelFormatInfo(int labelId)
        {
            DataTable dt = null;
            try
            {
                dt = (new LabelField()).GetLabelFormatInfo(labelId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dt;
        }

        [AjaxMethod]
        public void AddLabelFormat(int labelId, int labelFieldId, string labelFieldName, string createBy)
        {
            try
            {
                (new LabelField()).AddLabelFormat(labelId, labelFieldId, labelFieldName, createBy);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public string DeleteLabelFormat(int labelFieldId, int labelId, string userName)
        {
            string s = "";
            try
            {
                s = (new LabelField()).DeleteLabelFormat(labelFieldId, labelId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return s;
        }

        /// <summary>
        /// 修改文档列表
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public int LabelDocumentEdit(LabelDocumentInfo entity)
        {
            try
            {
                return new LabelDocument().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(entity.CreateBy, ex);
                return 0;
            }
        }
        /// <summary>
        /// 修改文档模板设计
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void TemplateEdit(PrintTemplateInfo entity)
        {
            try
            {
                if (entity.TempId > 0)
                {
                    PrintTemplateInfo old = new PrintTemplate().GetEnityByTempId(entity.TempId);
                    if (old != null)
                        entity.TempSet = old.TempSet;
                }
                if (string.IsNullOrWhiteSpace(entity.TempSet))
                    entity.TempSet = "[]";
                entity.CreateDateTime = DateTime.Now;
                entity.ModifyDateTime = DateTime.Now;

                List<int> ids = new List<int>();
                List<PrintTemplateDtl> templist = Newtonsoft.Json.JsonConvert.DeserializeObject<List<PrintTemplateDtl>>(entity.TempSet);
                templist.ForEach(item =>
                {
                    if (!string.IsNullOrWhiteSpace(item.key))
                    {
                        ids.Add(Convert.ToInt32(item.key));
                    }
                });
                string str = string.Join(",", ids.Distinct().ToArray());
                new PrintTemplate().Edit(entity, str);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(entity.CreateBy, ex);
            }
        }


        /// <summary>
        /// 新增修改ZPL标签
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void LabelZPLEdit(LabelZPLInfo entity, string ZplValues)
        {
            try
            {
                new LabelZPL().Edit(entity, ZplValues);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public DataTable GetCustomFun()
        {
            DataTable dt = null;
            try
            {
                dt = (new LabelField()).GetCustomFun();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dt;
        }



        /// <summary>
        /// 修改标签文档
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void LabelItemDocumentEdit(LabelItemDocumentsInfo entity)
        {
            try
            {
                new LabelItemDocuments().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 查找标签文档名称
        /// </summary>
        /// <param name="DocumentName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<LabelDocumentInfo> GetName(string DocumentName)
        {
            List<LabelDocumentInfo> list = null;
            SearchSettings searchSettings = new SearchSettings();
            if (DocumentName != "")
            {
                searchSettings.ExtensionCondition = " DocumentName like '%" + DocumentName + "%'";
            }

            try
            {
                list = (new LabelDocument()).GetAll(0, -1, "", searchSettings);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


    }
}
