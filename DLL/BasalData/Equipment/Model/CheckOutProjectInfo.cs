using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class CheckOutProjectInfo
    {
        private Int32 checkOutProjectId;
        private String checkOutProjectName;
        private Boolean isEnable;
        private String remark;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.CheckOutProjectInfo 类的新实例。
        /// </summary>
        public CheckOutProjectInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.CheckOutProjectInfo 类的新实例。
        /// </summary>
        /// <param name="checkOutProjectId"></param>
        /// <param name="checkOutProjectName"></param>
        /// <param name="isEnable"></param>
        /// <param name="remark"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        public CheckOutProjectInfo(Int32 checkOutProjectId, String checkOutProjectName, Boolean isEnable, String remark, 
            String createBy, DateTime createDateTime)
        {
            this.checkOutProjectId = checkOutProjectId;
            this.checkOutProjectName = checkOutProjectName;
            this.isEnable = isEnable;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 CheckOutProjectId
        {
            get { return this.checkOutProjectId; }
            set { this.checkOutProjectId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CheckOutProjectName
        {
            get { return this.checkOutProjectName; }
            set { this.checkOutProjectName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Boolean IsEnable
        {
            get { return this.isEnable; }
            set { this.isEnable = value; }
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
        public string IsEnableName { get; set; }

        public string ModifyBy
        {
            get
            {
                return modifyBy;
            }

            set
            {
                modifyBy = value;
            }
        }

        public DateTime ModifyDateTime
        {
            get
            {
                return modifyDateTime;
            }

            set
            {
                modifyDateTime = value;
            }
        }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }
    }
}