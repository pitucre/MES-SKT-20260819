using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Quality.Model
{
    public class OSPType
    {
        public int OSPTypeId { get; set; }
        public string OSPTypeName { get; set; }
        public int OSPTypeTime { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }  
        public string IsSystem { get; set; }
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
