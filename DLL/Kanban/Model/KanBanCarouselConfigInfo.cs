using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Kanban.Model
{
    [Serializable]
    public class KanBanCarouselConfigInfo
    {

        /// <summary>
        /// 看板轮播配置Id
        /// </summary>
        public int CarouselConfigId { get; set; }

        /// <summary>
        /// 看板轮播配置名称
        /// </summary>
        public string CarouselName { get; set; }

        /// <summary>
        /// 看板轮播时间（秒）
        /// </summary>
        public int? CarouselTime { get; set; }

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
        /// 看板轮播配置Id集合
        /// </summary>
        public string CarouselConfigIds { get; set; }

    }

}
