using System;
using System.Collections.Generic;
using AjaxPro;
using SKT.LeanMES.CommonDataSource.Model;
using SKT.LeanMES.CommonDataSource.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxServiceGlobarParameter
    {
        /// <summary>
        /// 编辑全局
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public Int32 GlobarParameterEdit(GlobarParametersInfo entity)
        {
            int GlobarParameterId = -1;
            try
            {
                //GetID
                GlobarParameterId = (new SKT.LeanMES.CommonDataSource.BLL.GlobarParameter()).Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return GlobarParameterId;
        }
        /// <summary>
        /// GetAll
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<GlobarParametersInfo> GetAll()
        {
            List<GlobarParametersInfo> list = null;
            try
            {
                list = (new SKT.LeanMES.CommonDataSource.BLL.GlobarParameter()).GetAll(0, -1, "", null);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public string GetParaType(Int32 id)
        {
            string strJson ="";
            try
            {
                strJson = new SKT.LeanMES.CommonDataSource.BLL.GlobarParameter().GetParaType(id);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return strJson;
        }
        //[AjaxMethod]
        //public void Delete(string idString)
        //{
        //    try
        //    {
        //        (new SKT.LeanMES.GlobarParameter.Bll.GlobarParameter()).Delete(idString, AccountController.GetCurrentUser().UserName);

        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //}
    }
}