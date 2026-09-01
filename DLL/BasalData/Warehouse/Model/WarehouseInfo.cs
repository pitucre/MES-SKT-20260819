using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class WarehouseInfo
    {
        private Int32 warehouseId;
        private String cWhCode;
        private String cWhName;
        private String iWHProperty;
        private String cDepCode;
        private String cWhAddress;
        private String ccWhPhone;
        private String cWhPerson;
        private Boolean bWhPos;
        private String cWhMemo;
        private Boolean bFreeze;
        private String cBarCode;
        private Int16 cycleCount;
        private Int16 cFrequency;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseInfo 类的新实例。
        /// </summary>
        public WarehouseInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseInfo 类的新实例。
        /// </summary>
        /// <param name="warehouseId">主键</param>
        /// <param name="cWhCode">仓库编码</param>
        /// <param name="cWhName">仓库名称</param>
        /// <param name="iWHProperty">仓库属性,1为普通仓,2为现场仓,3为委外仓,4为虚拟仓，默认为普通仓</param>
        /// <param name="cDepCode">所属部门</param>
        /// <param name="cWhAddress">仓库地址</param>
        /// <param name="ccWhPhone">电话</param>
        /// <param name="cWhPerson">负责人</param>
        /// <param name="bWhPos">是否货位管理,1为是货位管理,0为不是货位管理,默认为不是货位管理</param>
        /// <param name="cWhMemo">描述</param>
        /// <param name="bFreeze">是否冻结,1为冻结,0为未冻结,默认为未冻结</param>
        /// <param name="cBarCode">条形码</param>
        /// <param name="cycleCount">盘点周期</param>
        /// <param name="cFrequency">盘点周期单位</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public WarehouseInfo(Int32 warehouseId, String cWhCode, String cWhName, String iWHProperty, 
            String cDepCode, String cWhAddress, String ccWhPhone, String cWhPerson, Boolean bWhPos, 
            String cWhMemo, Boolean bFreeze, String cBarCode, Int16 cycleCount, Int16 cFrequency,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.warehouseId = warehouseId;
            this.cWhCode = cWhCode;
            this.cWhName = cWhName;
            this.iWHProperty = iWHProperty;
            this.cDepCode = cDepCode;
            this.cWhAddress = cWhAddress;
            this.ccWhPhone = ccWhPhone;
            this.cWhPerson = cWhPerson;
            this.bWhPos = bWhPos;
            this.cWhMemo = cWhMemo;
            this.bFreeze = bFreeze;
            this.cBarCode = cBarCode;
            this.cycleCount = cycleCount;
            this.cFrequency = cFrequency;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置主键
        /// </summary>
        public Int32 WarehouseId
        {
            get { return this.warehouseId; }
            set { this.warehouseId = value; }
        }

        /// <summary>
        /// 获取或设置仓库编码
        /// </summary>
        public String CWhCode
        {
            get { return this.cWhCode; }
            set { this.cWhCode = value; }
        }

        /// <summary>
        /// 获取或设置仓库名称
        /// </summary>
        public String CWhName
        {
            get { return this.cWhName; }
            set { this.cWhName = value; }
        }

        /// <summary>
        /// 获取或设置仓库属性,1为普通仓,2为现场仓,3为委外仓,4为虚拟仓，默认为普通仓
        /// </summary>
        public String IWHProperty
        {
            get { return this.iWHProperty; }
            set { this.iWHProperty = value; }
        }

        /// <summary>
        /// 获取或设置所属部门
        /// </summary>
        public String CDepCode
        {
            get { return this.cDepCode; }
            set { this.cDepCode = value; }
        }

        /// <summary>
        /// 获取或设置仓库地址
        /// </summary>
        public String CWhAddress
        {
            get { return this.cWhAddress; }
            set { this.cWhAddress = value; }
        }

        /// <summary>
        /// 获取或设置电话
        /// </summary>
        public String CcWhPhone
        {
            get { return this.ccWhPhone; }
            set { this.ccWhPhone = value; }
        }

        /// <summary>
        /// 获取或设置负责人
        /// </summary>
        public String CWhPerson
        {
            get { return this.cWhPerson; }
            set { this.cWhPerson = value; }
        }

        /// <summary>
        /// 获取或设置是否货位管理,1为是货位管理,0为不是货位管理,默认为不是货位管理
        /// </summary>
        public Boolean BWhPos
        {
            get { return this.bWhPos; }
            set { this.bWhPos = value; }
        }

        /// <summary>
        /// 获取或设置描述
        /// </summary>
        public String CWhMemo
        {
            get { return this.cWhMemo; }
            set { this.cWhMemo = value; }
        }

        /// <summary>
        /// 获取或设置是否冻结,1为冻结,0为未冻结,默认为未冻结
        /// </summary>
        public Boolean BFreeze
        {
            get { return this.bFreeze; }
            set { this.bFreeze = value; }
        }

        /// <summary>
        /// 获取或设置条形码
        /// </summary>
        public String CBarCode
        {
            get { return this.cBarCode; }
            set { this.cBarCode = value; }
        }

        /// <summary>
        /// 获取或设置盘点周期
        /// </summary>
        public Int16 CycleCount
        {
            get { return this.cycleCount; }
            set { this.cycleCount = value; }
        }

        /// <summary>
        /// 获取或设置盘点周期单位
        /// </summary>
        public Int16 CFrequency
        {
            get { return this.cFrequency; }
            set { this.cFrequency = value; }
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
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}