using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace SKT.LeanMES.ERP
{
    public class HttpClientHelper
    {
        //private static readonly object LockObj = new object();
        //private static HttpClient client = null;

        //public HttpClientHelper()
        //{
        //    GetInstance();
        //}
        //public static HttpClient GetInstance()
        //{

        //    if (client == null)
        //    {
        //        lock (LockObj)
        //        {
        //            if (client == null)
        //            {
        //                client = new HttpClient();
        //            }
        //        }
        //    }
        //    return client;
        //}

        public async Task<string> PostAsync(string url, string strJson)//post异步请求方法
        {
            using (HttpContent content = new StringContent(strJson))
            {
                content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");
                //由HttpClient发出异步Post请求
                using (var client = new HttpClient())
                {
                    using (HttpResponseMessage res = await client.PostAsync(url, content))
                    {
                        if (res.StatusCode == System.Net.HttpStatusCode.OK)
                        {
                            string str = res.Content.ReadAsStringAsync().Result;
                            return str;
                        }
                        else
                        {
                            return null;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// POST提交
        /// </summary>
        /// <param name="url"></param>
        /// <param name="json"></param>
        /// <returns></returns>
        /// <exception cref="Exception"></exception>
        public string Post(string url, string json)//post同步请求方法
        {
            var ERPMD5 = ConfigurationManager.AppSettings["ERPMD5"];
            var ERPAuthCode = ConfigurationManager.AppSettings["ERPAuthCode"];

            using (HttpContent content = new StringContent(json))
            {
                content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");
                //client.DefaultRequestHeaders.Connection.Add("keep-alive");

                content.Headers.Add("MD5", ERPMD5 ?? string.Empty);
                content.Headers.Add("authCode", ERPAuthCode ?? string.Empty);

                using (var client = new HttpClient())
                {
                    //由HttpClient发出Post请求
                    using (HttpResponseMessage res = client.PostAsync(url, content).Result)
                    {
                        if (res.StatusCode == System.Net.HttpStatusCode.OK)
                        {
                            string str = res.Content.ReadAsStringAsync().Result;
                            return str;
                        }
                        else
                        {
                            throw new Exception($"调用接口异常：{res.StatusCode}");
                        }
                    }
                }

            }
        }

        public string GetU9ShipData(string fromdatetime)
        {
            try
            {
                string token = "";
                string url = ConfigurationManager.AppSettings["U9CUrl"];
                string clientid= ConfigurationManager.AppSettings["U9Cclientid"];
                string clientsecret = ConfigurationManager.AppSettings["U9Cclientsecret"];
                string entCode = ConfigurationManager.AppSettings["U9CentCode"];
                string userCode = ConfigurationManager.AppSettings["U9CuserCode"];
                string orgCode = ConfigurationManager.AppSettings["U9CorgCode"];
                //WriteTextLog("U9参数", url + clientid + clientsecret + entCode + userCode + orgCode); 
                var client = new HttpClient();
                string u9url = url + "/webapi/OAuth2/AuthLogin?clientid=" + clientid + "&clientsecret=" + clientsecret + "&entCode=" + entCode + "&userCode=" + userCode + "&orgCode=" + orgCode;
                WriteTextLog("U9登录参数", u9url);
                HttpResponseMessage response = client.GetAsync(u9url).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = response.Content.ReadAsStringAsync().Result;
                    if(result!="")
                    {
                        JObject job = JsonConvert.DeserializeObject<JObject>(result);
                        if(job!=null)
                        {
                            token= job["Data"].ToString(); 
                        }
                    }
                }
                else
                {
                    WriteTextLog("U9token获取", "获取U9 TOKEN不成功");
                }
                WriteTextLog("U9 token", token);
                if (token!="")
                {
                    //获取时间
                    if(!string.IsNullOrEmpty(fromdatetime))
                    {
                        fromdatetime = Convert.ToDateTime(fromdatetime).AddDays(-1).ToString("yyyy-MM-dd")+" 00:00:01";   
                    }
                    JObject qjob = new JObject {
                      {"DocDateFrom",fromdatetime },
                      {"Status",1}
                    };
                    HttpContent httpContent = new StringContent(JsonConvert.SerializeObject(qjob));
                    httpContent.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");
                    httpContent.Headers.ContentType.CharSet = "utf-8";
                    httpContent.Headers.Add("token", token);
                    HttpClient httpClient = new HttpClient();
                    httpClient.Timeout = TimeSpan.FromMinutes(30);  
                    HttpResponseMessage response2 = httpClient.PostAsync(url+"/webapi/Ship/Query", httpContent).Result;

                    if (response2.IsSuccessStatusCode)
                    {
                        string result = response2.Content.ReadAsStringAsync().Result;
                        WriteTextLog("U9获取出货单数据：", result);
                        return result;
                    }
                    else
                    {
                        WriteTextLog("U9获取出货单", "获取出货单数据不成功");
                    }
                }
            }
            catch(Exception ex)
            {
                WriteTextLog("获取出货单错误：", ex.Message); 
                return string.Empty;
            }
            return null;
        }
        
        public string PostU9ShipAudit(string DocNo)
        {
            try
            {
                string token = "";
                var client = new HttpClient();
                var url = ConfigurationManager.AppSettings["U9CUrl"];
                string clientid = ConfigurationManager.AppSettings["U9Cclientid"];
                string clientsecret = ConfigurationManager.AppSettings["U9Cclientsecret"];
                string entCode = ConfigurationManager.AppSettings["U9CentCode"];
                string userCode = ConfigurationManager.AppSettings["U9CuserCode"];
                string orgCode = ConfigurationManager.AppSettings["U9CorgCode"];               
                HttpResponseMessage response = client.GetAsync(url + "/webapi/OAuth2/AuthLogin?clientid=" + clientid + "&clientsecret=" + clientsecret + "&entCode=" + entCode + "&userCode=" + userCode + "&orgCode=" + orgCode).Result;
               

                if (response.IsSuccessStatusCode)
                {
                    string result = response.Content.ReadAsStringAsync().Result;
                    if (result != "")
                    {
                        WriteTextLog("出货单审核TOKEN获取", result);
                        JObject job = JsonConvert.DeserializeObject<JObject>(result);
                        if (job != null)
                        {
                            token = job["Data"].ToString();
                        }
                    }
                }
                if(token!="")
                {
                    JObject qjob = new JObject {
                      {"DocNoFrom",DocNo},
                        {"DocNoTo",DocNo},
                        {"Status",1 }
                    };
                    HttpContent httpContent = new StringContent(JsonConvert.SerializeObject(qjob));
                    httpContent.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");
                    httpContent.Headers.ContentType.CharSet = "utf-8";
                    httpContent.Headers.Add("token", token);
                    HttpClient httpClient = new HttpClient();
                    HttpResponseMessage response2 = httpClient.PostAsync(url + "/webapi/Ship/Query", httpContent).Result;
                    if (response2.IsSuccessStatusCode)
                    {
                        string result = response2.Content.ReadAsStringAsync().Result;
                        JObject queryjob = JsonConvert.DeserializeObject<JObject>(result);
                        if(queryjob!=null)
                        {
                            JArray shiparr = JsonConvert.DeserializeObject<JArray>(queryjob["Data"].ToString());
                            if(shiparr!=null && shiparr.Count >0)
                            {

                            }
                            else
                            {
                                WriteTextLog("单据状态", DocNo + "为非开立状态，无法审核");
                                return DocNo + "为非开立状态，无法审核";
                            }
                        }
                        else
                        {
                            WriteTextLog("单据状态", "出货单据[" + DocNo + "]为非开立状态，无法审核");
                            return "出货单据["+DocNo + "]为非开立状态，无法审核";
                        }
                    }
                    else
                    {
                        WriteTextLog("单据状态", "U9中无法找到单据[" + DocNo + "]");
                        return "U9中无法找到单据[" + DocNo + "]";
                    }
                }
                else
                {
                    return "获取TOKEN出错";
                }
                if (token != "")
                {
                    JArray postdata = new JArray(); 
                    JObject qjob = new JObject {
                      {"Code",DocNo}
                    };
                    postdata.Add(qjob); 
                    HttpContent httpContent = new StringContent(JsonConvert.SerializeObject(postdata));
                    httpContent.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");
                    httpContent.Headers.ContentType.CharSet = "utf-8";
                    httpContent.Headers.Add("token", token);
                    HttpClient httpClient = new HttpClient();
                    HttpResponseMessage response2 = httpClient.PostAsync(url+ "/webapi/Ship/SubmitAndApprove", httpContent).Result;
                    if (response2.IsSuccessStatusCode)
                    {
                        string result = response2.Content.ReadAsStringAsync().Result;
                        WriteTextLog("出货单审核结果", result);
                        JObject _resjob = JsonConvert.DeserializeObject<JObject>(result);
                        if(_resjob.Property("Success") !=null && Convert.ToBoolean(_resjob["Success"].ToString())==true)
                        {
                            WriteTextLog("提交审核结果", "true");
                            JArray auarr = JsonConvert.DeserializeObject<JArray>(_resjob["Data"].ToString());
                            if(auarr!=null && auarr.Count >0)
                            {
                                JObject aubill = (JObject)auarr[0];
                                
                                if(Convert.ToBoolean(aubill["m_isSucess"].ToString())==false)
                                {
                                    return aubill["m_errorMsg"].ToString();
                                }
                            }
                            else
                            {
                                WriteTextLog("提交审核结果", "查找审核单据出错");
                                return "查找审核单据出错";
                            }                            
                        }
                        else
                        {
                            WriteTextLog("提交审核结果", "false"); 
                            return _resjob["ResMsg"].ToString();
                        }
                    }
                    else
                    {
                        WriteTextLog("出货单审核结果", "提交不成功！");
                        return "提交不成功！";
                    }
                }
            }
            catch (Exception ex)
            {
                WriteTextLog("出货单审核出错", ex.Message);
                return ex.Message;
            }
            return "OK";
        }

        private static void WriteTextLog(string action, string strMessage)
        {
            DateTime time = DateTime.Now;
            string path = AppDomain.CurrentDomain.BaseDirectory + @"\U9CLog\";
            if (!System.IO.Directory.Exists(path))
                System.IO.Directory.CreateDirectory(path);

            string fileFullPath = path + time.ToString("yyyy-MM-dd") + ".txt";
            StringBuilder str = new StringBuilder();
            str.Append("Time:    " + time.ToString() + "\r\n");
            str.Append("Action:  " + action + "\r\n");
            str.Append("Message: " + strMessage + "\r\n");
            str.Append("-----------------------------------------------------------\r\n\r\n");
            System.IO.StreamWriter sw;
            if (!System.IO.File.Exists(fileFullPath))
            {
                sw = System.IO.File.CreateText(fileFullPath);
            }
            else
            {
                sw = System.IO.File.AppendText(fileFullPath);
            }
            sw.WriteLine(str.ToString());
            sw.Close();
        }
    }
}
