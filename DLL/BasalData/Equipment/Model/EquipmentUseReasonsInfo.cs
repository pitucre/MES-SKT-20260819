using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentUseReasonsInfo
    {
        private Int32 equipmentUseReasonsId;
        private String content;
        private String remark;
        private String createBy;
        private DateTime createDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentUseReasonsInfo 类的新实例。
        /// </summary>
        public EquipmentUseReasonsInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentUseReasonsInfo 类的新实例。
        /// </summary>
        /// <param name="equipmentUseReasonsId"></param>
        /// <param name="content"></param>
        /// <param name="remark"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        public EquipmentUseReasonsInfo(Int32 equipmentUseReasonsId, String content, String remark, String createBy,
            DateTime createDateTime, int Type)
        {
            this.equipmentUseReasonsId = equipmentUseReasonsId;
            this.content = content;
            this.Type = Type;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EquipmentUseReasonsId
        {
            get { return this.equipmentUseReasonsId; }
            set { this.equipmentUseReasonsId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Content
        {
            get { return this.content; }
            set { this.content = value; }
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
        /// 类型
        /// </summary>
        public int Type { get; set; }
        /// <summary>
        /// 类型
        /// </summary>
        public string TypeName { get; set; }
        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime{ get; set; }
    }
}