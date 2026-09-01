using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Kanban.Model
{
    public class EquipmentStatusInfo
    {
        private Int32 equipmentId;
        private String equipmentCode;
        private String equipmentName;
        private Int32 equipmentTypeId;
        private String equipmentTypeName;
        private String equipmentModel;
        private String produceDate;
        private Int32 status;
        private String statusDesc;
        private Int32 lineId;
        private String lineName;
        private Int32 stationId;
        private String stationName;
        private String factoryDate;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 设备类型名称
        /// </summary>
        public String EquipmentTypeName
        {
            get { return this.equipmentTypeName; }
            set { this.equipmentTypeName = value; }
        }

        /// <summary>
        /// 状态描述
        /// </summary>
        public String StatusDesc
        {
            get { return this.statusDesc; }
            set { this.statusDesc = value; }
        }

        /// <summary>
        /// 产线名
        /// </summary>
        public String LineName
        {
            get { return this.lineName; }
            set { this.lineName = value; }
        }

        /// <summary>
        /// 工位名
        /// </summary>
        public String StationName
        {
            get { return this.stationName; }
            set { this.stationName = value; }
        }        
       
        /// <summary>
        /// 获取或设置 设备id
        /// </summary>
        public Int32 EquipmentId
        {
            get { return this.equipmentId; }
            set { this.equipmentId = value; }
        }

        /// <summary>
        /// 获取或设置设备编码
        /// </summary>
        public String EquipmentCode
        {
            get { return this.equipmentCode; }
            set { this.equipmentCode = value; }
        }

        /// <summary>
        /// 获取或设置设备名称
        /// </summary>
        public String EquipmentName
        {
            get { return this.equipmentName; }
            set { this.equipmentName = value; }
        }

        /// <summary>
        /// 获取或设置设备类型ID
        /// </summary>
        public Int32 EquipmentTypeId
        {
            get { return this.equipmentTypeId; }
            set { this.equipmentTypeId = value; }
        }

        /// <summary>
        /// 获取或设置设备型号
        /// </summary>
        public String EquipmentModel
        {
            get { return this.equipmentModel; }
            set { this.equipmentModel = value; }
        }

        /// <summary>
        /// 获取或设置设备生产日期
        /// </summary>
        public String ProduceDate
        {
            get { return this.produceDate; }
            set { this.produceDate = value; }
        }

        /// <summary>
        /// 获取或设置设备状态 标识
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
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
        /// 获取或设置站位ID
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置入厂日期。
        /// </summary>
        public String FactoryDate
        {
            get { return this.factoryDate; }
            set { this.factoryDate = value; }
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


        /// <summary>
        /// 初始化 SKT.MES.Model.EQUIPMENTInfo 类的新实例。
        /// </summary>
        public EquipmentStatusInfo()
        {
        }


        /// <summary>
        /// 初始化 SKT.MES.Model.EQUIPMENTInfo 类的新实例。  生成的默认构造
        /// </summary>
        /// <param name="eQPTID"></param>
        /// <param name="eQPTCode">设备编码</param>
        /// <param name="eQPTName">设备名称</param>
        /// <param name="eQPTTypeID">设备类型ID</param>
        /// <param name="eQPTModel">设备型号</param>
        /// <param name="produceDate">生产设备日期</param>
        /// <param name="status">设备状态</param>
        /// <param name="lineID">线别ID</param>
        /// <param name="stationID">站位ID</param>
        /// <param name="factoryDate">入厂日期。</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public EquipmentStatusInfo(Int32 eQPTID, String eQPTCode, String eQPTName, Int32 eQPTTypeID,
            String eQPTModel, Int32 status, Int32 lineID, Int32 stationID,String lineName,String stationName,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime,
            String remark)
        {
            this.equipmentId = eQPTID;
            this.equipmentCode = eQPTCode;
            this.equipmentName = eQPTName;
            this.equipmentTypeId = eQPTTypeID;
            this.equipmentModel = eQPTModel;
            this.status = status;
            this.lineId = lineID;
            this.lineName = lineName; 
            this.stationId = stationID;
            this.stationName = stationName;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }


        /// <summary>
        /// 初始化 SKT.MES.Model.EQUIPMENTInfo 类的新实例。          构造将关联ID，转换成描述的实例。
        /// </summary>
        /// <param name="eQPTID"></param>
        /// <param name="eQPTCode">设备编码</param>
        /// <param name="eQPTName">设备名称</param>
        /// <param name="eQPTTypeIDStr">设备类型描述</param>
        /// <param name="eQPTModel">设备型号</param>
        /// <param name="produceDate">生产设备日期</param>
        /// <param name="statusStr">设备状态描述</param>
        /// <param name="lineIDStr">线别ID</param>
        ///<param name="lineNameStr">线别名称</param>
        /// <param name="stationIDStr">站位描述</param>
        /// <param name="factoryDate">入厂日期。</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public EquipmentStatusInfo(Int32 eQPTID, String eQPTCode, String eQPTName, String eQptTypeIDStr,
         String eQPTModel, String statusStr, String lineNameStr, String stationNameStr,
          String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime,
         String remark)
        {
            this.equipmentId = eQPTID;
            this.equipmentCode = eQPTCode;
            this.equipmentName = eQPTName;
            this.equipmentTypeName = eQptTypeIDStr;
            this.equipmentModel = eQPTModel;
            this.statusDesc = statusStr; 
            this.lineName = lineNameStr;
            this.stationName = stationNameStr;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }
    }
}
