using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Formatting;
using System.Web.Http;

namespace WebAPI
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API 配置和服务

            // Web API 路由
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            //var jsonFormat = new JsonMediaTypeFormatter();
            //var settings = jsonFormat.SerializerSettings.NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore;
            //config.Services.Replace(typeof(IContentNegotiator), new JsonContentNegotiator(jsonFormat));
        }
    }
}
