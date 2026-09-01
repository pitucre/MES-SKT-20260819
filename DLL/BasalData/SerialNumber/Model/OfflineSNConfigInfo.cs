using System;

namespace SKT.LeanMES.SerialNumber.Model
{
    [Serializable]
    public class OfflineSNConfigInfo
    {
        private Int32 offlineSNConfigId;
        private Int32 mainItemId;
        private Int32 partItemId;
        private Int32 stationId;
        private Int32 assemblyQty;
        private Int32 maskId;
        private String remark;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        public string MainItemCode { get; set; }
        public string PartItemCode { get; set; }
        public string Station { get; set; }
        public string MaskGroup { get; set; }
        public string PartType { get; set; }
        public string PartName { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.OfflineSNConfigInfo 类的新实例。
        /// </summary>
        public OfflineSNConfigInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.OfflineSNConfigInfo 类的新实例。
        /// </summary>
        /// <param name="offlineSNConfigId"></param>
        /// <param name="mainItemId">主件产品ID</param>
        /// <param name="partItemId">部件ItemId</param>
        /// <param name="stationId">需在哪个工序进行相关的离线条码绑定</param>
        /// <param name="assemblyQty">需绑定离线条码的个数</param>
        /// <param name="maskId">掩码组ID</param>
        /// <param name="remark">备注</param>
        /// <param name="createBy">创建人。</param>
        /// <param name="createDateTime">创建时间。</param>
        /// <param name="modifyBy">修改人。</param>
        /// <param name="modifyDateTime">修改时间。</param>
        public OfflineSNConfigInfo(Int32 offlineSNConfigId, Int32 mainItemId, Int32 partItemId, Int32 stationId,
            Int32 assemblyQty, Int32 maskId, String remark, String createBy, DateTime createDateTime,
            String modifyBy, DateTime modifyDateTime)
        {
            this.offlineSNConfigId = offlineSNConfigId;
            this.mainItemId = mainItemId;
            this.partItemId = partItemId;
            this.stationId = stationId;
            this.assemblyQty = assemblyQty;
            this.maskId = maskId;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 OfflineSNConfigId
        {
            get { return this.offlineSNConfigId; }
            set { this.offlineSNConfigId = value; }
        }

        /// <summary>
        /// 获取或设置主件产品ID
        /// </summary>
        public Int32 MainItemId
        {
            get { return this.mainItemId; }
            set { this.mainItemId = value; }
        }

        /// <summary>
        /// 获取或设置部件ItemId
        /// </summary>
        public Int32 PartItemId
        {
            get { return this.partItemId; }
            set { this.partItemId = value; }
        }

        /// <summary>
        /// 获取或设置需在哪个工序进行相关的离线条码绑定
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置需绑定离线条码的个数
        /// </summary>
        public Int32 AssemblyQty
        {
            get { return this.assemblyQty; }
            set { this.assemblyQty = value; }
        }

        /// <summary>
        /// 获取或设置掩码组ID
        /// </summary>
        public Int32 MaskId
        {
            get { return this.maskId; }
            set { this.maskId = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置创建人。
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间。
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人。
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间。
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}