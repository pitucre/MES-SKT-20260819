using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.EmailConfig.BLL;
using SKT.LeanMES.EmailConfig.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEmailConfig
    {
        /// <summary>
        /// 邮箱服务器信息配置
        /// </summary>
        [AjaxMethod]
        public void EmailServerEdit(EmailServerConfigInfo entity)
        {
            try
            {
                (new EmailServerConfig()).Edit(entity);
            }
            catch(Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 邮件接收人配置
        /// </summary>
        [AjaxMethod]
        public void EmailRecPersonEdit(EmailRecPersonInfo entity)
        {
            try
            {
                (new EmailRecPerson()).Edit(entity);
            }
            catch(Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 获取邮件接收类别
        /// </summary>
        [AjaxMethod]
        public List<RecEmailTypeDictionary> GetRecEmailType(int recId)
        {
            List<RecEmailTypeDictionary> list = new List<RecEmailTypeDictionary>();

            try
            {
                list = (new EmailRecPerson()).GetRecEmailType(recId);
            }
            catch(Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return list;
        }
    }
}