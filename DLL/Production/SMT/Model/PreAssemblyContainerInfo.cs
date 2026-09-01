using System;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class PreAssemblyContainerInfo
    {
        private Int32 iD;
        private String containerNO;
        private String modelNO;
        private String orderNO;
        private String partNO;
        private String lotNO;
        private DateTime createDateTime;
        private Int32 createBy;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PreAssemblyContainerInfo 类的新实例。
        /// </summary>
        public PreAssemblyContainerInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PreAssemblyContainerInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="containerNO">容器号</param>
        /// <param name="modelNO">产品号</param>
        /// <param name="orderNO">工单号</param>
        /// <param name="partNO">物料编码</param>
        /// <param name="lotNO">GRN号码</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建人</param>
        public PreAssemblyContainerInfo(Int32 iD, String containerNO, String modelNO, String orderNO, 
            String partNO, String lotNO, DateTime createDateTime, Int32 createBy)
        {
            this.iD = iD;
            this.containerNO = containerNO;
            this.modelNO = modelNO;
            this.orderNO = orderNO;
            this.partNO = partNO;
            this.lotNO = lotNO;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
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
        /// 获取或设置容器号
        /// </summary>
        public String ContainerNO
        {
            get { return this.containerNO; }
            set { this.containerNO = value; }
        }

        /// <summary>
        /// 获取或设置产品号
        /// </summary>
        public String ModelNO
        {
            get { return this.modelNO; }
            set { this.modelNO = value; }
        }

        /// <summary>
        /// 获取或设置工单号
        /// </summary>
        public String OrderNO
        {
            get { return this.orderNO; }
            set { this.orderNO = value; }
        }

        /// <summary>
        /// 获取或设置物料编码
        /// </summary>
        public String PartNO
        {
            get { return this.partNO; }
            set { this.partNO = value; }
        }

        /// <summary>
        /// 获取或设置GRN号码
        /// </summary>
        public String LotNO
        {
            get { return this.lotNO; }
            set { this.lotNO = value; }
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
        /// 获取或设置创建人
        /// </summary>
        public Int32 CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }
    }
}