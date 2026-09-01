using System;

namespace SKT.MES.ReportingService.Utility.Common.Helpers
{
	/// <summary>
    /// 参数信息
    /// </summary>
	[Serializable]
	public class ParamInfo
	{
		/// <summary>
        /// 参数名称
        /// </summary>
		private string name;

		/// <summary>
        /// 参数数据类型
        /// </summary>
		private string type;

		/// <summary>
        /// 类型长度
        /// </summary>
		private int size;

		/// <summary>
        /// 参数值
        /// </summary>
		private string value;

        /// <summary>
        /// 参数名称
        /// </summary> 
        public string Name
		{
			get
			{
				return this.name;
			}
			set
			{
				this.name = value;
			}
		}

        /// <summary>
        /// 参数数据类型
        /// </summary>
        public string Type
		{
			get
			{
				return this.type;
			}
			set
			{
				this.type = value;
			}
		}

        /// <summary>
        /// 类型长度
        /// </summary>
        public int Size
		{
			get
			{
				return this.size;
			}
			set
			{
				this.size = value;
			}
		}

        /// <summary>
        /// 参数值
        /// </summary>
        public string Value
		{
			get
			{
				return this.value;
			}
			set
			{
				this.value = value;
			}
		}

        /// <summary>
        /// 构造函数、初始化
        /// </summary>
        public ParamInfo()
		{ 
			this.name = "";
			this.type = "VARCHAR";
			this.size = 0;
			this.value = ""; 
		}
	}
}
