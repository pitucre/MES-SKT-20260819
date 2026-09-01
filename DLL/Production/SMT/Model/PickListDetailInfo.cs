using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class PickListDetailInfo
    {
        private Int32 detailID;
        private Int32 listID;
        private Int32 itemID;
        private Decimal qty;
        private String groupCode;
        private String groupDesc;
        private Byte statusID;
        private String remark;
        private String itemCode;
        public string ItemName { get; set; }
        public string ItemSpec { get; set; }
        /// <summary>
        /// 初始化 SKT.MES.Model.PickListDetailInfo 类的新实例。
        /// </summary>
        public PickListDetailInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.PickListDetailInfo 类的新实例。
        /// </summary>
        /// <param name="detailID"></param>
        /// <param name="listID"></param>
        /// <param name="itemID"></param>
        /// <param name="qty">扣数数量</param>
        /// <param name="groupCode">工序名称</param>
        /// <param name="groupDesc">部件位置</param>
        /// <param name="statusID"></param>
        /// <param name="remark">备注</param>
        public PickListDetailInfo(Int32 detailID, Int32 listID, Int32 itemID, decimal qty,
            String groupCode, String groupDesc, Byte statusID, String remark)
        {
            this.detailID = detailID;
            this.listID = listID;
            this.itemID = itemID;
            this.qty = qty;
            this.groupCode = groupCode;
            this.groupDesc = groupDesc;
            this.statusID = statusID;
            this.remark = remark;
        }


        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 DetailID
        {
            get { return this.detailID; }
            set { this.detailID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ListID
        {
            get { return this.listID; }
            set { this.listID = value; }
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
        /// 获取或设置扣数数量
        /// </summary>
        public Decimal Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        /// <summary>
        /// 获取或设置工序名称
        /// </summary>
        public String GroupCode
        {
            get { return this.groupCode; }
            set { this.groupCode = value; }
        }

        /// <summary>
        /// 获取或设置部件位置
        /// </summary>
        public String GroupDesc
        {
            get { return this.groupDesc; }
            set { this.groupDesc = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Byte StatusID
        {
            get { return this.statusID; }
            set { this.statusID = value; }
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