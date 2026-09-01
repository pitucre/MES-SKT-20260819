using System;

namespace  SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class MachineTableInfo
    {
        private Int32 machineTableID;
        private Int32 machineID;
        private String machineTableSN;
        private String description;
        private Byte tablePosition;
        private Byte machineTableTypeID;
        private String machineTableTypeName;
        private Byte status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.TABLEInfo 类的新实例。
        /// </summary>
        public MachineTableInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.TABLEInfo 类的新实例。
        /// </summary>
        /// <param name="machineTableID"></param>
        /// <param name="machineID"></param>
        /// <param name="machineTableSN"></param>
        /// <param name="description"></param>
        /// <param name="tablePosition"></param>
        /// <param name="machineTableTypeID"></param>
        /// <param name="status"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public MachineTableInfo(Int32 machineTableID, Int32 machineID, String machineTableSN, String description, 
            Byte tablePosition, Byte machineTableTypeID, Byte status, String createBy, DateTime createDateTime, 
            String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.machineTableID = machineTableID;
            this.machineID = machineID;
            this.machineTableSN = machineTableSN;
            this.description = description;
            this.tablePosition = tablePosition;
            this.machineTableTypeID = machineTableTypeID;
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
        public Int32 MachineTableID
        {
            get { return this.machineTableID; }
            set { this.machineTableID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MachineID
        {
            get { return this.machineID; }
            set { this.machineID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MachineTableSN
        {
            get { return this.machineTableSN; }
            set { this.machineTableSN = value; }
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
        public Byte TablePosition
        {
            get { return this.tablePosition; }
            set { this.tablePosition = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Byte MachineTableTypeID
        {
            get { return this.machineTableTypeID; }
            set { this.machineTableTypeID = value; }
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