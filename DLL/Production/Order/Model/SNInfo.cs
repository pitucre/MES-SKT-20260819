using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Order.Model
{
    /// <summary>
    /// 用于SN标签打印
    /// add zhibin.chen  2015-12-25
    /// </summary>
    public class SNInfo
    {
        public SNInfo() { }

        /// <summary>
        /// 条码标签种类
        /// </summary>
        public Int32 SNRule { get; set; }

        /// <summary>
        /// 条码信息集合
        /// </summary>
        public List<String> SNList { get; set; }

        /// <summary>
        /// 产品编号
        /// </summary>
        public String ItemCode { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public String ItemName { get; set; }

        /// <summary>
        /// 产品型号
        /// </summary>
        public String ItemModel { get; set; }

        /// <summary>
        /// 产品分类
        /// </summary>
        public String ItemCategory { get; set; }

        /// <summary>
        /// 产品类型
        /// </summary>
        public String ItemType { get; set; }

        /// <summary>
        /// 产品规格
        /// </summary>
        public String ItemSpecification { get; set; }

    }

    public enum EnumItemType
    {
        Manufactured = 1,
        Purchased = 2,
        Manufactured_Purchased = 3
    }
}
