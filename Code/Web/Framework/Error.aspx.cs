using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using SKT.Common.Model;
using SKT.Common.Utility;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Framework
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Exception exp = WebHelper.ReadException();
            if (exp == null)
            {
                lblMessage.Text = Resources.Messages.UnknownError;
                return;
            }

            Exception baseException = exp.GetBaseException();
            MESException mesException = exp as MESException;

            if (mesException == null)
            {
                do
                {
                    exp = exp.InnerException;
                    mesException = exp as MESException;

                    if (mesException != null)
                    {
                        break;
                    }
                }
                while (exp != null);
            }

            if (mesException != null)
            {
                String resourceClass = mesException.MessageResourceClass;
                String resourceKey = mesException.MessageResourceKey;

                if (String.IsNullOrEmpty(resourceClass))
                {
                    resourceClass = "Messages";
                }

                String message;
                Object errorMessageObject = this.GetGlobalResourceObject(resourceClass, resourceKey);

                if (errorMessageObject == null)
                {
                    message = resourceKey;
                }
                else
                {
                    message = errorMessageObject.ToString();

                    if (mesException.Args != null)
                    {
                        message = String.Format(message, mesException.Args);
                    }
                }

                lblMessage.Text = message;


                switch (mesException.ExceptionLevel)
                {
                    case ExceptionLevel.Information:
                        imgErrorType.ImageUrl = WebHelper.ImageRoot + "msg_information.gif";
                        imgErrorType.AlternateText = this.GetGlobalResourceObject("Common", "MsgInformation").ToString();
                        break;
                    case ExceptionLevel.Warning:
                        imgErrorType.ImageUrl = WebHelper.ImageRoot + "msg_warning.gif";
                        imgErrorType.AlternateText = this.GetGlobalResourceObject("Common", "MsgWarning").ToString();
                        break;
                    case ExceptionLevel.Error:
                        imgErrorType.ImageUrl = WebHelper.ImageRoot + "msg_error.gif";
                        imgErrorType.AlternateText = this.GetGlobalResourceObject("Common", "MsgError").ToString();
                        break;
                    case ExceptionLevel.InnerError:
                        imgErrorType.ImageUrl = WebHelper.ImageRoot + "msg_innerror.gif";
                        imgErrorType.AlternateText = this.GetGlobalResourceObject("Common", "MsgInnerError").ToString();
                        break;
                    default:
                        imgErrorType.ImageUrl = WebHelper.ImageRoot + "msg_error.gif";
                        imgErrorType.AlternateText = this.GetGlobalResourceObject("Common", "MsgError").ToString();
                        break;
                }

                if (resourceKey.Equals("DBAccessError"))
                {
                    ErrorLog.WriteEntry(AccountController.GetCurrentUser().UserName, baseException);
                }
            }
            else
            {

                if (baseException is HttpRequestValidationException)
                {
                    imgErrorType.ImageUrl = WebHelper.ImageRoot + "msg_warning.gif";
                    imgErrorType.AlternateText = this.GetGlobalResourceObject("Common", "MsgWarning").ToString();
                    this.Label1.Text = Resources.Common.MsgWarning.ToString();
                    lblMessage.Text = Resources.Messages.HttpRequestValidationExp;
                }
                else if (baseException is AntiXsrfFaildException)
                {
                    imgErrorType.ImageUrl = WebHelper.ImageRoot + "msg_error.gif";
                    imgErrorType.AlternateText = this.GetGlobalResourceObject("Common", "MsgError").ToString();
                    lblMessage.Text = Resources.Messages.AntiXsrfFaildExcetion;
                }
                else
                {
                    imgErrorType.ImageUrl = WebHelper.ImageRoot + "msg_error.gif";
                    imgErrorType.AlternateText = this.GetGlobalResourceObject("Common", "MsgError").ToString();
                    lblMessage.Text = baseException.Message;
                }

                ErrorLog.WriteEntry(AccountController.GetCurrentUser().UserName, baseException);
            }
        }
    }
}