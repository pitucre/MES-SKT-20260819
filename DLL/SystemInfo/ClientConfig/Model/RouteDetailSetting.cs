using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ClientConfig.Model
{
    [Serializable]
    public class RouteDetailSetting
    {
        private int _R_ID;//路由ID
        private int _OpeID;//工序ID
        private string _ShowOpenLine;//显示开拉
        private string _ShowPrintCS;//显示打印客户SN
        private string _ShowPrintPack;//显示打印包装号
        private string _ShowUseElecScale;//显示使用电子称
        private string _ShowPrintPallet;//显示打印栈板
        private string _ShowRepairReceive;//显示不良接收
        //private string _ShowPrintSN;//显示打印包装SN
        private int _DefualtDeduct;//默认SMT扣料
        private int _DefualtOpenLine;//默认开拉
        private int _DefualtPrintCS;//默认打印客户SN
        private int _DefualtUseElecScale;//默认使用电子称
        private int _DefualtPrintPack;//默认打印包装号
        private int _DefualtPrintPallet;//默认打印栈板
        private int _DefualtRepairReceive;//默认不良接收
        private int _DefualtSteelCheck;//默认检查钢网
        private int _DefualtKnifeCheck;//默认刮刀检查
        private int _DefualtSplitPane;//默认解除拼板
        private int _DefualtPickDeduct;//默认手插扣料
        private int _DefualtInputStation;//是否投入站
        private int _DefualtOutputStation;//是否产出站
        private int _DefualtSMTAInputStation;//是否正面投入站
        private int _DefualtSMTAOutputStation;//是否正面产出站
        private int _DefualtSMTBInputStation;//是否背面投入站
        private int _DefualtSMTBOutputStation;//是否背面产出站
        //private int _DefualtPrintSN;//默认打印包装SN
        private int _DefualtPickOpenLine;//默认手插检查开拉
        private int _IfPrint;//是否打印
        public string GroupCode { get; set; }//手插扣料 扣料组编码
        /// <summary>
        /// OSP-双面焊接检查
        /// </summary>
        public string OSPWeldCheck { get; set; }
        /// <summary>
        /// OSP-开封至波峰焊检查
        /// </summary>
        public string OSPWaveSolderingCheck { get; set; }
        

        public RouteDetailSetting() { }

        public RouteDetailSetting(int r_ID,int opeID,string showOpenLine,string showPrintCS,string showPrintPack,string showUseElecScale,string showPrintPallet,string showRepairReceive,
            int defualtOpenLine, int defualtPrintCS,int defualtUseElecScale,int defualtPrintPack, int defualtPrintPallet , int defualtRepairReceive) //,string showPrintSN,int defualtPrintSN)
        {
            this._R_ID = r_ID;
            this._OpeID = opeID;
            this._ShowOpenLine = showOpenLine;
            this._ShowPrintCS = showPrintCS;
            this._ShowPrintPack = showPrintPack;
            this._ShowUseElecScale = showUseElecScale;
            this._ShowPrintPallet = showPrintPallet;
            this._ShowRepairReceive = showRepairReceive;
            //this._ShowPrintSN = showPrintSN;
            this._DefualtOpenLine = defualtOpenLine;
            this._DefualtPrintCS = defualtPrintCS;
            this._DefualtPrintPack = defualtPrintPack;
            this._DefualtPrintPallet = defualtPrintPallet;
            this._DefualtUseElecScale = defualtUseElecScale;
            this._DefualtRepairReceive = defualtRepairReceive;
            //this._DefualtPrintSN = defualtPrintSN;
        }

        /// <summary>
        /// 扣料
        /// </summary>
        public int DefualtDeduct
        {
            set { _DefualtDeduct = value; }
            get { return _DefualtDeduct; }
        }

        /// <summary>
        /// 启用电子称
        /// </summary>
        public int DefualtUseElecScale
        {
            set { _DefualtUseElecScale = value; }
            get { return _DefualtUseElecScale; }
        }

        /// <summary>
        /// 默认打印栈板
        /// </summary>
        public int DefualtPrintPallet
        {
            set { _DefualtPrintPallet = value; }
            get { return _DefualtPrintPallet; }
        }

        /// <summary>
        /// 默认打印包装号
        /// </summary>
        public int DefualtPrintPack
        {
            set { _DefualtPrintPack = value; }
            get { return _DefualtPrintPack; }
        }

        /// <summary>
        /// 默认打印包装产品SN
        /// </summary>
        //public int DefualtPrintSN
        //{
        //    set { _DefualtPrintSN = value; }
        //    get { return _DefualtPrintSN; }
        //}

        /// <summary>
        /// 默认打印客户SN
        /// </summary>
        public int DefualtPrintCS
        {
            set { _DefualtPrintCS = value; }
            get { return _DefualtPrintCS; }
        }

        /// <summary>
        /// 开拉默认值
        /// </summary>
        public int DefualtOpenLine
        {
            set { _DefualtOpenLine = value; }
            get { return _DefualtOpenLine; }
        }

        /// <summary>
        /// 不良接收默认值
        /// </summary>
        public int DefualtRepairReceive
        {
            set { _DefualtRepairReceive = value; }
            get { return _DefualtRepairReceive; }
        }

        /// <summary>
        /// 检查钢网
        /// </summary>
        public int DefualtSteelCheck
        {
            set { _DefualtSteelCheck = value; }
            get { return _DefualtSteelCheck; }
        }

        /// <summary>
        /// 检查刮刀
        /// </summary>
        public int DefualtKnifeCheck
        {
            set { _DefualtKnifeCheck = value; }
            get { return _DefualtKnifeCheck; }
        }

        /// <summary>
        /// 解除拼板
        /// </summary>
        public int DefualtSplitPane
        {
            set { _DefualtSplitPane = value; }
            get { return _DefualtSplitPane; }
        }

        /// <summary>
        /// 手插扣料
        /// </summary>
        public int DefualtPickDeduct
        {
            set { _DefualtPickDeduct = value; }
            get { return _DefualtPickDeduct; }
        }

        /// <summary>
        /// 是否投入站
        /// </summary>
        public int DefualtInputStation {
            set { _DefualtInputStation = value; }
            get { return _DefualtInputStation; }
        }

        /// <summary>
        /// 是否产出站
        /// </summary>
        public int DefualtOutputStation {
            set { _DefualtOutputStation = value; }
            get { return _DefualtOutputStation; }
        }

        /// <summary>
        /// 是否正面投入站
        /// </summary>
        public int DefualtSMTAInputStation {
            set { _DefualtSMTAInputStation = value; }
            get { return _DefualtSMTAInputStation; }
        }

        /// <summary>
        /// 是否正面产出站
        /// </summary>
        public int DefualtSMTAOutputStation {
            set { _DefualtSMTAOutputStation = value; }
            get { return _DefualtSMTAOutputStation; }
        }

        /// <summary>
        /// 是否背面投入站
        /// </summary>
        public int DefualtSMTBInputStation {
            set { _DefualtSMTBInputStation = value; }
            get { return _DefualtSMTBInputStation; }
        }

        /// <summary>
        /// 是否背面产出站
        /// </summary>
        public int DefualtSMTBOutputStation {
            set { _DefualtSMTBOutputStation = value; }
            get { return _DefualtSMTBOutputStation; }
        }

        /// <summary>
        /// 路由ID
        /// </summary>
        public int R_ID
        {
            set { _R_ID = value; }
            get { return _R_ID; }
        }

        /// <summary>
        /// 工序ID
        /// </summary>
        public int OpeID
        {
            set { _OpeID = value; }
            get { return _OpeID; }
        }

        /// <summary>
        /// 显示开拉
        /// </summary>
        public string ShowOpenLine
        {
            set { _ShowOpenLine = value; }
            get { return _ShowOpenLine; }
        }

        /// <summary>
        /// 显示打印客户SN
        /// </summary>
        public string ShowPrintCS
        {
            set { _ShowPrintCS = value; }
            get { return _ShowPrintCS; }
        }

        /// <summary>
        /// 显示打印包装号
        /// </summary>
        public string ShowPrintPack
        {
            set { _ShowPrintPack = value; }
            get { return _ShowPrintPack; }            
        }

        /// <summary>
        /// 显示打印栈板号
        /// </summary>
        public string ShowPrintPallet
        {
            set { _ShowPrintPallet = value; }
            get { return _ShowPrintPallet; }
        }

        /// <summary>
        /// 显示启用电子称
        /// </summary>
        public string ShowUseElecScale
        {
            set { _ShowUseElecScale = value; }
            get { return _ShowUseElecScale; }
        }

        /// <summary>
        /// 启用维修
        /// </summary>
        public string ShowRepairReceive
        {
            set { _ShowRepairReceive = value; }
            get { return _ShowRepairReceive; }
        }

        /// <summary>
        /// 包装箱产品条码打印
        /// </summary>
        //public string ShowPrintSN
        //{
        //    set { _ShowPrintSN = value; }
        //    get { return _ShowPrintSN; }
        //}

        public int DefualtPickOpenLine
        {
            set { _DefualtPickOpenLine = value; }
            get { return _DefualtPickOpenLine; }
        }
        /// <summary>
        /// 是否打印
        /// </summary>
        public int IfPrint
        {
            set { _IfPrint = value; }
            get { return _IfPrint; }
        }

        /// <summary>
        /// 是否启用样机测试
        /// </summary>
        public int SampleExame { get; set; }
        /// <summary>
        /// 是否生成 PQC送检 批次
        /// </summary>
        public int PQCInspect { get; set; }

        /// <summary>
        /// 上模校验
        /// </summary>
        public int UpModel {  get; set; }

    }
}
