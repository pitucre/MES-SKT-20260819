using System;
using System.Collections.Generic;
using System.Web;
using SKT.LeanMES.FormTemplate.BLL;

using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxFormTmpl
    {
        /// <summary>
        /// 获取单据的页面布局Html(新增时(Add)的界面调用)
        /// </summary>
        /// <param name="categoryId">单据类型大类(1: 加工流程单  2:工序采集单  3:追溯记录表)</param>
        /// <param name="formTypeId">单据类型Id</param>
        /// <returns>返回页面布局的Html</returns>
        [AjaxMethod]
        public String GetFormLayout(Int32 categoryId, Int32 formTypeId)
        {
            String UIHtml = "";
            try
            {
                UIHtml = (new FormTmplateFileds()).GetFormLayout(categoryId, formTypeId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return UIHtml;
        }

        /// <summary>
        /// 获取单据的页面布局Html(编辑时(Edit)的界面调用)
        /// </summary>
        /// <param name="id">单据实体ID</param>
        /// <param name="categoryId">单据类型大类(1: 加工流程单  2:工序采集单  3:追溯记录表)</param>
        /// <param name="formTypeId">单据类型Id</param>
        /// <returns>返回页面布局的Html(含赋值)</returns>
        [AjaxMethod]
        public String GetFormLayoutValue(Int32 id, Int32 categoryId, Int32 formTypeId)
        {
            String UIHtml = "";
            try
            {
                UIHtml = (new FormTmplateFileds()).GetFormLayoutValue(id, categoryId, formTypeId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return UIHtml;
        }

        /// <summary>
        /// 获取单据的页面布局Html(查看时(View)的界面调用)
        /// </summary>
        /// <param name="id">单据实体ID</param>
        /// <param name="categoryId">单据类型大类(1: 加工流程单  2:工序采集单  3:追溯记录表)</param>
        /// <param name="formTypeId">单据类型Id</param>
        /// <returns>返回页面布局的Html(含赋值)</returns>
        [AjaxMethod]
        public String GetFormLayoutViewValue(Int32 id, Int32 categoryId, Int32 formTypeId)
        {
            String UIHtml = "";
            try
            {
                UIHtml = (new FormTmplateFileds()).GetFormLayoutViewValue(id, categoryId, formTypeId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return UIHtml;
        }

        /// <summary>
        /// 单据保存通用处理方法(保存(Add/Edit在Save)时调用)
        /// </summary>
        /// <param name="id">单据实体ID</param>
        /// <param name="categoryId">单据类型大类(1: 加工流程单  2:工序采集单  3:追溯记录表)</param>
        /// <param name="frmTypeId">单据类型Id</param>
        /// <param name="colString">单据列名串联字符串,</param>
        /// <param name="cloValString">单据列值串联字符串^</param>
        /// <param name="createBy">创建人</param>
        /// <param name="modifyBy">修改人</param>
        /// <returns>返回单据实体ID</returns>
        [AjaxMethod]
        public Int32 FormSave(Int32 id, Int32 categoryId, Int32 frmTypeId, String colString, String cloValString, String createBy, String modifyBy)
        {
            Int32 frmId = id;
            try
            {
                frmId = (new FormTmplateFileds()).FormSave(id, categoryId, frmTypeId, colString, cloValString, createBy, modifyBy);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return frmId;
        }
    }
}