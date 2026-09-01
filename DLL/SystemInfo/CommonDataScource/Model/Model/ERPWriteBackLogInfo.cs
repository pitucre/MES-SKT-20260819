using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.CommonDataSource.Model
{
    /// <summary>
    /// ERP回写日志信息表
    /// </summary>
    [Serializable]
    public class ERPWriteBackLogInfo
    {
        /// <summary>
        /// ERP回写日志信息表Id
        /// </summary>
        public int WriteBackLogId { get; set; }

        /// <summary>
        /// 回写编码（可通过此字段关联ERP_WriteBackConfig表WriteBackCode字段）
        /// </summary>
        public string WriteBackCode { get; set; }

        /// <summary>
        /// 回写名称
        /// </summary>
        public string WriteBackName { get; set; }

        /// <summary>
        /// MD5（传给联晶ERP的MD5值）
        /// </summary>
        public string MD5 { get; set; }

        /// <summary>
        /// ERP回写结果（-1：ERP_WriteBackConfig表回写开关配置为否，不进行回写 -1：不回写 0：失败 1：成功）
        /// </summary>
        public int? ERPResult { get; set; }

        /// <summary>
        /// ERP返回的编码
        /// </summary>
        public string ERPNo { get; set; }

        /// <summary>
        /// ERP返回的消息
        /// </summary>
        public string ERPMsg { get; set; }

        /// <summary>
        /// ERP返回的描述
        /// </summary>
        public string ERPDes { get; set; }

        /// <summary>
        /// MES消息
        /// </summary>
        public string MESMsg { get; set; }

        /// <summary>
        /// MES单号
        /// </summary>
        public string MESBillNo { get; set; }

        /// <summary>
        /// 回写的数据(XML格式)
        /// </summary>
        public string WriteBackData { get; set; }

        /// <summary>
        /// 回写的数据(JSON格式)（此字段仅为更直观查看MES存储过程返回的数据，这些数据拼接成XML后(即WriteBackData字段的值)，传给ERP）
        /// </summary>
        public string WriteBackDataJSON { get; set; }

        /// <summary>
        /// 接收的数据(XML格式)
        /// </summary>
        public string ReceiveData { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }


        #region 扩展字段


        /// <summary>
        /// ERP回写结果（-1：ERP_WriteBackConfig表回写开关配置为否，不进行回写 0：失败 1：成功）
        /// </summary>
        public string ERPResultName { get; set; }


        #endregion

    }


}
