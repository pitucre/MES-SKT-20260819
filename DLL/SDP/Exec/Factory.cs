using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.SDP.Model;

namespace SKT.LeanMES.SDP.Exec
{
    /// <summary>
    /// 工厂类
    /// </summary>
    public class Factory
    {
        public static ExecBLL Start(HandleType type)
        {
            ExecBLL exec = null;
            switch (type)
            {
                case HandleType.BindTable:
                    exec = new BindTable();
                    break;
                case HandleType.BindValue:
                    exec = new BindValue();
                    break;
                case HandleType.Focus:
                    exec = new Focus();
                    break;
                case HandleType.RemoveValue:
                    exec = new RemoveValue();
                    break;
                case HandleType.Excute:
                    exec = new Save();
                    break;
                case HandleType.AlertMessage:
                    exec = new AlertMessage();
                    break;
                case HandleType.UnitComplete:
                    exec = new UnitComplete1();
                    break;
                case HandleType.Show:
                    exec = new Show();
                    break;
                case HandleType.Hidden:
                    exec = new Hidden();
                    break;
                case HandleType.SetValue:
                    exec = new SetValue();
                    break;
            }
            return exec;
        }
    }
}
