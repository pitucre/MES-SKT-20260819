using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{
    /// <summary>
    /// 自定义属性特性
    /// </summary>
    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Parameter, AllowMultiple = false)]
    public sealed class ParmsPropertyAttribute : Attribute
    {
        /// <summary>
        /// 数据为空时忽略此属性
        /// </summary>
        public bool NullIgnore { get; set; } = false;

        /// <summary>
        /// 查询ERP是否忽略此属性
        /// </summary>
        public bool QueryIgnore { get; set; } = false;
    }


    /// <summary>
    /// 查询ERP参数基类
    /// </summary>
    public class BasalERPParm
    {
        /// <summary>
        /// 第几页
        /// </summary>        
        [ParmsPropertyAttribute(NullIgnore = true)]
        public int? page_index { get; set; }

        /// <summary>
        /// 每页行数
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public int? rows_per_page { get; set; }


        /// <summary>
        /// 单号
        /// </summary>
        [ParmsPropertyAttribute(QueryIgnore = true)]
        public string BillNo { get; set; }

        /// <summary>
        /// 是否根据单号同步
        /// </summary>
        [ParmsPropertyAttribute(QueryIgnore = true)]
        public bool SyncByBillNo
        {
            get
            {
                return !string.IsNullOrWhiteSpace(BillNo);
            }
        }
        //public SyncType SyncType
        //{
        //    get
        //    {
        //        return !string.IsNullOrWhiteSpace(QueryBillNo) ? SyncType.BillNoSync : SyncType.DateTimeSync;
        //    }
        //}

        ///// <summary>
        ///// 起始修改日期
        ///// </summary>
        //[ParmsPropertyAttribute(NullIgnore = true)]
        //public DateTime? ModifyDate_begin { get; set; }

        ///// <summary>
        ///// 结束修改日期
        ///// </summary>
        //[ParmsPropertyAttribute(NullIgnore = true)]
        //public DateTime? ModifyDate_end { get; set; }


        /// <summary>
        /// 起始修改日期
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public dynamic ModifyDate_begin { get; set; }

        /// <summary>
        /// 结束修改日期
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public dynamic ModifyDate_end { get; set; }


        #region 供应商修改时间字段

        /// <summary>
        /// 起始修改日期
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public DateTime? dmodifydate_begin { get; set; }

        /// <summary>
        /// 结束修改日期
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public DateTime? dmodifydate_end { get; set; }

        #endregion


        #region 物料修改时间字段

        /// <summary>
        /// 起始修改日期
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public dynamic modifydate_begin { get; set; }

        /// <summary>
        /// 结束修改日期
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public dynamic modifydate_end { get; set; }

        #endregion
    }

    public enum SyncType
    {
        BillNoSync,
        FullSync,
        DateTimeSync
    }

}