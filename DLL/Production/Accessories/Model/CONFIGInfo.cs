using System;

namespace SKT.LeanMES.Accessories.Model
{
    [Serializable]
    public class CONFIGInfo
    {
        private Int32 iD;
        private Int32 sOLD_TYPE;
        private Int32 mINTHAW;
        private Int32 mAXVOID;
        private Int32 mAXUSE;

        /// <summary>
        /// 初始化 SKT.MES.Model.CONFIGInfo 类的新实例。
        /// </summary>
        public CONFIGInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.CONFIGInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="sOLD_TYPE">类别：1-锡膏；2-红胶</param>
        /// <param name="mINTHAW">至少解冻时间，按小时计算</param>
        /// <param name="mAXVOID">最长闲置时间</param>
        /// <param name="mAXUSE">最长使用时间</param>
        public CONFIGInfo(Int32 iD, Int32 sOLD_TYPE, Int32 mINTHAW, Int32 mAXVOID,
            Int32 mAXUSE)
        {
            this.iD = iD;
            this.sOLD_TYPE = sOLD_TYPE;
            this.mINTHAW = mINTHAW;
            this.mAXVOID = mAXVOID;
            this.mAXUSE = mAXUSE;
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
        /// 获取或设置类别：1-锡膏；2-红胶
        /// </summary>
        public Int32 SOLD_TYPE
        {
            get { return this.sOLD_TYPE; }
            set { this.sOLD_TYPE = value; }
        }

        /// <summary>
        /// 获取或设置至少解冻时间，按小时计算
        /// </summary>
        public Int32 MINTHAW
        {
            get { return this.mINTHAW; }
            set { this.mINTHAW = value; }
        }

        /// <summary>
        /// 获取或设置最长闲置时间
        /// </summary>
        public Int32 MAXVOID
        {
            get { return this.mAXVOID; }
            set { this.mAXVOID = value; }
        }

        /// <summary>
        /// 获取或设置最长使用时间
        /// </summary>
        public Int32 MAXUSE
        {
            get { return this.mAXUSE; }
            set { this.mAXUSE = value; }
        }
    }
}