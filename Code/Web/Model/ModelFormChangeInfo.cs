using System;
namespace SKT.LeanMES.Web.Models
{
    /// <summary>
    /// ModelFormChangeInfo:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class ModelFormChangeInfo
    {
        public ModelFormChangeInfo()
        { }
        #region Model
        private int _formchangeid;
        private string _formchangeno;
        private string _documenttype;
        private string _organization;
        private string _project;
        private string _warehousecode;
        private string _warehousename;
        private DateTime? _formchangedate;
        private int? _status;
        private string _factorycode;
        private string _createby;
        private DateTime? _createdatetime;
        private string _modifyby;
        private DateTime? _modifydatetime;
        /// <summary>
        /// 形态转换单ID
        /// </summary>
        public int FormChangeId
        {
            set { _formchangeid = value; }
            get { return _formchangeid; }
        }
        /// <summary>
        /// 单号
        /// </summary>
        public string FormChangeNo
        {
            set { _formchangeno = value; }
            get { return _formchangeno; }
        }
        /// <summary>
        /// 单据类型
        /// </summary>
        public string DocumentType
        {
            set { _documenttype = value; }
            get { return _documenttype; }
        }
        /// <summary>
        /// 组织
        /// </summary>
        public string Organization
        {
            set { _organization = value; }
            get { return _organization; }
        }
        /// <summary>
        /// 项目
        /// </summary>
        public string Project
        {
            set { _project = value; }
            get { return _project; }
        }
        /// <summary>
        /// 仓库编码
        /// </summary>
        public string WarehouseCode
        {
            set { _warehousecode = value; }
            get { return _warehousecode; }
        }
        /// <summary>
        /// 仓库名称
        /// </summary>
        public string WarehouseName
        {
            set { _warehousename = value; }
            get { return _warehousename; }
        }
        /// <summary>
        /// 日期
        /// </summary>
        public DateTime? FormChangeDate
        {
            set { _formchangedate = value; }
            get { return _formchangedate; }
        }
        /// <summary>
        /// 状态:0待转换,1已转换
        /// </summary>
        public int? Status
        {
            set { _status = value; }
            get { return _status; }
        }
        /// <summary>
        /// 工厂代码
        /// </summary>
        public string FactoryCode
        {
            set { _factorycode = value; }
            get { return _factorycode; }
        }
        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy
        {
            set { _createby = value; }
            get { return _createby; }
        }
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime
        {
            set { _createdatetime = value; }
            get { return _createdatetime; }
        }
        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy
        {
            set { _modifyby = value; }
            get { return _modifyby; }
        }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime
        {
            set { _modifydatetime = value; }
            get { return _modifydatetime; }
        }
        #endregion Model

    }
}

