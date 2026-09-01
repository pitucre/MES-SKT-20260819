using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.ERP
{
    /// <summary>
    /// E智联 接收输出参数
    /// </summary>
    public class ESIPBean
    {
        /// <summary>
        /// 创建人
        /// </summary>
        public string creator { get; set; }

        /// <summary>
        /// 服务名称
        /// </summary>
        public string sName { get; set; }

        /// <summary>
        /// 服务类型：1001同步，2001异步有序，2002异步无序
        /// </summary>
        public int sType { get; set; }

        /// <summary>
        /// 当服务为异步有序模式时，该业务描述将作为服务的分类说明
        /// </summary>
        public string group { get; set; }

        /// <summary>
        /// 业务描述
        /// </summary>
        public string bDesc { get; set; }

        /// <summary>
        /// 节点用于执行的json格式数据
        /// </summary>
        public dynamic data { get; set; }
        //public string data { get; set; }

        /// <summary>
        /// 是否是大文件，0普通数据，1大文件，不填默认0
        /// </summary>
        public int dFlag { get; set; }

        /// <summary>
        /// 业务系统自己设置值的备用字段
        /// </summary>
        public string remark { get; set; }


    }
}
