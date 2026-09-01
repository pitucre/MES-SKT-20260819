using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using SKT.LeanMES.Material.BLL;
namespace SKT.LeanMES.Web.WebService
{
    /// <summary>
    /// U9CloudShipAPI 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class U9CloudShipAPI : System.Web.Services.WebService
    {

        [WebMethod(Description ="定时从U9获取开立状态的出货单")]
        public void GetU9CShipData()
        {
            SKT.LeanMES.Material.BLL.ERPShipData eRPShipData = new LeanMES.Material.BLL.ERPShipData();
            string res = eRPShipData.GetU9CShipData();
            Context.Response.Charset = "GB2312"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
            Context.Response.Write(res);
            Context.Response.End();            
        }
    }
}
