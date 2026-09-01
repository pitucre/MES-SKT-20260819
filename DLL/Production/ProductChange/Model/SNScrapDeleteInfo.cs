using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductChange.Model
{
    public class SNScrapDeleteInfo
    {
        private Int32 SnID;
        private Int32 SNTypeID;
        private string SNStatus;
        private string SNValue;
        private string remark;
        private string createBy;
        private DateTime createdatetime;
        private string modifyby;
        private DateTime modifydatetime;

        public Int64 UnitId { get; set; }

        /// <summary>
        /// 初始化 SKT.MES.User.Model.ORDERInfo 类的新实例。
        /// </summary>
        public SNScrapDeleteInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.User.Model.ORDERInfo 类的新实例。
        /// </summary>
        /// <param name="ID">SN ID</param>
        /// <param name="SNTypeID">SN 类型</param>
        /// <param name="SNStatus">SN 状态</param>
        /// <param name="SNValue">SN 值</param>
        /// <param name="remark">SN 备注</param>
        public SNScrapDeleteInfo(Int32 SNID, Int32 SNTypeID, string SNStatus, string SNValue, string Remark,
            String createBy, DateTime createTime, String modifyBy,
            DateTime modifyTime)
        {
            this.SNID = SNID;
            this.SNTYPEID = SNTypeID;
            this.SNTYPEID = SNTypeID;
            this.SNVALUE = SNValue;
            this.REMARK = remark;
            this.CreateBy = createBy;
            this.CreateTime = createTime;
            this.ModifyBy = modifyBy;
            this.ModifyTime = modifyTime;
        }

        /// <summary>
        /// 获取或设置ID
        /// </summary>
        public Int32 SNID
        {
            get { return this.SnID; }
            set { this.SnID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 SNTYPEID
        {
            get { return this.SNTypeID; }
            set { this.SNTypeID = value; }
        }

        /// <summary>
        /// 获取或设置serial number
        /// </summary>
        public string SNVALUE
        {
            get { return this.SNValue; }
            set { this.SNValue = value; }
        }

        /// <summary>
        /// 获取或设置SN状态
        /// </summary>
        public string SNSTATUS
        {
            get { return this.SNStatus; }
            set { this.SNStatus = value; }
        }

        /// <summary>
        /// 获取或设置SN remark
        /// </summary>
        public string REMARK
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createdatetime; }
            set { this.createdatetime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyby; }
            set { this.modifyby = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyTime
        {
            get { return this.modifydatetime; }
            set { this.modifydatetime = value; }
        }
    }
}
