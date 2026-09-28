using System;
using System.Collections.Generic;
using System.Reflection;
using System.Windows.Forms;
using LeanMES.FileMonitor.Resources;

namespace LeanMES.FileMonitor.Utility
{
public static class ExtensionMethod
{
public static void BindData<T>(this ComboBox combox, IList<T> list, string displayMember, string valueMember, bool addDefaultItem = false, string value = "-1") where T : class
{
	combox.DataSource = null;
	combox.Items.Clear();
	if (addDefaultItem)
	{
		AddDefaultItem(list, displayMember, valueMember, value);
	}
	combox.DataSource = list;
	combox.DisplayMember = displayMember;
	combox.ValueMember = valueMember;
}

private static void AddDefaultItem<T>(IList<T> list, string displayMember, string valueMember, string value)
{
	object obj = Activator.CreateInstance<T>();
	Type type = obj.GetType();
	PropertyInfo property = type.GetProperty(displayMember);
	property.SetValue(obj, lang.PleaseChoose, null);
	PropertyInfo property2 = type.GetProperty(valueMember);
	if (property2.PropertyType == typeof(int))
	{
		property2.SetValue(obj, Convert.ToInt32(value), null);
	}
	else if (property2.PropertyType == typeof(string))
	{
		property2.SetValue(obj, value, null);
	}
	list.Insert(0, (T)obj);
}

public static string GetValue(this ComboBox cbo)
{
	object selectedValue = cbo.SelectedValue;
	if (selectedValue == null)
	{
		return string.Empty;
	}
	return selectedValue.ToString();
}

public static string GetDateTimeStr(this DateTime dateTime, int type = 0)
{
	DateTime dateTime2 = dateTime;
	switch (type)
	{
		case 0:
			return dateTime2.ToString("yyyy-MM-dd");
		case 1:
			return dateTime2.ToString("yyyyMMdd");
		case 2:
			return dateTime2.ToString("yyyy-MM-dd HH:mm:ss");
		case 3:
			return dateTime2.ToString("yyyy/MM/dd HH:mm:ss");
		case 4:
			return dateTime2.ToString("yyyyMM");
		default:
			return dateTime2.ToString("yyyy-MM-dd HH:mm:ss");
	}
}
}
}
