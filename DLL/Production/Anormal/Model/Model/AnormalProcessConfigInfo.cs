using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProdAnormal.Model
{
    public class AnormalProcessConfigInfo
    {
        /// <summary>
        /// 异常处理配置信息表Id
        /// </summary>
        public int AnormalProcessConfigId { get; set; }

        /// <summary>
        /// 线别Id
        /// </summary>
        public int? LineId { get; set; }

        /// <summary>
        /// 异常类型信息表Id（关联Basal_Anormal_Group表AnormalGroupId字段），如果为-1则表示可以处理对应线体所有异常
        /// </summary>
        public int? AnormalGroupId { get; set; }

        /// <summary>
        /// 异常处理人员账号（多个用逗号隔开）具体数据存在Prod_AnormalProcessConfigUserUser表中，AnormalUserType字段0表示异常处理人员，1表示异常完结人员
        /// </summary>
        public string ProcessBy { get; set; }

        /// <summary>
        /// 异常处理人员姓名（多个用逗号隔开）具体数据存在Prod_AnormalProcessConfigUserUser表中，AnormalUserType字段0表示异常处理人员，1表示异常完结人员
        /// </summary>
        public string ProcessByName { get; set; }

        /// <summary>
        /// 异常完结人员账号（多个用逗号隔开）具体数据存在Prod_AnormalProcessConfigUserUser表中，AnormalUserType字段0表示异常处理人员，1表示异常完结人员
        /// </summary>
        public string CompleteBy { get; set; }

        /// <summary>
        /// 异常完结人员姓名（多个用逗号隔开）具体数据存在Prod_AnormalProcessConfigUserUser表中，AnormalUserType字段0表示异常处理人员，1表示异常完结人员
        /// </summary>
        public string CompleteByName { get; set; }

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


        /// <summary>
        /// 线别编码
        /// </summary>
        public string LineCode { get; set; }

        /// <summary>
        /// 线别
        /// </summary>
        public string LineName { get; set; }

        /// <summary>
        /// 异常类型信息表Id（关联Basal_Anormal_Group表AnormalGroupId字段），如果为-1则表示可以处理对应线体所有异常
        /// </summary>
        public string AnormalGroupName { get; set; }
        /// <summary>
        /// 域
        /// </summary>
        public string AnormalContract { get; set; }

        public decimal ExpirationTime { get; set; }
    }
}
