using System;

namespace SKT.LeanMES.Anormal.Model
{
    [Serializable]
    public class AnormalInfo
    {
        private Int32 anormalId;
        private Int32 subTypeId;
        private String anormalObject;
        private Int32 lineId;
        private Int32 opeId;
        private Int32 userId;
        private String owner;
        private String deptId;
        private Int32 status;
        private DateTime startTime;
        private DateTime endTime;
        private String descriptions;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private Byte lineStop;
        private Int32 planId;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.AnormalInfo 类的新实例。
        /// </summary>
        public AnormalInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.AnormalInfo 类的新实例。
        /// </summary>
        /// <param name="anormalId"></param>
        /// <param name="subTypeId">异常子类</param>
        /// <param name="anormalObject">异常对象</param>
        /// <param name="lineId">线别ID</param>
        /// <param name="opeId">工位ID</param>
        /// <param name="userId">异常录入人员</param>
        /// <param name="owner">责任人</param>
        /// <param name="deptId">责任人邮件/部门</param>
        /// <param name="status">1 未确认 2 已确认</param>
        /// <param name="startTime">异常开始时间</param>
        /// <param name="endTime">异常结束时间</param>
        /// <param name="descriptions">异常描述</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        /// <param name="lineStop">1 停线 2 未停线</param>
        /// <param name="planId"></param>
        public AnormalInfo(Int32 anormalId, Int32 subTypeId, String anormalObject, Int32 lineId, 
            Int32 opeId, Int32 userId, String owner, String deptId, Int32 status, 
            DateTime startTime, DateTime endTime, String descriptions, String createBy, DateTime createDateTime, 
            String modifyBy, DateTime modifyDateTime, String remark, Byte lineStop, Int32 planId)
        {
            this.anormalId = anormalId;
            this.subTypeId = subTypeId;
            this.anormalObject = anormalObject;
            this.lineId = lineId;
            this.opeId = opeId;
            this.userId = userId;
            this.owner = owner;
            this.deptId = deptId;
            this.status = status;
            this.startTime = startTime;
            this.endTime = endTime;
            this.descriptions = descriptions;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.lineStop = lineStop;
            this.planId = planId;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AnormalId
        {
            get { return this.anormalId; }
            set { this.anormalId = value; }
        }

        /// <summary>
        /// 获取或设置异常子类
        /// </summary>
        public Int32 SubTypeId
        {
            get { return this.subTypeId; }
            set { this.subTypeId = value; }
        }

        /// <summary>
        /// 获取或设置异常对象
        /// </summary>
        public String AnormalObject
        {
            get { return this.anormalObject; }
            set { this.anormalObject = value; }
        }

        /// <summary>
        /// 获取或设置线别ID
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置工位ID
        /// </summary>
        public Int32 OpeId
        {
            get { return this.opeId; }
            set { this.opeId = value; }
        }

        /// <summary>
        /// 获取或设置异常录入人员
        /// </summary>
        public Int32 UserId
        {
            get { return this.userId; }
            set { this.userId = value; }
        }

        /// <summary>
        /// 获取或设置责任人
        /// </summary>
        public String Owner
        {
            get { return this.owner; }
            set { this.owner = value; }
        }

        /// <summary>
        /// 获取或设置责任人邮件/部门
        /// </summary>
        public String DeptId
        {
            get { return this.deptId; }
            set { this.deptId = value; }
        }

        /// <summary>
        /// 获取或设置1 未确认 2 已确认
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置异常开始时间
        /// </summary>
        public DateTime StartTime
        {
            get { return this.startTime; }
            set { this.startTime = value; }
        }

        /// <summary>
        /// 获取或设置异常结束时间
        /// </summary>
        public DateTime EndTime
        {
            get { return this.endTime; }
            set { this.endTime = value; }
        }

        /// <summary>
        /// 获取或设置异常描述
        /// </summary>
        public String Descriptions
        {
            get { return this.descriptions; }
            set { this.descriptions = value; }
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

        /// <summary>
        /// 获取或设置1 停线 2 未停线
        /// </summary>
        public Byte LineStop
        {
            get { return this.lineStop; }
            set { this.lineStop = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PlanId
        {
            get { return this.planId; }
            set { this.planId = value; }
        }
    }
}