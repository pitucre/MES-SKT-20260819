using System.Web.Http;
using WebActivatorEx;
using WebAPI;
using Swashbuckle.Application;
using System.Linq;
using WebAPI.Privider;
using Newtonsoft.Json.Serialization;
using Swashbuckle.Examples;
using Swashbuckle.Swagger;
using System.Collections.Generic;
using System.Collections.Concurrent;
using System.Xml;
using System.IO;
using System;
using System.Web.Http.Description;
using WebAPI.Models.RequestExample;
using SKT.LeanMES.SDK;
using WebAPI.Models.MES;
using System.Text; 

[assembly: PreApplicationStartMethod(typeof(SwaggerConfig), "Register")]

namespace WebAPI
{
    /// <summary>
    /// 
    /// </summary>
    public class SwaggerConfig
    {
        /// <summary>
        /// 
        /// </summary>
        public static void Register()
        {
            var thisAssembly = typeof(SwaggerConfig).Assembly;

            GlobalConfiguration.Configuration
                .EnableSwagger(c =>
                {
                    c.SingleApiVersion("v1", "MES WebAPI");
                    c.IncludeXmlComments(string.Format("{0}/bin/WebAPI.XML", System.AppDomain.CurrentDomain.BaseDirectory));
                    c.IncludeXmlComments(string.Format("{0}/bin/SKT.LeanMES.SDK.XML", System.AppDomain.CurrentDomain.BaseDirectory));
                    c.ResolveConflictingActions(apiDescriptions => apiDescriptions.First());
                    //显示控制器的描述
                    c.CustomProvider((defaultProvider) => new SwaggerCacheProvider(defaultProvider, string.Format("{0}/bin/WebAPI.XML", System.AppDomain.CurrentDomain.BaseDirectory)));
                    //示例过滤器
                    if (!bool.Parse(SettingsHelper.AppSettings("IsEasyParamMode"))) c.OperationFilter<ExamplesOperationFilter>();
                })
                .EnableSwaggerUi(c =>
                {
                    //c.DocumentTitle("料塔操作接口");
                    c.InjectJavaScript(System.Reflection.Assembly.GetExecutingAssembly(), "WebAPI.Content.Script.swagger-lan.js");

                    //c.SwaggerEndpoint($"/swagger/V1/swagger.json", $"MES WebAPI V1");

                    //如果是为空 访问路径就为 根域名/index.html,注意localhost:8001/swagger是访问不到的
                    //路径配置，设置为空，表示直接在根域名（localhost:8001）访问该文件
                    // c.RoutePrefix = "swagger"; // 如果你想换一个路径，直接写名字即可，比如直接写c.RoutePrefix = "swagger"; 则访问路径为 根域名/swagger/index.html

                    //c.SetValidatorUrl("") ;  
                       
                    //c.DocumentTitle("MES WebAPI 在线文档调试");

                    #region 自定义样式

                    ////css 注入
                    c.InjectStylesheet(System.Reflection.Assembly.GetExecutingAssembly(), "WebAPI.Content.swagger-common.css");
                    //c.InjectStylesheet(System.Reflection.Assembly.GetExecutingAssembly(), "/css/app.min.css");
                    ////js 注入
                    //c.InjectJavaScript(System.Reflection.Assembly.GetExecutingAssembly(), "WebAPI.Script.jquery-1.10.2.min.js");
                    //c.InjectJavaScript(System.Reflection.Assembly.GetExecutingAssembly(), "/js/swaggerdoc.js");
                    //c.InjectJavaScript(System.Reflection.Assembly.GetExecutingAssembly(), "/js/app.min.js");

                    #endregion
                });

            //忽略可序列化属性
            GlobalConfiguration.Configuration.Formatters.JsonFormatter.SerializerSettings.ContractResolver = new DefaultContractResolver { IgnoreSerializableAttribute = true };
            //日期格式处理
            GlobalConfiguration.Configuration.Formatters.JsonFormatter.SerializerSettings.DateFormatString = "yyyy-MM-dd HH:mm:ss";
        }
    }

    /// <summary>
    /// swagger显示控制器的描述
    /// </summary>
    public class SwaggerCacheProvider : ISwaggerProvider
    {
        private readonly ISwaggerProvider _swaggerProvider;
        private static ConcurrentDictionary<string, SwaggerDocument> _cache = new ConcurrentDictionary<string, SwaggerDocument>();
        private readonly string _xml;
        /// <summary>
        ///
        /// </summary>
        /// <param name="swaggerProvider"></param>
        /// <param name="xml">xml文档路径</param>
        public SwaggerCacheProvider(ISwaggerProvider swaggerProvider, string xml)
        {
            _swaggerProvider = swaggerProvider;
            _xml = xml;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="rootUrl"></param>
        /// <param name="apiVersion"></param>
        /// <returns></returns>
        public SwaggerDocument GetSwagger(string rootUrl, string apiVersion)
        {

            var cacheKey = string.Format("{0}_{1}", rootUrl, apiVersion);
            SwaggerDocument srcDoc = null;
            //只读取一次
            if (!_cache.TryGetValue(cacheKey, out srcDoc))
            {
                srcDoc = _swaggerProvider.GetSwagger(rootUrl, apiVersion);

                srcDoc.vendorExtensions = new Dictionary<string, object> { { "ControllerDesc", GetControllerDesc() } };
                _cache.TryAdd(cacheKey, srcDoc);
            }
            return srcDoc;
        }

        /// <summary>
        /// 从API文档中读取控制器描述
        /// </summary>
        /// <returns>所有控制器描述</returns>
        public ConcurrentDictionary<string, string> GetControllerDesc()
        {
            string xmlpath = _xml;
            ConcurrentDictionary<string, string> controllerDescDict = new ConcurrentDictionary<string, string>();
            if (File.Exists(xmlpath))
            {
                XmlDocument xmldoc = new XmlDocument();
                xmldoc.Load(xmlpath);
                string type = string.Empty, path = string.Empty, controllerName = string.Empty;

                string[] arrPath;
                int length = -1, cCount = "Controller".Length;
                XmlNode summaryNode = null;
                foreach (XmlNode node in xmldoc.SelectNodes("//member"))
                {
                    type = node.Attributes["name"].Value;
                    if (type.StartsWith("T:"))
                    {
                        //控制器
                        arrPath = type.Split('.');
                        length = arrPath.Length;
                        controllerName = arrPath[length - 1];
                        if (controllerName.EndsWith("Controller"))
                        {
                            //获取控制器注释
                            summaryNode = node.SelectSingleNode("summary");
                            string key = controllerName.Remove(controllerName.Length - cCount, cCount);
                            if (summaryNode != null && !string.IsNullOrEmpty(summaryNode.InnerText) && !controllerDescDict.ContainsKey(key))
                            {
                                controllerDescDict.TryAdd(key, summaryNode.InnerText.Trim());
                            }
                        }
                    }
                }
            }
            return controllerDescDict;
        }
    }


