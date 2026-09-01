using System;
using AjaxPro;
using SKT.LeanMES.Quality.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxInspectionFQC
    {
        [AjaxMethod]
        public string GetFQCFormModel(int intId)
        {
            string str = "";
            try
            {
                str = (new InspectionFQC()).GetFQCFormModel(intId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        [AjaxMethod]
        public string GetFqcFormItem(Int32 intId, Int32 intTempId)
        {
            string str = "";
            try
            {
                str = (new InspectionFQC()).GetFqcFormItem(intId, intTempId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }


        [AjaxMethod]
        public void SaveCheck(string strJson)
        {
            try
            {
                (new InspectionFQC()).SaveCheck(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public string FQCGrnNG(string sn, string InspectionFQCNo, int TemplateId ,string Remarks,  int type)
        {
            string str = "";
            try
            {
                str = (new InspectionFQC()).FQCGrnNG(sn, InspectionFQCNo, TemplateId,Remarks, type);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

    }
}
