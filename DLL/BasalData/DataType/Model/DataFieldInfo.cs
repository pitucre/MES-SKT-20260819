using System;

namespace SKT.LeanMES.DataType.Model
{
    [Serializable]
    public class DataFieldInfo
    {
        private Int32 dataFieldId;
        private Int32 dataTypeId;
        private Int32 maskGroup;
        private String dataField;
        private String dataTag;        
        private String dataType;
        private Boolean required;
        private Int32 sequence;
        private String remark;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;

        private String maskGroupData;
        /// <summary>
        /// 初始化 SKT.MES.Model.SYS.FIELDInfo 类的新实例。
        /// </summary>
        public DataFieldInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.SYS.FIELDInfo 类的新实例。
        /// </summary>
        /// <param name="fID">系统ID</param>
        /// <param name="tID">主表ID</param>
        /// <param name="dataField">数据项</param>
        /// <param name="dataTag">项标签</param>
        /// <param name="maskGroup">需要验证的掩码组名</param>
        /// <param name="dataType">数据类型(T文本，D日期，N数字，C复选框)</param>
        /// <param name="required">是否必须（false，true）</param>
        /// <param name="sequence">次序</param>
        /// <param name="remark">备注</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改者</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        public DataFieldInfo(Int32 dataFieldId, Int32 dataTypeId, String dataField, String dataTag,
            Int32 maskGroup, String dataType, Boolean required, Int32 sequence, String remark, 
            DateTime modifyDateTime, String modifyBy, DateTime createDateTime, String createBy)
        {
            this.dataFieldId = dataFieldId;
            this.dataTypeId = dataTypeId;
            this.dataField = dataField;
            this.dataTag = dataTag;
            this.maskGroup = maskGroup;
            this.dataType = dataType;
            this.required = required;
            this.sequence = sequence;
            this.remark = remark;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }
        /// <summary>
        /// 初始化 SKT.MES.Model.SYS.FIELDInfo 类的新实例。
        /// </summary>
        /// <param name="fID">系统ID</param>
        /// <param name="tID">主表ID</param>
        /// <param name="dataField">数据项</param>
        /// <param name="dataTag">项标签</param>
        /// <param name="maskGroup">需要验证的掩码组名</param>
        /// <param name="dataType">数据类型(T文本，D日期，N数字，C复选框)</param>
        /// <param name="required">是否必须（false，true）</param>
        /// <param name="sequence">次序</param>
        /// <param name="remark">备注</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改者</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        /// <param name="maskGroupData">掩码组名</param>
        public DataFieldInfo(Int32 dataFieldId, Int32 dataTypeId, String dataField, String dataTag,
            Int32 maskGroup, String dataType, Boolean required, Int32 sequence, String remark,
            DateTime modifyDateTime, String modifyBy, DateTime createDateTime, String createBy, String maskGroupData)
        {
            this.dataFieldId = dataFieldId;
            this.dataTypeId = dataTypeId;
            this.dataField = dataField;
            this.dataTag = dataTag;
            this.maskGroup = maskGroup;
            this.dataType = dataType;
            this.required = required;
            this.sequence = sequence;
            this.remark = remark;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.maskGroupData = maskGroupData;
        }
        /// <summary>
        /// 获取或设置系统ID
        /// </summary>
        public Int32 DataFieldId
        {
            get { return this.dataFieldId; }
            set { this.dataFieldId = value; }
        }

        /// <summary>
        /// 获取或设置主表ID
        /// </summary>
        public Int32 DataTypeId
        {
            get { return this.dataTypeId; }
            set { this.dataTypeId = value; }
        }

        /// <summary>
        /// 获取或设置数据项
        /// </summary>
        public String DataField
        {
            get { return this.dataField; }
            set { this.dataField = value; }
        }

        /// <summary>
        /// 获取或设置项标签
        /// </summary>
        public String DataTag
        {
            get { return this.dataTag; }
            set { this.dataTag = value; }
        }

        /// <summary>
        /// 获取或设置需要验证的掩码组名
        /// </summary>
        public Int32 MaskGroup
        {
            get { return this.maskGroup; }
            set { this.maskGroup = value; }
        }

        /// <summary>
        /// 获取或设置数据类型(T文本，D日期，N数字，C复选框)
        /// </summary>
        public String DataType
        {
            get { return this.dataType; }
            set { this.dataType = value; }
        }

        /// <summary>
        /// 获取或设置是否必须（false，true）
        /// </summary>
        public Boolean Required
        {
            get { return this.required; }
            set { this.required = value; }
        }

        /// <summary>
        /// 获取或设置次序
        /// </summary>
        public Int32 Sequence
        {
            get { return this.sequence; }
            set { this.sequence = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModiftDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
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
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
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
        /// 获取或设置掩码组名
        /// </summary>
        public String MaskGroupData
        {
            get { return this.maskGroupData; }
            set { this.maskGroupData = value; }
        }
    }
}