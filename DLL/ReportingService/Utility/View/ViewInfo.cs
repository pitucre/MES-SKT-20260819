using System;

namespace SKT.MES.ReportingService.Utility.View
{
	/// <summary>
    /// 视图信息
    /// </summary>
	public class ViewInfo
	{
        /// <summary>
        /// 视图或表名
        /// </summary>
        private string _viewname;

        /// <summary>
        /// 主键名
        /// </summary>
        private string _keyname;

		/// <summary>
        /// 初始化
        /// </summary>
        /// <param name="viewname"></param>
        /// <param name="keyname"></param>
		public ViewInfo(string viewname, string keyname)
		{ 
			this._viewname = "";
			this._keyname = ""; 
			this._viewname = viewname;
			this._keyname = keyname;
		}

		/// <summary>
        /// 视图或表名
        /// </summary>
		public string ViewName
		{
			get
			{
				return this._viewname;
			}
			set
			{
				this._viewname = value;
			}
		}

        /// <summary>
        /// 主键名
        /// </summary>
        public string KeyName
		{
			get
			{
				return this._keyname;
			}
			set
			{
				this._keyname = value;
			}
		}
	}
}
