using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class UrgentMaterialInfo
    {
        private Int32 urgentMaterialId;
        private String itemCode;
        private String pOCode;
        private DateTime starDateTime;
        private DateTime endDateTime;
        private String createBy;
        private DateTime createDateTime;
        private String updateBy;
        private DateTime updateDateTime;
        private String reserve;
        private String reserve1;

        /// <summary>
        /// 初始化 SKT.LeanMES.Material.Model.UrgentMaterialInfo 类的新实例。
        /// </summary>
        public UrgentMaterialInfo()
        {
        }
          
        /// <summary>
        /// 初始化 SKT.LeanMES.Material.Model.UrgentMaterialInfo 类的新实例。
        /// </summary>
        /// <param name="urgentMaterialId"></param>
        /// <param name="itemCode"></param>
        /// <param name="pOCode"></param>
        /// <param name="starDateTime"></param>
        /// <param name="endDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="updateBy"></param>
        /// <param name="updateDateTime"></param>
        /// <param name="reserve"></param>
        /// <param name="reserve1"></param>
        public UrgentMaterialInfo(Int32 urgentMaterialId, String itemCode, String pOCode, DateTime starDateTime, 
            DateTime endDateTime, String createBy, DateTime createDateTime, String updateBy, DateTime updateDateTime, 
            String reserve, String reserve1)
        {
            this.urgentMaterialId = urgentMaterialId;
            this.itemCode = itemCode;
            this.pOCode = pOCode;
            this.starDateTime = starDateTime;
            this.endDateTime = endDateTime;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.updateBy = updateBy;
            this.updateDateTime = updateDateTime;
            this.reserve = reserve;
            this.reserve1 = reserve1;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 UrgentMaterialId
        {
            get { return this.urgentMaterialId; }
            set { this.urgentMaterialId = value; }
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
        public String POCode
        {
            get { return this.pOCode; }
            set { this.pOCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime StarDateTime
        {
            get { return this.starDateTime; }
            set { this.starDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime EndDateTime
        {
            get { return this.endDateTime; }
            set { this.endDateTime = value; }
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
        public String UpdateBy
        {
            get { return this.updateBy; }
            set { this.updateBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime UpdateDateTime
        {
            get { return this.updateDateTime; }
            set { this.updateDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Reserve
        {
            get { return this.reserve; }
            set { this.reserve = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Reserve1
        {
            get { return this.reserve1; }
            set { this.reserve1 = value; }
        }
    }
}