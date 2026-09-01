using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Plan.Model
{
    [Serializable]
    public class StandardLaborTimeInfo
    {
        private Int32 standardLaborTimeId;
        private Int32 laborTimeType;
        private Int32 equipmentLineId;
        private Int32 itemId;
        private String tableName;
        private Decimal standardLaborTime;
        private decimal standardCapacity;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        public string EquipmentLineName { get; set; }
        public string ItemCode { get; set; }
        public int PanelQty { get; set; }//拼版数
        public string ItemName { get; set; }
        public string LaborTimeTypeName { get; set; }
        public string TableDesc { get; set; }
        public Decimal BottleneckHours { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.StandardLaborTimeInfo 类的新实例。
        /// </summary>
        public StandardLaborTimeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.StandardLaborTimeInfo 类的新实例。
        /// </summary>
        /// <param name="standardLaborTimeId"></param>
        /// <param name="laborTimeType">标准工时类型： 1、SMT 2、非SMT</param>
        /// <param name="equipmentLineId">线别设备类型ID</param>
        /// <param name="itemId">产品ID</param>
        /// <param name="tableName">面别</param>
        /// <param name="standardLaborTime">标准工时（秒）</param>
        /// <param name="standardCapacity">标准产能</param>
        /// <param name="createBy">创建者</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改者</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public StandardLaborTimeInfo(Int32 standardLaborTimeId, Int32 laborTimeType, Int32 equipmentLineId, Int32 itemId,
            String tableName, Decimal standardLaborTime, Int32 standardCapacity, String createBy, DateTime createDateTime,
            String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.standardLaborTimeId = standardLaborTimeId;
            this.laborTimeType = laborTimeType;
            this.equipmentLineId = equipmentLineId;
            this.itemId = itemId;
            this.tableName = tableName;
            this.standardLaborTime = standardLaborTime;
            this.standardCapacity = standardCapacity;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StandardLaborTimeId
        {
            get { return this.standardLaborTimeId; }
            set { this.standardLaborTimeId = value; }
        }

        /// <summary>
        /// 获取或设置标准工时类型： 1、SMT 2、非SMT
        /// </summary>
        public Int32 LaborTimeType
        {
            get { return this.laborTimeType; }
            set { this.laborTimeType = value; }
        }

        /// <summary>
        /// 获取或设置线别设备类型ID
        /// </summary>
        public Int32 EquipmentLineId
        {
            get { return this.equipmentLineId; }
            set { this.equipmentLineId = value; }
        }

        /// <summary>
        /// 获取或设置产品ID
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置面别
        /// </summary>
        public String TableName
        {
            get { return this.tableName; }
            set { this.tableName = value; }
        }

        /// <summary>
        /// 获取或设置标准工时（秒）
        /// </summary>
        public Decimal StandardLaborTime
        {
            get { return this.standardLaborTime; }
            set { this.standardLaborTime = value; }
        }

        /// <summary>
        /// 获取或设置标准产能
        /// </summary>
        public decimal StandardCapacity
        {
            get { return this.standardCapacity; }
            set { this.standardCapacity = value; }
        }

        /// <summary>
        /// 获取或设置创建者
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改者
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}
