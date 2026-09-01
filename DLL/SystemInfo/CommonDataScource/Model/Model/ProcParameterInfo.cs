using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.CommonDataSource.Model
{
    [Serializable]
    public class ProcParameterInfo
    {
        private string _procName;
        private string _businessName;
        private string _parameterName;
        private string _parameterType;
        private string _paramterValue;
        private int _maxlength;

        public ProcParameterInfo() { }

        public ProcParameterInfo(string procName, string parameterName, string parameterType,int maxlength,string businessName,string paramterValue)
        {
            ProcName = procName;
            ParameterName = parameterName;
            ParameterType = parameterType;
            Maxlength = maxlength;
            BusinessName = businessName;
            ParameterValue = paramterValue;
        }

        public string BusinessName
        {
            get { return this._businessName; }
            set { this._businessName = value; }
        }

        public string ProcName
        {
            get { return this._procName; }
            set { this._procName = value; }
        }

        public string ParameterName
        {
            get { return this._parameterName; }
            set { this._parameterName = value; }
        }

        public string ParameterType
        {
            get { return this._parameterType; }
            set { this._parameterType = value; }
        }

        public string ParameterValue
        {
            get { return this._paramterValue; }
            set { this._paramterValue = value; }
        }

        public int Maxlength
        {
            get { return this._maxlength; }
            set { this._maxlength = value; }
        }
    }
}
