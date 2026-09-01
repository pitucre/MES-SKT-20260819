using System;

namespace SKT.LeanMES.MSD.Model
{
    [Serializable]
    public class MsdContainerInfo
    {
        private Int32 msdContainerId;
        private Int32 containerType;
        private String containerCode;
        private Decimal maxTemp;
        private Decimal minTemp;
        private Int32 maxQty;
        private Int32 state;
        private String remark;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private int useQty;    //已用数
        public string ContainerName { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MsdContainerInfo 类的新实例。
        /// </summary>
        public MsdContainerInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MsdContainerInfo 类的新实例。
        /// </summary>
        /// <param name="msdContainerId"></param>
        /// <param name="containerType">容器类型： 1、干燥箱 2、烤炉</param>
        /// <param name="containerCode">容器编码</param>
        /// <param name="maxTemp">烤炉上限温度</param>
        /// <param name="minTemp">烤炉下限温度</param>
        /// <param name="maxQty">容器最大存放个数</param>
        /// <param name="state">容器状态： 0、停用  1、在用</param>
        /// <param name="remark">容器描述</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public MsdContainerInfo(Int32 msdContainerId, Int32 containerType, String containerCode, Decimal maxTemp, 
            Decimal minTemp, Int32 maxQty, Int32 state, String remark, String createBy, 
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime,int useQty)
        {
            this.msdContainerId = msdContainerId;
            this.containerType = containerType;
            this.containerCode = containerCode;
            this.maxTemp = maxTemp;
            this.minTemp = minTemp;
            this.maxQty = maxQty;
            this.state = state;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.useQty = useQty;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MsdContainerId
        {
            get { return this.msdContainerId; }
            set { this.msdContainerId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 UseQty
        {
            get { return this.useQty; }
            set { this.useQty = value; }
        }

        /// <summary>
        /// 获取或设置容器类型： 1、干燥箱 2、烤炉
        /// </summary>
        public Int32 ContainerType
        {
            get { return this.containerType; }
            set { this.containerType = value; }
        }

        /// <summary>
        /// 获取或设置容器编码
        /// </summary>
        public String ContainerCode
        {
            get { return this.containerCode; }
            set { this.containerCode = value; }
        }

        /// <summary>
        /// 获取或设置烤炉上限温度
        /// </summary>
        public Decimal MaxTemp
        {
            get { return this.maxTemp; }
            set { this.maxTemp = value; }
        }

        /// <summary>
        /// 获取或设置烤炉下限温度
        /// </summary>
        public Decimal MinTemp
        {
            get { return this.minTemp; }
            set { this.minTemp = value; }
        }

        /// <summary>
        /// 获取或设置容器最大存放个数
        /// </summary>
        public Int32 MaxQty
        {
            get { return this.maxQty; }
            set { this.maxQty = value; }
        }

        /// <summary>
        /// 获取或设置容器状态： 0、停用  1、在用
        /// </summary>
        public Int32 State
        {
            get { return this.state; }
            set { this.state = value; }
        }

        /// <summary>
        /// 获取或设置容器描述
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}