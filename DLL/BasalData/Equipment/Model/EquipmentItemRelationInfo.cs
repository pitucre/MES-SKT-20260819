using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentItemRelationInfo
    {
        private Int32 equipmentItemRelationId;
        private String itemCode;
        private String eqCode;
        private String createBy;
        private DateTime createDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentItemRelationInfo 类的新实例。
        /// </summary>
        public EquipmentItemRelationInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentItemRelationInfo 类的新实例。
        /// </summary>
        /// <param name="equipmentItemRelationId"></param>
        /// <param name="itemCode"></param>
        /// <param name="eqCode"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        public EquipmentItemRelationInfo(Int32 equipmentItemRelationId, String itemCode, String eqCode, String createBy, 
            DateTime createDateTime)
        {
            this.equipmentItemRelationId = equipmentItemRelationId;
            this.itemCode = itemCode;
            this.eqCode = eqCode;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EquipmentItemRelationId
        {
            get { return this.equipmentItemRelationId; }
            set { this.equipmentItemRelationId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String EqCode
        {
            get { return this.eqCode; }
            set { this.eqCode = value; }
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
        public string EqName { get; set; }
        public string ItemSpec { get; set; }

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