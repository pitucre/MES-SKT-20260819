using System;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class LoadingTypeInfo
    {
        private Int32 loadingTypeId;
        private String typeName;
        private Int32 beginRow;
        private Int32 colPosition;
        private Int32 colTable;
        private Int32 colPartNum;
        private Int32 colNum;
        private Int32 colFeederType;
        private Int32 colLocationType;
        private Int32 colPoint;
        private Int32 colReplaceNum;
        private String remark;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;
        public int ColPosition_2 { set; get; }
        public int ColArea { set; get; }
        public int ElementDescription { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.SMT.Model.LoadingTypeInfo 类的新实例。
        /// </summary>
        public LoadingTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.SMT.Model.LoadingTypeInfo 类的新实例。
        /// </summary>
        /// <param name="loadingTypeId"></param>
        /// <param name="typeName"></param>
        /// <param name="beginRow"></param>
        /// <param name="colPosition">料站/插槽</param>
        /// <param name="colTable">面别</param>
        /// <param name="colPartNum">物料编码</param>
        /// <param name="colNum">用量</param>
        /// <param name="colFeederType">Feeder类型</param>
        /// <param name="colLocationType">这是元件位置</param>
        /// <param name="colPoint">点位</param>
        /// <param name="colReplaceNum">替代料</param>
        /// <param name="remark"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        public LoadingTypeInfo(Int32 loadingTypeId, String typeName, Int32 beginRow, Int32 colPosition,
            Int32 colTable, Int32 colPartNum, Int32 colNum, Int32 colFeederType, Int32 colLocationType,
            Int32 colPoint, Int32 colReplaceNum, String remark, DateTime modifyDateTime, String modifyBy,
            DateTime createDateTime, String createBy)
        {
            this.loadingTypeId = loadingTypeId;
            this.typeName = typeName;
            this.beginRow = beginRow;
            this.colPosition = colPosition;
            this.colTable = colTable;
            this.colPartNum = colPartNum;
            this.colNum = colNum;
            this.colFeederType = colFeederType;
            this.colLocationType = colLocationType;
            this.colPoint = colPoint;
            this.colReplaceNum = colReplaceNum;
            this.remark = remark;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LoadingTypeId
        {
            get { return this.loadingTypeId; }
            set { this.loadingTypeId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String TypeName
        {
            get { return this.typeName; }
            set { this.typeName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 BeginRow
        {
            get { return this.beginRow; }
            set { this.beginRow = value; }
        }

        /// <summary>
        /// 获取或设置料站/插槽
        /// </summary>
        public Int32 ColPosition
        {
            get { return this.colPosition; }
            set { this.colPosition = value; }
        }

        /// <summary>
        /// 获取或设置面别
        /// </summary>
        public Int32 ColTable
        {
            get { return this.colTable; }
            set { this.colTable = value; }
        }

        /// <summary>
        /// 获取或设置物料编码
        /// </summary>
        public Int32 ColPartNum
        {
            get { return this.colPartNum; }
            set { this.colPartNum = value; }
        }

        /// <summary>
        /// 获取或设置用量
        /// </summary>
        public Int32 ColNum
        {
            get { return this.colNum; }
            set { this.colNum = value; }
        }

        /// <summary>
        /// 获取或设置Feeder类型
        /// </summary>
        public Int32 ColFeederType
        {
            get { return this.colFeederType; }
            set { this.colFeederType = value; }
        }

        /// <summary>
        /// 获取或设置这是元件位置
        /// </summary>
        public Int32 ColLocationType
        {
            get { return this.colLocationType; }
            set { this.colLocationType = value; }
        }

        /// <summary>
        /// 获取或设置点位
        /// </summary>
        public Int32 ColPoint
        {
            get { return this.colPoint; }
            set { this.colPoint = value; }
        }

        /// <summary>
        /// 获取或设置替代料
        /// </summary>
        public Int32 ColReplaceNum
        {
            get { return this.colReplaceNum; }
            set { this.colReplaceNum = value; }
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
    }
}