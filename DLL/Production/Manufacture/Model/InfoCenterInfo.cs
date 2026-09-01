using System;

namespace SKT.LeanMES.Manufacture.Model
{
    [Serializable]
    public class InfoCenterInfo
    {
        private String serialNumber;

        private String lineName;
        private String nextOperation;

        private String prodOrderHistoryTime;
        private String prodOrderAction;

        private String operaterPerson;
        private DateTime operaterTime;
        private String operaterDesc;

        private String routerName;

        public string ContainerSN { get; set; }
        public string Location { get; set; }

        public string BoxSN { get; set; }
        /// <summary>
        /// 产品序列号
        /// </summary>
        public String SerialNumber
        {
            get { return serialNumber; }
            set { serialNumber = value; }
        }

        /// <summary>
        /// 产线
        /// </summary>
        public String LineName
        {
            get { return lineName; }
            set { lineName = value; }
        }

        /// <summary>
        /// 下一工位
        /// </summary>
        public String NextOperation
        {
            get { return nextOperation; }
            set { nextOperation = value; }
        }

        /// <summary>
        /// 工单操作的历史时间
        /// </summary>
        public String ProdOrderHistoryTime
        {
            get { return prodOrderHistoryTime; }
            set { prodOrderHistoryTime = value; }
        }

        /// <summary>
        /// 工单操作
        /// </summary>
        public String ProdOrderAction
        {
            get { return prodOrderAction; }
            set { prodOrderAction = value; }
        }

        /// <summary>
        /// 操作人
        /// </summary>
        public String OperaterPerson
        {
            get { return operaterPerson; }
            set { operaterPerson = value; }
        }

        /// <summary>
        /// 操作时间
        /// </summary>
        public DateTime OperaterTime
        {
            get { return operaterTime; }
            set { operaterTime = value; }
        }

        /// <summary>
        /// 什么操作
        /// </summary>
        public String OperaterDesc
        {
            get { return operaterDesc; }
            set { operaterDesc = value; }
        }

        /// <summary>
        /// 路由名称
        /// </summary>
        public String RouterName
        {
            get { return routerName; }
            set { routerName = value; }
        }
    }
}
