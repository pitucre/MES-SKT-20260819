using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Globalization;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    public static class DateTimeUtility
    {
        /// <summary>
        /// 获取指定日期，在为一年中为第几周
        /// </summary>
        /// <param name="year"></param>
        /// <returns></returns>
        public static int GetWeekOfYear(DateTime dt)
        {
            GregorianCalendar gc = new GregorianCalendar();
            int weekOfYear = gc.GetWeekOfYear(dt, CalendarWeekRule.FirstDay, DayOfWeek.Monday);
            return weekOfYear;
        }

        /// <summary>
        /// 清除默认时间
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string ClearDefaultTime(string dt) {
            var wrongArr = new string[] { "9999-12-31 00:00:00", "1900-01-01 00:00:00" };
            if (wrongArr.Contains(dt)) return "";
            return dt;
        }
    }
}