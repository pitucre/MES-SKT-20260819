using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProdUnit.Model
{
    [Serializable]
    public class PrepSerialNumberInfo
    {
        private Int64 prepSNId;
        private Int32 pSNTypeId;
        private Int32 prodOrderId;
        private Int32 itemId;
        private String pSN;
        private Int32 statusId;
        private Boolean isOnlineRelese;
        private String createBy;
        private DateTime createDateTime;
        private String userBy;
        private DateTime userDateTime;
        public string PSNType { get; set; }
        public string OrderNO { get; set; }
        public string ItemCode { get; set; }
        public string Status { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PrepSerialNumberInfo 类的新实例。
        /// </summary>
        public PrepSerialNumberInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PrepSerialNumberInfo 类的新实例。
        /// </summary>
        /// <param name="prepSNId"></param>
        /// <param name="pSNTypeId">条码类型: -4、包装箱条码 -5、栈板条码 -16、客户条码</param>
        /// <param name="prodOrderId">工单ID</param>
        /// <param name="itemId">产品ID</param>
        /// <param name="pSN">离线打印条码</param>
        /// <param name="statusId">条码使用状态：1、未使用 2、已使用 （此状态下条码不允许删除）</param>
        /// <param name="isOnlineRelese">是否前台采集UI释放条码，前台释放条码不可删除</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="userBy">使用人</param>
        /// <param name="userDateTime">使用时间</param>
        public PrepSerialNumberInfo(Int64 prepSNId, Int32 pSNTypeId, Int32 prodOrderId, Int32 itemId,
            String pSN, Int32 statusId, Boolean isOnlineRelese, String createBy, DateTime createDateTime,
            String userBy, DateTime userDateTime)
        {
            this.prepSNId = prepSNId;
            this.pSNTypeId = pSNTypeId;
            this.prodOrderId = prodOrderId;
            this.itemId = itemId;
            this.pSN = pSN;
            this.statusId = statusId;
            this.isOnlineRelese = isOnlineRelese;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.userBy = userBy;
            this.userDateTime = userDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 PrepSNId
        {
            get { return this.prepSNId; }
            set { this.prepSNId = value; }
        }

        /// <summary>
        /// 获取或设置条码类型: -4、包装箱条码 -5、栈板条码 -16、客户条码
        /// </summary>
        public Int32 PSNTypeId
        {
            get { return this.pSNTypeId; }
            set { this.pSNTypeId = value; }
        }

        /// <summary>
        /// 获取或设置工单ID
        /// </summary>
        public Int32 ProdOrderId
        {
            get { return this.prodOrderId; }
            set { this.prodOrderId = value; }
        }

        /// <summary>
        /// 获取或设置产品ID
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置离线打印条码
        /// </summary>
        public String PSN
        {
            get { return this.pSN; }
            set { this.pSN = value; }
        }

        /// <summary>
        /// 获取或设置条码使用状态：1、未使用 2、已使用 （此状态下条码不允许删除）
        /// </summary>
        public Int32 StatusId
        {
            get { return this.statusId; }
            set { this.statusId = value; }
        }

        /// <summary>
        /// 获取或设置是否前台采集UI释放条码，前台释放条码不可删除
        /// </summary>
        public Boolean IsOnlineRelese
        {
            get { return this.isOnlineRelese; }
            set { this.isOnlineRelese = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
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
        /// 获取或设置使用人
        /// </summary>
        public String UserBy
        {
            get { return this.userBy; }
            set { this.userBy = value; }
        }

        /// <summary>
        /// 获取或设置使用时间
        /// </summary>
        public DateTime UserDateTime
        {
            get { return this.userDateTime; }
            set { this.userDateTime = value; }
        }

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemName { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemSpec { get; set; }

    }
}
