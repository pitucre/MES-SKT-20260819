using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Manufacture.Model
{
    [Serializable]
    public class VUnitHistoryInfo
    {
        private Int64 uID;
        private String serailNumber;
        private String iTEM;
        private String isPass;
        private DateTime enterTime;
        private DateTime exitTime;
        private String operation;
        private String loginID;
        private String productionOrder;
        private Int32 loopCount;

        private String lineName;
        private String resName;
        private String unitStatus;

        private string customerSN;
        private string cartonNo;
        private string palletNo;
        private string qcLotNo;


        private String itemName;
        private String itemDesc;
        private String itemSpec;

        private string itemCode;
        private string itemModel;
        
        private string prodOrderNo;

        private String container_Number;

        private String exitTimeStr;
        private String enterTimeStr;

        private string panelNO;

        public string BoxSN { get; set; }
        public string CustomerSN2 { get; set; }
        /// <summary>
        /// 初始化 SKT.MES.Production.Model.VUnitInfo 类的新实例。
        /// </summary>
        public VUnitHistoryInfo()
        {
        }
        /// <summary>
        /// 初始化 SKT.MES.Production.Model.VUnitInfo 类的新实例。
        /// </summary>
        /// <param name="uID"></param>
        /// <param name="isPass">是否通过。</param>
        /// <param name="operation">操作工位。</param>
        /// <param name="enterTime">进入时间。</param>
        /// <param name="exitTime">完成时间。</param>
        /// <param name="loginID">用户id。</param>
        /// <param name="iTEM">物品名称。</param>
        /// <param name="productionOrder">生产序列号。</param>
        /// <param name="loopCount">循环记数</param>

        public VUnitHistoryInfo(Int64 uID, string isPass,
          DateTime enterTime, DateTime exitTime, String operation, String loginID, String iTEM, String productionOrder,
         Int32 loopCount, String serailNumber)
        {
            this.uID = uID;
            this.isPass = isPass;
            this.operation = operation;
            this.enterTime = enterTime;
            this.exitTime = exitTime;
            this.loginID = loginID;
            this.iTEM = iTEM;
            this.productionOrder = productionOrder;
            this.loopCount = loopCount;
            this.serailNumber = serailNumber;
        }
        public VUnitHistoryInfo(Int64 uID, string isPass,
   DateTime enterTime, DateTime exitTime, String operation, String loginID, String iTEM, String productionOrder,
  Int32 loopCount)
        {
            this.uID = uID;
            this.isPass = isPass;
            this.operation = operation;
            this.enterTime = enterTime;
            this.exitTime = exitTime;
            this.loginID = loginID;
            this.iTEM = iTEM;
            this.productionOrder = productionOrder;
            this.loopCount = loopCount;
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 UID
        {
            get { return this.uID; }
            set { this.uID = value; }
        }
        /// <summary>
        /// 获取或设置SN码
        /// </summary>
        public String SerailNumber
        {
            get { return serailNumber; }
            set { serailNumber = value; }
        }
        /// <summary>
        /// 获取或设置是否通过
        /// </summary>
        public string IsPass
        {
            get { return this.isPass; }
            set { this.isPass = value; }
        }

        /// <summary>
        /// 获取或设置操作工位
        /// </summary>
        public string Operation
        {
            get { return this.operation; }
            set { this.operation = value; }
        }

        /// <summary>
        /// 获取或设置进入时间
        /// </summary>
        public DateTime EnterTime
        {
            get { return this.enterTime; }
            set { this.enterTime = value; }
        }

        /// <summary>
        /// 获取或设置完成时间
        /// </summary>
        public DateTime ExitTime
        {
            get { return this.exitTime; }
            set { this.exitTime = value; }
        }

        /// <summary>
        /// 获取或设置用户
        /// </summary>
        public string LoginID
        {
            get { return this.loginID; }
            set { this.loginID = value; }
        }

        /// <summary>
        /// 获取或设置产品名
        /// </summary>
        public string ITEM
        {
            get { return this.iTEM; }
            set { this.iTEM = value; }
        }

        /// <summary>
        /// 获取或设置生产序列号
        /// </summary>
        public string ProductionOrder
        {
            get { return this.productionOrder; }
            set { this.productionOrder = value; }
        }

        /// <summary>
        /// 获取或设置循环记数
        /// </summary>
        public Int32 LoopCount
        {
            get { return this.loopCount; }
            set { this.loopCount = value; }
        }
                /// <summary>
        /// 物料名称
        /// </summary>
        public String ItemName
        {
            get { return itemName; }
            set { itemName = value; }
        }


        /// <summary>
        /// 物料简介
        /// </summary>
        public String ItemDesc
        {
            get { return itemDesc; }
            set { itemDesc = value; }
        }
        /// <summary>
        /// 产品规格
        /// </summary>
        public String ItemModel
        {
            get { return itemModel; }
            set { itemModel = value; }
        }
        
        /// <summary>
        /// 物料描述
        /// </summary>
        public String ItemSpec
        {
            get { return itemSpec; }
            set { itemSpec = value; }
        }
        /// <summary>
        /// 包装编码
        /// </summary>
        public String Container_Number
        {
            get { return container_Number; }
            set { container_Number = value; }
        }

        /// <summary>
        /// 产线名称
        /// </summary>
        public String LineName
        {
            get { return lineName; }
            set { lineName = value; }
        }

        /// <summary>
        /// 产品的unit状态
        /// </summary>
        public String UnitStatus
        {
            get { return unitStatus; }
            set { unitStatus = value; }
        }

        /// <summary>
        /// 退出时间
        /// </summary>
        public String ExitTimeStr
        {
            get { return exitTimeStr; }
            set { exitTimeStr = value; }
        }

        /// <summary>
        /// 进入时间
        /// </summary>
        public String EnterTimeStr
        {
            get { return enterTimeStr; }
            set { enterTimeStr = value; }
        }

        /// <summary>
        /// 返回资源名称
        /// </summary>
        public String ResName
        {
            get { return resName; }
            set { resName = value; }
        }

        /// <summary>
        /// 客户序列号
        /// </summary>
        public string CustomerSN
        {
            get { return customerSN; }
            set { customerSN = value; }
        }

        /// <summary>
        /// 箱号
        /// </summary>
        public string CartonNo
        {
            get { return cartonNo; }
            set { cartonNo = value; }
        }

        /// <summary>
        /// 栈板号
        /// </summary>
        public string PalletNo
        {
            get { return palletNo; }
            set { palletNo = value; }
        }

        /// <summary>
        /// 批次号
        /// </summary>
        public string QcLotNo
        {
            get { return qcLotNo; }
            set { qcLotNo = value; }
        }

        /// <summary>
        /// 料号
        /// </summary>
        public string ItemCode
        {
            set { itemCode = value; }
            get { return itemCode; }
        }

        /// <summary>
        /// 工单号
        /// </summary>
        public string ProdOrderNo
        {
            set { prodOrderNo = value; }
            get { return prodOrderNo; }
        }

        /// <summary>
        /// 拼板号
        /// </summary>
        public string PanelNO
        {
            set { panelNO = value; }
            get { return panelNO; }
        }
        /// <summary>
        /// 数量
        /// </summary>
        public int Qty { get; set; }
    }
}
