using Newtonsoft.Json;
using SKT.LeanMES.SDK;
using Swashbuckle.Examples;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Reflection;
using System.Web;
using WebAPI.Models.MES;

namespace WebAPI.Models.RequestExample
{
    /// <summary>
    /// 请求示例【post】
    /// </summary>
    public class ReqExample<T> : IExamplesProvider
    {
        private dynamic Results { get; set; }

        /// <summary>
        /// 构造函数
        /// </summary>
        public ReqExample()
        {
            //类名
            var class_name = typeof(T).FullName;
            //实例默认值处理  
            object entity_obj = DefaultVal(class_name);

            //初始化数据
            Results = new { List = new List<dynamic> { entity_obj }, SyncNowFlag = 0 };

            //if (class_name == "WebAPI.Models.MES.ERPERPPurOrderInfo")
            //{
            //    Utility.Logger.Write.Info($"class_name：{class_name}");
            //    Utility.Logger.Write.Info($"Results：{Newtonsoft.Json.JsonConvert.SerializeObject(Results)}");
            //}
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="class_full_name"></param>
        /// <returns></returns>
        private object DefaultVal(string class_full_name)
        {
            //类型
            Type entity_type = Type.GetType(class_full_name);
            //创建实例  
            object entity_obj = Activator.CreateInstance(entity_type);

            PropertyInfo[] propertys = entity_obj.GetType().GetProperties();

            foreach (PropertyInfo p in propertys)
            {
                string fieldName = p.Name;

                string[] types = { "Boolean", "SByte", "Byte", "UInt16", "Int16", "UInt32", "Int32", "UInt64", "Int64", "Decimal", "DateTime", "Char", "Single", "String", "Double", "Nullable`1" };
                if (!types.Contains(p.PropertyType.Name))
                {
                    if (p.PropertyType.Name == "List`1")
                    {
                        foreach (Type cls in p.PropertyType.GenericTypeArguments)
                        {
                            object _obj = DefaultVal(cls.FullName);

                            //if (p.ReflectedType.FullName == "WebAPI.Models.MES.ERPERPPurOrderInfo") Utility.Logger.Write.Info($"fieldName：{fieldName}  _obj：{Newtonsoft.Json.JsonConvert.SerializeObject(_obj)}");

                            //获取方法所在类的Type，MethodClass是存放fun<T>()方法的类
                            var method_type = typeof(MyList);

                            //获取泛型方法，
                            var generic_method = method_type.GetMethod("Default");

                            //合并生成最终的函数
                            MethodInfo cur_method = generic_method.MakeGenericMethod(cls);

                            //执行函数
                            var result = cur_method.Invoke(null, new object[] { _obj });

                            p.SetValue(entity_obj, result);
                        }
                    }
                    else
                    {
                        object _obj = DefaultVal(p.PropertyType.FullName);
                        p.SetValue(entity_obj, _obj);
                    }
                }
                else
                {
                    switch (p.PropertyType.Name)
                    {
                        case "Nullable`1":
                            var type_name = GetTypeName(p.PropertyType);
                            SetVal(p, entity_obj, type_name);
                            break;
                        default:
                            SetVal(p, entity_obj, p.PropertyType.Name);
                            break;
                    }
                }
            }

            return entity_obj;
        }

        /// <summary>
        /// 设置值
        /// </summary>
        /// <param name="p"></param>
        /// <param name="obj"></param>
        /// <param name="type_name"></param>
        private void SetVal(PropertyInfo p, object obj, string type_name)
        {
            switch (type_name)
            {
                case "Boolean":
                    p.SetValue(obj, false);
                    break;
                case "SByte":
                case "Byte":
                case "UInt16":
                case "Int16":
                case "UInt32":
                case "Int32":
                case "UInt64":
                case "Int64":
                case "Double":
                    p.SetValue(obj, 0);
                    break;
                case "Char":
                case "String":
                    p.SetValue(obj, "");
                    break;
                case "Decimal":
                    p.SetValue(obj, 0M);
                    break;
                case "DateTime":
                    p.SetValue(obj, DateTime.Now);
                    break;
            }
        }

        /// <summary>
        /// 获取类型
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        private string GetTypeName(Type type)
        {
            var nullableType = Nullable.GetUnderlyingType(type);
            bool isNullableType = nullableType != null;
            if (isNullableType)
                return nullableType.Name;
            else
                return type.Name;
        }

        /// <summary>
        /// 默认示例
        /// </summary>
        /// <returns></returns>
        public object GetExamples()
        {
            return new GlobalPackage
            {
                Global = new SignPackage
                {
                    IMEI = "",
                    IMSI = "",
                    IP = "",
                    OS = 0,
                    Token = "D34C9F1F57EADCF62799CD86097C45C9897CAB9F52A87D1E",
                    Sign = "b1nWmQ+nzBk/lIpHgtLYx9YUAK7KwmoRxiXHrqBRNu/sdgRECfKE1ynCRH8swyloVPwe6xt0PULCSMuqZfDdWwZo5V45ncWIZku2XRsuiHtUIsB2OJR7cINXN5Z4ojn4j0ufmEmH9UI+8xJqHyOpoqyK97IEb1A6q4nEJKmeXVo="
                },
                Data = Results
            };
        }
    }

    /// <summary>
    /// 集合处理
    /// </summary>
    public class MyList
    {
        /// <summary>
        /// 默认结果
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="t"></param>
        /// <returns></returns>
        public static List<T> Default<T>(T t)
        {
            return new List<T> { t };
        }
    }
}