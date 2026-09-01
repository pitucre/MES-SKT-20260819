using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization.Json;

namespace SKT.MES.ReportingService.Utility.Common.Helpers
{
    /// <summary>
    /// 通用帮助程序
    /// </summary>
    public class CommonHelper
	{
		/// <summary>
        /// 对象转整型
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
		public static int ObjToInt(object obj)
		{
			int result;
			int num;
			if (obj == null)
			{
				result = 0;
			}
			else if (obj.Equals(DBNull.Value))
			{
				result = 0;
			}
			else if (int.TryParse(obj.ToString(), out num))
			{
				result = num;
			}
			else
			{
				result = 0;
			}
			return result;
		}

		/// <summary>
        /// 对象转bool
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
		public static bool ObjToBool(object obj)
		{
			bool flag;
			return obj != null && !obj.Equals(DBNull.Value) && bool.TryParse(obj.ToString(), out flag) && flag;
		}

		/// <summary>
        /// 对象转可空整型
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
		public static int? ObjToIntNull(object obj)
		{
			int? result;
			if (obj == null)
			{
				result = null;
			}
			else if (obj.Equals(DBNull.Value))
			{
				result = null;
			}
			else
			{
				result = new int?(CommonHelper.ObjToInt(obj));
			}
			return result;
		}

		/// <summary>
        /// 对象转字符串
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
		public static string ObjToStr(object obj)
		{
			string result;
			if (obj == null)
			{
				result = "";
			}
			else if (obj.Equals(DBNull.Value))
			{
				result = "";
			}
			else
			{
				result = Convert.ToString(obj);
			}
			return result;
		}

        /// <summary>
        /// 参数转decimal
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static decimal ObjToDecimal(object obj)
		{
			decimal result;
			if (obj == null)
			{
				result = 0m;
			}
			else if (obj.Equals(DBNull.Value))
			{
				result = 0m;
			}
			else
			{
				try
				{
					result = Convert.ToDecimal(obj);
				}
				catch
				{
					result = 0m;
				}
			}
			return result;
		}

		/// <summary>
        /// 参数转可空decimal
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
		public static decimal? ObjToDecimalNull(object obj)
		{
			decimal? result;
			if (obj == null)
			{
				result = null;
			}
			else if (obj.Equals(DBNull.Value))
			{
				result = null;
			}
			else
			{
				result = new decimal?(CommonHelper.ObjToDecimal(obj));
			}
			return result;
		}

		/// <summary>
        /// 对象转日期
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
		public static DateTime? ObjToDateNull(object obj)
		{
			DateTime? result;
			if (obj == null)
			{
				result = null;
			}
			else
			{
				try
				{
					result = new DateTime?(Convert.ToDateTime(obj));
				}
				catch
				{
					result = null;
				}
			}
			return result;
		}

		/// <summary>
        /// json对象转参数列表
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
		public static List<ParamInfo> ObjToParamList(object json)
		{
			List<ParamInfo> result;
			using (MemoryStream memoryStream = new MemoryStream())
			{
				DataContractJsonSerializer dataContractJsonSerializer = new DataContractJsonSerializer(typeof(List<ParamInfo>));
				using (StreamWriter streamWriter = new StreamWriter(memoryStream))
				{
					streamWriter.Write(json);
					streamWriter.Flush();
					memoryStream.Position = 0L;
					object obj = dataContractJsonSerializer.ReadObject(memoryStream);
					List<ParamInfo> list = (List<ParamInfo>)obj;
					result = list;
				}
			}
			return result;
		}

		/// <summary>
        /// 构造函数
        /// </summary>
		public CommonHelper()
		{ 
		}
	}
}
