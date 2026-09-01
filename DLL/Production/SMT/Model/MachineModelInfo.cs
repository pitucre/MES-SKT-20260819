using System;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class MachineModelInfo
    {
        private Int32 modelID;
        private String modelName;
        private String description;
        private Int32 machineModelFamilyID;
        private String modelFamilyName;
        private String machineType;
        private String vendor;
        private String status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.MODELInfo 类的新实例。
        /// </summary>
        public MachineModelInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.MODELInfo 类的新实例。
        /// </summary>
        /// <param name="modelID"></param>
        /// <param name="modelName"></param>
        /// <param name="description"></param>
        /// <param name="machineModelFamilyID"></param>
        /// <param name="machineType"></param>
        /// <param name="vendor"></param>
        /// <param name="status"></param>
        public MachineModelInfo(Int32 modelID, String modelName, String description, Int32 machineModelFamilyID,
            String machineType, String vendor, String status, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.modelID = modelID;
            this.modelName = modelName;
            this.description = description;
            this.machineModelFamilyID = machineModelFamilyID;
            this.machineType = machineType;
            this.vendor = vendor;
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
        public Int32 ModelID
        {
            get { return this.modelID; }
            set { this.modelID = value; }
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
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MachineModelFamilyID
        {
            get { return this.machineModelFamilyID; }
            set { this.machineModelFamilyID = value; }
        }

        
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModelFamilyName
        {
            get { return this.modelFamilyName; }
            set { this.modelFamilyName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MachineType
        {
            get { return this.machineType; }
            set { this.machineType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Vendor
        {
            get { return this.vendor; }
            set { this.vendor = value; }
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