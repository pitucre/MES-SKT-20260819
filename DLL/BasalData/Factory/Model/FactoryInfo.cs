using System;

namespace SKT.LeanMES.Factory.Model
{
    [Serializable]
    public class FactoryInfo
    {
        private Int32 factoryID;
        private String factoryName;
        private String factoryCode;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private Int32 chkIsDefaultFactory;
        private String isDefaultFactory;
      
        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.FactoryInfo 类的新实例。
        /// </summary>
        public FactoryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.FactoryInfo 类的新实例。
        /// </summary>
        /// <param name="factoryID"></param>
        /// <param name="factoryName"></param>
        /// <param name="factoryCode"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public FactoryInfo(Int32 factoryID, String factoryName, String factoryCode, String createBy, 
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark,Int32 chkIsDefaultFactory)
        {
            this.factoryID = factoryID;
            this.factoryName = factoryName;
            this.factoryCode = factoryCode;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.chkIsDefaultFactory = chkIsDefaultFactory;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 FactoryID
        {
            get { return this.factoryID; }
            set { this.factoryID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FactoryName
        {
            get { return this.factoryName; }
            set { this.factoryName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FactoryCode
        {
            get { return this.factoryCode; }
            set { this.factoryCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
        private Int32 typeId;
        /// <summary>
        /// 类型ID  1=工厂 2=公司
        /// </summary>
        public Int32 TypeId
        {
            get { return this.typeId; }
            set { this.typeId = value; }
        }

        /// <summary>
        /// 是否为首选工厂 add by zhi.li
        /// </summary>
        public Int32 ChkIsDefaultFactory
        {
            get
            {
                return chkIsDefaultFactory;
            }

            set
            {
                chkIsDefaultFactory = value;
            }
        }


        /// <summary>
        /// 是否首选工厂：1是  2否
        /// </summary>
        public string IsDefaultFactory
        {
            get
            {
                return isDefaultFactory;
            }

            set
            {
                isDefaultFactory = value;
            }
        }


    }
}