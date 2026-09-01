using iTextSharp.text.pdf.qrcode;
using QRCoder;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// QRCoderHandler 的摘要说明
    /// </summary>
    public class QRCoderHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            SqlInjectableHelper.Validation(context);

            string strCode = context.Request["code"];
            QRCodeGenerator qrGenerator = new QRCoder.QRCodeGenerator();
            QRCodeData qrCodeData = qrGenerator.CreateQrCode(strCode, QRCodeGenerator.ECCLevel.Q);
            QRCoder.QRCode qrcode = new QRCoder.QRCode(qrCodeData);
            //new Bitmap(HttpContext.Current.Server.MapPath("~/Content/login/FRD_logo.png"))
            Bitmap qrCodeImage = qrcode.GetGraphic(5, Color.Black, Color.White, null, 15, 6, false);
            MemoryStream ms = new MemoryStream();
            qrCodeImage.Save(ms, ImageFormat.Jpeg);

            byte[] bytes = ms.GetBuffer();
            string base64 = "data:image/png;base64," + Convert.ToBase64String(bytes);

            context.Response.ContentType = "text/plain";
            context.Response.Write(base64);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}