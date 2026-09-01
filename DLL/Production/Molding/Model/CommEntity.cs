using System;
namespace SKT.LeanMES.Molding.Model
{
    /// <summary>
    /// Des:公共实体类
    /// Author:Hanson.Lei
    /// Date:2017.8.14
    /// </summary>
    public class CommEntity
    {
        /// <summary>
        /// 创建人(ID)
        /// </summary>
        public int CreateBy { get; set; }

        /// <summary>
        /// 创建人(用户名)
        /// </summary>
        public string CreateByName { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 修改人(ID)
        /// </summary>
        public int ModifyBy { get; set; }

        /// <summary>
        /// 修改人(用户名)
        /// </summary>
        public string ModifyByName { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime ModifyTime { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }
    }
}
