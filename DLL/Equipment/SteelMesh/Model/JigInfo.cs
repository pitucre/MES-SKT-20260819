using System;

namespace SKT.LeanMES.Jig.Model
{
    [Serializable]
    public class JigInfo
    {
        private Int32 jigId;
        private String jigName;
        private String jigNickName;
        private String jigCode;
        private Int32 jigType;
        private Int32 itemId;
        private Int32 vendorId;
        private String position;
        private Int32 standarLive;
        private Int32 standarMaint;
        private Int32 useCount;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private String itemCode;
        private String itemName;
        private String vendorCode;
        private String vendorName;
        private String typeName;

        public String CurPosition{get; set;}
        public Int32 JigStatus { get; set; }
        public Int32 InOrOut { get; set; }
        public Int32 WarningTime { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.JigInfo 类的新实例。
        /// </summary>
        public JigInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.JigInfo 类的新实例。
        /// </summary>
        /// <param name="jigId">主键id</param>
        /// <param name="jigName">工装夹具名称</param>
        /// <param name="jigNickName">工装夹具别名</param>
        /// <param name="jigType">类别</param>
        /// <param name="itemId">对应产品编号</param>
        /// <param name="vendorId">供应商编号</param>
        /// <param name="position">存放位置</param>
        /// <param name="standarLive">标准寿命</param>
        /// <param name="standarMaint">保养标准</param>
        /// <param name="useCount">已使用次数</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public JigInfo(Int32 jigId, String jigName, String jigNickName,String jigCode, Int32 jigType, 
            Int32 itemId, Int32 vendorId, String position, Int32 standarLive, Int32 standarMaint, 
            Int32 useCount, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime,
            String remark)
        {
            this.jigId = jigId;
            this.jigName = jigName;
            this.jigNickName = jigNickName;
            this.jigCode = jigCode;
            this.jigType = jigType;
            this.itemId = itemId;
            this.vendorId = vendorId;
            this.position = position;
            this.standarLive = standarLive;
            this.standarMaint = standarMaint;
            this.useCount = useCount;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }
        public JigInfo(Int32 jigId, String jigName, String jigNickName, String jigCode, Int32 jigType,
           Int32 itemId, Int32 vendorId, String position, Int32 standarLive, Int32 standarMaint,
           Int32 useCount, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime,
           String remark, String itemCode, String itemName, String vendorCode, String vendorName, String typeName)
        {
            this.jigId = jigId;
            this.jigName = jigName;
            this.jigNickName = jigNickName;
            this.jigCode = jigCode;
            this.jigType = jigType;
            this.itemId = itemId;
            this.vendorId = vendorId;
            this.position = position;
            this.standarLive = standarLive;
            this.standarMaint = standarMaint;
            this.useCount = useCount;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;

            this.itemCode = itemCode;
            this.itemName = itemName;
            this.vendorCode = vendorCode;
            this.vendorName = vendorName;
            this.typeName = typeName;
        }
        #region
        /// <summary>
        /// 获取或设置主键id
        /// </summary>
        public Int32 JigId
        {
            get { return this.jigId; }
            set { this.jigId = value; }
        }

        /// <summary>
        /// 获取或设置工装夹具名称
        /// </summary>
        public String JigName
        {
            get { return this.jigName; }
            set { this.jigName = value; }
        }

        /// <summary>
        /// 获取或设置工装夹具别名
        /// </summary>
        public String JigNickName
        {
            get { return this.jigNickName; }
            set { this.jigNickName = value; }
        }
        /// <summary>
        /// 获取或设置工装夹具编号
        /// </summary>
        public String JigCode
        {
            get { return this.jigCode; }
            set { this.jigCode = value; }
        }
        /// <summary>
        /// 获取或设置类别
        /// </summary>
        public Int32 JigType
        {
            get { return this.jigType; }
            set { this.jigType = value; }
        }

        /// <summary>
        /// 获取或设置对应产品编号
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置供应商编号
        /// </summary>
        public Int32 VendorId
        {
            get { return this.vendorId; }
            set { this.vendorId = value; }
        }

        /// <summary>
        /// 获取或设置存放位置
        /// </summary>
        public String Position
        {
            get { return this.position; }
            set { this.position = value; }
        }

        /// <summary>
        /// 获取或设置标准寿命
        /// </summary>
        public Int32 StandarLive
        {
            get { return this.standarLive; }
            set { this.standarLive = value; }
        }

        /// <summary>
        /// 获取或设置保养标准
        /// </summary>
        public Int32 StandarMaint
        {
            get { return this.standarMaint; }
            set { this.standarMaint = value; }
        }

        /// <summary>
        /// 获取或设置已使用次数
        /// </summary>
        public Int32 UseCount
        {
            get { return this.useCount; }
            set { this.useCount = value; }
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
        #endregion

        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }
        public String VendorCode
        {
            get { return this.vendorCode; }
            set { this.vendorCode = value; }
        }
        public String VendorName
        {
            get { return this.vendorName; }
            set { this.vendorName = value; }
        }
        public String TypeName
        {
            get { return this.typeName; }
            set { this.typeName = value; }
        }
    }
}