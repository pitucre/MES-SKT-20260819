using System;

namespace SKT.LeanMES.Labels.Model
{
    [Serializable]
    public class LabelZPLInfo
    {
        private Int32 labelZplId;
        private String zplName;
        private Int32 zplType;
        private String description;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Labels.Model.LabelZPLInfo 类的新实例。
        /// </summary>
        public LabelZPLInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Labels.Model.LabelZPLInfo 类的新实例。
        /// </summary>
        /// <param name="labelZplId"></param>
        /// <param name="zplName"></param>
        /// <param name="description"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="remark"></param>
        /// <param name="zplType"></param>
        public LabelZPLInfo(Int32 labelZplId, String zplName, String description, DateTime modifyDateTime, 
            String modifyBy, DateTime createDateTime, String createBy, String remark,Int32 zplType)
        {
            this.labelZplId = labelZplId;
            this.zplName = zplName;
            this.description = description;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.remark = remark;
            this.zplType = zplType;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LabelZplId
        {
            get { return this.labelZplId; }
            set { this.labelZplId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ZplName
        {
            get { return this.zplName; }
            set { this.zplName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ZplType
        {
            get { return this.zplType; }
            set { this.zplType = value; }
        }


        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
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
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}