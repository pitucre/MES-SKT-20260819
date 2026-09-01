using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{
    public class BaseERPReturn
    {
        /// <summary>
        /// 错误码
        /// </summary>
        [JsonProperty("errcode")]
        public string ErrCode { get; set; }

        /// <summary>
        /// 错误信息
        /// </summary>
        [JsonProperty("errmsg")]
        public string ErrMsg { get; set; }

        /// <summary>
        /// 批量查询(batch_get)返回的页号
        /// </summary>
        [JsonProperty("page_index", NullValueHandling = NullValueHandling.Ignore)]
        public int? PageIndex { get; set; }

        /// <summary>
        /// 批量查询(batch_get)返回的总行数
        /// </summary>
        [JsonProperty("row_count", NullValueHandling = NullValueHandling.Ignore)]
        public int? RowCount { get; set; }

        /// <summary>
        /// 批量查询(batch_get)返回的每页行数
        /// </summary>
        [JsonProperty("rows_per_page", NullValueHandling = NullValueHandling.Ignore)]
        public int? RowsPerPage { get; set; }

        /// <summary>
        /// 批量查询(batch_get)返回的页数
        /// </summary>
        [JsonProperty("page_count", NullValueHandling = NullValueHandling.Ignore)]
        public int? PageCount { get; set; }


    }
}