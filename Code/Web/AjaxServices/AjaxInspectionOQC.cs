using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxInspectionOQC
    {
        /// <summary>
        /// 获取模版信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
      /*  [AjaxMethod]
        public string GetOqcFormModel(int intId)
        {
            string str = "";
            try
            {
                str = (new ProductOQC()).GetOqcFormModel(intId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 获取模版信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetOqcFormItem(int intIqcId, int intTempId)
        {
            string str = "";
            try
            {
                str = (new ProductOQC()).GetOqcFormItem(intIqcId, intTempId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 获取模版LCR信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetOqcFormLcrItem(int intIqcId)
        {
            string str = "";
            try
            {
                str = (new ProductOQC()).GetOqcFormLcrItem(intIqcId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        /// <summary>
        /// 保存OQC检验结果
        /// </summary>
        /// <param name="strJson"></param>
        [AjaxMethod]
        public void SaveOqcCheck(string strJson)
        {
            try
            {
                (new ProductOQC()).SaveOqcCheck(strJson);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 获取模版信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetPqcFormModel(int intId)
        {
            string str = "";
            try
            {
                str = (new ProductPQC()).GetPqcFormModel(intId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 获取模版LCR信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetPqcFormLcrItem(int intIqcId)
        {
            string str = "";
            try
            {
                str = (new ProductPQC()).GetPqcFormLcrItem(intIqcId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 保存OQC检验结果
        /// </summary>
        /// <param name="strJson"></param>
        [AjaxMethod]
        public void SavePqcCheck(string strJson)
        {
            try
            {
                (new ProductPQC()).SavePqcCheck(strJson);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 获取模版信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetPqcFormItem(int intIqcId, int intTempId)
        {
            string str = "";
            try
            {
                str = (new ProductPQC()).GetPqcFormItem(intIqcId, intTempId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }*/
    }
}