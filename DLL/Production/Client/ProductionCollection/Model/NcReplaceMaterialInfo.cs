using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection.Model
{
    /// <summary>
	/// 维修物料更换记录表
	/// </summary>
	[Serializable]
    public partial class NcReplaceMaterialInfo
    {
        public NcReplaceMaterialInfo()
        { }
        #region Model
        private int _ncreplacematerialid;
        private int? _unitid;
        private int? _ncdataid;
        private string _grn;
        private string _replacegrn;
        private int? _qty;
        private string _createby;
        private DateTime? _createdatetime = DateTime.Now;
        private string _modifyby;
        private DateTime? _modifydatetime = DateTime.Now;
        /// <summary>
        /// 主键（维修物料更换记录表）
        /// </summary>
        public int NcReplaceMaterialId
        {
            set { _ncreplacematerialid = value; }
            get { return _ncreplacematerialid; }
        }
        /// <summary>
        /// SN Id
        /// </summary>
        public int? UnitId
        {
            set { _unitid = value; }
            get { return _unitid; }
        }
        /// <summary>
        /// Prod_NcData表Id
        /// </summary>
        public int? NCDataId
        {
            set { _ncdataid = value; }
            get { return _ncdataid; }
        }
        /// <summary>
        /// GRN
        /// </summary>
        public string GRN
        {
            set { _grn = value; }
            get { return _grn; }
        }
        /// <summary>
        /// 更换后GRN
        /// </summary>
        public string ReplaceGRN
        {
            set { _replacegrn = value; }
            get { return _replacegrn; }
        }
        /// <summary>
        /// 数量
        /// </summary>
        public int? Qty
        {
            set { _qty = value; }
            get { return _qty; }
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
        /// 最后更新人
        /// </summary>
        public string ModifyBy
        {
            set { _modifyby = value; }
            get { return _modifyby; }
        }
        /// <summary>
        /// 最后更新时间
        /// </summary>
        public DateTime? ModifyDateTime
        {
            set { _modifydatetime = value; }
            get { return _modifydatetime; }
        }
        #endregion Model

        /// <summary>
        /// SN
        /// </summary>
        public string SN { get; set; }

        /// <summary>
        /// 不良位置
        /// </summary>
        public string NcPosition { get; set; }

        /// <summary>
        /// 产品ID
        /// </summary>
        public int ItemId { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemCode { get; set; }

        public string UserName { get; set; }

        /// <summary>
        /// 更换前物料编码
        /// </summary>
        public string ItemCodeBefore { get; set; }

        /// <summary>
        /// 更换前物料名称
        /// </summary>
        public string ItemNameBefore { get; set; }

        /// <summary>
        /// 更换前物料规格
        /// </summary>
        public string ItemSpecBefore { get; set; }

        /// <summary>
        /// 更换前DateCode
        /// </summary>
        public string DateCodeBefore { get; set; }

        /// <summary>
        /// 更换前LotNo
        /// </summary>
        public string LotCodeBefore { get; set; }
        
        /// <summary>
        /// 更换后物料编码
        /// </summary>
        public string ItemCodeAfter { get; set; }

        /// <summary>
        /// 更换后物料名称
        /// </summary>
        public string ItemNameAfter { get; set; }

        /// <summary>
        /// 更换后物料规格
        /// </summary>
        public string ItemSpecAfter { get; set; }

        /// <summary>
        /// 更换后DateCode
        /// </summary>
        public string DateCodeAfter { get; set; }

        /// <summary>
        /// 更换后LotNo
        /// </summary>
        public string LotCodeAfter { get; set; }

        /// <summary>
        /// 不良数据ID
        /// </summary>
        public int NcDataId { get; set; }

        public decimal? Num { get; set; }
    }
}
