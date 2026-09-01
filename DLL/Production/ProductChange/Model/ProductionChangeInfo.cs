using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductChange.Model
{
    [Serializable]
    public class ProductionChangeInfo
    {
        private Int32 productionChangeId;
        private String serialNumber;
        private Int32 oldRouterId;
        private Int32 oldStationId;
        private Int32 newRouterId;
        private Int32 newStationId;
        private String createdBy;
        private DateTime cretatedTime;

        private String oldRouterName;
        private String oldStationName;
        private String newRouterName;
        private String newStationName;
        public string OldOrderNo { get; set; }
        public string NewOrderNo { get; set; }

        public string Remark { get; set; } //生产变更原因
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProductionChangeInfo 类的新实例。
        /// </summary>
        public ProductionChangeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProductionChangeInfo 类的新实例。
        /// </summary>
        /// <param name="productionChangeId"></param>
        /// <param name="serialNumber">产品序列号</param>
        /// <param name="oldRouterId">原路由ID</param>
        /// <param name="oldStationId">新工序ID</param>
        /// <param name="newRouterId">新路由ID</param>
        /// <param name="newStationId">新工序ID</param>
        /// <param name="createdBy">变更人</param>
        /// <param name="cretatedTime">变更时间</param>
        public ProductionChangeInfo(Int32 productionChangeId, String serialNumber, Int32 oldRouterId, Int32 oldStationId,
            Int32 newRouterId, Int32 newStationId, String createdBy, DateTime cretatedTime)
        {
            this.productionChangeId = productionChangeId;
            this.serialNumber = serialNumber;
            this.oldRouterId = oldRouterId;
            this.oldStationId = oldStationId;
            this.newRouterId = newRouterId;
            this.newStationId = newStationId;
            this.createdBy = createdBy;
            this.cretatedTime = cretatedTime;
        }

        /// <summary>
        /// 获取或设置ID
        /// </summary>
        public Int32 ProductionChangeId
        {
            get { return this.productionChangeId; }
            set { this.productionChangeId = value; }
        }

        /// <summary>
        /// 获取或设置产品序列号
        /// </summary>
        public String SerialNumber
        {
            get { return this.serialNumber; }
            set { this.serialNumber = value; }
        }

        /// <summary>
        /// 获取或设置原路由ID
        /// </summary>
        public Int32 OldRouterId
        {
            get { return this.oldRouterId; }
            set { this.oldRouterId = value; }
        }

        /// <summary>
        /// 获取或设置原工序ID
        /// </summary>
        public Int32 OldStationId
        {
            get { return this.oldStationId; }
            set { this.oldStationId = value; }
        }

        /// <summary>
        /// 获取或设置新路由ID
        /// </summary>
        public Int32 NewRouterId
        {
            get { return this.newRouterId; }
            set { this.newRouterId = value; }
        }

        /// <summary>
        /// 获取或设置新工序ID
        /// </summary>
        public Int32 NewStationId
        {
            get { return this.newStationId; }
            set { this.newStationId = value; }
        }

        /// <summary>
        /// 获取或设置变更人
        /// </summary>
        public String CreatedBy
        {
            get { return this.createdBy; }
            set { this.createdBy = value; }
        }

        /// <summary>
        /// 获取或设置变更时间
        /// </summary>
        public DateTime CretatedTime
        {
            get { return this.cretatedTime; }
            set { this.cretatedTime = value; }
        }


        /// <summary>
        /// 获取或设置原路由名称
        /// </summary>
        public String OldRouterName
        {
            get { return this.oldRouterName; }
            set { this.oldRouterName = value; }
        }

        /// <summary>
        /// 获取或设置原工序名称
        /// </summary>
        public String OldStationName
        {
            get { return this.oldStationName; }
            set { this.oldStationName = value; }
        }

        /// <summary>
        /// 获取或设置新路由名称
        /// </summary>
        public String NewRouterName
        {
            get { return this.newRouterName; }
            set { this.newRouterName = value; }
        }

        /// <summary>
        /// 获取或设置新工序名称
        /// </summary>
        public String NewStationName
        {
            get { return this.newStationName; }
            set { this.newStationName = value; }
        }

    }
}
