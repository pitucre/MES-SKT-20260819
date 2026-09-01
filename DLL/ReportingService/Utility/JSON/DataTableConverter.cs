using System;
using System.Data;
using Newtonsoft.Json;

namespace SKT.MES.ReportingService.Utility.JSON
{
    /// <summary>
    /// DataTable转换类
    /// </summary>
    public class DataTableConverter : JsonConverter
	{
		/// <summary>
        /// 是否能够转换
        /// </summary>
        /// <param name="objectType"></param>
        /// <returns></returns>
		public override bool CanConvert(Type objectType)
		{
			return typeof(DataTable).IsAssignableFrom(objectType);
		}

		/// <summary>
        /// 
        /// </summary>
        /// <param name="reader"></param>
        /// <param name="objectType"></param>
        /// <param name="existingValue"></param>
        /// <param name="serializer"></param>
        /// <returns></returns>
		public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
		{
			throw new NotImplementedException();
		}

		/// <summary>
        /// DataTable转成Json
        /// </summary>
        /// <param name="writer"></param>
        /// <param name="value"></param>
        /// <param name="serializer"></param>
		public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
		{
			DataTable dataTable = (DataTable)value;
			writer.WriteStartArray();
			foreach (object obj in dataTable.Rows)
			{
				DataRow dataRow = (DataRow)obj;
				writer.WriteStartObject();
				foreach (object obj2 in dataTable.Columns)
				{
					DataColumn dataColumn = (DataColumn)obj2;
					writer.WritePropertyName(dataColumn.ColumnName);
					writer.WriteValue(dataRow[dataColumn].ToString());
				}
				writer.WriteEndObject();
			}
			writer.WriteEndArray();
		}

		/// <summary>
        /// 构造函数
        /// </summary>
		public DataTableConverter()
		{ 
		}
	}
}
