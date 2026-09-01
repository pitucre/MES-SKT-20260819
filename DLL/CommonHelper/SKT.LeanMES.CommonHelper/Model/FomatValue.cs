using System;

namespace SKT.LeanMES.CommonHelper.Model
{
	[System.AttributeUsage(System.AttributeTargets.Property, AllowMultiple = false, Inherited = false)]
	public class FomatValue : System.Attribute
	{
		protected string str;

		public string dataType
		{
			get
			{
				return this.str;
			}
		}

		public FomatValue(string strType)
		{
			this.str = strType;
		}
	}
}
