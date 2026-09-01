using System;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class FeederGroupInfo
    {
        private Int32 iD;
        private Int32 machineModelID;
        private Int32 minSize;
        private Int32 maxSize;
        private String modelName;
        /// <summary>
        /// 初始化 SKT.MES.SMT.Model.FEEDERGROUPInfo 类的新实例。
        /// </summary>
        public FeederGroupInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.SMT.Model.FEEDERGROUPInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="machineModelID">机器设备ID</param>
        /// <param name="minSize">最小尺寸</param>
        /// <param name="maxSize">最大尺寸</param>
        public FeederGroupInfo(Int32 iD, Int32 machineModelID, String modelName, Int32 minSize, Int32 maxSize)
        {
            this.iD = iD;
            this.machineModelID = machineModelID;
            this.minSize = minSize;
            this.maxSize = maxSize;
            this.modelName =modelName;
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
        /// 获取或设置机器设备ID
        /// </summary>
        public Int32 MachineModelID
        {
            get { return this.machineModelID; }
            set { this.machineModelID = value; }
        }

        /// <summary>
        /// 获取或设置最小尺寸
        /// </summary>
        public Int32 MinSize
        {
            get { return this.minSize; }
            set { this.minSize = value; }
        }

        /// <summary>
        /// 获取或设置最大尺寸
        /// </summary>
        public Int32 MaxSize
        {
            get { return this.maxSize; }
            set { this.maxSize = value; }
        }

        /// <summary>
        /// 获取或设置最大尺寸
        /// </summary>
        public String ModelName
        {
            get { return this.modelName; }
            set { this.modelName = value; }
        }
    }
}