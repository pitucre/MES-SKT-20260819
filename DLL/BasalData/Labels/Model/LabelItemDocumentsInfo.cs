using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Labels.Model
{
    [Serializable]
    public class LabelItemDocumentsInfo
    {
        private Int32 itemDocId;
        private Int32 itemID;
        private Int32 docID;
        private Int32 stationId;
        private Int32 typeId;
        private Int32 sequence;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        private String itemName;
        private String documentName;
        private String station;
        private String typeName;
        private Int32 printSort;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.LabelItemDocumentsInfo 类的新实例。
        /// </summary>
        public LabelItemDocumentsInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.LabelItemDocumentsInfo 类的新实例。
        /// </summary>
        /// <param name="itemDocId">产品标签ID</param>
        /// <param name="itemID">产品ID,对应ITEM.ItemId</param>
        /// <param name="docID">打印文档ID，对应DOCUMENT.DocumentId</param>
        /// <param name="stationId">工位ID</param>
        /// <param name="typeId">类别</param>
        /// <param name="sequence">排序</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public LabelItemDocumentsInfo(Int32 itemDocId, Int32 itemID, Int32 docID, Int32 stationId, 
            Int32 typeId, Int32 sequence, String createBy, DateTime createDateTime, String modifyBy, 
            DateTime modifyDateTime)
        {
            this.itemDocId = itemDocId;
            this.itemID = itemID;
            this.docID = docID;
            this.stationId = stationId;
            this.typeId = typeId;
            this.sequence = sequence;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置产品标签ID
        /// </summary>
        public Int32 ItemDocId
        {
            get { return this.itemDocId; }
            set { this.itemDocId = value; }
        }

        /// <summary>
        /// 获取或设置产品ID,对应ITEM.ItemId
        /// </summary>
        public Int32 ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }

        /// <summary>
        /// 获取或设置打印文档ID，对应DOCUMENT.DocumentId
        /// </summary>
        public Int32 DocID
        {
            get { return this.docID; }
            set { this.docID = value; }
        }

        /// <summary>
        /// 获取或设置工位ID
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置类别
        /// </summary>
        public Int32 TypeId
        {
            get { return this.typeId; }
            set { this.typeId = value; }
        }

        /// <summary>
        /// 获取或设置排序
        /// </summary>
        public Int32 Sequence
        {
            get { return this.sequence; }
            set { this.sequence = value; }
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
        /// 获取或设置产品名称
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        /// <summary>
        /// 获取或设置打印文档名称
        /// </summary>
        public String DocumentName
        {
            get { return this.documentName; }
            set { this.documentName = value; }
        }

        /// <summary>
        /// 获取或设置工位名称
        /// </summary>
        public String Station
        {
            get { return this.station; }
            set { this.station = value; }
        }

        /// <summary>
        /// 获取或设置类型名称
        /// </summary>
        public String TypeName
        {
            get { return this.typeName; }
            set { this.typeName = value; }
        }
        public Int32 PrintSort
        {
            get { return this.printSort; }
            set { this.printSort = value; }
        }
        
    }
}
