using System;

namespace SKT.LeanMES.Accessories.Model
{
    [Serializable]
    public class PARTInfo
    {
        private Int32 iD;
        private String itemName;
        private Int32 leedFree;

        /// <summary>
        /// 初始化 SKT.MES.Model.PARTInfo 类的新实例。
        /// </summary>
        public PARTInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.PARTInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="itemName">物料</param>
        /// <param name="leedFree">保留字段</param>
        public PARTInfo(Int32 iD, String itemName, Int32 leedFree)
        {
            this.iD = iD;
            this.itemName = itemName;
            this.leedFree = leedFree;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置物料
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        /// <summary>
        /// 获取或设置保留字段
        /// </summary>
        public Int32 LeedFree
        {
            get { return this.leedFree; }
            set { this.leedFree = value; }
        }
    }
}