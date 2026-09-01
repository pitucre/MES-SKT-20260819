using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Wave.Model
{
    [Serializable]
    public class DeviceInterfaceInfo
    {
        /// <summary>
		/// 配置ID（主键）
        /// </summary>		
		private int _deviceinterfaceid;
        public int DeviceInterfaceId
        {
            get { return _deviceinterfaceid; }
            set { _deviceinterfaceid = value; }
        }
        /// <summary>
        /// 设备接口类型型号ID
        /// </summary>		
        private int _deviceinterfacetypeid;
        public int DeviceInterfaceTypeId
        {
            get { return _deviceinterfacetypeid; }
            set { _deviceinterfacetypeid = value; }
        }
        /// <summary>
        /// 目标文件目录
        /// </summary>		
        private string _targetfiledir;
        public string TargetFileDir
        {
            get { return _targetfiledir; }
            set { _targetfiledir = value; }
        }
        /// <summary>
        /// 文件类型
        /// </summary>		
        private string _filetype;
        public string FileType
        {
            get { return _filetype; }
            set { _filetype = value; }
        }
        /// <summary>
        /// 标题解析分割字符
        /// </summary>		
        private string _titleSplitChar;
        public string TitleSplitChar
        {
            get { return _titleSplitChar; }
            set { _titleSplitChar = value; }
        }
        /// <summary>
        /// TXT解析分割字符
        /// </summary>		
        private string _txtSplitChar;
        public string TxtSplitChar
        {
            get { return _txtSplitChar; }
            set { _txtSplitChar = value; }
        }
        /// <summary>
        /// 文件存在服务器目录
        /// </summary>
        private string _fileNewPath;
        public string FileNewPath
        {
            get { return _fileNewPath; }
            set { _fileNewPath = value; }
        }
        /// <summary>
        /// 默认用户
        /// </summary>		
        private string _defaultusername;
        public string DefaultUserName
        {
            get { return _defaultusername; }
            set { _defaultusername = value; }
        }
        /// <summary>
        /// 不良代码ID
        /// </summary>		
        private int _nccodeid;
        public int NCCodeId
        {
            get { return _nccodeid; }
            set { _nccodeid = value; }
        }
        /// <summary>
        /// 线别ID
        /// </summary>		
        private int _lineid;
        public int LineId
        {
            get { return _lineid; }
            set { _lineid = value; }
        }
        /// <summary>
        /// 是否联板
        /// </summary>		
        private int _iscouplet;
        public int IsCouplet
        {
            get { return _iscouplet; }
            set { _iscouplet = value; }
        }
        /// <summary>
        /// 序列号位置
        /// </summary>		
        private string _snposition;
        public string SnPosition
        {
            get { return _snposition; }
            set { _snposition = value; }
        }
        /// <summary>
        /// CreateDateTime
        /// </summary>		
        private DateTime _createdatetime;
        public DateTime CreateDateTime
        {
            get { return _createdatetime; }
            set { _createdatetime = value; }
        }
        /// <summary>
        /// CreateBy
        /// </summary>		
        private string _createby;
        public string CreateBy
        {
            get { return _createby; }
            set { _createby = value; }
        }
        /// <summary>
        /// ModifyDateTime
        /// </summary>		
        private DateTime _modifydatetime;
        public DateTime ModifyDateTime
        {
            get { return _modifydatetime; }
            set { _modifydatetime = value; }
        }
        /// <summary>
        /// ModifyBy
        /// </summary>		
        private string _modifyby;
        public string ModifyBy
        {
            get { return _modifyby; }
            set { _modifyby = value; }
        }
        /// <summary>
        /// Reserved1
        /// </summary>		
        private int _reserved1;
        public int Reserved1
        {
            get { return _reserved1; }
            set { _reserved1 = value; }
        }
        /// <summary>
        /// Reserved2
        /// </summary>		
        private string _reserved2;
        public string Reserved2
        {
            get { return _reserved2; }
            set { _reserved2 = value; }
        }
        /// <summary>
        /// Reserved3
        /// </summary>		
        private string _reserved3;
        public string Reserved3
        {
            get { return _reserved3; }
            set { _reserved3 = value; }
        }
        /// <summary>
        /// Reserved4
        /// </summary>		
        private string _reserved4;
        public string Reserved4
        {
            get { return _reserved4; }
            set { _reserved4 = value; }
        }
        /// <summary>
        /// Reserved5
        /// </summary>		
        private string _reserved5;
        public string Reserved5
        {
            get { return _reserved5; }
            set { _reserved5 = value; }
        }

        #region 额外关联查询的字段

        public string IsCoupletName { get; set; }

        /// <summary>
        /// 设备类型
        /// </summary>
        public string DeviceType { get; set; }
        /// <summary>
        /// 品牌型号
        /// </summary>
        public string Brand { get; set; }
        /// <summary>
        /// 不良代码
        /// </summary>
        public string NCCode { get; set; }
        /// <summary>
        /// 线别
        /// </summary>
        public string LineName { get; set; }

        /// <summary>
        /// 测试结果位置（XML格式）
        /// </summary>
        public string TestResultPosition { get; set; }

        #endregion
    }
}
