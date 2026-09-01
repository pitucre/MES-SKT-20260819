using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.MSD.Model
{
    [Serializable]
    public class MsdOperationInfo
    {
        public MsdOperationInfo() { }




        /// <summary>
        /// 操作Id
        /// </summary>
        public int Oid { get; set; }

        /// <summary>
        /// 物料编号
        /// </summary>
        public string SerialNumber { get; set; }


        /// <summary>
        /// 产品编号
        /// </summary>
        public string ItemCode { get; set; }


        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }

        /// <summary>
        /// 产品规格
        /// </summary>
        public string ItemSpec { get; set; }


        /// <summary>
        /// 操作动作
        /// </summary>
        public string OperateDes { get; set; }

        /// <summary>
        /// 操作时间
        /// </summary>
        public DateTime OperateTime { get; set; }

        /// <summary>
        /// 烘箱编号
        /// </summary>
        public string ContainerCode { get; set; }

        /// <summary>
        /// 烘箱名称
        /// </summary>
        public string ContainerName { get; set; }
        
        /// <summary>
        /// 操作人
        /// </summary>
        public string OperateUser { get; set; }
        
        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

    }
}
