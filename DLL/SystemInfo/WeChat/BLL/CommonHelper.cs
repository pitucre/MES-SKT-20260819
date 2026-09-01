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
    public class CommonHelper<T>
    {
        /// <summary>
        /// 获取AccessToken
        /// </summary>
        /// <returns>AccessToken</returns>
        public static string GetAccessToken(string corpID,string secret)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid={0}&corpsecret={1}", corpID, secret);
            Dictionary<string, object> respDic = CommonHelper<Dictionary<string, object>>.SendMessage(url);
            return respDic["access_token"].ToString();
        }

        /// <summary>
        /// POST 带实体信息的数据到微信
        /// </summary>
        /// <param name="json"></param>
        /// <param name="url"></param>
        /// <returns></returns>
        public static T SendMessage(string url,string json )
        {
            byte[] bytes = Encoding.UTF8.GetBytes(json);

            //声明一个HttpWebRequest请求  
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "POST";
            request.ContentType = "text/xml";
            request.Timeout = 90000; //设置连接超时时间 
            request.Headers.Set("Pragma", "no-cache");
            request.ContentLength = bytes.Length;
            Stream reqstream = request.GetRequestStream();
            reqstream.Write(bytes, 0, bytes.Length);


            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            Stream streamReceive = response.GetResponseStream();
            Encoding encoding = Encoding.UTF8;

            StreamReader streamReader = new StreamReader(streamReceive, encoding);
            string respText = streamReader.ReadToEnd();
            streamReceive.Dispose();
            streamReader.Dispose();

            T respDic = JsonConvert.DeserializeObject<T>(respText);
            return respDic;
        }

        /// <summary>
        /// REQUEST 信息到微信
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public static T SendMessage(string url)
        {
            string respText = "";

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();

            using (Stream resStream = response.GetResponseStream())
            {
                StreamReader reader = new StreamReader(resStream, Encoding.UTF8);
                respText = reader.ReadToEnd();
                resStream.Close();
            }
            T respDic = JsonConvert.DeserializeObject<T>(respText);
            return respDic;
        } 
    }
}
