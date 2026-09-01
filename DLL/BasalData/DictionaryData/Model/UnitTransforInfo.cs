using System;

namespace SKT.LeanMES.DictionaryData.Model
{
    [Serializable]
    public class UnitTransforInfo
    {
        private Int32 unitTransforID;
        private Int32 unitID;
        private Int32 transforUnitID;
        private Decimal transforData;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.UnitTransforInfo 类的新实例。
        /// </summary>
        public UnitTransforInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.UnitTransforInfo 类的新实例。
        /// </summary>
        /// <param name="unitTransforID">单位换算ID</param>
        /// <param name="unitID">元单位ID</param>
        /// <param name="transforUnitID">换算单位ID</param>
        /// <param name="transforData">换算值</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建日期</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改日期</param>
        public UnitTransforInfo(Int32 unitTransforID, Int32 unitID, Int32 transforUnitID, Decimal transforData, 
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.unitTransforID = unitTransforID;
            this.unitID = unitID;
            this.transforUnitID = transforUnitID;
            this.transforData = transforData;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置单位换算ID
        /// </summary>
        public Int32 UnitTransforID
        {
            get { return this.unitTransforID; }
            set { this.unitTransforID = value; }
        }

        /// <summary>
        /// 获取或设置元单位ID
        /// </summary>
        public Int32 UnitID
        {
            get { return this.unitID; }
            set { this.unitID = value; }
        }

        public string UintName { set; get; }

        /// <summary>
        /// 获取或设置换算单位ID
        /// </summary>
        public Int32 TransforUnitID
        {
            get { return this.transforUnitID; }
            set { this.transforUnitID = value; }
        }

        public string TransforUnitName { set; get; }

        /// <summary>
        /// 获取或设置换算值
        /// </summary>
        public Decimal TransforData
        {
            get { return this.transforData; }
            set { this.transforData = value; }
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
        /// 获取或设置创建日期
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
        /// 获取或设置修改日期
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}