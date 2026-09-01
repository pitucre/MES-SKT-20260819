using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    /// <summary>
    /// IQC检验录入IQC信息
    /// </summary>
    public class InspectionInputGRNInfo
    {
        /// <summary>
        /// iqc检验单id
        /// </summary>
        public string InspectionId { get; set; }
        /// <summary>
        /// iqc检验单编码
        /// </summary>
        public string InspectionNo { get; set; }
        /// <summary>
        /// 模板Id
        /// </summary>
        public int InspectionTemplateId { get; set; }
        /// <summary>
        /// 检验项id
        /// </summary>
        public int InspectionTemplateMemberId { get; set; }
        public int Pid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string GRN { get; set; }
        /// <summary>
        /// 检测值
        /// </summary>
        public string Value { get; set; }
        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }
        /// <summary>
        /// 结果
        /// </summary>
        public int Result { get; set; }

        public bool DtlResult { get; set; }
        /// <summary>
        /// 扫描人
        /// </summary>
        public string CreateBy { get; set; }
        /// <summary>
        /// 扫描时间
        /// </summary>
        public string CreateDateTime { get; set; }
        /// <summary>
        /// 检验标准值
        /// </summary>
        public string MethodValue { get; set; }

        /// <summary>
        /// 检验项ID
        /// </summary>
        public int InspectionItemId { set; get; }

        /// <summary>
        /// 检验项名称
        /// </summary>
        public string InspectionItemName { set; get; }

        /// <summary>
        /// 录入值
        /// </summary>
        public string InspectionMethodValue { set; get; }

        /// <summary>
        /// 单位
        /// </summary>
        public string UnitName { set; get; }

        /// <summary>
        /// 录入方式
        /// </summary>
        public int InspectionMethodId { set; get; }

        /// <summary>
        /// 检验方式
        /// </summary>
        public string CheckFashion { set; get; }

        /// <summary>
        /// 上传文件地址
        /// </summary>
        public string FilePath { set; get; }

        public DateTime InspectionTime { set; get; }

        /// <summary>
        /// 公差单位
        /// </summary>
        public string OffsetUnitName { set; get; }
    }
}
