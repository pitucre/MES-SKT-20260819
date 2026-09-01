using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.MSD.Model
{
    [Serializable]
    public class MsdEncapsulationInfo
    {
        public MsdEncapsulationInfo() { }

        public MsdEncapsulationInfo(Int32 eid, String serialNumber, Int32 msdContainerId, DateTime scanTime, DateTime startBakeTime, DateTime predictBakeTime,
      decimal bakeHours, decimal actualHours, string stauts, DateTime createTime, DateTime modifyDateTime, string createUser, string remark
      )
        {


            this.Eid = eid;
            this.SerialNumber = serialNumber;
    
            this.EncapStatus = stauts;

            this.CreateTime = createTime;
            this.ModifyDateTime = modifyDateTime;
            this.CreateUser = createUser;
            this.Remark = remark;
        }


        /// <summary>
        /// 开封ID
        /// </summary>
        public int Eid { get; set; }

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
        /// 开始暴露时间
        /// </summary>
        public DateTime StartExposeTime { get; set; }


        /// <summary>
        /// 暴露总时长
        /// </summary>
        public decimal TotalExposeMinute { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public string EncapStatus { get; set; }

        /// <summary>
        /// 添加时间
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 允许暴露时长
        /// </summary>
        public Int32 FloorLife { get; set; }
        
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

    }

    [Serializable]
    public class MSDKanBanInfo
    {

        public int Oid { get; set; }
        /// <summary>
        /// GRN
        /// </summary>
        public string SerialNumber { get; set; }


        /// <summary>
        /// 物料编号
        /// </summary>
        public string ItemCode { get; set; }


        /// <summary>
        /// 物料名称
        /// </summary>
        public string ItemName { get; set; }


        /// <summary>
        /// 操作动作
        /// </summary>
        public string OperateDes { get; set; }

        /// <summary>
        /// 操作时间
        /// </summary>
        public DateTime OperateTime { get; set; }

        /// <summary>
        /// 累积暴露时长
        /// </summary>
        public decimal TotalExposeMinute { get; set; }

        /// <summary>
        /// 剩余暴露时长
        /// </summary>
        public decimal BalanceExposeMinute { get; set; }

        /// <summary>
        /// 烘/恒箱编号
        /// </summary>
        public string ContainerCode { get; set; }

        /// <summary>
        /// 允许暴露时长
        /// </summary>
        public Int32 FloorLife { get; set; }

    }
}
