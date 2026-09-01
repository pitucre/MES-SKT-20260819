using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.MSD.Model
{
    [Serializable]
    public class MsdThermostatInfo : MsdContainerInfo
    {
        public MsdThermostatInfo() { }

        public MsdThermostatInfo(Int32 gid, String serialNumber, Int32 msdContainerId, DateTime scanTime, DateTime addTime, DateTime outtime,
  decimal totalThermostat, DateTime createTime, DateTime modifyDateTime, string createUser, string remark
      )
        {


            this.Tid = gid;
            this.SerialNumber = serialNumber;
            this.MsdContainerId = msdContainerId;
            this.ScanTime = scanTime;
            this.AddTime = addTime;
            this.OutTime = outtime;
            this.TotalThermostat = totalThermostat;
            this.CreateTime = createTime;
            this.ModifyDateTime = modifyDateTime;
            this.CreateUser = createUser;
            this.Remark = remark;
        }

        /// <summary>
        /// ID
        /// </summary>
        public int Tid { get; set; }

        /// <summary>
        /// 物料编号
        /// </summary>
        public string SerialNumber { get; set; }


        /// <summary>
        /// 产品编号
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }


        /// <summary>
        /// 产品规格
        /// </summary>
        public string ItemSpec { get; set; }

        /// <summary>
        /// 扫描时间
        /// </summary>
        public DateTime ScanTime { get; set; }

        /// <summary>
        /// 添加时间
        /// </summary>
        public DateTime AddTime { get; set; }

        /// <summary>
        /// 拿出时间
        /// </summary>
        public DateTime OutTime { get; set; }

        /// <summary>
        /// 累计时长
        /// </summary>
        public decimal TotalThermostat { get; set; }

        /// <summary>
        /// 添加时间
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 结束烘烤时间
        /// </summary>
        public DateTime EndBakeTime { get; set; }

        /// <summary>
        /// 更新时间
        /// </summary>
        public DateTime ModifyDateTime { get; set; }

        /// <summary>
        /// 操作人
        /// </summary>
        public string CreateUser { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public string Tstatus { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

    }
}
