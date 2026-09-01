using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.MSD.Model
{
    [Serializable]
    public class MsdBakeInfo
    {
        public MsdBakeInfo() { }

        public MsdBakeInfo(Int32 gid, String serialNumber, Int32 msdContainerId, DateTime scanTime, DateTime startBakeTime, DateTime predictBakeTime,
      decimal bakeHours, decimal actualHours, string stauts, DateTime createTime, DateTime modifyDateTime, string createUser, string remark,string machineType
      )
        {


            this.Gid = gid;
            this.SerialNumber = serialNumber;
            this.MsdContainerId = msdContainerId;
            this.ScanTime = scanTime;
            this.StartBakeTime = startBakeTime;
            this.PredictBakeTime = predictBakeTime;

            this.BakeHours = bakeHours;
            this.ActualHours = actualHours;
            this.BakeStauts = stauts;

            this.CreateTime = createTime;
            this.ModifyDateTime = modifyDateTime;
            this.CreateUser = createUser;
            this.Remark = remark;
            //Modified by zhili 20180605  增加machineType
            this.MachineType = machineType;
        }


        /// <summary>
        /// 烘烤ID
        /// </summary>
        public int Gid { get; set; }

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
        /// 烤箱编号
        /// </summary>
        public string ContainerCode { get; set; }

        /// <summary>
        /// 烤箱名称
        /// </summary>
        public string ContainerName { get; set; }

        /// <summary>
        /// 烘烤ID
        /// </summary>
        public int MsdContainerId { get; set; }

        /// <summary>
        /// 扫描时间
        /// </summary>
        public DateTime ScanTime { get; set; }

        /// <summary>
        /// 开始烘烤时间
        /// </summary>
        public DateTime StartBakeTime { get; set; }

        /// <summary>
        /// 预计烘烤完时间
        /// </summary>
        public DateTime PredictBakeTime { get; set; }

        /// <summary>
        /// 标准烘烤时长
        /// </summary>
        public decimal BakeHours { get; set; }

        /// <summary>
        /// 实际烘烤时长
        /// </summary>
        public decimal ActualHours { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public string BakeStauts { get; set; }


        /// <summary>
        /// 状态
        /// </summary>
        public int EncapStauts { get; set; }

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
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// 下限温度
        /// </summary>
        public decimal MinTemp { get; set; }


        /// <summary>
        /// 上限温度
        /// </summary>
        public decimal MaxTemp { get; set; }


        /// <summary>
        /// 当前温度
        /// </summary>
        public decimal Temperature { get; set; }

        /// <summary>
        /// MSD等级
        /// </summary>
        public string Msl { get; set; }


        /// <summary>
        /// 机型
        /// </summary>
        public string MachineType { get; set; }

    }
}
