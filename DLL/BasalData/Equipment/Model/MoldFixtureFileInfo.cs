using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Equipment.Model
{
    public class MoldFixtureFileInfo
    {
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MoldFixtureId { get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String EqCode { get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FileName { get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy { get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }
    }
}
