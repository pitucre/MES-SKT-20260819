using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace SKT.LeanMES.PackPrint.Model
{
    [Serializable]
    public class ShipmentListConfigInfo
    {
        /// <summary>
        /// 自增ID
        /// </summary>
        private Int32 shipConfigID;
        /// <summary>
        /// SN
        /// </summary>
        private int itemId;
        /// <summary>
        /// 部件名配置ID
        /// </summary>
        private Int32 partNameConfigId;

        public Int32 PartNameConfigId
        {
            get { return partNameConfigId; }
            set { partNameConfigId = value; }
        }
        /// <summary>
        /// 一级料号
        /// </summary>
        private int onePartId;
        /// <summary>
        /// 二级料号
        /// </summary>
        private int twoPartId;
        /// <summary>
        /// 二级料号
        /// </summary>
        private int threePartId;
        /// <summary>
        /// 是否扫描或者输入(默认值是0)
        /// </summary>
        private int isScanOrInput;
        /// <summary>
        /// 是否从系统抓取(默认值是0)
        /// </summary>
        private int isFromSystem;
        /// <summary>
        /// 扫描顺序
        /// </summary>
        private int scanOrder;
        //固定
        private string remark;//备注
        private DateTime modifyDateTime;//修改时间
        private string modifyby;//修改人
        private DateTime createDateTime;//创建时间
        private string createBy;//创建人
        private string partName;//额外添加的字段（部件名称）
        public ShipmentListConfigInfo()
        {
        }
        /// <summary>
        ///  初始化 SKT.LeanMES.PackPrint.Model.ShipmentListConfigInfo 类的新实例。
        /// </summary>
        /// <param name="nCID"></param>
        /// <param name="nCPhenomenName"></param>
        /// <param name="dataType"></param>
        /// <param name="remark"></param>
        /// <param name="nCPhenomenNum"></param>
        /// <param name="ModifyDateTime"></param>
        /// <param name="modifyby"></param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        public ShipmentListConfigInfo(int ShipConfigID, int ItemId, Int32 PartNameConfigId, int OnePartId, int TwoPartId, int IsScanOrInput, int IsFromSystem, int ScanOrder, DateTime ModifyDateTime, string ModifyBy, DateTime CreateDateTime, string CreateBy, string Remark, string PartName,int threePartId)
        {
            this.ShipConfigID = ShipConfigID;
            this.ItemId = ItemId;
            this.PartNameConfigId = PartNameConfigId;
            this.OnePartId = OnePartId;
            this.ModifyDateTime = ModifyDateTime;
            this.TwoPartId = TwoPartId;
            this.IsScanOrInput = IsScanOrInput;
            this.IsFromSystem = IsFromSystem;
            this.ScanOrder = ScanOrder;
            this.ModifyDateTime = ModifyDateTime;
            this.Modifyby = ModifyBy;
            this.CreateDateTime = CreateDateTime;
            this.CreateBy = CreateBy;
            this.Remark = Remark;
            this.PartName = PartName;
            this.threePartId = threePartId;
        }
        /// <summary>
        /// 自增ID
        /// </summary>
        public int ShipConfigID
        {
            get { return shipConfigID; }
            set { shipConfigID = value; }
        }
        /// <summary>
        /// 额外添加的字段（部件名称）
        /// </summary>
        public string PartName
        {
            get { return partName; }
            set { partName = value; }
        }
        /// <summary>
        /// SN
        /// </summary>
        public int ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }
        /// <summary>
        /// 一级料号
        /// </summary>
        public int OnePartId
        {
            get { return onePartId; }
            set { onePartId = value; }
        }
        /// <summary>
        /// 二级料号
        /// </summary>
        public int TwoPartId
        {
            get { return twoPartId; }
            set { twoPartId = value; }
        }
        /// <summary>
        /// 三级料号
        /// </summary>
        public int ThreePartId
        {
            get { return threePartId; }
            set { threePartId = value; }
        }
        /// <summary>
        /// 是否扫描或者输入(默认值是0)
        /// </summary>
        public int IsScanOrInput
        {
            get { return isScanOrInput; }
            set { isScanOrInput = value; }
        }
        /// <summary>
        /// 是否从系统抓取(默认值是0)
        /// </summary>
        public int IsFromSystem
        {
            get { return isFromSystem; }
            set { isFromSystem = value; }
        }
        /// <summary>
        /// 扫描顺序
        /// </summary>
        public int ScanOrder
        {
            get { return scanOrder; }
            set { scanOrder = value; }
        }
        /// <summary>
        /// 备注
        /// </summary>
        public string Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
        /// <summary>
        /// 修改人
        /// </summary>
        public string Modifyby
        {
            get { return modifyby; }
            set { modifyby = value; }
        }
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }
        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 一级料号
        /// </summary>
        private string onePart;

        public string OnePart
        {
            get { return onePart; }
            set { onePart = value; }
        }
        /// <summary>
        /// 二级料号
        /// </summary>
        private string twoPart;

        public string TwoPart
        {
            get { return twoPart; }
            set { twoPart = value; }
        }
        /// <summary>
        /// 二级料号
        /// </summary>
        private string threePart;

        public string ThreePart
        {
            get { return threePart; }
            set { threePart = value; }
        }


        //以下信息是用于捆包装的信息
        /// <summary>
        /// 产品UID
        /// </summary>
        private int productUID;

        public int ProductUID
        {
            get { return productUID; }
            set { productUID = value; }
        }
        /// <summary>
        /// 产品ItemID
        /// </summary>
        private int productItemId;

        public int ProductItemId
        {
            get { return productItemId; }
            set { productItemId = value; }
        }
        /// <summary>
        /// 下一个部件名称
        /// </summary>
        private string nextBomName;

        public string NextBomName
        {
            get { return nextBomName; }
            set { nextBomName = value; }
        }
        /// <summary>
        /// 下一个序号
        /// </summary>
        private int nextNum;

        public int NextNum
        {
            get { return nextNum; }
            set { nextNum = value; }
        }
        /// <summary>
        /// 换算后新的部件SN
        /// </summary>
        private string newSN;

        public string NewSN
        {
            get { return newSN; }
            set { newSN = value; }
        }
        
        /// <summary>
        /// 扫描的部件ID
        /// </summary>
        private int scanBomId;

        public int ScanBomId
        {
            get { return scanBomId; }
            set { scanBomId = value; }
        }
        
        /// <summary>
        /// 部件ItemID
        /// </summary>
        private int bomItemId;

        public int BomItemId
        {
            get { return bomItemId; }
            set { bomItemId = value; }
        }
        /// <summary>
        /// 部件条码
        /// </summary>
        private string bomName;

        public string BomName
        {
            get { return bomName; }
            set { bomName = value; }
        }
    }
}
