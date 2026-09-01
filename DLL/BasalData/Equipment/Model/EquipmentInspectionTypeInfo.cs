using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentInspectionTypeInfo
    {
        private Int32 iD;
        private Int32 inspectionTypeId;
        private String inspectionTypeName;
        private String creater;
        private DateTime createTime;
        private String description;
        private Boolean status;
        private String inspectionRuleIdList;

        public int GenerateNumberTypeId { get; set; }
        public string GenerateNumberTypeName { get; set; }
        public int SystemType { get; set; }
        public string QCTypeName { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionTypeInfo 类的新实例。
        /// </summary>
        public EquipmentInspectionTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionTypeInfo 类的新实例。
        /// </summary>
        /// <param name="iD">排序编号,主键</param>
        /// <param name="inspectionTypeId">检验类型类型编号</param>
        /// <param name="inspectionTypeName">检验类型名称</param>
        /// <param name="creater">检验类型创建者</param>
        /// <param name="createTime">检验类型的创建日期</param>
        /// <param name="description">检验类型说明</param>
        /// <param name="status">检验类型的状态，默认为启用 1 ,禁用为0</param>
        /// <param name="inspectionRuleIdList">此检验类型已应用的检验规则ID清单</param>
        public EquipmentInspectionTypeInfo(Int32 inspectionTypeId, String inspectionTypeName, String creater,
            DateTime createTime, String description, Boolean status, String inspectionRuleIdList)
        {
            this.inspectionTypeId = inspectionTypeId;
            this.inspectionTypeName = inspectionTypeName;
            this.creater = creater;
            this.createTime = createTime;
            this.description = description;
            this.status = status;
            this.inspectionRuleIdList = inspectionRuleIdList;
        }

        /// <summary>
        /// 获取或设置排序编号,主键
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置检验类型类型编号
        /// </summary>
        public Int32 InspectionTypeId
        {
            get { return this.inspectionTypeId; }
            set { this.inspectionTypeId = value; }
        }

        /// <summary>
        /// 获取或设置检验类型名称
        /// </summary>
        public String InspectionTypeName
        {
            get { return this.inspectionTypeName; }
            set { this.inspectionTypeName = value; }
        }

        /// <summary>
        /// 获取或设置检验类型创建者
        /// </summary>
        public String Creater
        {
            get { return this.creater; }
            set { this.creater = value; }
        }

        /// <summary>
        /// 获取或设置检验类型的创建日期
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

        /// <summary>
        /// 获取或设置检验类型说明
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置检验类型的状态，默认为启用 1 ,禁用为0
        /// </summary>
        public Boolean Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置此检验类型已应用的检验规则ID清单
        /// </summary>
        public String InspectionRuleIdList
        {
            get { return this.inspectionRuleIdList; }
            set { this.inspectionRuleIdList = value; }
        }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }
    }
}