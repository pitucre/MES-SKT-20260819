using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class ItemABCInfo
    {
        private Int32 itemABCId;
        private String aBCClass;
        private Int32 aBCSuper;
        private Int32 aBCVal;
        private Decimal aBCPercentVal;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        public string ABCSuperDesc { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ItemABCInfo 类的新实例。
        /// </summary>
        public ItemABCInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ItemABCInfo 类的新实例。
        /// </summary>
        /// <param name="itemABCId"></param>
        /// <param name="aBCClass">A/B/C等级（A：贵重的、B：一般贵重 C：不贵重）</param>
        /// <param name="aBCSuper">ABC等级超发限制类型（1、数量 2、百分比 3、数量+百分比（两者取大值））</param>
        /// <param name="aBCVal">超发限制值</param>
        /// <param name="aBCPercentVal">超发限制百分比值</param>
        /// <param name="createBy">创建人。</param>
        /// <param name="createDateTime">创建时间。</param>
        /// <param name="modifyBy">修改人。</param>
        /// <param name="modifyDateTime">修改时间。</param>
        /// <param name="remark">备注。</param>
        public ItemABCInfo(Int32 itemABCId, String aBCClass, Int32 aBCSuper, Int32 aBCVal,
            Decimal aBCPercentVal, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime,
            String remark)
        {
            this.itemABCId = itemABCId;
            this.aBCClass = aBCClass;
            this.aBCSuper = aBCSuper;
            this.aBCVal = aBCVal;
            this.aBCPercentVal = aBCPercentVal;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ItemABCId
        {
            get { return this.itemABCId; }
            set { this.itemABCId = value; }
        }

        /// <summary>
        /// 获取或设置A/B/C等级（A：贵重的、B：一般贵重 C：不贵重）
        /// </summary>
        public String ABCClass
        {
            get { return this.aBCClass; }
            set { this.aBCClass = value; }
        }

        /// <summary>
        /// 获取或设置ABC等级超发限制类型（1、数量 2、百分比 3、数量+百分比（两者取大值））
        /// </summary>
        public Int32 ABCSuper
        {
            get { return this.aBCSuper; }
            set { this.aBCSuper = value; }
        }

        /// <summary>
        /// 获取或设置超发限制值
        /// </summary>
        public Int32 ABCVal
        {
            get { return this.aBCVal; }
            set { this.aBCVal = value; }
        }

        /// <summary>
        /// 获取或设置超发限制百分比值
        /// </summary>
        public Decimal ABCPercentVal
        {
            get { return this.aBCPercentVal; }
            set { this.aBCPercentVal = value; }
        }

        /// <summary>
        /// 获取或设置创建人。
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间。
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人。
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间。
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置备注。
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}
