using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentCheckOutHistoryInfo
    {
        private Int32 equipmentCheckOutHistory;
        private Int32 equipmentCheckOutPlanId;
        private Int32 status;
        private String certificateNo;
        private String certificateFileName;
        private String remark;
        private String createBy;
        private DateTime createTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentCheckOutHistoryInfo 类的新实例。
        /// </summary>
        public EquipmentCheckOutHistoryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentCheckOutHistoryInfo 类的新实例。
        /// </summary>
        /// <param name="equipmentCheckOutHistory"></param>
        /// <param name="equipmentCheckOutPlanId"></param>
        /// <param name="status"></param>
        /// <param name="certificateNo"></param>
        /// <param name="certificateFileName"></param>
        /// <param name="remark"></param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        public EquipmentCheckOutHistoryInfo(Int32 equipmentCheckOutHistory, Int32 equipmentCheckOutPlanId, Int32 status, String certificateNo, 
            String certificateFileName, String remark, String createBy, DateTime createTime)
        {
            this.equipmentCheckOutHistory = equipmentCheckOutHistory;
            this.equipmentCheckOutPlanId = equipmentCheckOutPlanId;
            this.status = status;
            this.certificateNo = certificateNo;
            this.certificateFileName = certificateFileName;
            this.remark = remark;
            this.createBy = createBy;
            this.createTime = createTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EquipmentCheckOutHistory
        {
            get { return this.equipmentCheckOutHistory; }
            set { this.equipmentCheckOutHistory = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EquipmentCheckOutPlanId
        {
            get { return this.equipmentCheckOutPlanId; }
            set { this.equipmentCheckOutPlanId = value; }
        }

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
        public String CertificateNo
        {
            get { return this.certificateNo; }
            set { this.certificateNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CertificateFileName
        {
            get { return this.certificateFileName; }
            set { this.certificateFileName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
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
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }
        public string EqCode { get; set; }
        public string CheckTypeName { get; set; }
        public string CycleTypeName { get; set; }
        public string CheckProjectName { get; set; }
        public string StatusNmae { get; set; }
        public DateTime NextTime { get; set; }
        public DateTime LastTime { get; set; }
        public int Cycle { get; set; }

        /// <summary>
        /// 送检日期
        /// </summary>
        public DateTime InspectionTime { get; set; }


        /// <summary>
        /// 对象 1= 设备  2=设备类型
        /// </summary>
        public string ObjectTypeName { get; set; }


        public string EquimentTypeName { get; set; }

        /// <summary>
        /// 送检单位
        /// </summary>
        public string InspectionUnit { get; set; }
    }
}