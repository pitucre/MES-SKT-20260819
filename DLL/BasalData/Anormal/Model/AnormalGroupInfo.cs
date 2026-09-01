using System;

namespace SKT.LeanMES.Anormal.Model
{
    [Serializable]
    public class AnormalGroupInfo
    {
        private Int32 anormalgroupId;
        private String anormalgroupCode;
        private String anormalgroupName;
        private String controlShow;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.Anormal_TypeInfo 类的新实例。
        /// </summary>
        public AnormalGroupInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.Anormal_TypeInfo 类的新实例。
        /// </summary>
        /// <param name="typeId"></param>
        /// <param name="typeCode">异常类型编码</param>
        /// <param name="typeName">异常类型名称</param>
        /// <param name="controlShow">异常类型模板（html）</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public AnormalGroupInfo(Int32 anormalgroupId, String anormalgroupCode, String anormalgroupName, String controlShow, 
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.anormalgroupId = anormalgroupId;
            this.anormalgroupCode = anormalgroupCode;
            this.anormalgroupName = anormalgroupName;
            this.controlShow = controlShow;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AnormalGroupId
        {
            get { return this.anormalgroupId; }
            set { this.anormalgroupId = value; }
        }

        /// <summary>
        /// 获取或设置异常类型编码
        /// </summary>
        public String AnormalGroupCode
        {
            get { return this.anormalgroupCode; }
            set { this.anormalgroupCode = value; }
        }

        /// <summary>
        /// 获取或设置异常类型名称
        /// </summary>
        public String AnormalGroupName
        {
            get { return this.anormalgroupName; }
            set { this.anormalgroupName = value; }
        }

        /// <summary>
        /// 获取或设置异常类型模板（html）
        /// </summary>
        public String ControlShow
        {
            get { return this.controlShow; }
            set { this.controlShow = value; }
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
    }
}