    public class ByteHelper
    {
        public static byte[] StreamToBytes(Stream stream)
        {
            byte[] bytes = new byte[stream.Length];
            stream.Read(bytes, 0, bytes.Length);
            // 设置当前流的位置为流的开始 
            stream.Seek(0, SeekOrigin.Begin);
            return bytes;
        }

        /// 将 byte[] 转成 Stream
        public static Stream BytesToStream(byte[] bytes)
        {
            Stream stream = new MemoryStream(bytes);
            return stream;
        }
    }

    #region MyRegion

    //public class HtmlHelper
    //{
    //    /// <summary>
    //    /// 将数据遍历静态页面中
    //    /// </summary>
    //    /// <param name="templatePath">静态页面地址</param>
    //    /// <param name="model">获取到的文件数据</param>
    //    /// <returns></returns>
    //    public static string GeneritorSwaggerHtml(string templatePath, OpenApiDocument model)
    //    {
    //        var template = System.IO.File.ReadAllText(templatePath);
    //        var result = Engine.Razor.RunCompile(template, "i3yuan", typeof(OpenApiDocument), model);
    //        return result;
    //    }
    //}

    //public class SpireDocHelper
    //{
    //    private readonly IWebHostEnvironment _hostingEnvironment;
    //    public SpireDocHelper(IWebHostEnvironment hostingEnvironment)
    //    {
    //        _hostingEnvironment = hostingEnvironment;
    //    }
    //    /// <summary>
    //    /// 静态页面转文件
    //    /// </summary>
    //    /// <param name="html">静态页面html</param>
    //    /// <param name="type">文件类型</param>
    //    /// <param name="contenttype">上下文类型</param>
    //    /// <returns></returns>
    //    public Stream SwaggerConversHtml(string html, string type, out string contenttype)
    //    {
    //        string fileName = Guid.NewGuid().ToString() + type;
    //        //文件存放路径
    //        string webRootPath = _hostingEnvironment.WebRootPath;
    //        string path = webRootPath + @"\Files\TempFiles\";
    //        var addrUrl = path + $"{fileName}";
    //        FileStream fileStream = null;
    //        var provider = new FileExtensionContentTypeProvider();
    //        contenttype = provider.Mappings[type];
    //        try
    //        {
    //            if (!Directory.Exists(path))
    //            {
    //                Directory.CreateDirectory(path);
    //            }
    //            var data = System.Text.Encoding.Default.GetBytes(html);
    //            var stream = ByteHelper.BytesToStream(data);
    //            //创建Document实例
    //            Document document = new Document();
    //            //加载HTML文档
    //            document.LoadFromStream(stream, FileFormat.Html, XHTMLValidationType.None);

    //            switch (type)
    //            {
    //                case ".docx":
    //                    document.SaveToFile(addrUrl, FileFormat.Docx);
    //                    break;
    //                case ".pdf":
    //                    document.SaveToFile(addrUrl, FileFormat.PDF);
    //                    break;
    //                case ".html":
    //                    //document.SaveToFile(addrUrl, FileFormat.Html);
    //                    //当然了，html 如果不用spire，也可以直接生成
    //                    FileStream fs = new FileStream(addrUrl, FileMode.Append, FileAccess.Write, FileShare.None);//html直接写入不用spire.doc
    //                    StreamWriter sw = new StreamWriter(fs); // 创建写入流
    //                    sw.WriteLine(html); // 写入Hello World
    //                    sw.Close(); //关闭文件
    //                    fs.Close();
    //                    break;
    //                case ".xml":
    //                    document.SaveToFile(addrUrl, FileFormat.Xml);
    //                    break;
    //                case ".svg":
    //                    document.SaveToFile(addrUrl, FileFormat.SVG);
    //                    break;
    //                default:
    //                    //保存为Word
    //                    document.SaveToFile(addrUrl, FileFormat.Docx);
    //                    break;
    //            }
    //            document.Close();
    //            fileStream = File.Open(addrUrl, FileMode.OpenOrCreate);
    //            var filedata = ByteHelper.StreamToBytes(fileStream);
    //            var outdata = ByteHelper.BytesToStream(filedata);
    //            return outdata;
    //        }
    //        catch (Exception)
    //        {
    //            throw;
    //        }
    //        finally
    //        {
    //            if (fileStream != null)
    //                fileStream.Close();
    //            if (File.Exists(addrUrl))
    //                File.Delete(addrUrl);//删掉文件
    //        }
    //    }
    //}

    #endregion
}
