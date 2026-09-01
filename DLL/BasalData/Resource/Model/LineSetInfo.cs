using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Resource.Model
{
    [Serializable]
    public class LineSetInfo
    {
        private Int32 lineSetId;
        private DateTime lineSetDate;
        private Int32 lineId;
        private Int32 shiftId;
        private Int32 principal;
        private Decimal standardHuman;
        private Decimal actualHuman;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        public string LineName { get; set; }
        public string ShiftName { get; set; }
        public string CName { get; set; }
        public string CSecName { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.LineSetInfo 类的新实例。
        /// </summary>
        public LineSetInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.LineSetInfo 类的新实例。
        /// </summary>
        /// <param name="lineSetId"></param>
        /// <param name="lineSetDate">日期</param>
        /// <param name="lineId">线别ID</param>
        /// <param name="shiftId">班制ID</param>
        /// <param name="principal">负责人</param>
        /// <param name="standardHuman">标准人数</param>
        /// <param name="actualHuman">实到人数</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public LineSetInfo(Int32 lineSetId, DateTime lineSetDate, Int32 lineId, Int32 shiftId,
            Int32 principal, Decimal standardHuman, Decimal actualHuman, String createBy, DateTime createDateTime,
            String modifyBy, DateTime modifyDateTime)
        {
            this.lineSetId = lineSetId;
            this.lineSetDate = lineSetDate;
            this.lineId = lineId;
            this.shiftId = shiftId;
            this.principal = principal;
            this.standardHuman = standardHuman;
            this.actualHuman = actualHuman;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LineSetId
        {
            get { return this.lineSetId; }
            set { this.lineSetId = value; }
        }

        /// <summary>
        /// 获取或设置日期
        /// </summary>
        public DateTime LineSetDate
        {
            get { return this.lineSetDate; }
            set { this.lineSetDate = value; }
        }

        /// <summary>
        /// 获取或设置线别ID
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置班制ID
        /// </summary>
        public Int32 ShiftId
        {
            get { return this.shiftId; }
            set { this.shiftId = value; }
        }

        /// <summary>
        /// 获取或设置负责人
        /// </summary>
        public Int32 Principal
        {
            get { return this.principal; }
            set { this.principal = value; }
        }
        /// <summary>
        /// 获取或设置负责人
        /// </summary>
        public Int32 Seccipal
        {
            get;
            set;
        }
        /// <summary>
        /// 获取或设置标准人数
        /// </summary>
        public Decimal StandardHuman
        {
            get { return this.standardHuman; }
            set { this.standardHuman = value; }
        }

        /// <summary>
        /// 获取或设置实到人数
        /// </summary>
        public Decimal ActualHuman
        {
            get { return this.actualHuman; }
            set { this.actualHuman = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}
