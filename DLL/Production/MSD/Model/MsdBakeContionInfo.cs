using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.MSD.Model
{
    [Serializable]
    public class MsdBakeContionInfo
    {
        public MsdBakeContionInfo() { }

        public MsdBakeContionInfo(Int32 bid, String mSL, string hoursNum,
      int temperature, int temperature2,string remark, DateTime addTime, DateTime modifyDateTime, string createBy, int hoursNum2, string overrunExposureTime
      )
        {


            this.Bid = bid;
            this.Msl = mSL;
            this.HoursNum = hoursNum;
            this.Temperature = temperature;
            this.TemperatureTwo = temperature2;
            this.Remark = remark;
            this.AddTime = addTime;
            this.CreateBy = createBy;
            this.ModifyDateTime = modifyDateTime;
            //2018-06-05 by zhili 增加字段
            this.HoursNum2 = hoursNum2;
            this.OverrunExposureTime = overrunExposureTime;

        }

        /// <summary>
        /// 烘烤条件ID
        /// </summary>
        public int Bid { get; set; }

        /// <summary>
        /// MSD 等级
        /// </summary>
        public string Msl { get; set; }

        /// <summary>
        /// 封装厚度(mm)
        /// </summary>
        public string HoursNum { get; set; }

        /// <summary>
        /// 烘烤时长(h)
        /// </summary>
        public int HoursNum2 { get; set; }

        /// <summary>
        /// 操作时间
        /// </summary>
        public DateTime ModifyDateTime { get; set; }

        /// <summary>
        /// 添加时间
        /// </summary>
        public DateTime AddTime { get; set; }

        /// <summary>
        /// 操作人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 烘烤下限温度(℃)
        /// </summary>
        public int Temperature { get; set; }

        /// <summary>
        /// 烘烤上限温度(℃)
        /// </summary>
        public int TemperatureTwo { get; set; }

        /// <summary>
        /// 是否删除
        /// </summary>
        public int Isdelete { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// 暴露时长(h)
        /// </summary>
        public string OverrunExposureTime { get; set; }

        public string ModifyBy { get; set; }
    }
}
