using System;

namespace SKT.LeanMES.Accessories.Model
{
    [Serializable]
    public class LOGInfo
    {
        private Int32 iD;
        private String bARCODE;
        private DateTime cREATEDTIME;
        private Int32 uSERID;
        private String aCTION;
        private String pN;
        private String eXPIREDDATE;
        private string createTime;
        private string loginID;
        private DateTime useTime;
        private DateTime expireTime;
        private String cREATEDTIMEStr;

        private String useTimeStr;
        private String expireTimeStr;

        private Int32 minthaw;
        private Int32 maxvoid;
        private Int32 maxuse;

        /// <summary>
        /// 初始化 SKT.MES.Model.LOGInfo 类的新实例。
        /// </summary>
        public LOGInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.LOGInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="bARCODE">条码编号</param>
        /// <param name="cREATEDTIME">创建时间</param>
        /// <param name="uSERID">创建者</param>
        /// <param name="aCTION">行为</param>
        /// <param name="pN">料号</param>


        //private String eXPIREDDATE;
        //private string createTime;
        //private string loginID;
        //private DateTime useTime;
        //private DateTime expireTime;
        //private String cREATEDTIMEStr;

        //private String useTimeStr;
        //private String expireTimeStr;

        public LOGInfo(Int32 iD, String bARCODE, DateTime cREATEDTIME, Int32 uSERID,
            String aCTION, String pN)
        {
            this.iD = iD;
            this.bARCODE = bARCODE;
            this.cREATEDTIME = cREATEDTIME;
            this.uSERID = uSERID;
            this.aCTION = aCTION;
            this.pN = pN;
        }


        //BARCODE,PN,CREATEDTIME,UseTime,EXPIREDDATE

        public Int32 Minthaw
        {
            get { return this.minthaw; }
            set { this.minthaw = value; }
        }
        public Int32 Maxvoid
        {
            get { return this.maxvoid; }
            set { this.maxvoid = value; }
        }
        public Int32 Maxuse
        {
            get { return this.maxuse; }
            set { this.maxuse = value; }
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
        /// 获取或设置创建者
        /// </summary>
        public Int32 USERID
        {
            get { return this.uSERID; }
            set { this.uSERID = value; }
        }

        /// <summary>
        /// 获取或设置行为
        /// </summary>
        public String ACTION
        {
            get { return this.aCTION; }
            set { this.aCTION = value; }
        }

        /// <summary>
        /// 获取或设置料号
        /// </summary>
        public String PN
        {
            get { return this.pN; }
            set { this.pN = value; }
        }
        /// <summary>
        /// 过期时间
        /// </summary>
        public String EXPIREDDATE
        {
            get { return eXPIREDDATE; }
            set { eXPIREDDATE = value; }
        }
        /// <summary>
        /// 创建时间
        /// </summary>
        public string CreateTime
        {
            get { return createTime; }
            set { createTime = value; }
        }
        /// <summary>
        /// 用户名
        /// </summary>
        public string LoginID
        {
            get { return loginID; }
            set { loginID = value; }
        }
        /// <summary>
        /// 使用时间
        /// </summary>
        public DateTime UseTime
        {
            get { return useTime; }
            set { useTime = value; }
        }
        /// <summary>
        /// 有效期
        /// </summary>
        public DateTime ExpireTime
        {
            get { return expireTime; }
            set { expireTime = value; }
        }

        public String CREATEDTIMEStr
        {
            get { return cREATEDTIMEStr; }
            set { cREATEDTIMEStr = value; }
        }
        public String UseTimeStr
        {
            get { return useTimeStr; }
            set { useTimeStr = value; }
        }
        public String ExpireTimeStr
        {
            get { return expireTimeStr; }
            set { expireTimeStr = value; }
        }


    }
}