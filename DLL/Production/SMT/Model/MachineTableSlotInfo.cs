using System;


namespace  SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class MachineTableSlotInfo
    {
        private Int32 tableSlotID;
        private Int32 machineTableID;
        private String tableSlotSN;
        private String description;
        private Int16 slotPosition;
        private Byte status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.TABLE_SLOTInfo 类的新实例。
        /// </summary>
        public MachineTableSlotInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.TABLE_SLOTInfo 类的新实例。
        /// </summary>
        /// <param name="tableSlotID"></param>
        /// <param name="machineTableID"></param>
        /// <param name="tableSlotSN"></param>
        /// <param name="description"></param>
        /// <param name="slotPosition"></param>
        /// <param name="status"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public MachineTableSlotInfo(Int32 tableSlotID, Int32 machineTableID, String tableSlotSN, String description, 
            Int16 slotPosition, Byte status, String createBy, DateTime createDateTime, String modifyBy, 
            DateTime modifyDateTime, String remark)
        {
            this.tableSlotID = tableSlotID;
            this.machineTableID = machineTableID;
            this.tableSlotSN = tableSlotSN;
            this.description = description;
            this.slotPosition = slotPosition;
            this.status = status;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 TableSlotID
        {
            get { return this.tableSlotID; }
            set { this.tableSlotID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MachineTableID
        {
            get { return this.machineTableID; }
            set { this.machineTableID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String TableSlotSN
        {
            get { return this.tableSlotSN; }
            set { this.tableSlotSN = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int16 SlotPosition
        {
            get { return this.slotPosition; }
            set { this.slotPosition = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Byte Status
        {
            get { return this.status; }
            set { this.status = value; }
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

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}