using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Kanban.Model
{
    [Serializable]
    public class KanBanCarouselConfigDetailInfo
    {

        /// <summary>
        /// 看板轮播配置明细表Id
        /// </summary>
        public int CarouselConfigDetailId { get; set; }

        /// <summary>
        /// 看板轮播配置信息表Id（KanBan_CarouselConfig）
        /// </summary>
        public int? CarouselConfigId { get; set; }

        /// <summary>
        /// 看板名称
        /// </summary>
        public string KanBanName { get; set; }

        /// <summary>
        /// 看板URL
        /// </summary>
        public string KanBanURL { get; set; }

        /// <summary>
        /// 顺序
        /// </summary>
        public int? Sequence { get; set; }

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


        /// <summary>
        /// 轮播时间
        /// </summary>
        public int CarouselTime { get; set; }
    }

}
