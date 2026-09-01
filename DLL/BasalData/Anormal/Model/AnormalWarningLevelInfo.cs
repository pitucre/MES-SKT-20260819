using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Anormal.Model
{
    public class AnormalWarningLevelInfo
    {
        /// <summary>
        /// 预警等级信息表Id
        /// </summary>
        public int AnormalWarningLevelId { get; set; }

        /// <summary>
        /// 预警等级（1、2、3、4、5）
        /// </summary>
        public int WarningLevel { get; set; }

        /// <summary>
        /// 预警等级名称
        /// </summary>
        public string WarningLevelName { get; set; }

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
    }
}
