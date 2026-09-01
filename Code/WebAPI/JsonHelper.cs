using Newtonsoft.Json;

namespace WebAPI
{
    /// <summary>
    /// Json 帮助类
    /// </summary>
    public class JsonHelper
    {
        #region 第二种 JSON.NET 
        //使用Json.NET类库需要引入的命名空间 using Newtonsoft.Json;
        //注：可用[JsonIgnore]标记不序列化的属性

        /// <summary>
        /// 序列化
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static string ObjectToJson(object obj)
        {
            return JsonConvert.SerializeObject(obj);
        }

        /// <summary>
        /// 反序列化
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="strJson"></param>
        /// <returns></returns>
        public static T JsonToObject<T>(string strJson)
        {
            return JsonConvert.DeserializeObject<T>(strJson);
        }
        #endregion
    }
}