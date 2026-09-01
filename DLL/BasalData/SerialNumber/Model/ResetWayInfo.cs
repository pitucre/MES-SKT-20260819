using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SerialNumber.Model
{
    [Serializable]
    public class ResetWayInfo
    {
        private Int32 resetWayId;
        private String resetWay;
        private Boolean isSystemResetWay;
        private String resetWayDesc;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        public string RelationFunc { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ResetWayInfo 类的新实例。
        /// </summary>
        public ResetWayInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ResetWayInfo 类的新实例。
        /// </summary>
        /// <param name="resetWayId">复位方式ID</param>
        /// <param name="resetWay">复位方式</param>
        /// <param name="isSystemResetWay">是否系统内置复位方式</param>
        /// <param name="resetWayDesc">复位方式描述</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public ResetWayInfo(Int32 resetWayId, String resetWay, Boolean isSystemResetWay, String resetWayDesc,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.resetWayId = resetWayId;
            this.resetWay = resetWay;
            this.isSystemResetWay = isSystemResetWay;
            this.resetWayDesc = resetWayDesc;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置复位方式ID
        /// </summary>
        public Int32 ResetWayId
        {
            get { return this.resetWayId; }
            set { this.resetWayId = value; }
        }

        /// <summary>
        /// 获取或设置复位方式
        /// </summary>
        public String ResetWay
        {
            get { return this.resetWay; }
            set { this.resetWay = value; }
        }

        /// <summary>
        /// 获取或设置是否系统内置复位方式
        /// </summary>
        public Boolean IsSystemResetWay
        {
            get { return this.isSystemResetWay; }
            set { this.isSystemResetWay = value; }
        }

        /// <summary>
        /// 获取或设置复位方式描述
        /// </summary>
        public String ResetWayDesc
        {
            get { return this.resetWayDesc; }
            set { this.resetWayDesc = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}
