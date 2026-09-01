using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
 
namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class MachineModelFamilyInfo
    {
        private Int32 modelFamilyID;
        private String modelFamilyName;
        private String description;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.MODEL_FAMILYInfo 类的新实例。
        /// </summary>
        public MachineModelFamilyInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.MODEL_FAMILYInfo 类的新实例。
        /// </summary>
        /// <param name="modelFamilyID"></param>
        /// <param name="modelFamilyName"></param>
        /// <param name="description"></param>
        public MachineModelFamilyInfo(Int32 modelFamilyID, String modelFamilyName, String description, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.modelFamilyID = modelFamilyID;
            this.modelFamilyName = modelFamilyName;
            this.description = description;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ModelFamilyID
        {
            get { return this.modelFamilyID; }
            set { this.modelFamilyID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModelFamilyName
        {
            get { return this.modelFamilyName; }
            set { this.modelFamilyName = value; }
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