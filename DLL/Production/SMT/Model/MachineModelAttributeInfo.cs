using System;


namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class MachineModelAttributeInfo
    {
        private Int32 modelAttrID;
        private Int32 machineModelID;
        private String machineModelName;
        private Byte tablePosition;
        //private Byte machineTableType;
        private Int16 machineTableType;
        private Int16 startSlotPosition;
        private Int16 endSlotPosition;
        private String status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private String machineTableTypeName;

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.MODEL_ATTRIBUTEInfo 类的新实例。
        /// </summary>
        public MachineModelAttributeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.MODEL_ATTRIBUTEInfo 类的新实例。
        /// </summary>
        /// <param name="modelAttrID"></param>
        /// <param name="machineModelID"></param>
        /// <param name="tablePosition"></param>
        /// <param name="machineTableType"></param>
        /// <param name="startSlotPosition"></param>
        /// <param name="endSlotPosition"></param>
        /// <param name="status"></param>
        public MachineModelAttributeInfo(Int32 modelAttrID, Int32 machineModelID, Byte tablePosition, Byte machineTableType,
            Int16 startSlotPosition, Int16 endSlotPosition, String status, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.modelAttrID = modelAttrID;
            this.machineModelID = machineModelID;
            this.tablePosition = tablePosition;
            this.machineTableType = machineTableType;
            this.startSlotPosition = startSlotPosition;
            this.endSlotPosition = endSlotPosition;
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
        public Int32 ModelAttrID
        {
            get { return this.modelAttrID; }
            set { this.modelAttrID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MachineModelID
        {
            get { return this.machineModelID; }
            set { this.machineModelID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MachineModelName
        {
            get { return this.machineModelName; }
            set { this.machineModelName = value; }
        }
        
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Byte TablePosition
        {
            get { return this.tablePosition; }
            set { this.tablePosition = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int16 MachineTableType
        {
            get { return this.machineTableType; }
            set { this.machineTableType = value; }
        }


        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MachineTableTypeName
        {
            get { return this.machineTableTypeName; }
            set { this.machineTableTypeName = value; }
        }
        
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int16 StartSlotPosition
        {
            get { return this.startSlotPosition; }
            set { this.startSlotPosition = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int16 EndSlotPosition
        {
            get { return this.endSlotPosition; }
            set { this.endSlotPosition = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Status
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