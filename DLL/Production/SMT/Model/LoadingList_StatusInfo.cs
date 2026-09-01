using System;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class LIST_StatusInfo
    {
        private Int32 id;
        private String description;

        /// <summary>
        /// 初始化 SKT.MES.Model.LIST_StatusInfo 类的新实例。
        /// </summary>
        public LIST_StatusInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.LIST_StatusInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="description"></param>
        public LIST_StatusInfo(Int32 id, String description)
        {
            this.id = id;
            this.description = description;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Id
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }
    }
}