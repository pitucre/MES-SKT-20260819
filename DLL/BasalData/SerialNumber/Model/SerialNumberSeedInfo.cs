using System;

namespace SKT.LeanMES.SerialNumber.Model
{
    [Serializable]
    public class SerialNumberSeedInfo
    {
        private Int32 serialNumberSeedId;
        private Int32 serialNumberID;
        private Int64 sequence_Base;
        private String number_Sequence;
        private Int64 max_Seq;
        private Int64 sequence_Length;
        private Int64 current_Sequence;
        private Int64 min_Sequence;
        private Int64 incrementBy;
        private Int64 warning;
        private String reset;
        private DateTime resetDate;
        private DateTime lastUpdate;

        private String resetStr;

        /// <summary>
        /// 初始化 SKT.LeanMES.SerialNumber.Model.SerialNumberSeedInfo 类的新实例。
        /// </summary>
        public SerialNumberSeedInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.SerialNumber.Model.SerialNumberSeedInfo 类的新实例。
        /// </summary>
        /// <param name="serialNumberSeedId">产生序号从表ID</param>
        /// <param name="serialNumberID">产生序号主表ID</param>
        /// <param name="sequence_Base">进制数</param>
        /// <param name="number_Sequence">数字序列</param>
        /// <param name="max_Seq">最大序号</param>
        /// <param name="sequence_Length">序列号长度</param>
        /// <param name="current_Sequence">当前序号</param>
        /// <param name="min_Sequence">最小序号</param>
        /// <param name="incrementBy">递增增量</param>
        /// <param name="warning">预警天数</param>
        /// <param name="reset">复位方式</param>
        /// <param name="resetDate">上次复位日期</param>
        /// <param name="lastUpdate">最后更新时间</param>
        public SerialNumberSeedInfo(Int32 serialNumberSeedId, Int32 serialNumberID, Int64 sequence_Base, String number_Sequence, 
            Int64 max_Seq, Int64 sequence_Length, Int64 current_Sequence, Int64 min_Sequence, Int64 incrementBy,
            Int64 warning, String reset, DateTime resetDate, DateTime lastUpdate)
        {
            this.serialNumberSeedId = serialNumberSeedId;
            this.serialNumberID = serialNumberID;
            this.sequence_Base = sequence_Base;
            this.number_Sequence = number_Sequence;
            this.max_Seq = max_Seq;
            this.sequence_Length = sequence_Length;
            this.current_Sequence = current_Sequence;
            this.min_Sequence = min_Sequence;
            this.incrementBy = incrementBy;
            this.warning = warning;
            this.reset = reset;
            this.resetDate = resetDate;
            this.lastUpdate = lastUpdate;
        }

        /// <summary>
        /// 获取或设置产生序号从表ID
        /// </summary>
        public Int32 SerialNumberSeedId
        {
            get { return this.serialNumberSeedId; }
            set { this.serialNumberSeedId = value; }
        }

        /// <summary>
        /// 获取或设置产生序号主表ID
        /// </summary>
        public Int32 SerialNumberID
        {
            get { return this.serialNumberID; }
            set { this.serialNumberID = value; }
        }

        /// <summary>
        /// 获取或设置进制数
        /// </summary>
        public Int64 Sequence_Base
        {
            get { return this.sequence_Base; }
            set { this.sequence_Base = value; }
        }

        /// <summary>
        /// 获取或设置数字序列
        /// </summary>
        public String Number_Sequence
        {
            get { return this.number_Sequence; }
            set { this.number_Sequence = value; }
        }

        /// <summary>
        /// 获取或设置最大序号
        /// </summary>
        public Int64 Max_Seq
        {
            get { return this.max_Seq; }
            set { this.max_Seq = value; }
        }

        /// <summary>
        /// 获取或设置序列号长度
        /// </summary>
        public Int64 Sequence_Length
        {
            get { return this.sequence_Length; }
            set { this.sequence_Length = value; }
        }

        /// <summary>
        /// 获取或设置当前序号
        /// </summary>
        public Int64 Current_Sequence
        {
            get { return this.current_Sequence; }
            set { this.current_Sequence = value; }
        }

        /// <summary>
        /// 获取或设置最小序号
        /// </summary>
        public Int64 Min_Sequence
        {
            get { return this.min_Sequence; }
            set { this.min_Sequence = value; }
        }

        /// <summary>
        /// 获取或设置递增增量
        /// </summary>
        public Int64 IncrementBy
        {
            get { return this.incrementBy; }
            set { this.incrementBy = value; }
        }

        /// <summary>
        /// 获取或设置预警天数
        /// </summary>
        public Int64 Warning
        {
            get { return this.warning; }
            set { this.warning = value; }
        }

        /// <summary>
        /// 获取或设置复位方式
        /// </summary>
        public String Reset
        {
            get { return this.reset; }
            set { this.reset = value; }
        }

        /// <summary>
        /// 获取或设置上次复位日期
        /// </summary>
        public DateTime ResetDate
        {
            get { return this.resetDate; }
            set { this.resetDate = value; }
        }

        /// <summary>
        /// 获取或设置最后更新时间
        /// </summary>
        public DateTime LastUpdate
        {
            get { return this.lastUpdate; }
            set { this.lastUpdate = value; }
        }

        public String ResetStr
        {
            get { return this.resetStr; }
            set { this.resetStr = value; }
        }
    }
}