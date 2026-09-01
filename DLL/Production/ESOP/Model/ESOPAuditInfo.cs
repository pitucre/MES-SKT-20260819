using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ESOP.Model
{

    public class ESOPAuditInfo
    {
        /// <summary>
        /// ESOPId
        /// </summary>
        public int ESOPId { get; set; }

        /// <summary>
        /// 审核单号
        /// </summary>
        public string AuditNo { get; set; }

        /// <summary>
        /// 工序名称
        /// </summary>
        public string StationName { get; set; }

        /// <summary>
        /// ESOP名称
        /// </summary>
        public string ESOPName { get; set; }

        /// <summary>
        /// ESOP文件名
        /// </summary>
        public string ESOPFileName { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }

        /// <summary>
        /// 状态(是否启用)
        /// </summary>
        public string IsEnableName { get; set; }

        /// <summary>
        /// 审核结果
        /// </summary>
        public string AuditStates { get; set; }

        /// <summary>
        /// 审核人
        /// </summary>
        public string AuditUserName { get; set; }

        /// <summary>
        /// 审核时间
        /// </summary>
        public string AuditDatatime { get; set; }

        /// <summary>
        /// 审核备注
        /// </summary>
        public string AuditRemark { get; set; }

        /// <summary>
        /// 批准状态(是否启用)
        /// </summary>
        public string IsEnableApproval { get; set; }

        /// <summary>
        /// 批准结果
        /// </summary>
        public string ApprovalStates { get; set; }

        /// <summary>
        /// 批准人
        /// </summary>
        public string ApprovalUser { get; set; }

        /// <summary>
        /// 批准时间
        /// </summary>
        public string ApprovalDatatime { get; set; }

        /// <summary>
        /// 批准备注
        /// </summary>
        public string ApprovalRemark { get; set; }

        /// <summary>
        /// 审核备注
        /// </summary>
        public string ESOPFileNameURL { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDate { get; set; } 

    }
}
