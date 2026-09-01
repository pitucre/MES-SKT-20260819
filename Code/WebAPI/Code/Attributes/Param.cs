using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using SKT;
using SKT.LeanMES.SDK;
using System;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;
using WebAPI.Models;
using WebAPI.Models.Enum;

namespace WebAPI.Code.Attributes
{
    /// <summary>
    /// 参数处理
    /// @author xudong.zhu 
    /// @date 2022-08-19
    /// </summary>
    public class Param : BaseAttributers
    {

      

        /// <summary>
        /// 参数处理
        /// </summary>
        /// <param name="actionContext"></param>
        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            base.OnActionExecuting(actionContext);

            try
            {
                //是否开启简单参数模式
                if (bool.Parse(SettingsHelper.AppSettings("IsEasyParamMode"))) return;

                if (actionContext.ActionArguments.ContainsKey("entity"))
                {
                    //参数类型类名
                    var class_name = actionContext.ActionArguments["entity"].GetType().FullName;

                    //通过类名获取同名类,泛型方法中fun<T>()中的T
                    Type entity_type = Type.GetType(class_name);

                    //创建实例  
                    object entity_obj = Activator.CreateInstance(entity_type);       
 
                    //获取方法所在类的Type，MethodClass是存放fun<T>()方法的类
                    var method_type = typeof(MyJsonConvert);

                    //获取泛型方法，
                    var generic_method = method_type.GetMethod("DeserializeObject");

                    //合并生成最终的函数
                    MethodInfo cur_method = generic_method.MakeGenericMethod(entity_type);

                    //执行函数
                    var result = cur_method.Invoke(null, new object[] { Package.Data.ToString() });

                    actionContext.ActionArguments["entity"] = result; 
                }
            }
            catch (Exception ex)
            {
                var msg = ex.Message;
                //获取MyJsonConvert异常信息
                if (ex.InnerException.Source == "Newtonsoft.Json")
                {
                    msg = ex.InnerException.Message;
                }
                Utility.Logger.Write.Info($"Param-ex：{msg}");
                actionContext.Response = APIResponse.ResponseMsg(msg, ResultEnum.NG);
                return;
            }
        }

        /// <summary>
        /// Json转换处理
        /// </summary>
        private class MyJsonConvert
        {
            /// <summary>
            /// 反序列化
            /// </summary>
            /// <typeparam name="T"></typeparam>
            /// <param name="str"></param>
            /// <returns></returns>
            public static T DeserializeObject<T>(string str)
            {
                return Newtonsoft.Json.JsonConvert.DeserializeObject<T>(str);
            }
        }
    }
}