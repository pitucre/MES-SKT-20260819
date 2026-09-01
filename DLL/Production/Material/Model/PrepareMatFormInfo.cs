using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class PrepareMatFormInfo
    {
        private Int64 pMID;//	主表ID

        public Int64 PMID
        {
            get { return pMID; }
            set { pMID = value; }
        }
        private string org;//	工厂编号(宇宙默认'1001209125678707')

        public string Org
        {
            get { return org; }
            set { org = value; }
        }
        private int pMType;//	类型

        public int PMType
        {
            get { return pMType; }
            set { pMType = value; }
        }
        private int state;//	状态

        public int State
        {
            get { return state; }
            set { state = value; }
        }
        private string pMCode;//	领料申请单号

        public string PMCode
        {
            get { return pMCode; }
            set { pMCode = value; }
        }
        private DateTime pMDate;//	日期

        public DateTime PMDate
        {
            get { return pMDate; }
            set { pMDate = value; }
        }
        private int mOType;//	生产订单类型

        public int MOType
        {
            get { return mOType; }
            set { mOType = value; }
        }
        private int mOID;//	生产订单ID

        public int MOID
        {
            get { return mOID; }
            set { mOID = value; }
        }
        private string mOCode;//	生产订单号

        public string MOCode
        {
            get { return mOCode; }
            set { mOCode = value; }
        }
        private string personCode;//	申请人员编号

        public string PersonCode
        {
            get { return personCode; }
            set { personCode = value; }
        }
        private string personName;//	申请人员名称

        public string PersonName
        {
            get { return personName; }
            set { personName = value; }
        }
        private string depCode;//	申请部门编号

        public string DepCode
        {
            get { return depCode; }
            set { depCode = value; }
        }
        private string depName;//	申请部门名称

        public string DepName
        {
            get { return depName; }
            set { depName = value; }
        }
        private int whID;//	仓库ID

        public int WhID
        {
            get { return whID; }
            set { whID = value; }
        }
        private string whCode;	//仓库编号

        public string WhCode
        {
            get { return whCode; }
            set { whCode = value; }
        }
        private string whName;	//仓库名称

        public string WhName
        {
            get { return whName; }
            set { whName = value; }
        }
        private string pOCode;//	采购订单号

        public string POCode
        {
            get { return pOCode; }
            set { pOCode = value; }
        }
        private int venID;	//供应商ID

        public int VenID
        {
            get { return venID; }
            set { venID = value; }
        }
        private string venCode;	//供应商编码

        public string VenCode
        {
            get { return venCode; }
            set { venCode = value; }
        }
        private string venName;//	供应商名称

        public string VenName
        {
            get { return venName; }
            set { venName = value; }
        }
        private string sOCode;//	销售订单号

        public string SOCode
        {
            get { return sOCode; }
            set { sOCode = value; }
        }
        private int cusID;	//客户ID

        public int CusID
        {
            get { return cusID; }
            set { cusID = value; }
        }
        private string cusCode;	//客户编码

        public string CusCode
        {
            get { return cusCode; }
            set { cusCode = value; }
        }
        private string cusName;//	客户名称

        public string CusName
        {
            get { return cusName; }
            set { cusName = value; }
        }
        private string default_1;//	预留字段

        public string Default_1
        {
            get { return default_1; }
            set { default_1 = value; }
        }
        private string default_2;//	预留字段

        public string Default_2
        {
            get { return default_2; }
            set { default_2 = value; }
        }
        private string default_3;//	预留字段

        public string Default_3
        {
            get { return default_3; }
            set { default_3 = value; }
        }
        private string default_4;//	预留字段

        public string Default_4
        {
            get { return default_4; }
            set { default_4 = value; }
        }
        private string default_5;//	预留字段

        public string Default_5
        {
            get { return default_5; }
            set { default_5 = value; }
        }
        private string default_6;//	预留字段

        public string Default_6
        {
            get { return default_6; }
            set { default_6 = value; }
        }
        private string default_7;//	预留字段

        public string Default_7
        {
            get { return default_7; }
            set { default_7 = value; }
        }
        private string default_8;//	预留字段

        public string Default_8
        {
            get { return default_8; }
            set { default_8 = value; }
        }
        private string default_9;//	预留字段

        public string Default_9
        {
            get { return default_9; }
            set { default_9 = value; }
        }
        private string default_10;//	预留字段

        public string Default_10
        {
            get { return default_10; }
            set { default_10 = value; }
        }
        private string remark;//	备注

        public string Remark
        {
            get { return remark; }
            set { remark = value; }
        }
        private string createBy;//	创建人

        public string CreateBy
        {
            get { return createBy; }
            set { createBy = value; }
        }
        private DateTime createDateTime;//	创建时间

        public DateTime CreateDateTime
        {
            get { return createDateTime; }
            set { createDateTime = value; }
        }
        private string modifyBy;//	修改人

        public string ModifyBy
        {
            get { return modifyBy; }
            set { modifyBy = value; }
        }
        private DateTime modifyDateTime;//	修改时间

        public DateTime ModifyDateTime
        {
            get { return modifyDateTime; }
            set { modifyDateTime = value; }
        }
        private string approvedBy;//	审核人

        public string ApprovedBy
        {
            get { return approvedBy; }
            set { approvedBy = value; }
        }
        private DateTime approvedDateTime;//	审核时间

        public DateTime ApprovedDateTime
        {
            get { return approvedDateTime; }
            set { approvedDateTime = value; }
        }
        private string unApprovedBy;//	弃审人

        public string UnApprovedBy
        {
            get { return unApprovedBy; }
            set { unApprovedBy = value; }
        }
        private DateTime unApprovedDateTime;//弃审时间        

        public DateTime UnApprovedDateTime
        {
            get { return unApprovedDateTime; }
            set { unApprovedDateTime = value; }
        }


        ///额外添加的字段
        private string statusName;
        public string StatusName
        {
            get { return statusName; }
            set { statusName = value; }
        }
        //物料编码
        private string itemCode;

        public string ItemCode
        {
            get { return itemCode; }
            set { itemCode = value; }
        }
        //物料名称
        private string itemName;

        public string ItemName
        {
            get { return itemName; }
            set { itemName = value; }
        }
        //
        private int sourceQty;

        public int SourceQty
        {
            get { return sourceQty; }
            set { sourceQty = value; }
        }
        //
        private int qty;

        public int Qty
        {
            get { return qty; }
            set { qty = value; }
        }
        private int modtlId;

        public int ModtlId
        {
            get { return modtlId; }
            set { modtlId = value; }
        }

        private int modtlNo;

        public int ModtlNo
        {
            get { return modtlNo; }
            set { modtlNo = value; }
        }

        private int itemId;

        public int ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }
    }
}
