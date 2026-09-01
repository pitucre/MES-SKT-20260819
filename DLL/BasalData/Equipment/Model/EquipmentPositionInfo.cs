using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentPositionInfo
    {
        private Int32 equipmentPositionId;
        private String positionName;
        private String remark;
        private String createBy;
        private DateTime createDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentPositionInfo 类的新实例。
        /// </summary>
        public EquipmentPositionInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentPositionInfo 类的新实例。
        /// </summary>
        /// <param name="equipmentPositionId"></param>
        /// <param name="positionName"></param>
        /// <param name="remark"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        public EquipmentPositionInfo(Int32 equipmentPositionId, String positionName, String remark, String createBy, 
            DateTime createDateTime)
        {
            this.equipmentPositionId = equipmentPositionId;
            this.positionName = positionName;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EquipmentPositionId
        {
            get { return this.equipmentPositionId; }
            set { this.equipmentPositionId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String PositionName
        {
            get { return this.positionName; }
            set { this.positionName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
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
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }
    }
}