using System;

namespace SKT.LeanMES.Turnover.Model
{
    [Serializable]
    public class TurnoverTypeInfo
    {
        private Int32 turnoverTypeId;
        private String turnoverTypeCode;
        private String turnoverTypeName;
        private DateTime createDateTime;
        private String createBy;
        private DateTime modifyDateTime;
        private String modifyBy;

        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINER_TYPEInfo 类的新实例。
        /// </summary>
        public TurnoverTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.CONTAINER_TYPEInfo 类的新实例。
        /// </summary>
        /// <param name="cCTypeID"></param>
        /// <param name="circulationType"></param>
        /// <param name="description"></param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        public TurnoverTypeInfo(Int32 cCTypeID, String circulationType, String description, DateTime createDateTime, 
            String createBy, DateTime modifyDateTime, String modifyBy)
        {
            this.turnoverTypeId = cCTypeID;
            this.turnoverTypeCode = circulationType;
            this.turnoverTypeName = description;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
        }

        /// <summary>
        /// 获取或设置   周转工具种类Id
        /// </summary>
        public Int32 TurnoverTypeId
        {
            get { return this.turnoverTypeId; }
            set { this.turnoverTypeId = value; }
        }

        /// <summary>
        /// 获取或设置   周转工具种类编码
        /// </summary>
        public String TurnoverTypeCode
        {
            get { return this.turnoverTypeCode; }
            set { this.turnoverTypeCode = value; }
        }

        /// <summary>
        /// 获取或设置   周转工具种类名称
        /// </summary>
        public String TurnoverTypeName
        {
            get { return this.turnoverTypeName; }
            set { this.turnoverTypeName = value; }
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
    }
}