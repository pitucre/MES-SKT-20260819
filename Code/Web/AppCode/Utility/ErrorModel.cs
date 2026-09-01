using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.Utility
{
    [Serializable]
    public class ErrorModel
    {
        private string operateUser;
        private string occurTime;
        private string errorMessage;
        private string errorStackTrace;

        public String OperateUser
        {
            set { this.operateUser = value; }
            get { return this.operateUser; }
        }

        public String OccurTime
        {
            set { this.occurTime = value; }
            get { return this.occurTime; }
        }

        public String ErrorMessage
        {
            set { this.errorMessage = value; }
            get { return this.errorMessage; }
        }

        public String ErrorStackTrace
        {
            set { this.errorStackTrace = value; }
            get { return this.errorStackTrace; }
        }
    }
}