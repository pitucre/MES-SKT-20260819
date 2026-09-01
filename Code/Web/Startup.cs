using Microsoft.Owin;
using Owin;
using System;
using System.Threading.Tasks;

[assembly: OwinStartup(typeof(SKT.LeanMES.Web.Startup))]

namespace SKT.LeanMES.Web
{
    public class Startup
    {
        //public void Configuration(IAppBuilder app)
        //{
        //    // 有关如何配置应用程序的详细信息，请访问 https://go.microsoft.com/fwlink/?LinkID=316888
        //}
    }
}
