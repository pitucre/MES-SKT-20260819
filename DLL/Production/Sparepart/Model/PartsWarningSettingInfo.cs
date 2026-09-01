using System;

namespace SKT.LeanMES.Sparepart.Model
{
    [Serializable]
    public class PartsWarningSettingInfo
    {
        private Int32 wSId;
        private Boolean wSIsWarning;
        private String wSWarningRate;
        private String wSWarningTime;
        private String wSWarningFirst;
        private String wSWarningSecond;
        private String wSWarningThird;
        private Boolean wSIsInventory;
        private String wSInventoryRate;
        private String wSInventoryTime;
        private String wSInventoryFirst;
        private String wSInventorySecond;
        private String wSInventoryThird;
        private String wSText;
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PartsWarningSettingInfo 类的新实例。
        /// </summary>
        public PartsWarningSettingInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PartsWarningSettingInfo 类的新实例。
        /// </summary>
        /// <param name="wSId"></param>
        /// <param name="wSIsWarning">开启安全库存预警</param>
        /// <param name="wSWarningRate">库存预警频率(daily, weekly, monthly)</param>
        /// <param name="wSWarningTime"></param>
        /// <param name="wSWarningFirst">一级接收人</param>
        /// <param name="wSWarningSecond">二级接收人</param>
        /// <param name="wSWarningThird">三级接收人</param>
        /// <param name="wSIsInventory">开启自动盘点报表</param>
        /// <param name="wSInventoryRate">报表发送频率(daily,weekly,monthly)</param>
        /// <param name="wSInventoryTime">报表发送时间段</param>
        /// <param name="wSInventoryFirst">一级接收人</param>
        /// <param name="wSInventorySecond">二级接收人</param>
        /// <param name="wSInventoryThird">三级接收人</param>
        /// <param name="wSText">用户名字符串</param>
        public PartsWarningSettingInfo(Int32 wSId, Boolean wSIsWarning, String wSWarningRate, String wSWarningTime,
            String wSWarningFirst, String wSWarningSecond, String wSWarningThird, Boolean wSIsInventory, String wSInventoryRate,
            String wSInventoryTime, String wSInventoryFirst, String wSInventorySecond, String wSInventoryThird, String wSText)
        {
            this.wSId = wSId;
            this.wSIsWarning = wSIsWarning;
            this.wSWarningRate = wSWarningRate;
            this.wSWarningTime = wSWarningTime;
            this.wSWarningFirst = wSWarningFirst;
            this.wSWarningSecond = wSWarningSecond;
            this.wSWarningThird = wSWarningThird;
            this.wSIsInventory = wSIsInventory;
            this.wSInventoryRate = wSInventoryRate;
            this.wSInventoryTime = wSInventoryTime;
            this.wSInventoryFirst = wSInventoryFirst;
            this.wSInventorySecond = wSInventorySecond;
            this.wSInventoryThird = wSInventoryThird;
            this.wSText = wSText;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 WSId
        {
            get { return this.wSId; }
            set { this.wSId = value; }
        }

        /// <summary>
        /// 获取或设置开启安全库存预警
        /// </summary>
        public Boolean WSIsWarning
        {
            get { return this.wSIsWarning; }
            set { this.wSIsWarning = value; }
        }

        /// <summary>
        /// 获取或设置库存预警频率(daily, weekly, monthly)
        /// </summary>
        public String WSWarningRate
        {
            get { return this.wSWarningRate; }
            set { this.wSWarningRate = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String WSWarningTime
        {
            get { return this.wSWarningTime; }
            set { this.wSWarningTime = value; }
        }

        /// <summary>
        /// 获取或设置一级接收人
        /// </summary>
        public String WSWarningFirst
        {
            get { return this.wSWarningFirst; }
            set { this.wSWarningFirst = value; }
        }

        /// <summary>
        /// 获取或设置二级接收人
        /// </summary>
        public String WSWarningSecond
        {
            get { return this.wSWarningSecond; }
            set { this.wSWarningSecond = value; }
        }

        /// <summary>
        /// 获取或设置三级接收人
        /// </summary>
        public String WSWarningThird
        {
            get { return this.wSWarningThird; }
            set { this.wSWarningThird = value; }
        }

        /// <summary>
        /// 获取或设置开启自动盘点报表
        /// </summary>
        public Boolean WSIsInventory
        {
            get { return this.wSIsInventory; }
            set { this.wSIsInventory = value; }
        }

        /// <summary>
        /// 获取或设置报表发送频率(daily,weekly,monthly)
        /// </summary>
        public String WSInventoryRate
        {
            get { return this.wSInventoryRate; }
            set { this.wSInventoryRate = value; }
        }

        /// <summary>
        /// 获取或设置报表发送时间段
        /// </summary>
        public String WSInventoryTime
        {
            get { return this.wSInventoryTime; }
            set { this.wSInventoryTime = value; }
        }

        /// <summary>
        /// 获取或设置一级接收人
        /// </summary>
        public String WSInventoryFirst
        {
            get { return this.wSInventoryFirst; }
            set { this.wSInventoryFirst = value; }
        }

        /// <summary>
        /// 获取或设置二级接收人
        /// </summary>
        public String WSInventorySecond
        {
            get { return this.wSInventorySecond; }
            set { this.wSInventorySecond = value; }
        }

        /// <summary>
        /// 获取或设置三级接收人
        /// </summary>
        public String WSInventoryThird
        {
            get { return this.wSInventoryThird; }
            set { this.wSInventoryThird = value; }
        }
        /// <summary>
        /// 获取或设置用户名字符串
        /// </summary>
        public String WSText
        {
            get { return this.wSText; }
            set { this.wSText = value; }
        }
    }
}