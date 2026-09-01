using System;

namespace SKT.LeanMES.Container.Model
{
    [Serializable]
    public class FloorLineInfoInfo
    {
        private Int32 fLId;
        private Int32 fid;
        private Int32 lineId;
        private Int32 status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.FloorLineInfoInfo 类的新实例。
        /// </summary>
        public FloorLineInfoInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.FloorLineInfoInfo 类的新实例。
        /// </summary>
        /// <param name="fLId">主键</param>
        /// <param name="fid">楼层ID</param>
        /// <param name="lineId">线别ID</param>
        /// <param name="status">状态</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public FloorLineInfoInfo(Int32 fLId, Int32 fid, Int32 lineId, Int32 status, 
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.fLId = fLId;
            this.fid = fid;
            this.lineId = lineId;
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
        public Int32 FLId
        {
            get { return this.fLId; }
            set { this.fLId = value; }
        }

        /// <summary>
        /// 获取或设置楼层ID
        /// </summary>
        public Int32 Fid
        {
            get { return this.fid; }
            set { this.fid = value; }
        }

        /// <summary>
        /// 获取或设置线别ID
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
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

        /// <summary>
        /// 楼层名
        /// </summary>
        public string FName { set; get; }
        /// <summary>
        /// 线别名
        /// </summary>
        public string LineName { set; get; }
    }
}