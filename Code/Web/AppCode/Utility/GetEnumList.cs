using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Reflection;
using System.Globalization;

namespace SKT.LeanMES.Web.Utility
{
    /// <summary>
    /// 将枚举类转成List
    /// </summary>
    public class EnumHelper
    {
        public static List<ListItem> ParseEnumToList(Type enumType)
        {
            List<ListItem> list = new List<ListItem>();
            if (!enumType.IsEnum)
            {
                return null;
            }

            FieldInfo[] fields = enumType.GetFields();
            string v = "";
            string n = "";
            foreach (FieldInfo field in fields)
            {
                if (field.IsSpecialName) continue;
                v = field.GetRawConstantValue().ToString();
                n = field.Name;
                list.Add(new ListItem((String)HttpContext.GetGlobalResourceObject("Enum", n), v));
            }

            return list;
        }
    }
}