using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentFileManageInfo
    {
        private Int32 equipmentFileManageId;
        private String eqCode;
        private String fileName;
        private String createBy;
        private DateTime createDateTime;
        private String reserve;
        private String reserve1;
        private String reserve2;

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentFileManageInfo 类的新实例。
        /// </summary>
        public EquipmentFileManageInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentFileManageInfo 类的新实例。
        /// </summary>
        /// <param name="equipmentFileManageId"></param>
        /// <param name="eqCode"></param>
        /// <param name="fileName"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="reserve"></param>
        /// <param name="reserve1"></param>
        /// <param name="reserve2"></param>
        public EquipmentFileManageInfo(Int32 equipmentFileManageId, String eqCode, String fileName, String createBy, 
            DateTime createDateTime, String reserve, String reserve1, String reserve2)
        {
            this.equipmentFileManageId = equipmentFileManageId;
            this.eqCode = eqCode;
            this.fileName = fileName;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.reserve = reserve;
            this.reserve1 = reserve1;
            this.reserve2 = reserve2;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EquipmentFileManageId
        {
            get { return this.equipmentFileManageId; }
            set { this.equipmentFileManageId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String EqCode
        {
            get { return this.eqCode; }
            set { this.eqCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FileName
        {
            get { return this.fileName; }
            set { this.fileName = value; }
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
        public String Reserve
        {
            get { return this.reserve; }
            set { this.reserve = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Reserve1
        {
            get { return this.reserve1; }
            set { this.reserve1 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Reserve2
        {
            get { return this.reserve2; }
            set { this.reserve2 = value; }
        }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }
    }
}