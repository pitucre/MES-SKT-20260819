using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Quality.Model
{
    public class HoldInfo
    {
        public int HistoryId { get; set; }
        public string ObjectName { get; set; }
        public string ObjectCode { get; set; }
        public string ObjectStatus { get; set; }
        public string OperatePerson { get; set; }
        public DateTime OperateDateTime { get; set; }
        public string OperateType { get; set; }
        public string HoldOrUnHoldCause { get; set; }
        public string Remark { get; set; }

        public int SignId { get; set; }
        public string SerialNumber { get; set; }
        public string Cause { get; set; }
        public string States { get; set; }
        public string ErrorMessage { get; set; }

        /// <summary>
        /// Excel文件中表示无效SN（已经Qhold）
        /// </summary>
        public string msg1 { get; set; }

        /// <summary>
        ///  Excel文件中表示不存在SN
        /// </summary>
        public string msg2 { get; set; }

        public HoldInfo()
        {
        }

        public HoldInfo(string objectName, string objectCode, string objectStatus, string operatePerson, DateTime operateDateTime)
        {
            this.ObjectName = objectName;
            this.ObjectCode = objectCode;
            this.ObjectStatus = objectStatus;
            this.OperatePerson = operatePerson;
            this.OperateDateTime = operateDateTime;
        }

        public String Msg1
        {
            get { return this.msg1; }
            set { this.msg1 = value; }
        }

        public String Msg2
        {
            get { return this.msg2; }
            set { this.msg2 = value; }
        }
    }
}
