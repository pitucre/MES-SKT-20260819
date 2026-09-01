namespace SKT.LeanMES.ERP
{
    using Newtonsoft.Json;
    using System.Collections.Generic;

    /// <summary>
    /// ERPU9盘点单返回信息主类
    /// </summary>
    public class ERPU9InventoryListInfo
    {
        /// <summary>
        /// 返回值单条（数组）
        /// </summary>
        [JsonProperty("返回值单条")]
        public List<InventoryResultItem> ReturnSingleItems { get; set; }
    }

    /// <summary>
    /// 盘点单执行结果项（返回值单条的数组元素）
    /// </summary>
    public class InventoryResultItem
    {
        /// <summary>
        /// 执行结果（如：err/success）
        /// </summary>
        [JsonProperty("执行结果")]
        public string ExecuteResult { get; set; }

        /// <summary>
        /// 提示文本（错误信息或成功提示）
        /// </summary>
        [JsonProperty("提示文本")]
        public string PromptText { get; set; }

        /// <summary>
        /// 附件信息1
        /// </summary>
        [JsonProperty("附件信息1")]
        public string Attachment1 { get; set; }

        /// <summary>
        /// 附件信息2
        /// </summary>
        [JsonProperty("附件信息2")]
        public string Attachment2 { get; set; }

        /// <summary>
        /// 附件信息3
        /// </summary>
        [JsonProperty("附件信息3")]
        public string Attachment3 { get; set; }

        /// <summary>
        /// 附件信息4
        /// </summary>
        [JsonProperty("附件信息4")]
        public string Attachment4 { get; set; }

        /// <summary>
        /// 附件信息5
        /// </summary>
        [JsonProperty("附件信息5")]
        public string Attachment5 { get; set; }
    }
}
