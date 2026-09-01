using AjaxPro;
using SKT.LeanMES.ESOP.BLL;
using SKT.LeanMES.ESOP.Model;
using System;
using System.IO;
using System.Net;
using System.Text;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxFormChangePDA 
    {
       
        [AjaxMethod]
        public string SubFormChangeToERP(string beItem , string afItem , string qty, string beWar, string afWar)
        {
            try
            {
                string url = "http://kcdrd.rmmes.com/u9_xtzh.aspx";



                string json_post = "{\r\n    \"接口配置编号\": \"直传\",\r\n    \"yhbsp_session_uer_UAid\": \"特殊\",\r\n    \"配置_OrgID\": \"1002407120111024\",\r\n    \"配置_UserID\": \"1002407120111741\",\r\n    \"配置_EnterpriseID\": \"999\",\r\n    \"配置_CultureName\": \"zh-CN\",\r\n    \"配置_DefaultCultureName\": \"zh-CN\",\r\n    \"单据类型编号\": \"TransForm001\",\r\n    \"其他备注\": \"接口创建\",\r\n    \"转前物料编码\": \""+ beItem + "\",\r\n    \"转前数量\": \""+qty+"\",\r\n    \"转前库位编号\": \""+beWar+"\",\r\n    \"转后物料编码\": \""+afItem+"\",\r\n    \"转后数量\": \""+qty+"\",\r\n    \"转后库位编号\": \""+afWar+"\"\r\n}";

                HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(url);
                httpWebRequest.Method = "POST";
                httpWebRequest.ContentType = "application/json;charset=utf-8";
                httpWebRequest.ContentLength = Encoding.UTF8.GetByteCount(json_post);
                byte[] bytes = Encoding.UTF8.GetBytes(json_post);
                httpWebRequest.GetRequestStream().Write(bytes, 0, bytes.Length);

                HttpWebResponse httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse();
                StreamReader streamReader = new StreamReader(httpWebResponse.GetResponseStream(), Encoding.UTF8);
                string result = streamReader.ReadToEnd();
                streamReader.Close();
                httpWebResponse.Close();
                httpWebRequest.Abort();

                return result;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
    }
}
