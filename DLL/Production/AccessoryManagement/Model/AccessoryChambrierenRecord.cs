using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.AccessoryManagement.Model
{
    public class AccessoryChambrierenRecord
    {
        public int ACRId { set; get; }
        public string ACRSerialNumber { set; get; }

        public string ItemCode { set; get; }
        public string ItemName { set; get; }
        public int ACRTypeID { set; get; }
        public string ACRTypeName { set; get; }
        public string ACRStartTime { set; get; }
        public string ACRStopTime { set; get; }
        public int ACRCount { set; get; }

        public string ACRCountString
        {
            get
            {
                if (ACRCount == 1)
                {
                    return "第一次";
                }
                if (ACRCount == 2)
                {
                    return "第二次";
                }
                else
                {
                    return "";
                }
            }
        }
        public int ACRStatus { set; get; }

        public string ACRStatusString
        {
            get
            {
                if (ACRStatus == 0)
                {
                    return "未完成";
                }
                if (ACRStatus == 1)
                {
                    return "完成";
                }
                else
                {
                    return "未知";
                }
            }
        }
        public string CreateBy { set; get; }
        public string CreateTime { set; get; }
        public string ACRRem { set; get; }
    }
}
