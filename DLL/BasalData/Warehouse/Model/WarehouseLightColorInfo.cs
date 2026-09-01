using System;


namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class WarehouseLightColorInfo
    {
        private Int32 functionId;
        private String functionName;
        private String colorCode;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String colorDescription;


        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseLightColorInfo 类的新实例。
        /// </summary>
        public WarehouseLightColorInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseLocationLightColorInfo 类的新实例。
        /// </summary>
        /// <param name="functionId"></param>
        /// <param name="functionName">亮灯功能名称</param>
        /// <param name="ColorCode">亮灯颜色代码</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public WarehouseLightColorInfo(Int32 functionId, String functionName, String colorCode, String createBy, DateTime createDateTime,
            String modifyBy, DateTime modifyDateTime, string colorDescription)
        {
            this.functionId = functionId;
            this.functionName = functionName;
            this.colorCode = colorCode;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.colorDescription = colorDescription;
        }
        public WarehouseLightColorInfo(Int32 functionId, String functionName)
        {
            this.functionId = functionId;
            this.functionName = functionName;
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 FunctionId
        {
            get { return this.functionId; }
            set { this.functionId = value; }
        }

        /// <summary>
        /// 获取或设置亮灯方法名称
        /// </summary>
        public String FunctionName
        {
            get { return this.functionName; }
            set { this.functionName = value; }
        }

        /// <summary>
        /// 获取或设置亮灯代码
        /// </summary>
        public String ColorCode
        {
            get { return this.colorCode; }
            set { this.colorCode = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
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
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
        /// <summary>
        /// 获取或设置亮灯颜色描述
        /// </summary>
        public String ColorDescription
        {
            get { return this.colorDescription; }
            set { this.colorDescription = value; }
        }

        /// <summary>
        /// 正在使用得工单号
        /// </summary>
        public string InUseProdOrderNo { get; set; }
    }
}