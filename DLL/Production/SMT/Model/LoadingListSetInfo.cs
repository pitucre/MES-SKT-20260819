using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SMT.Model
{
    public class LoadingListSetOrderInfo
    {
        public int LinePlanId { get; set; }//排产工单ID
        public string PlanOrderNo { get; set; }//排产工单号
        public int ItemId { get; set; }//产品ID
        public string ItemCode { get; set; }//产品编码
        public string ItemName { get; set; }//产品名称
        public int LineId { get; set; }//线别ID
        public string LineName { get; set; }//线别名称
        public int State { get; set; }//SMT状态
        public string StatusDesc { get; set; }
        public string TableName { get; set; }//面别编码
        public string TableDesc { get; set; }//面别描述
    }

    public class LoadingListSetEquipmentInfo
    {
        public int EquipmentId { get; set; }
        public string EquipmentCode { get; set; }//设备编码
        public string EquipmentModel { get; set; }//设备型号
        public string EquipmentName { get; set; }//设备名称
        public int SequenceNo { get; set; }//序号
        public int LineId { get; set; }//线别ID
        public bool IsLoading { get; set; }//是否上料
        public bool IsOffLine { get; set; }//是否离线备料
        public bool IsScanPos { get; set; }   //是否扫描站位      
    }
}
