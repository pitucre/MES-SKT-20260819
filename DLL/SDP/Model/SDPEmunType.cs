using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SDP.Model
{
    /// <summary>
    /// 控件类型
    /// </summary>
    public enum ControlType
    {
        text,
        textarea,
        checkboxs,
        radios,
        select,
        listctrl,
        gridctrl,
        button
    }
    
    /// <summary>
    /// 数据源类型
    /// </summary>
    public enum DataSourceType
    {
        Empty,
        Table,
        Logic
    }

    /// <summary>
    /// 脚本类型
    /// </summary>
    public enum SqlType
    {
        SqlText,
        Procedure,
        WebService,
        Table
    }

    /// <summary>
    /// 操作类型
    /// </summary>
    public enum HandleType
    {
        BindTable = 1,
        BindValue,
        Focus,
        RemoveValue,
        Excute,
        AlertMessage,
        ChoosePage,
        Show,
        Hidden,
        SetValue,
        UnitComplete,
        SNCheck,
        Print
    }

    public enum UseType
    {
        Common,
        UIModel,
        Report,
        Board
    }

    public enum TableBoundType
    {
        ReBound = 0,    //重新绑定
        Superimposed    //叠加
    }
}
