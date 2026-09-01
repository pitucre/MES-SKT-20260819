using System;

namespace SKT.LeanMES.Turnover.Model
{
    [Serializable]
    public class TurnoverStatusInfo
    {
        private Int32 turnoverStatusId;
        private String description;

        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINER_STATUSInfo 类的新实例。
        /// </summary>
        public TurnoverStatusInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINER_STATUSInfo 类的新实例。
        /// </summary>
        /// <param name="cCStatusId"></param>
        /// <param name="description"></param>
        public TurnoverStatusInfo(Int32 cCStatusId, String description)
        {
            this.turnoverStatusId = cCStatusId;
            this.description = description;
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
        /// 获取或设置 周转工具状态描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }
    }
}