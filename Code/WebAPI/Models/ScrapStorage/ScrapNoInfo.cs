using System.Collections.Generic;
using WebAPI.Models.MES;

namespace WebAPI.Models.ScrapStorage
{
    public class ScrapNoInfo
    {
        /// <summary>
        /// 报废单号列表
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ScrapNo { get; set; }
    }
}