/*-------------------------------------------------
// Copyright(C)2016 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:AssyDataDetailInfo.cs
// 文件功能描述：装配--组件--数据类型字段相关model信息。
// 
// 创建标识：Larry.Lin 2016/08/16
// 
// 
//--------------------------------------------------*/
using System;

namespace SKT.LeanMES.ProductionCollection.Model
{
    [Serializable]
    public class AssyDataDetailInfo
    {
        public int DataFieldId { get; set; }
        public string DataField { get; set; }
        public string DataTag { get; set; }
        public string DataType { get; set; }
        public string RegularExpression { get; set; }
        public Boolean Required { get; set; }
        public string FieldValue { get; set; }
    }
}
