using System;

namespace SKT.LeanMES.SDP.Model
{
    [Serializable]
    public class FunctionExecStepInfo
    {
        private Int32 logicID;
        private Int32 aC_ID;
        private Int32 preLogicID;
        private String stepName;
        private String stepType;
        private String stepXml;
        private String dataSourceId;
        private String dataSourceControlId;
        private String dataSourceControl;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.FunctionExecStepInfo 类的新实例。
        /// </summary>
        public FunctionExecStepInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.FunctionExecStepInfo 类的新实例。
        /// </summary>
        /// <param name="logicID"></param>
        /// <param name="aC_ID"></param>
        /// <param name="preLogicID"></param>
        /// <param name="stepName"></param>
        /// <param name="stepType"></param>
        /// <param name="stepXml"></param>
        /// <param name="dataSourceId"></param>
        /// <param name="dataSourceControlId"></param>
        public FunctionExecStepInfo(Int32 logicID, Int32 aC_ID, Int32 preLogicID, String stepName,
            String stepType, String stepXml, String dataSourceId, String dataSourceControlId)
        {
            this.logicID = logicID;
            this.aC_ID = aC_ID;
            this.preLogicID = preLogicID;
            this.stepName = stepName;
            this.stepType = stepType;
            this.stepXml = stepXml;
            this.dataSourceId = dataSourceId;
            this.dataSourceControlId = dataSourceControlId;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LogicID
        {
            get { return this.logicID; }
            set { this.logicID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AC_ID
        {
            get { return this.aC_ID; }
            set { this.aC_ID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PreLogicID
        {
            get { return this.preLogicID; }
            set { this.preLogicID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String StepName
        {
            get { return this.stepName; }
            set { this.stepName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String StepType
        {
            get { return this.stepType; }
            set { this.stepType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String StepXml
        {
            get { return this.stepXml; }
            set { this.stepXml = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String DataSourceId
        {
            get { return this.dataSourceId; }
            set { this.dataSourceId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String DataSourceControlId
        {
            get { return this.dataSourceControlId; }
            set { this.dataSourceControlId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string DataSourceControl
        {
            get { return this.dataSourceControl; }
            set { this.dataSourceControl = value; }
        }
    }
}