using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using SKT.MES.ReportingService.Utility.Common.Helpers;
using SKT.MES.ReportingService.Utility.View;

namespace SKT.MES.ReportingService.Utility.DataBase
{
	/// <summary>
    /// 数据翻页
    /// </summary>
	public abstract class DataBasePager
	{
		/// <summary>
        /// 视图列表
        /// </summary>
		private IList<ViewInfo> _views;

		/// <summary>
        /// 
        /// </summary>
		public virtual IList<ViewInfo> Views
		{
			get
			{
				return this._views;
			}
		}

		/// <summary>
        /// 获取主键名
        /// </summary>
        /// <param name="ViewName"></param>
        /// <returns></returns>
		public string GetKeyName(string ViewName)
		{
			string result;
			if (this.Views == null)
			{
				result = null;
			}
			else
			{
				foreach (ViewInfo viewInfo in this.Views)
				{
					if (viewInfo.ViewName.Equals(ViewName))
					{
						return viewInfo.KeyName;
					}
				}
				result = null;
			}
			return result;
		}

        /// <summary>
        /// 获取查询结果
        /// </summary>
        /// <param name="gridViewName">表或视图（isPROC为ture时，存储过程）</param>
        /// <param name="pageNo">当前页码</param>
        /// <param name="pageSize">每页记录数</param>
        /// <param name="orderStr">排序参数</param>
        /// <param name="searchConditions">查询条件</param>
        /// <param name="recordTotal">返回记录数</param>
        /// <param name="isPROC">是否是存储过程</param>
        /// <param name="lists">isPROC为ture时，存储过程的参数列表</param>
        /// <returns></returns>
        public DataTable GetGridView(string gridViewName, int pageNo, int pageSize, string orderStr, string searchConditions, ref int recordTotal, bool isPROC, List<ParamInfo> lists)
		{
			return this.GetGridView(gridViewName, "*", "", pageNo, pageSize, orderStr, searchConditions, ref recordTotal, isPROC, lists);
		}

        /// <summary>
        /// 获取查询结果
        /// </summary>
        /// <param name="gridViewName">表或视图（isPROC为ture时，存储过程）</param>
        /// <param name="fieldName">要查询的列字符串</param>
        /// <param name="gridKeyName">主键</param>
        /// <param name="pageNo">当前页码</param>
        /// <param name="pageSize">每页记录数</param>
        /// <param name="orderStr">排序参数</param>
        /// <param name="whereStr">查询条件</param>
        /// <param name="recordTotal">返回记录数</param>
        /// <param name="isPROC">是否是存储过程</param>
        /// <param name="list">isPROC为ture时，存储过程的参数列表</param>
        /// <returns></returns>
        public DataTable GetGridView(string gridViewName, string fieldName, string gridKeyName, int pageNo, int pageSize, string orderStr, string whereStr, ref int recordTotal, bool isPROC, List<ParamInfo> list)
		{
			DataTable dataTable = new DataTable();
			recordTotal = 0;
			if (isPROC)
			{
				SqlParameter[] array = null;
				if (list.Count > 0)
				{
					array = new SqlParameter[list.Count];
					for (int i = 0; i < list.Count; i++)
					{
						array[i] = new SqlParameter(list[i].Name, this.GetDataType(list[i].Type), Convert.ToInt32(list[i].Size));
						array[i].Value = list[i].Value;
					}
				}
				dataTable = SqlHelper.ExecuteDataset(DataBaseHelper.connectionstring, CommandType.StoredProcedure, gridViewName, array).Tables[0];
				recordTotal = dataTable.Rows.Count;
			}
			else
			{
				string commandText = "Common_GetPageRecords";
				SqlParameter[] array = new SqlParameter[]
				{
					new SqlParameter("@StartRow", SqlDbType.Int) { Value = -1},
					new SqlParameter("@MaxRows", SqlDbType.Int) { Value = 0},
					new SqlParameter("@TableName", SqlDbType.NVarChar, 2000) { Value = gridViewName},
					new SqlParameter("@PrimaryKey", SqlDbType.NVarChar, 100) { Value = gridKeyName},
					new SqlParameter("@GetFields", SqlDbType.NVarChar, 4000) { Value = fieldName},
					new SqlParameter("@SearchConditions", SqlDbType.NVarChar, 4000) { Value = (whereStr == "" ? "1=1" : whereStr)},
					new SqlParameter("@SortExpression", SqlDbType.NVarChar, 100) { Value = orderStr},
					new SqlParameter("@recordTotal", SqlDbType.Int) { Direction = ParameterDirection.Output}
				};
				 
				dataTable = SqlHelper.ExecuteDataset(DataBaseHelper.connectionstring, CommandType.StoredProcedure, commandText, array).Tables[0];
				recordTotal = CommonHelper.ObjToInt(array[7].Value);
			}
			return dataTable;
		}

		/// <summary>
        /// 获取Sql数据类型
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
		private SqlDbType GetDataType(string type)
		{
			string text = type.ToUpper();
			switch (text)
			{
			case "INT":
				return SqlDbType.Int;
			case "BIGINT":
				return SqlDbType.BigInt;
			case "SMALLINT":
				return SqlDbType.SmallInt;
			case "TINYINT":
				return SqlDbType.TinyInt;
			case "VARCHAR":
				return SqlDbType.VarChar;
			case "NVARCHAR":
				return SqlDbType.NVarChar;
			case "CHAR":
				return SqlDbType.Char;
			case "NCHAR":
				return SqlDbType.NChar;
			case "DECIMAL":
				return SqlDbType.Decimal;
			case "BIT":
				return SqlDbType.Bit;
			case "DATETIME":
				return SqlDbType.DateTime;
			case "SMALLDATETIME":
				return SqlDbType.SmallDateTime;
			case "FLOAT":
				return SqlDbType.Float;
			case "MONEY":
				return SqlDbType.Money;
			case "SMALLMONEY":
				return SqlDbType.SmallMoney;
			case "TEXT":
				return SqlDbType.Text;
			case "NTEXT":
				return SqlDbType.NText;
			}
			return SqlDbType.NVarChar;
		}

		/// <summary>
        /// 
        /// </summary>
		protected DataBasePager()
		{
			this._views = new List<ViewInfo>(); 
		}
	}
}
