using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.SDP.Model;

namespace SKT.LeanMES.SDP.Exec
{
    /// <summary>
    /// 执行类
    /// </summary>
    public class ExecBLL
    {
        public ExecBLL() { ExecResult = ""; }
        public SqlType sqltype { get; set; }
        public string SQlInfo { get; set; }
        public string DataSourceControlId { get; set; }
        public string DataSourceType { get; set; }
        public string stepXml { get; set; }
        public string Paramters { get; set; }
        public string valuearr { get; set; }
        public string ExecResult { get; set; }

        public virtual string Exec()
        {
            return ExecResult;
        }
    }
}
