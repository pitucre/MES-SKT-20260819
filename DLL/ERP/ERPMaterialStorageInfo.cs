using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ERP
{

    /// <summary>
    /// 物料入库回写ERP实体
    /// </summary>
    public class ERPMaterialStorageInfo
    {
        /// <summary>
        /// 
        /// </summary>
        public string Token { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public Login login { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public Head head { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public List<BodyItem> body { get; set; }
    }

    public class Head
    {
        /// <summary>
        /// 
        /// </summary>
        public string cvencode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string dnmaketime { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cmaker { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string bcalculationmode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string bauditmode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cordercode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cwhcode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ddate { get; set; }

        /// <summary>
        /// 税率
        /// </summary>
        public string itaxrate { get; set; }
    }

    public class BodyItem
    {
        /// <summary>
        /// 
        /// </summary>
        public string cinvcode { get; set; }
        /// <summary>
        /// 压块
        /// </summary>
        public string cinvname { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string iquantity { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string iposid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cpoid { get; set; }

        public string iunitprice { get; set; }

        public string ioritaxcost { get; set; }
    }


    #region Old
    ///// <summary>
    ///// 物料入库回写ERP实体
    ///// </summary>
    //public class ERPMaterialStorageInfo
    //{
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string ccode { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string ddate { get; set; }
    //    /// <summary>
    //    /// 普通采购
    //    /// </summary>
    //    public string cbustype { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string cmaker { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string iexchrate { get; set; }
    //    /// <summary>
    //    /// 人民币
    //    /// </summary>
    //    public string cexch_name { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string cvencode { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string cvouchtype { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string cwhcode { get; set; }
    //    /// <summary>
    //    /// 采购订单
    //    /// </summary>
    //    public string csource { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string cordercode { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string ipurorderid { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string cptcode { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string cpersoncode { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public List<ERPMaterialStorageDetailInfo> body { get; set; }
    //}

    //public class ERPMaterialStorageDetailInfo
    //{
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string cinvcode { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string cinvm_unit { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string iquantity { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string editprop { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string irowno { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string iunitcost { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string iposid { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string cassunit { get; set; }
    //    /// <summary>
    //    /// 
    //    /// </summary>
    //    public string cpoid { get; set; }
    //} 
    #endregion
}
