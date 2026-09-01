using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class PrepareMatFormMemberInfo
    {
        private int pMAutoID;//	子表ID

        public int PMAutoID
        {
            get { return pMAutoID; }
            set { pMAutoID = value; }
        }
        private int pMID;//	主表ID

        public int PMID
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
        private int state;//	状态：0开立（预留），状态：1未备料，2备料中，3已发料，4已接收、9完结

        public int State
        {
            get { return state; }
            set { state = value; }
        }
        private int itemID;//	产品ID

        public int ItemID
        {
            get { return itemID; }
            set { itemID = value; }
        }
        private string itemCode;//	产品编号

        public string ItemCode
        {
            get { return itemCode; }
            set { itemCode = value; }
        }
        private string itemName;//	产品名称

        public string ItemName
        {
            get { return itemName; }
            set { itemName = value; }
        }
        private string uOM;//	单位

        public string UOM
        {
            get { return uOM; }
            set { uOM = value; }
        }
        private int whID;//	仓库ID

        public int WhID
        {
            get { return whID; }
            set { whID = value; }
        }
        private string whCode;//	仓位编号

        public string WhCode
        {
            get { return whCode; }
            set { whCode = value; }
        }
        private string whName;//    仓位名称

        public string WhName
        {
            get { return whName; }
            set { whName = value; }
        }
        private int posID;//	货位ID

        public int PosID
        {
            get { return posID; }
            set { posID = value; }
        }
        private string posCode;//	货位编号

        public string PosCode
        {
            get { return posCode; }
            set { posCode = value; }
        }
        private string batch;//	批号关联来源单或自动生成批次号（产品档是批次管理）

        public string Batch
        {
            get { return batch; }
            set { batch = value; }
        }
        private int sourceType;//	来源单类型 

        public int SourceType
        {
            get { return sourceType; }
            set { sourceType = value; }
        }
        private int sourceID;//	来源单主表ID

        public int SourceID
        {
            get { return sourceID; }
            set { sourceID = value; }
        }
        private string sourceCode;//	来源单号

        public string SourceCode
        {
            get { return sourceCode; }
            set { sourceCode = value; }
        }
        private int sourceLine;//	来源单子表ID或行号

        public int SourceLine
        {
            get { return sourceLine; }
            set { sourceLine = value; }
        }
        private int sourceQty;//	来源单数量

        public int SourceQty
        {
            get { return sourceQty; }
            set { sourceQty = value; }
        }
        private int qty;	//领料申请数量 

        public int Qty
        {
            get { return qty; }
            set { qty = value; }
        }
        private int sumStockQty;	//累计备料数量

        public int SumStockQty
        {
            get { return sumStockQty; }
            set { sumStockQty = value; }
        }
        private int sumActiQuantity;//	累计发料数量

        public int SumActiQuantity
        {
            get { return sumActiQuantity; }
            set { sumActiQuantity = value; }
        }
        private string wherson;//	仓库员 

        public string Wherson
        {
            get { return wherson; }
            set { wherson = value; }
        }
        private int isGRN;//	是否扫描条码(默认‘1’,如可以不扫描出库为‘0’)

        public int IsGRN
        {
            get { return isGRN; }
            set { isGRN = value; }
        }
        private int isIN;//	是否已出库(默认‘0’,扫描条码出库后更新为‘1’)

        public int IsIN
        {
            get { return isIN; }
            set { isIN = value; }
        }
        private int isERP;//	是否已回写ERP(默认‘0’,成功回写ERP后更新为‘1’)

        public int IsERP
        {
            get { return isERP; }
            set { isERP = value; }
        }
        private float scrap;//	损耗率(%)

        public float Scrap
        {
            get { return scrap; }
            set { scrap = value; }
        }
        private int auxQtyLoss;//	损耗数量

        public int AuxQtyLoss
        {
            get { return auxQtyLoss; }
            set { auxQtyLoss = value; }
        }
        private int auxQtySupply;//	补料数量

        public int AuxQtySupply
        {
            get { return auxQtySupply; }
            set { auxQtySupply = value; }
        }
        private int discardAuxQty;//	报废数量

        public int DiscardAuxQty
        {
            get { return discardAuxQty; }
            set { discardAuxQty = value; }
        }
        private int machinePos;//	工位

        public int MachinePos
        {
            get { return machinePos; }
            set { machinePos = value; }
        }
        private int operID;//	工序ID

        public int OperID
        {
            get { return operID; }
            set { operID = value; }
        }
        private string operSN;//	工序号

        public string OperSN
        {
            get { return operSN; }
            set { operSN = value; }
        }
        private string pOCode;//	采购订单号

        public string POCode
        {
            get { return pOCode; }
            set { pOCode = value; }
        }
        private int venID;//	供应商ID

        public int VenID
        {
            get { return venID; }
            set { venID = value; }
        }
        private string venCode;//	供应商编码

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
        private int cusID;//	客户ID

        public int CusID
        {
            get { return cusID; }
            set { cusID = value; }
        }
        private string cusCode;//	客户编码

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
        private string remarkS;//	备注

        public string RemarkS
        {
            get { return remarkS; }
            set { remarkS = value; }
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
        private DateTime unApprovedDateTime;//	弃审时间

        public DateTime UnApprovedDateTime
        {
            get { return unApprovedDateTime; }
            set { unApprovedDateTime = value; }
        }
    }
}
