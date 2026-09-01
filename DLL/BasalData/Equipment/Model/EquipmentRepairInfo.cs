using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentRepairInfo
    {
        private Int32 equipmentRepairId;
        private String repairNo;
        private String eqCode;
        private String repairDesc;
        private String createBy;
        private DateTime createDateTime;
        private Int32 status;
        private String repairBy;
        private DateTime repairSTime;
        private DateTime repairETime;
        private String handleContent;
        private String partContent;
        private String reserve1;
        private String reserve2;
        private String reserve3;

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentRepairInfo 类的新实例。
        /// </summary>
        public EquipmentRepairInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentRepairInfo 类的新实例。
        /// </summary>
        /// <param name="equipmentRepairId"></param>
        /// <param name="repairNo"></param>
        /// <param name="eqCode"></param>
        /// <param name="repairDesc"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="status"></param>
        /// <param name="repairBy"></param>
        /// <param name="repairSTime"></param>
        /// <param name="repairETime"></param>
        /// <param name="handleContent"></param>
        /// <param name="partContent"></param>
        /// <param name="reserve1"></param>
        /// <param name="reserve2"></param>
        /// <param name="reserve3"></param>
        public EquipmentRepairInfo(Int32 equipmentRepairId, String repairNo, String eqCode, String repairDesc, 
            String createBy, DateTime createDateTime, Int32 status, String repairBy, DateTime repairSTime, 
            DateTime repairETime, String handleContent, String partContent, String reserve1, String reserve2, 
            String reserve3)
        {
            this.equipmentRepairId = equipmentRepairId;
            this.repairNo = repairNo;
            this.eqCode = eqCode;
            this.repairDesc = repairDesc;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.status = status;
            this.repairBy = repairBy;
            this.repairSTime = repairSTime;
            this.repairETime = repairETime;
            this.handleContent = handleContent;
            this.partContent = partContent;
            this.reserve1 = reserve1;
            this.reserve2 = reserve2;
            this.reserve3 = reserve3;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EquipmentRepairId
        {
            get { return this.equipmentRepairId; }
            set { this.equipmentRepairId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String RepairNo
        {
            get { return this.repairNo; }
            set { this.repairNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String EqCode
        {
            get { return this.eqCode; }
            set { this.eqCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String RepairDesc
        {
            get { return this.repairDesc; }
            set { this.repairDesc = value; }
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
        /// 送修时间 add zx 20171019
        /// </summary>
        public DateTime RepairTime{get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String RepairBy
        {
            get { return this.repairBy; }
            set { this.repairBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime RepairSTime
        {
            get { return this.repairSTime; }
            set { this.repairSTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime RepairETime
        {
            get { return this.repairETime; }
            set { this.repairETime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String HandleContent
        {
            get { return this.handleContent; }
            set { this.handleContent = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String PartContent
        {
            get { return this.partContent; }
            set { this.partContent = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Reserve1
        {
            get { return this.reserve1; }
            set { this.reserve1 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Reserve2
        {
            get { return this.reserve2; }
            set { this.reserve2 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Reserve3
        {
            get { return this.reserve3; }
            set { this.reserve3 = value; }
        }

       /// <summary>
       /// 设备名称
       /// </summary>
        public string EquipmentName { get; set; }

        /// <summary>
        /// 保管部门
        /// </summary>
        public string DepositoryDep { get; set; }


        public string StatusName { get; set; }

        public string ConfirmUser { get; set; }
        public DateTime? ConfirmDateTime { get; set; }
        public string CreateByCName { get; set; }
        public string RepairByCName { get; set; }
        public string ConfirmUserCName { get; set; }
    }
}