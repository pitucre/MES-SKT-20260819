using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Certification.BLL;
using SKT.LeanMES.Certification.Model;


namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxCertification
    {
        /// <summary>
        /// 更新或者增加资格认证
        /// </summary>
        /// <param name="entity">资格认证实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public void EditCertification(CertificationInfo entity)
        {
            try
            {
                new SKT.LeanMES.Certification.BLL.Certification().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        [AjaxMethod]
        public void RemoveCertsFromUser(String uCertIDString)
        {
            try
            {
                CertificationMember Member = new CertificationMember();
                Member.RemoveCertsFromUser(uCertIDString, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void AssignCertsToUser(int UserID, string uCertIDString, string dtStart, string dtExpiration)
        {
            try
            {
                CertificationMember Member = new CertificationMember();
                Member.AssignCertsToUser(UserID, uCertIDString, AccountController.GetCurrentUser().UserName, dtStart, dtExpiration);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}