using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ESOP.Model
{
     [Serializable]
    public class ESOPFileItemRelation
    {
          private Int32 fileItemID;
        private Int32 itemID;
        private Int32 eSOPFileID;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ESOPFile_ItemInfo 类的新实例。
        /// </summary>
        public ESOPFileItemRelation()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ESOPFile_ItemInfo 类的新实例。
        /// </summary>
        /// <param name="fileItemID"></param>
        /// <param name="itemID"></param>
        /// <param name="eSOPFileID"></param>
        public ESOPFileItemRelation(Int32 fileItemID, Int32 itemID, Int32 eSOPFileID)
        {
            this.fileItemID = fileItemID;
            this.itemID = itemID;
            this.eSOPFileID = eSOPFileID;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 FileItemID
        {
            get { return this.fileItemID; }
            set { this.fileItemID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ESOPFileID
        {
            get { return this.eSOPFileID; }
            set { this.eSOPFileID = value; }
        }
    }
}
