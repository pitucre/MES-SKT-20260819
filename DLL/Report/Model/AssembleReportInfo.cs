using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Report.Model
{
    [Serializable]
    public class AssembleReportInfo
    {
        private int rowNo;
        private string productBarCode;
        private string moCode;
        private string productName;
        private string productCode;
        private string productModel;
        private DateTime onLineTime;
        private DateTime nextLineTime;
        private string maintainDate;
        private int peopleNumber;
        private int planOutputQty;
        private int maintainID;
        private string remark;
        private string startTime;

        public string StartTime
        {
            get { return startTime; }
            set { startTime = value; }
        }
        private string endTime;

        public string EndTime
        {
            get { return endTime; }
            set { endTime = value; }
        }
        private int lineID;

        public int LineID
        {
            get { return lineID; }
            set { lineID = value; }
        }
        private int impactPeople;

        public int ImpactPeople
        {
            get { return impactPeople; }
            set { impactPeople = value; }
        }
        private int timeQty;

        public int TimeQty
        {
            get { return timeQty; }
            set { timeQty = value; }
        }
        private int timeSum;

        public int TimeSum
        {
            get { return timeSum; }
            set { timeSum = value; }
        }
        private string anormalCause;

        public string AnormalCause
        {
            get { return anormalCause; }
            set { anormalCause = value; }
        }
        private string causeType;

        public string CauseType
        {
            get { return causeType; }
            set { causeType = value; }
        }
        private int anromalTypeId;

        public int AnromalTypeId
        {
            get { return anromalTypeId; }
            set { anromalTypeId = value; }
        }
        private string dutyDept;

        public string DutyDept
        {
            get { return dutyDept; }
            set { dutyDept = value; }
        }
        private int waitMaterialTime;

        public int WaitMaterialTime
        {
            get { return waitMaterialTime; }
            set { waitMaterialTime = value; }
        }
        private int processQualityTime;

        public int ProcessQualityTime
        {
            get { return processQualityTime; }
            set { processQualityTime = value; }
        }
        private int redoTime;

        public int RedoTime
        {
            get { return redoTime; }
            set { redoTime = value; }
        }
        private int partsQualityTime;

        public int PartsQualityTime
        {
            get { return partsQualityTime; }
            set { partsQualityTime = value; }
        }
        private int changeModelTime;

        public int ChangeModelTime
        {
            get { return changeModelTime; }
            set { changeModelTime = value; }
        }
        private int technologyTime;

        public int TechnologyTime
        {
            get { return technologyTime; }
            set { technologyTime = value; }
        }
        private int customerInfoTime;

        public int CustomerInfoTime
        {
            get { return customerInfoTime; }
            set { customerInfoTime = value; }
        }
        private int waitingTime;

        public int WaitingTime
        {
            get { return waitingTime; }
            set { waitingTime = value; }
        }
        private string clientShort;

        private int sequence;

        public int Sequence
        {
            get { return sequence; }
            set { sequence = value; }
        }

        private int pSequence;

        public int PSequence
        {
            get { return pSequence; }
            set { pSequence = value; }
        }
        public AssembleReportInfo()
        {
        }

        public AssembleReportInfo(Int32 rowNo, String productBarCode, String moCode, String productName, string productCode,
            string productModel, DateTime onLineTime, DateTime nextLineTime)
        {
            this.rowNo = rowNo;
            this.productBarCode = productBarCode;
            this.moCode = moCode;
            this.productName = productName;
            this.productCode = productCode;
            this.productModel = productModel;
            this.onLineTime = onLineTime;
            this.nextLineTime = nextLineTime;
        }
        public string ClientShort
        {
            get { return this.clientShort; }
            set { this.clientShort = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 RowNo
        {
            get { return this.rowNo; }
            set { this.rowNo = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ProductBarCode
        {
            get { return this.productBarCode; }
            set { this.productBarCode = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MoCode
        {
            get { return this.moCode; }
            set { this.moCode = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ProductName
        {
            get { return this.productName; }
            set { this.productName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ProductCode
        {
            get { return this.productCode; }
            set { this.productCode = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ProductModel
        {
            get { return this.productModel; }
            set { this.productModel = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime OnLineTime
        {
            get { return this.onLineTime; }
            set { this.onLineTime = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime NextLineTime
        {
            get { return this.nextLineTime; }
            set { this.nextLineTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MaintainDate
        {
            get { return this.maintainDate; }
            set { this.maintainDate = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PeopleNumber
        {
            get { return this.peopleNumber; }
            set { this.peopleNumber = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PlanOutputQty
        {
            get { return this.planOutputQty; }
            set { this.planOutputQty = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MaintainID
        {
            get { return this.maintainID; }
            set { this.maintainID = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

    }
}
