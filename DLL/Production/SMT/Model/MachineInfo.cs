using System;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class MachineInfo
    {
        private Int32 iD;
        private String machineSN;
        private String description;
        private Int32 machineModelID;
        private String modelName;
        private Int32 lineID;
        private String lineName;
        private Byte status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.MACHINEInfo 类的新实例。
        /// </summary>
        public MachineInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.MACHINEInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="machineSN"></param>
        /// <param name="description"></param>
        /// <param name="machineModelID"></param>
        /// <param name="lineID"></param>
        /// <param name="status"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public MachineInfo(Int32 iD, String machineSN, String description, Int32 machineModelID,
            String modelName, Int32 lineID, String lineName, Byte status, String createBy, DateTime createDateTime, String modifyBy,
            DateTime modifyDateTime, String remark)
        {
            this.iD = iD;
            this.machineSN = machineSN;
            this.description = description;
            this.machineModelID = machineModelID;
            this.modelName = modelName;
            this.lineID = lineID;
            this.lineName = lineName;
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
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MachineSN
        {
            get { return this.machineSN; }
            set { this.machineSN = value; }
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
        public Int32 MachineModelID
        {
            get { return this.machineModelID; }
            set { this.machineModelID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModelName
        {
            get { return this.modelName; }
            set { this.modelName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LineID
        {
            get { return this.lineID; }
            set { this.lineID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String LineName
        {
            get { return this.lineName; }
            set { this.lineName = value; }
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