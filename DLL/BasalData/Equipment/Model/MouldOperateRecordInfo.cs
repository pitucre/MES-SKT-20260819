using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Equipment.Model
{
    public class MouldOperateRecordInfo
    {
      public Int64  MouldOperateRecordId {get;set;}
        public int MouldId { get; set; }
        public string OperateType { get; set; }
        public string MouldCode { get; set; }
        public string MouldName { get;set;}
        public string Operator {get;set;}
        public string Item1 {get;set;}
        public string Item2 {get;set;}
        public string Item3 {get;set;}
        public string Remark {get;set;}
        public string CreateBy {get;set;}
        public string CreateTime {get;set;}
    }
}
