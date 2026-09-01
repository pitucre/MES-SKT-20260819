using System;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class FeederTypeInfo
    {
        private Int32 iD;
        private String name;
        private String description;
        private Int32 size;
        private Int32 pitch;
        private Int32 attrition;
        private DateTime createDateTime;
        private String createBy;
        private DateTime modifyDateTime;
        private String modifyBy;

        /// <summary>
        /// 初始化 SKT.MES.SMT.Model.FEEDERTYPEInfo 类的新实例。
        /// </summary>
        public FeederTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.SMT.Model.FEEDERTYPEInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="name">类型名称</param>
        /// <param name="description">类型描述</param>
        /// <param name="size">尺寸</param>
        /// <param name="pitch"></param>
        /// <param name="attrition">消耗量</param>
        public FeederTypeInfo(Int32 iD, String name, String description, Int32 size, 
            Int32 pitch, Int32 attrition)
        {
            this.iD = iD;
            this.name = name;
            this.description = description;
            this.size = size;
            this.pitch = pitch;
            this.attrition = attrition;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置类型名称
        /// </summary>
        public String Name
        {
            get { return this.name; }
            set { this.name = value; }
        }

        /// <summary>
        /// 获取或设置类型描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置尺寸
        /// </summary>
        public Int32 Size
        {
            get { return this.size; }
            set { this.size = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Pitch
        {
            get { return this.pitch; }
            set { this.pitch = value; }
        }

        /// <summary>
        /// 获取或设置消耗量
        /// </summary>
        public Int32 Attrition
        {
            get { return this.attrition; }
            set { this.attrition = value; }
        }

        public DateTime CreateDateTime
        {
            get
            {
                return createDateTime;
            }

            set
            {
                createDateTime = value;
            }
        }

        public string CreateBy
        {
            get
            {
                return createBy;
            }

            set
            {
                createBy = value;
            }
        }

        public DateTime ModifyDateTime
        {
            get
            {
                return modifyDateTime;
            }

            set
            {
                modifyDateTime = value;
            }
        }

        public string ModifyBy
        {
            get
            {
                return modifyBy;
            }

            set
            {
                modifyBy = value;
            }
        }
    }
}
