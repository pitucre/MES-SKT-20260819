/*-------------------------------------------------
// Copyright(C)2016 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:AssyDataPartInfo.cs
// 文件功能描述：装配--组件--子件字段相关model信息。
// 
// 创建标识：ZhiMan.Yuan 2016/09/18
// 
// 
//--------------------------------------------------*/
using System;

namespace SKT.LeanMES.ProductionCollection.Model
{
    [Serializable]
    public class AssyDataPartInfo
    {
        /// <summary>
        /// 组件表ID
        /// </summary>
        public int UnitAssyDataId { get; set; }

        /// <summary>
        /// 子件编码
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 子件名称
        /// </summary>
        public string ItemName { get; set; }

        /// <summary>
        /// 条码/SN
        /// </summary>
        public string SN { get; set; }

        /// <summary>
        /// 是否为离线组装条码
        /// </summary>
        public int IsOffline { get; set; }

        /// <summary>
        /// 离线条码规则
        /// </summary>
        public string RegularExpression { get; set; }
    }
}
