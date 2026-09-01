using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentLineRelationInfo
    {
        private Int32 equipmentLineId;
        private String equipmentLineType;
        private String equipmentLineDisplayName;
        private Int32 lineId;
        private String createBy;
        private DateTime createDateTime;
        private String updateBy;
        private DateTime updateDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.EquipmentLineRelationInfo 类的新实例。
        /// </summary>
        public EquipmentLineRelationInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.EquipmentLineRelationInfo 类的新实例。
        /// </summary>
        /// <param name="equipmentLineId"></param>
        /// <param name="equipmentLineType"></param>
        /// <param name="equipmentLineDisplayName"></param>
        /// <param name="lineId"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="updateBy"></param>
        /// <param name="updateDateTime"></param>
        /// <param name="remark"></param>
        public EquipmentLineRelationInfo(Int32 equipmentLineId, String equipmentLineType, String equipmentLineDisplayName, Int32 lineId, 
            String createBy, DateTime createDateTime, String updateBy, DateTime updateDateTime, String remark)
        {
            this.equipmentLineId = equipmentLineId;
            this.equipmentLineType = equipmentLineType;
            this.equipmentLineDisplayName = equipmentLineDisplayName;
            this.lineId = lineId;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.updateBy = updateBy;
            this.updateDateTime = updateDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EquipmentLineId
        {
            get { return this.equipmentLineId; }
            set { this.equipmentLineId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String EquipmentLineType
        {
            get { return this.equipmentLineType; }
            set { this.equipmentLineType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String EquipmentLineDisplayName
        {
            get { return this.equipmentLineDisplayName; }
            set { this.equipmentLineDisplayName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
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
        public String UpdateBy
        {
            get { return this.updateBy; }
            set { this.updateBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime UpdateDateTime
        {
            get { return this.updateDateTime; }
            set { this.updateDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        public string LineName { get;set; }

     
    }
}