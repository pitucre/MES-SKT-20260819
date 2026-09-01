using System;
namespace SKT.LeanMES.Web.Models
{
    /// <summary>
    /// ModelFormChangeDtledInfo:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class ModelFormChangeDtledInfo
    {
        public ModelFormChangeDtledInfo()
        { }
        #region Model
        private int _formchangedtledid;
        private int? _formchangedtlid;
        private int? _formchangeid;
        private string _rowno;
        private string _changetype;
        private string _materialcode;
        private string _materialname;
        private string _storagetype;
        private decimal? _quantity;
        private decimal? _costquantity;
        private string _unit;
        private string _costunit;
        private decimal? _cost;
        private decimal? _unitprice;
        private string _storagelocation;
        private string _warehouselocation;
        private string _specificationmodel;
        private int? _status;
        private string _factorycode;
        private string _createby;
        private DateTime? _createdatetime;
        private string _modifyby;
        private DateTime? _modifydatetime;
        /// <summary>
        /// 形态转换单明细表(转换后)ID
        /// </summary>
        public int FormChangeDtledId
        {
            set { _formchangedtledid = value; }
            get { return _formchangedtledid; }
        }
        /// <summary>
        /// 形态转换单明细表ID
        /// </summary>
        public int? FormChangeDtlId
        {
            set { _formchangedtlid = value; }
            get { return _formchangedtlid; }
        }
        /// <summary>
        /// 形态转换单主表ID
        /// </summary>
        public int? FormChangeId
        {
            set { _formchangeid = value; }
            get { return _formchangeid; }
        }
        /// <summary>
        /// 行号
        /// </summary>
        public string RowNo
        {
            set { _rowno = value; }
            get { return _rowno; }
        }
        /// <summary>
        /// 转换类别
        /// </summary>
        public string ChangeType
        {
            set { _changetype = value; }
            get { return _changetype; }
        }
        /// <summary>
        /// 料号
        /// </summary>
        public string MaterialCode
        {
            set { _materialcode = value; }
            get { return _materialcode; }
        }
        /// <summary>
        /// 品名
        /// </summary>
        public string MaterialName
        {
            set { _materialname = value; }
            get { return _materialname; }
        }
        /// <summary>
        /// 存储类型
        /// </summary>
        public string StorageType
        {
            set { _storagetype = value; }
            get { return _storagetype; }
        }
        /// <summary>
        /// 数量
        /// </summary>
        public decimal? Quantity
        {
            set { _quantity = value; }
            get { return _quantity; }
        }
        /// <summary>
        /// 成本数量
        /// </summary>
        public decimal? CostQuantity
        {
            set { _costquantity = value; }
            get { return _costquantity; }
        }
        /// <summary>
        /// 单位
        /// </summary>
        public string Unit
        {
            set { _unit = value; }
            get { return _unit; }
        }
        /// <summary>
        /// 成本单位
        /// </summary>
        public string CostUnit
        {
            set { _costunit = value; }
            get { return _costunit; }
        }
        /// <summary>
        /// 成本
        /// </summary>
        public decimal? Cost
        {
            set { _cost = value; }
            get { return _cost; }
        }
        /// <summary>
        /// 单价
        /// </summary>
        public decimal? UnitPrice
        {
            set { _unitprice = value; }
            get { return _unitprice; }
        }
        /// <summary>
        /// 存储地点
        /// </summary>
        public string StorageLocation
        {
            set { _storagelocation = value; }
            get { return _storagelocation; }
        }
        /// <summary>
        /// 库位
        /// </summary>
        public string WarehouseLocation
        {
            set { _warehouselocation = value; }
            get { return _warehouselocation; }
        }
        /// <summary>
        /// 规格型号
        /// </summary>
        public string SpecificationModel
        {
            set { _specificationmodel = value; }
            get { return _specificationmodel; }
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

