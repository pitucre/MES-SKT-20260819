using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Wave.Model
{
    [Serializable]
    public class DeviceInterfaceTestPositionInfo
    {
        private int _devicetestposid;
        private int? _deviceinterfaceid;
        private string _analysisType;
        private string _ponitType;
        private string _testresult;
        private int? _sequencenumber;
        /// <summary>
        /// 测试结果位置ID（主键）
        /// </summary>
        public int DeviceTestPosId
        {
            set { _devicetestposid = value; }
            get { return _devicetestposid; }
        }
        /// <summary>
        /// 设备接口ID（Prod_DeviceInterface）
        /// </summary>
        public int? DeviceInterfaceId
        {
            set { _deviceinterfaceid = value; }
            get { return _deviceinterfaceid; }
        }
        /// <summary>
        /// 测试结果位置
        /// </summary>
        public string AnalysisType
        {
            set { _analysisType = value; }
            get { return _analysisType; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string PonitType
        {
            set { _ponitType = value; }
            get { return _ponitType; }
        }
        /// <summary>
        /// 测试结果
        /// </summary>
        public string TestResult
        {
            set { _testresult = value; }
            get { return _testresult; }
        }
        
    }
}
