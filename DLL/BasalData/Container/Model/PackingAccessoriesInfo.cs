using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Container.Model
{
    [Serializable]
    public class PackingAccessoriesConfigInfo
    {
        private Int32 packingAccessoriesConfigId;
        private Int32 itemId;
        private String accessoriesName;
        private Int32 stationId;
        private Int32 accessoriesQty;
        private Int32 maskId;
        private String remark;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private int checkType;

        public string ItemCode { get; set; }
        public string Station { get; set; }
        public string MaskGroup { get; set; }
        public int Sequence { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PackingAccessoriesConfigInfo 类的新实例。
        /// </summary>
        public PackingAccessoriesConfigInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PackingAccessoriesConfigInfo 类的新实例。
        /// </summary>
        /// <param name="packingAccessoriesConfigId"></param>
        /// <param name="itemId">物料ID</param>
        /// <param name="accessoriesName">附件名称</param>
        /// <param name="stationId">需在哪个工序进行相关的附件采集</param>
        /// <param name="accessoriesQty">需采集的附件个数</param>
        /// <param name="maskId">掩码组ID</param>
        /// <param name="remark">备注</param>
        /// <param name="createBy">创建人。</param>
        /// <param name="createDateTime">创建时间。</param>
        /// <param name="modifyBy">修改人。</param>
        /// <param name="modifyDateTime">修改时间。</param>
        public PackingAccessoriesConfigInfo(Int32 packingAccessoriesConfigId, Int32 itemId, String accessoriesName, Int32 stationId,
            Int32 accessoriesQty, Int32 maskId, String remark, String createBy, DateTime createDateTime,
            String modifyBy, DateTime modifyDateTime,int checkType)
        {
            this.packingAccessoriesConfigId = packingAccessoriesConfigId;
            this.itemId = itemId;
            this.accessoriesName = accessoriesName;
            this.stationId = stationId;
            this.accessoriesQty = accessoriesQty;
            this.maskId = maskId;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.checkType = checkType;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PackingAccessoriesConfigId
        {
            get { return this.packingAccessoriesConfigId; }
            set { this.packingAccessoriesConfigId = value; }
        }

        /// <summary>
        /// 获取或设置物料ID
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置附件名称
        /// </summary>
        public String AccessoriesName
        {
            get { return this.accessoriesName; }
            set { this.accessoriesName = value; }
        }

        /// <summary>
        /// 获取或设置需在哪个工序进行相关的附件采集
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置需采集的附件个数
        /// </summary>
        public Int32 AccessoriesQty
        {
            get { return this.accessoriesQty; }
            set { this.accessoriesQty = value; }
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

        public Int32 CheckType
        {
            get { return this.checkType; }
            set { this.checkType = value; }
        }
    }
}
