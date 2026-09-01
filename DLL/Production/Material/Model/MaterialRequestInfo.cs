using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class MaterialRequestInfo
    {
        private Int32 materialRequestId;
        private String formNO;
        private Int32 wOId;
        private Int32 departId;
        private Int32 requestUserId;
        private Int32 responseUserId;
        private String formDescription;
        private Byte state;
        private Byte prepareState;
        private Byte prioritys;
        private DateTime userDate;
        private DateTime createDateTime;
        private String createBy;
        private DateTime modifyDateTime;
        private String modifyBy;

        private String departName;
        private String userName;
        private String outForm;
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialRequestInfo 类的新实例。
        /// </summary>
        public MaterialRequestInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialRequestInfo 类的新实例。
        /// </summary>
        /// <param name="materialRequestId"></param>
        /// <param name="formNO">领料单号</param>
        /// <param name="wOId">工单ID(生产流程单)</param>
        /// <param name="departId">领料部门</param>
        /// <param name="requestUserId">领料人</param>
        /// <param name="responseUserId">发料人</param>
        /// <param name="formDescription">领料用途说明</param>
        /// <param name="state">状态(0: 未领料   1:已领料)</param>
        /// <param name="prepareState">备料状态（0:等待备料  1:正在备料  2:备料完成）</param>
        /// <param name="prioritys">备料优先级(1: 高  2:中  3:低)</param>
        /// <param name="userDate">物料预计使用时间</param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        public MaterialRequestInfo(Int32 materialRequestId, String formNO, Int32 wOId, Int32 departId,
            Int32 requestUserId, Int32 responseUserId, String formDescription, Byte state, Byte prepareState,
            Byte prioritys, DateTime userDate, DateTime createDateTime, String createBy, DateTime modifyDateTime,
            String modifyBy)
        {
            this.materialRequestId = materialRequestId;
            this.formNO = formNO;
            this.wOId = wOId;
            this.departId = departId;
            this.requestUserId = requestUserId;
            this.responseUserId = responseUserId;
            this.formDescription = formDescription;
            this.state = state;
            this.prepareState = prepareState;
            this.prioritys = prioritys;
            this.userDate = userDate;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
        }


        public String OutForm
        {
            get { return this.outForm; }
            set { this.outForm = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MaterialRequestId
        {
            get { return this.materialRequestId; }
            set { this.materialRequestId = value; }
        }

        /// <summary>
        /// 获取或设置领料单号
        /// </summary>
        public String FormNO
        {
            get { return this.formNO; }
            set { this.formNO = value; }
        }

        /// <summary>
        /// 获取或设置工单ID(生产流程单)
        /// </summary>
        public Int32 WOId
        {
            get { return this.wOId; }
            set { this.wOId = value; }
        }

        /// <summary>
        /// 获取或设置领料部门
        /// </summary>
        public Int32 DepartId
        {
            get { return this.departId; }
            set { this.departId = value; }
        }

        /// <summary>
        /// 获取或设置领料人
        /// </summary>
        public Int32 RequestUserId
        {
            get { return this.requestUserId; }
            set { this.requestUserId = value; }
        }

        /// <summary>
        /// 获取或设置发料人
        /// </summary>
        public Int32 ResponseUserId
        {
            get { return this.responseUserId; }
            set { this.responseUserId = value; }
        }

        /// <summary>
        /// 获取或设置领料用途说明
        /// </summary>
        public String FormDescription
        {
            get { return this.formDescription; }
            set { this.formDescription = value; }
        }

        /// <summary>
        /// 获取或设置状态(0: 未领料   1:已领料)
        /// </summary>
        public Byte State
        {
            get { return this.state; }
            set { this.state = value; }
        }

        /// <summary>
        /// 获取或设置备料状态（0:等待备料  1:正在备料  2:备料完成）
        /// </summary>
        public Byte PrepareState
        {
            get { return this.prepareState; }
            set { this.prepareState = value; }
        }

        /// <summary>
        /// 获取或设置备料优先级(1: 高  2:中  3:低)
        /// </summary>
        public Byte Prioritys
        {
            get { return this.prioritys; }
            set { this.prioritys = value; }
        }

        /// <summary>
        /// 获取或设置物料预计使用时间
        /// </summary>
        public DateTime UserDate
        {
            get { return this.userDate; }
            set { this.userDate = value; }
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
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
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
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }


        public String UserDateStr
        {
            get;
            set;
        }

        public String UserDate_BinStr
        {
            get { return this.userDate.ToString("yyyy-MM-dd HH:mm:ss"); }
        }
        public String DepartName
        {
            get { return this.departName; }
            set { this.departName = value; }
        }

        public String UserName
        {
            get { return this.userName; }
            set { this.userName = value; }
        }
    }
}