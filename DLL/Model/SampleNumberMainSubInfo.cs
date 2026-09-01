using System;

namespace SKT.LeanMES.SampleNumberManagement.Model
{
    public class SampleNumberMainSubInfo
    {
        public int Id { get; set; }
        public int ItemId { get; set; }
        public String ItemCode { get; set; }
        public String ItemName { get; set; }
        public String ItemSpec { get; set; }
        public String CreateBy { get; set; }
        public DateTime CreateTime { get; set; }
        public String ModifyBy { get; set; }
        public DateTime ModifyTime { get; set; }

        //------------------从表字段------------------
        public String SampleNumber { get; set; }
        public String SampleName { get; set; }
        public String StationName { get; set; }
        //public Int32 MaxUserCount { get; set; }
        //public Int32 UsedCount { get; set; }
        public String Remark { get; set; }

        //------------------------非两表字段------------
        public String UserName { get; set; }
        public Int32 SubId { get; set; }

        /// <summary>
        /// 样品序号主表Id（Basal_SampleNumberMain表Id）
        /// </summary>
        public int? SampleNumberMainId { get; set; }

        /// <summary>
        /// 工序Id
        /// </summary>
        public int? StationId { get; set; }

        /// <summary>
        /// 失效日期（未重检时，以失效日期为准，重检后，以下一失效日期为准）
        /// </summary>
        public DateTime? ExpirationDate { get; set; }

        /// <summary>
        /// 下一失效日期（未重检时，以失效日期为准，重检后，以下一失效日期为准）（未重检时，下一失效日期为空，重检后，以下一失效日期为样品序号失效时间）
        /// </summary>
        public DateTime? NextExpirationDate { get; set; }

        /// <summary>
        /// 不良属性（0：不良品 1：良品）
        /// </summary>
        public int? PrototypeAttr { get; set; }

        /// <summary>
        /// 不良代码（多个用逗号隔开，可用Basal_SampleNumberNcCode表进行查询维护的不良代码）
        /// </summary>
        public string NcCodes { get; set; }

        /// <summary>
        /// 报废标记（0：未报废 1：报废）
        /// </summary>
        public int? ScrapFlag { get; set; }

        /// <summary>
        /// 报废人
        /// </summary>
        public string ScrapBy { get; set; }

        /// <summary>
        /// 报废时间
        /// </summary>
        public DateTime? ScrapTime { get; set; }

        /// <summary>
        /// 重检人
        /// </summary>
        public string RecheckBy { get; set; }

        /// <summary>
        /// 重检时间
        /// </summary>
        public DateTime? RecheckTime { get; set; }

        /// <summary>
        /// 不良属性（0：不良品 1：良品）
        /// </summary>
        public string PrototypeAttrName { get; set; }

        /// <summary>
        /// 报废标记（0：未报废 1：报废）
        /// </summary>
        public string ScrapFlagName { get; set; }

        /// <summary>
        /// 工序
        /// </summary>
        public string Station { get; set; }
    }
}
