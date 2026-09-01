using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.CommonDataSource.Model
{
    /// <summary>
    /// ERP回写开关配置表
    /// </summary>
    [Serializable]
    public class ERPWriteBackConfigInfo
    {
        /// <summary>
        /// ERP回写开关配置表Id
        /// </summary>
        public int WriteBackConfigId { get; set; }

        /// <summary>
        /// 回写编码
        /// </summary>
        public string WriteBackCode { get; set; }

        /// <summary>
        /// 回写名称
        /// </summary>
        public string WriteBackName { get; set; }

        /// <summary>
        /// 是否回写（0：否（不回写） 1：是（回写））
        /// </summary>
        public int? WriteBackFlag { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }


        #region 扩展字段


        /// <summary>
        /// 是否回写（0：否（不回写） 1：是（回写））
        /// </summary>
        public string WriteBackFlagName { get; set; }


        #endregion

    }


}
