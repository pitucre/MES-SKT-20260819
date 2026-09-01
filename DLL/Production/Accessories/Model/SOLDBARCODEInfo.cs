using System;

namespace SKT.LeanMES.Accessories.Model
{
    [Serializable]
    public class SOLDBARCODEInfo
    {
        private Int32 iD;
        private String bARCODE;
        private DateTime cREATEDTIME;
        private DateTime eXPIREDDATE;
        private String cUR_STATUS;
        private String lEADFREE;
        private Int32 partID;
        private Int32 sOLD_TYPE;
        private Int32 qUANTITY;
        private String itemName;
        private String soldType;




        /// <summary>
        /// 初始化 SKT.MES.Model.SOLDBARCODEInfo 类的新实例。
        /// </summary>
        public SOLDBARCODEInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.SOLDBARCODEInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="bARCODE">条码编号</param>
        /// <param name="cREATEDTIME">创建时间</param>
        /// <param name="eXPIREDDATE">过期日期</param>
        /// <param name="cUR_STATUS">当前状态：登记,解冻,报废,开封使用</param>
        /// <param name="lEADFREE">保留字段</param>
        /// <param name="pN">料号</param>
        /// <param name="sOLD_TYPE">类型：1-锡膏；2-红胶</param>
        /// <param name="qUANTITY">数量</param>
        public SOLDBARCODEInfo(Int32 iD, String bARCODE, DateTime cREATEDTIME, DateTime eXPIREDDATE,
            String cUR_STATUS, String itemName, String soldType, Int32 qUANTITY)
        {
            this.iD = iD;
            this.bARCODE = bARCODE;
            this.cREATEDTIME = cREATEDTIME;
            this.eXPIREDDATE = eXPIREDDATE;
            this.cUR_STATUS = cUR_STATUS;
            this.itemName = itemName;
            this.soldType = soldType;
            this.qUANTITY = qUANTITY;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置条码编号
        /// </summary>
        public String BARCODE
        {
            get { return this.bARCODE; }
            set { this.bARCODE = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CREATEDTIME
        {
            get { return this.cREATEDTIME; }
            set { this.cREATEDTIME = value; }
        }

        /// <summary>
        /// 获取或设置过期日期
        /// </summary>
        public DateTime EXPIREDDATE
        {
            get { return this.eXPIREDDATE; }
            set { this.eXPIREDDATE = value; }
        }

        /// <summary>
        /// 获取或设置当前状态：登记,解冻,报废,开封使用
        /// </summary>
        public String CUR_STATUS
        {
            get { return this.cUR_STATUS; }
            set { this.cUR_STATUS = value; }
        }

        /// <summary>
        /// 获取或设置保留字段
        /// </summary>
        public String LEADFREE
        {
            get { return this.lEADFREE; }
            set { this.lEADFREE = value; }
        }
        /// <summary>
        /// 获取或设置料号
        /// </summary>
        public Int32 PartID
        {
            get { return partID; }
            set { partID = value; }
        }
        /// <summary>
        /// 料号名称
        /// </summary>
        public String ItemName
        {
            get { return itemName; }
            set { itemName = value; }
        }
        /// <summary>
        /// 获取或设置类型：1-锡膏；2-红胶
        /// </summary>
        public Int32 SOLD_TYPE
        {
            get { return this.sOLD_TYPE; }
            set { this.sOLD_TYPE = value; }
        }
        /// <summary>
        /// 获取或设置类型：1-锡膏；2-红胶
        /// </summary>
        public String SoldType
        {
            get { return soldType; }
            set { soldType = value; }
        }
        /// <summary>
        /// 获取或设置数量
        /// </summary>
        public Int32 QUANTITY
        {
            get { return this.qUANTITY; }
            set { this.qUANTITY = value; }
        }
    }
}