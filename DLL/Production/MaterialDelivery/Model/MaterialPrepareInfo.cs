using System;

namespace SKT.LeanMES.MaterialDelivery.Model
{
    [Serializable]
    public class MaterialPrepareInfo
    {
        private Int32 prepareId;
        private String prepareNO;
        private Int32 scheduleId;
        private Decimal requestQty;
        private String requestDate;
        private Int32 sTATUS;
        private String createBy;
        private String createDateTime;
        private String getPerson;
        private String getDateTime;
        private String modifyBy;
        private String modifyDateTime;

        private String prodOrderNO;
        private String sectionNO;
        private String productCode;

        /// <summary>
        /// 初始化 SKT.LeanMES.MaterialDelivery.Model.MaterialPrepareInfo 类的新实例。
        /// </summary>
        public MaterialPrepareInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.MaterialDelivery.Model.MaterialPrepareInfo 类的新实例。
        /// </summary>
        /// <param name="prepareId"></param>
        /// <param name="prepareNO">备料单号</param>
        /// <param name="scheduleId">排程Id</param>
        /// <param name="requestDate">需备料的日期时间</param>
        /// <param name="sTATUS">状态 1 未备料  2 已备料</param>
        /// <param name="createBy">创建者</param>
        /// <param name="createDateTime">创建人</param>
        /// <param name="getPerson">领料人</param>
        /// <param name="getDateTime">领料时间</param>
        /// <param name="modifyBy">修改者</param>
        /// <param name="modifyDateTime">修改时间</param>
        public MaterialPrepareInfo(Int32 prepareId, String prepareNO, Int32 scheduleId, String requestDate,
            Int32 sTATUS, String createBy, String createDateTime, String getPerson, String getDateTime,
            String modifyBy, String modifyDateTime)
        {
            this.prepareId = prepareId;
            this.prepareNO = prepareNO;
            this.scheduleId = scheduleId;
            this.requestDate = requestDate;
            this.sTATUS = sTATUS;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.getPerson = getPerson;
            this.getDateTime = getDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }


        /// <summary>
        /// 初始化 SKT.LeanMES.MaterialDelivery.Model.MaterialPrepareInfo 类的新实例。
        /// </summary>
        /// <param name="prepareId"></param>
        /// <param name="prepareNO">备料单号</param>
        /// <param name="prodOrderNO">工单号</param>
        /// <param name="requestQty">备料数量</param>
        /// <param name="sectionNO">工艺段</param>
        /// <param name="productCode">产品编码</param>
        /// <param name="requestDate">需备料的日期时间</param>
        /// <param name="sTATUS">状态 1 未备料  2 已备料</param>
        /// <param name="createBy">创建者</param>
        /// <param name="createDateTime">创建人</param>
        /// <param name="getPerson">领料人</param>
        /// <param name="getDateTime">领料时间</param>
        /// <param name="modifyBy">修改者</param>
        /// <param name="modifyDateTime">修改时间</param>
        public MaterialPrepareInfo(Int32 prepareId, String prepareNO, String prodOrderNO, String sectionNO, String productCode
            , Decimal requestQty, String requestDate, Int32 sTATUS, String createBy, String createDateTime, String getPerson
            , String getDateTime, String modifyBy, String modifyDateTime)
        {
            this.prepareId = prepareId;
            this.prepareNO = prepareNO;
            this.prodOrderNO = prodOrderNO;
            this.sectionNO = sectionNO;
            this.productCode = productCode;
            this.requestQty = requestQty;
            this.requestDate = requestDate;
            this.sTATUS = sTATUS;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.getPerson = getPerson;
            this.getDateTime = getDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
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
        /// 获取或设置备料单号
        /// </summary>
        public String PrepareNO
        {
            get { return this.prepareNO; }
            set { this.prepareNO = value; }
        }

        /// <summary>
        /// 获取或设置排程Id
        /// </summary>
        public Int32 ScheduleId
        {
            get { return this.scheduleId; }
            set { this.scheduleId = value; }
        }

        /// <summary>
        /// 获取或设置需备料的物料数量
        /// </summary>
        public Decimal RequestQty
        {
            get { return this.requestQty; }
            set { this.requestQty = value; }
        }

        /// <summary>
        /// 获取或设置需备料的日期时间
        /// </summary>
        public String RequestDate
        {
            get { return this.requestDate; }
            set { this.requestDate = value; }
        }

        /// <summary>
        /// 获取或设置状态 1 未备料  2 已备料
        /// </summary>
        public Int32 STATUS
        {
            get { return this.sTATUS; }
            set { this.sTATUS = value; }
        }

        /// <summary>
        /// 获取或设置创建者
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置领料人
        /// </summary>
        public String GetPerson
        {
            get { return this.getPerson; }
            set { this.getPerson = value; }
        }

        /// <summary>
        /// 获取或设置领料时间
        /// </summary>
        public String GetDateTime
        {
            get { return this.getDateTime; }
            set { this.getDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改者
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public String ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 工单号
        /// </summary>
        public String ProdOrderNO
        {
            get { return this.prodOrderNO; }
            set { this.prodOrderNO = value; }
        }

        /// <summary>
        /// 工艺段
        /// </summary>
        public String SectionNO
        {
            get { return this.sectionNO; }
            set { this.sectionNO = value; }
        }

        /// <summary>
        /// 产品编码
        /// </summary>
        public String ProductCode
        {
            get { return this.productCode; }
            set { this.productCode = value; }
        }

    }
}