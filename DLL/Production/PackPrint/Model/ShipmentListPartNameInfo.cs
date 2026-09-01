using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.PackPrint.Model
{
    [Serializable]
    public class ShipmentListPartNameInfo
    {
        private Int32 partNameId;  //自增
        private string partName;//部件名称
        private Int32 partSeq;//排序
        //固定
        private string remark;//备注
        private DateTime modifyDateTime;//修改时间
        private string modifyby;//修改人
        private DateTime createDateTime;//创建时间
        private string createBy;//创建人
        public ShipmentListPartNameInfo()
        {
        }
        /// <summary>
        ///  初始化 SKT.LeanMES.PackPrint.Model.ShipmentListPartNameInfo 类的新实例。
        /// </summary>
        /// <param name="nCID"></param>
        /// <param name="nCPhenomenName"></param>
        /// <param name="dataType"></param>
        /// <param name="remark"></param>
        /// <param name="nCPhenomenNum"></param>
        /// <param name="ModifyDateTime"></param>
        /// <param name="modifyby"></param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        public ShipmentListPartNameInfo(Int32 partNameId, string partName, Int32 partSeq, string remark, DateTime ModifyDateTime,
           string modifyby, DateTime createDateTime, string createBy)
        {
            this.PartNameId = partNameId;
            this.PartName = partName;
            this.PartSeq = partSeq;
            this.remark = remark;
            this.ModifyDateTime = ModifyDateTime;
            this.modifyby = modifyby;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }
        /// <summary>
        /// 自增
        /// </summary>
        public Int32 PartNameId
        {
            get { return partNameId; }
            set { partNameId = value; }
        }
        /// <summary>
        /// 部件名称
        /// </summary>
        public string PartName
        {
            get { return partName; }
            set { partName = value; }
        }
        /// <summary>
        /// 排序
        /// </summary>
        public Int32 PartSeq
        {
            get { return partSeq; }
            set { partSeq = value; }
        }
        /// <summary>
        /// 备注
        /// </summary>
        public string Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
        /// <summary>
        /// 修改人
        /// </summary>
        public string Modifyby
        {
            get { return this.modifyby; }
            set { this.modifyby = value; }
        }
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }
        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }
    }
}
