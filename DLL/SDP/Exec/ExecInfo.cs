using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Data;
using System.Data.SqlClient;

namespace SKT.LeanMES.SDP.Exec
{
    /// <summary>
    /// 执行操作类
    /// </summary>
    public class Show : ExecBLL
    {
        public override string Exec()
        {
            try
            {
                string result = "";
                result = "$('#" + DataSourceControlId + "').show()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return ExecResult;
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
    public class Hidden : ExecBLL
    {
        public override string Exec()
        {
            try
            {
                string result = "";
                result = "$('#" + DataSourceControlId + "').show()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return ExecResult;
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
    public class Save : ExecBLL
    {
        public override string Exec()
        {
            try
            {
                string result = "";
                result = "$('#" + DataSourceControlId + "').show()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return ExecResult;
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
    public class SetValue : ExecBLL
    {
        public override string Exec()
        {
            try
            {
                string result = "";
                result = "$('#" + DataSourceControlId + "').show()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return ExecResult;
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
    public class UnitComplete : ExecBLL
    {
        public override string Exec()
        {
            try
            {
                string result = "";
                result = "$('#" + DataSourceControlId + "').show()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return ExecResult;
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
    public class UnitComplete1 : ExecBLL
    {
        public override string Exec()
        {
            try
            {
                string result = "";
                result = "$('#" + DataSourceControlId + "').show()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return ExecResult;
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
    public class AlertMessage : ExecBLL
    {
        public override string Exec()
        {
            try
            {
                string result = "";
                result = "$('#" + DataSourceControlId + "').show()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return ExecResult;
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
    public class Update : ExecBLL
    {
        public override string Exec()
        {
            try
            {
                string result = "";
                result = "$('#" + DataSourceControlId + "').show()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return ExecResult;
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
    public class RemoveValue : ExecBLL
    {
        public override string Exec()
        {
            try
            {
                string result = "";
                result = "$('#" + DataSourceControlId + "').show()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return ExecResult;
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
    public class Focus : ExecBLL
    {
        public override string Exec()
        {
            try
            {
                string result = "";
                result = "$('#" + DataSourceControlId + "').show()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return ExecResult;
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
    public class BindValue : ExecBLL
    {
        public override string Exec()
        {
            return "";
        }
    }
    public class BindTable : ExecBLL
    {
        public override string Exec()
        {
            try
            {
                string result = "";
                result = "$('#" + DataSourceControlId + "').show()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return ExecResult;
            }
            catch (Exception)
            {
                return "";
            }
        }
    }

}
