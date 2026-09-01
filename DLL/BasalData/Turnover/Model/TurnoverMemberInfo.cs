using System;

namespace SKT.LeanMES.Turnover.Model
{
    [Serializable]
    public class TurnoverMemberInfo
    {
        private Int64 turnoverMemberId;
        private Int32 turnoverDataId;
        private Int64 uID;
        private Int32 turnoverStatusId;
        private Int32 opeId;
        private Int32 resId;
        private DateTime createDateTime;
        private String createBy;

        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINER_MEMBERInfo 类的新实例。
        /// </summary>
        public TurnoverMemberInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINER_MEMBERInfo 类的新实例。
        /// </summary>
        /// <param name="cCMemberId"></param>
        /// <param name="cCDataId"></param>
        /// <param name="uID"></param>
        /// <param name="statusId"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        public TurnoverMemberInfo(Int64 cCMemberId, Int32 cCDataId, Int64 uID, Int32 statusId, 
            Int32 opeId, Int32 resId, DateTime createDateTime, String createBy)
        {
            this.turnoverMemberId = cCMemberId;
            this.turnoverDataId = cCDataId;
            this.uID = uID;
            this.turnoverStatusId = statusId;
            this.opeId = opeId;
            this.resId = resId;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置 周转工具内装载的成员记录Id
        /// </summary>
        public Int64 TurnoverMemberId
        {
            get { return this.turnoverMemberId; }
            set { this.turnoverMemberId = value; }
        }

        /// <summary>
        /// 获取或设置 周转工具Id
        /// </summary>
        public Int32 TurnoverDataId
        {
            get { return this.turnoverDataId; }
            set { this.turnoverDataId = value; }
        }

        /// <summary>
        /// 获取或设置 周转工具内装载的成员UNIT表Id
        /// </summary>
        public Int64 UID
        {
            get { return this.uID; }
            set { this.uID = value; }
        }

        /// <summary>
        /// 获取或设置 周转工具状态Id
        /// </summary>
        public Int32 TurnoverStatusId
        {
            get { return this.turnoverStatusId; }
            set { this.turnoverStatusId = value; }
        }

        /// <summary>
        /// 获取或设置 工位Id
        /// </summary>
        public Int32 OpeId
        {
            get { return this.opeId; }
            set { this.opeId = value; }
        }

        /// <summary>
        /// 获取或设置 资源Id
        /// </summary>
        public Int32 ResId
        {
            get { return this.resId; }
            set { this.resId = value; }
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
    }
}