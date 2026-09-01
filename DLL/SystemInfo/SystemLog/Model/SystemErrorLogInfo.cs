using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.SystemLog.Model
{
  public  class SystemErrorLogInfo
    {

        public int  ID { get; set; }
        public string UserName { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string ErrorMsg { get; set; }
        public string Remark { get; set; }
    }
}
