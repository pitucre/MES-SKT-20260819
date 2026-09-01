using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class SealedSampleInfo
    {
        private Int32 sampleId;
        private String sampleCode;
        private String lotCode;
        private Int32 itemId;
        private String sampleType;
        private Int32 sampleQty;
        private Int32 supplierId;
        private Int32 sampleStatusId;
        private DateTime sampleTime;
        private DateTime effectiveTime;
        private DateTime saveTime;
        private String samplePicture;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string VendorName { get; set; }
        public string Status { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SealedSampleInfo 类的新实例。
        /// </summary>
        public SealedSampleInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SealedSampleInfo 类的新实例。
        /// </summary>
        /// <param name="sampleId"></param>
        /// <param name="sampleCode"></param>
        /// <param name="lotCode">生产批次</param>
        /// <param name="itemId">产品ID 获取 --机型（产品编码） --规格型号（产品名称）</param>
        /// <param name="sampleType">封样件类别</param>
        /// <param name="sampleQty">封样件数量</param>
        /// <param name="supplierId">供应商ID(获取供应商名称)</param>
        /// <param name="sampleStatusId">封样状态</param>
        /// <param name="sampleTime">封样时间</param>
        /// <param name="effectiveTime">有效时间</param>
        /// <param name="saveTime">保存时间</param>
        /// <param name="samplePicture">封样图片路径</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public SealedSampleInfo(Int32 sampleId, String sampleCode, String lotCode, Int32 itemId,
            String sampleType, Int32 sampleQty, Int32 supplierId, Int32 sampleStatusId, DateTime sampleTime,
            DateTime effectiveTime, DateTime saveTime, String samplePicture, String createBy, DateTime createDateTime,
            String modifyBy, DateTime modifyDateTime)
        {
            this.sampleId = sampleId;
            this.sampleCode = sampleCode;
            this.lotCode = lotCode;
            this.itemId = itemId;
            this.sampleType = sampleType;
            this.sampleQty = sampleQty;
            this.supplierId = supplierId;
            this.sampleStatusId = sampleStatusId;
            this.sampleTime = sampleTime;
            this.effectiveTime = effectiveTime;
            this.saveTime = saveTime;
            this.samplePicture = samplePicture;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 SampleId
        {
            get { return this.sampleId; }
            set { this.sampleId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SampleCode
        {
            get { return this.sampleCode; }
            set { this.sampleCode = value; }
        }

        /// <summary>
        /// 获取或设置生产批次
        /// </summary>
        public String LotCode
        {
            get { return this.lotCode; }
            set { this.lotCode = value; }
        }

        /// <summary>
        /// 获取或设置产品ID 获取 --机型（产品编码） --规格型号（产品名称）
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置封样件类别
        /// </summary>
        public String SampleType
        {
            get { return this.sampleType; }
            set { this.sampleType = value; }
        }

        /// <summary>
        /// 获取或设置封样件数量
        /// </summary>
        public Int32 SampleQty
        {
            get { return this.sampleQty; }
            set { this.sampleQty = value; }
        }

        /// <summary>
        /// 获取或设置供应商ID(获取供应商名称)
        /// </summary>
        public Int32 SupplierId
        {
            get { return this.supplierId; }
            set { this.supplierId = value; }
        }

        /// <summary>
        /// 获取或设置封样状态
        /// </summary>
        public Int32 SampleStatusId
        {
            get { return this.sampleStatusId; }
            set { this.sampleStatusId = value; }
        }

        /// <summary>
        /// 获取或设置封样时间
        /// </summary>
        public DateTime SampleTime
        {
            get { return this.sampleTime; }
            set { this.sampleTime = value; }
        }

        /// <summary>
        /// 获取或设置有效时间
        /// </summary>
        public DateTime EffectiveTime
        {
            get { return this.effectiveTime; }
            set { this.effectiveTime = value; }
        }

        /// <summary>
        /// 获取或设置保存时间
        /// </summary>
        public DateTime SaveTime
        {
            get { return this.saveTime; }
            set { this.saveTime = value; }
        }

        /// <summary>
        /// 获取或设置封样图片路径
        /// </summary>
        public String SamplePicture
        {
            get { return this.samplePicture; }
            set { this.samplePicture = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}
