using System;

namespace SKT.LeanMES.MaterialDelivery.Model
{
    [Serializable]
    public class MaterialPrepareDetailInfo
    {
        private Int32 id;
        private Int32 prepareId;
        private String materialNO;
        private Decimal requestQty;
        private String createBy;
        private String createDateTime;
        private Int32 lastPrepareDetailId;
        private Int32 recordType;
        private Boolean isCurrent;

        private String recordTypeStr;
        private String isCurrentStr;
        private Int32 times;


        private String shiftName;
        private String lineName;

        /// <summary>
        /// 初始化 SKT.LeanMES.MaterialDelivery.Model.MaterialPrepareDetailInfo 类的新实例。
        /// </summary>
        public MaterialPrepareDetailInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.MaterialDelivery.Model.MaterialPrepareDetailInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="prepareId"></param>
        /// <param name="materialNO"></param>
        /// <param name="requestQty"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="lastPrepareDetailId">上一个版本的明细Id</param>
        /// <param name="recordType">记录类型 1 插入 2 更新  3 删除（代表此明细记录，是在生成备料单的时候插入的，还是变更时更新插入的，还是变更时移除的。）</param>
        /// <param name="isCurrent">是否当前</param>
        public MaterialPrepareDetailInfo(Int32 id, Int32 prepareId, String materialNO, Decimal requestQty,
            String createBy, String createDateTime, Int32 lastPrepareDetailId, Int32 recordType, Boolean isCurrent)
        {
            this.id = id;
            this.prepareId = prepareId;
            this.materialNO = materialNO;
            this.requestQty = requestQty;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.lastPrepareDetailId = lastPrepareDetailId;
            this.recordType = recordType;
            this.isCurrent = isCurrent;
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.MaterialDelivery.Model.MaterialPrepareDetailInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="materialNO"></param>
        /// <param name="requestQty"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="recordType">记录类型 1 插入 2 更新  3 删除（代表此明细记录，是在生成备料单的时候插入的，还是变更时更新插入的，还是变更时移除的。）</param>
        /// <param name="isCurrent">是否当前</param>
        public MaterialPrepareDetailInfo(Int32 id, String materialNO, Decimal requestQty,
            String createBy, String createDateTime, String recordTypeStr, String isCurrentStr)
        {
            this.id = id;
            this.materialNO = materialNO;
            this.requestQty = requestQty;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.recordTypeStr = recordTypeStr;
            this.isCurrentStr = isCurrentStr;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Id
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PrepareId
        {
            get { return this.prepareId; }
            set { this.prepareId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MaterialNO
        {
            get { return this.materialNO; }
            set { this.materialNO = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal RequestQty
        {
            get { return this.requestQty; }
            set { this.requestQty = value; }
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
        public String CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置上一个版本的明细Id
        /// </summary>
        public Int32 LastPrepareDetailId
        {
            get { return this.lastPrepareDetailId; }
            set { this.lastPrepareDetailId = value; }
        }

        /// <summary>
        /// 获取或设置记录类型 1 插入 2 更新  3 删除（代表此明细记录，是在生成备料单的时候插入的，还是变更时更新插入的，还是变更时移除的。）
        /// </summary>
        public Int32 RecordType
        {
            get { return this.recordType; }
            set { this.recordType = value; }
        }

        /// <summary>
        /// 获取或设置是否当前
        /// </summary>
        public Boolean IsCurrent
        {
            get { return this.isCurrent; }
            set { this.isCurrent = value; }
        }

        /// <summary>
        /// 获取或设置记录类型 1 插入 2 更新  3 删除（代表此明细记录，是在生成备料单的时候插入的，还是变更时更新插入的，还是变更时移除的。）
        /// </summary>
        public String RecordTypeStr
        {
            get { return this.recordTypeStr; }
            set { this.recordTypeStr = value; }
        }

        /// <summary>
        /// 获取或设置是否当前
        /// </summary>
        public String IsCurrentStr
        {
            get { return this.isCurrentStr; }
            set { this.isCurrentStr = value; }
        }

        /// <summary>
        /// 获取该备料项的变更次数
        /// </summary>
        public Int32 Times
        {
            get { return this.times; }
            set { this.times = value; }
        }

        /// <summary>
        /// 获取或设置 班次
        /// </summary>
        public String ShiftName
        {
            get { return this.shiftName; }
            set { this.shiftName = value; }
        }

        /// <summary>
        /// 获取或设置 产线名
        /// </summary>
        public String LineName
        {
            get { return this.lineName; }
            set { this.lineName = value; }
        }
    }
}