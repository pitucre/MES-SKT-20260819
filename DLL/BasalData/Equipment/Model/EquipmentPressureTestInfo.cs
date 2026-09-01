using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Equipment.Model
{
    public class EquipmentPressureTestInfo
    {
        public int EquipmentPressureTestId { get; set; }
        public int EquipmentId { get; set; }
        public string EquipmentCode { get; set; }
        public string EquipmentName { get; set; }
        public int TestCycle { get; set; }
        public string Pressure { get; set; }
        public string Equation { get; set; }
        public string Tester { get; set; }
        public string TestTime { get; set; }
        public string NextTestTime { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string ModifyBy { get; set; }
        public DateTime ModifyDateTime { get; set; }
        public string TestStatus { get; set; }
    }
    
}
