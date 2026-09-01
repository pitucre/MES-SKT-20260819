using System;

namespace SKT.LeanMES.Schedule.Model
{
    [Serializable]
    public class SchedulingLockMaterialInfo
    {
        private Int32 id;
        private String materialCode;
        private String materialName;
        private Decimal curStockQty;
        private Decimal lockQty;
        private DateTime updateDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.SchedulingLockMaterialInfo 类的新实例。
        /// </summary>
        public SchedulingLockMaterialInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.SchedulingLockMaterialInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="materialCode">物料编码</param>
        /// <param name="materialName">物料名称</param>
        /// <param name="curStockQty">当前库存数</param>
        /// <param name="lockQty">锁定库存数</param>
        /// <param name="updateDateTime">库存同步时间</param>
        /// <param name="remark">备注</param>
        public SchedulingLockMaterialInfo(Int32 id, String materialCode, String materialName, Decimal curStockQty, 
            Decimal lockQty, DateTime updateDateTime, String remark)
        {
            this.id = id;
            this.materialCode = materialCode;
            this.materialName = materialName;
            this.curStockQty = curStockQty;
            this.lockQty = lockQty;
            this.updateDateTime = updateDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Id
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// 获取或设置物料编码
        /// </summary>
        public String MaterialCode
        {
            get { return this.materialCode; }
            set { this.materialCode = value; }
        }

        /// <summary>
        /// 获取或设置物料名称
        /// </summary>
        public String MaterialName
        {
            get { return this.materialName; }
            set { this.materialName = value; }
        }

        /// <summary>
        /// 获取或设置当前库存数
        /// </summary>
        public Decimal CurStockQty
        {
            get { return this.curStockQty; }
            set { this.curStockQty = value; }
        }

        /// <summary>
        /// 获取或设置锁定库存数
        /// </summary>
        public Decimal LockQty
        {
            get { return this.lockQty; }
            set { this.lockQty = value; }
        }

        /// <summary>
        /// 获取或设置库存同步时间
        /// </summary>
        public DateTime UpdateDateTime
        {
            get { return this.updateDateTime; }
            set { this.updateDateTime = value; }
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