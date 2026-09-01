using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using SKT.LeanMES.CropWeChat.Model;

namespace SKT.LeanMES.CropWeChat.BLL
{
    /// <summary>
    /// 上传临时素材
    /// </summary>
    public class CorpMediaApi
    {
        /// <summary>
        /// 上传临时素材,返回上传结果
        /// </summary>     
        public static CorpMediaResultInfo MediaUpload(string accessToken,string uploadType, string path)
        {
            string url = String.Format("https://qyapi.weixin.qq.com/cgi-bin/media/upload?access_token={0}&type={1}", accessToken, uploadType);

            try
            {
                // 设置参数
                HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
                CookieContainer cookieContainer = new CookieContainer();
                request.CookieContainer = cookieContainer;
                request.AllowAutoRedirect = true;
                request.Method = "POST";

                string boundary = DateTime.Now.Ticks.ToString("X"); // 随机分隔线
                request.ContentType = "multipart/form-data;charset=utf-8;boundary=" + boundary;

                byte[] itemBoundaryBytes = Encoding.UTF8.GetBytes("\r\n--" + boundary + "\r\n");
                byte[] endBoundaryBytes = Encoding.UTF8.GetBytes("\r\n--" + boundary + "--\r\n");

                int pos = path.LastIndexOf("\\");
                string fileName = path.Substring(pos + 1);

                //请求头部信息 
                StringBuilder sbHeader = new StringBuilder(string.Format("Content-Disposition:form-data;name=\"media\";filename=\"{0}\"\r\nContent-Type:application/octet-stream\r\n\r\n", fileName));
                byte[] postHeaderBytes = Encoding.UTF8.GetBytes(sbHeader.ToString());

                FileStream fs = new FileStream(path, FileMode.Open, FileAccess.Read);
                byte[] bArr = new byte[fs.Length];
                fs.Read(bArr, 0, bArr.Length);
                fs.Close();

                Stream postStream = request.GetRequestStream();
                postStream.Write(itemBoundaryBytes, 0, itemBoundaryBytes.Length);
                postStream.Write(postHeaderBytes, 0, postHeaderBytes.Length);
                postStream.Write(bArr, 0, bArr.Length);
                postStream.Write(endBoundaryBytes, 0, endBoundaryBytes.Length);
                postStream.Close();

                //发送请求并获取相应回应数据
                HttpWebResponse response = request.GetResponse() as HttpWebResponse;
                //直到request.GetResponse()程序才开始向目标网页发送Post请求
                Stream instream = response.GetResponseStream();
                StreamReader sr = new StreamReader(instream, Encoding.UTF8);
                //返回结果网页（html）代码
                string respText = sr.ReadToEnd();

                CorpMediaResultInfo respDic = JsonConvert.DeserializeObject<CorpMediaResultInfo>(respText);

                return respDic;
            }
            catch (Exception ex)
            { 
                throw ex;
            }
           
        }
    }
}
