using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LeanMES.FileMonitor.Model
{
    public class DeviceData
    {

        public string DevId { get; set; } = "9";


        public string Topic { get; set; } = "all";


        public string SendTime { get; set; } = "2025-07-29 14:49:26";


        public long SendStamp { get; set; } = 1753771766000;


        public string Time { get; set; } = "2025-07-29 14:49:18";


        public long Timestamp { get; set; } = 1753771758000;


        public DeviceDataDetail Data { get; set; }
    }

    public class DeviceDataDetail
    {
        // 基础状态参数
        public string ATST { get; set; }
        public string OPM { get; set; }
        public string OT { get; set; }
        public string STS { get; set; }

        public string CYCN { get; set; }

        /// <summary>
        /// 
        /// </summary>

        public string ECYCT { get; set; }
        
        /// <summary>
        /// 
        /// </summary>
        public string EPLSPM { get; set; }

        // 温度传感器组 (℃)
        public string T1 { get; set; }
        public string T2 { get; set; }
        public string T3 { get; set; }
        public string T4 { get; set; }
        public string T5 { get; set; }
        public string TS1 { get; set; }  // 温度设定值

        // 电流/电压组 (A/V)
        public string IS1 { get; set; }  // 电流
        public string IV1 { get; set; }   // 电压
        public string IP1 { get; set; }   // 功率 (W)

        // 压力传感器组 (kPa)
        public string PP1 { get; set; }   // 压力实际值
        public string PV1 { get; set; }   // 压力设定值
        public double PT1 { get; set; } // 压力阈值

        // 设备控制状态
        public string SBS1 { get; set; }  // 开关状态
        public string PLV1 { get; set; }  // 负载电压
        public string PLP1 { get; set; }  // 负载功率

        // 电机控制参数
        public string MCP1 { get; set; }  // 电机电流
        public string MCV1 { get; set; }  // 电机电压
        public string MOP1 { get; set; }  // 电机操作参数

        // 能耗统计
        public string CycleCount { get; set; }
        public string EnergyPerCycle { get; set; }
        public double InputPower { get; set; }

        // 特殊状态标识
        public string SystemInputPressureThreshold { get; set; }
        public string SystemInputPressureStatus { get; set; }
    }
}
