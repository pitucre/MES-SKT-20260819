using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class ItemIQCParamInfo
    {
        private Int32 itemIQCParamId;
        private Int32 itemId;
        private String paramName;
        private String paramStandard;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private String itemName;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ItemIQCParamInfo 类的新实例。
        /// </summary>
        public ItemIQCParamInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ItemIQCParamInfo 类的新实例。
        /// </summary>
        /// <param name="itemIQCParamId">抽检参数与Item的对应关系Id</param>
        /// <param name="parameterName">抽检参数名称</param>
        /// <param name="parameterStandard">抽检参数合格标准</param>
        public ItemIQCParamInfo(Int32 itemIQCParamId, String paramName, String paramStandard)
        {
            this.itemIQCParamId = itemIQCParamId;
            this.paramName = paramName;
            this.paramStandard = paramStandard;
        }

        /// <summary>
        /// 获取或设置抽检参数与Item的对应关系Id
        /// </summary>
        public Int32 ItemIQCParamId
        {
            get { return this.itemIQCParamId; }
            set { this.itemIQCParamId = value; }
        }

        /// <summary>
        /// 获取或设置Item表对应Id
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置抽检参数名称
        /// </summary>
        public String ParamName
        {
            get { return this.paramName; }
            set { this.paramName = value; }
        }

        /// <summary>
        /// 获取或设置抽检参数合格标准
        /// </summary>
        public String ParamStandard
        {
            get { return this.paramStandard; }
            set { this.paramStandard = value; }
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

        /// <summary>
        /// 获取或设置 物料名 产品名
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }
    }
}