using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Warning.Model
{
    [Serializable]
    public class WarningTypeInfo
    {
        private Int32 warningTypeId;
        private String warningTypeName;
        private Decimal warningTypeValue;
        private Int32 warningGroup;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.WarningTypeInfo 类的新实例。
        /// </summary>
        public WarningTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.WarningTypeInfo 类的新实例。
        /// </summary>
        /// <param name="warningTypeId">警报类型ID</param>
        /// <param name="warningTypeName">警报类型名称</param>
        /// <param name="warningTypeValue">警报类型值</param>
        /// <param name="warningGroup">警报分组：1 - 系统警报；2 - 生产警报；3 - 品质警报。</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public WarningTypeInfo(Int32 warningTypeId, String warningTypeName, Decimal warningTypeValue, Int32 warningGroup,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.warningTypeId = warningTypeId;
            this.warningTypeName = warningTypeName;
            this.warningTypeValue = warningTypeValue;
            this.warningGroup = warningGroup;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置警报类型ID
        /// </summary>
        public Int32 WarningTypeId
        {
            get { return this.warningTypeId; }
            set { this.warningTypeId = value; }
        }

        /// <summary>
        /// 获取或设置警报类型名称
        /// </summary>
        public String WarningTypeName
        {
            get { return this.warningTypeName; }
            set { this.warningTypeName = value; }
        }

        /// <summary>
        /// 获取或设置警报类型值
        /// </summary>
        public Decimal WarningTypeValue
        {
            get { return this.warningTypeValue; }
            set { this.warningTypeValue = value; }
        }

        /// <summary>
        /// 获取或设置警报分组：1 - 系统警报；2 - 生产警报；3 - 品质警报。
        /// </summary>
        public Int32 WarningGroup
        {
            get { return this.warningGroup; }
            set { this.warningGroup = value; }
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

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}
