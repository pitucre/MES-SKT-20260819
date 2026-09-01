using System.Collections.Generic;

namespace WebAPI.Models.ScrapStorage
{
    public class ScrapStorageBaseInfo<T> where T : class
    {
        /// <summary>
        /// 数据集合
        /// </summary>
        public List<T> List { get; set; }
    }
}