using System;

namespace SKT.LeanMES.Container.Model
{
    [Serializable]
    public class FloorInfoInfo
    {
        private Int32 fid;
        private String code;
        private String name;
        private Int32 status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.FloorInfoInfo 类的新实例。
        /// </summary>
        public FloorInfoInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.FloorInfoInfo 类的新实例。
        /// </summary>
        /// <param name="fid">主键</param>
        /// <param name="code">代码</param>
        /// <param name="name">名称</param>
        /// <param name="status">状态</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public FloorInfoInfo(Int32 fid, String code, String name, Int32 status, 
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.fid = fid;
            this.code = code;
            this.name = name;
            this.status = status;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置主键
        /// </summary>
        public Int32 Fid
        {
            get { return this.fid; }
            set { this.fid = value; }
        }

        /// <summary>
        /// 获取或设置代码
        /// </summary>
        public String Code
        {
            get { return this.code; }
            set { this.code = value; }
        }

        /// <summary>
        /// 获取或设置名称
        /// </summary>
        public String Name
        {
            get { return this.name; }
            set { this.name = value; }
        }

        /// <summary>
        /// 获取或设置状态
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
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