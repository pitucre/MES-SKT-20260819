using System;
using System.Data;

namespace SKT.LeanMES.CommonHelper.BLL
{
	public class ComParameter
	{
		public string PropertyName
		{
			get;
			set;
		}

		public string Name
		{
			get;
			set;
		}

		public object Value
		{
			get;
			set;
		}

		public SqlDbType Type
		{
			get;
			set;
		}

		public int Size
		{
			get;
			set;
		}

		public ParameterDirection Direction
		{
			get;
			set;
		}

		public ComParameter()
		{
		}

		public ComParameter(string strName, SqlDbType Type, int intSize, string strDirection)
		{
			this.Name = strName;
			this.Type = Type;
			this.Size = intSize;
			this.Direction = ((strDirection == "Out") ? ParameterDirection.InputOutput : ParameterDirection.Input);
		}

		public ComParameter(string strName, SqlDbType Type)
		{
			this.Name = strName;
			this.Type = Type;
		}

		public ComParameter(string strName, SqlDbType Type, int intSize)
		{
			this.Name = strName;
			this.Type = Type;
			this.Size = intSize;
		}
	}
}
