using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class PrepareToOtherInfo
    {
        private Int32 rID;
        private Int32 prepareId;
        private String prepareDesc;
        private Int32 enableFlag;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        public string Remark { set; get; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Material.Model.PrepareToOtherInfo 类的新实例。
        /// </summary>
        public PrepareToOtherInfo()
        {

        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Material.Model.PrepareToOtherInfo 类的新实例。
        /// </summary>
        /// <param name="rID"></param>
        /// <param name="prepareId">-1</param>
        /// <param name="prepareDesc">''</param>
        /// <param name="enableFlag">是否启用</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public PrepareToOtherInfo(Int32 rID, Int32 prepareId, String prepareDesc, Int32 enableFlag,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.rID = rID;
            this.prepareId = prepareId;
            this.prepareDesc = prepareDesc;
            this.enableFlag = enableFlag;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 RID
        {
            get { return this.rID; }
            set { this.rID = value; }
        }

        /// <summary>
        /// 获取或设置-1
        /// </summary>
        public Int32 PrepareId
        {
            get { return this.prepareId; }
            set { this.prepareId = value; }
        }

        /// <summary>
        /// 获取或设置''
        /// </summary>
        public String PrepareDesc
        {
            get { return this.prepareDesc; }
            set { this.prepareDesc = value; }
        }

        /// <summary>
        /// 获取或设置是否启用
        /// </summary>
        public Int32 EnableFlag
        {
            get { return this.enableFlag; }
            set { this.enableFlag = value; }
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
    }
}
