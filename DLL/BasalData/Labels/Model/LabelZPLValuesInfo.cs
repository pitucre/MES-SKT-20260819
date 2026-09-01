using System;

namespace SKT.LeanMES.Labels.Model
{
    [Serializable]
    public class LabelZPLValuesInfo
    {
        private Int32 labelZplValuesId;
        private Int32 labelZplId;
        private Int32 zplIndex;
        private String zplValues;

        /// <summary>
        /// 初始化 SKT.LeanMES.Labels.Model.LabelZPLValuesInfo 类的新实例。
        /// </summary>
        public LabelZPLValuesInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Labels.Model.LabelZPLValuesInfo 类的新实例。
        /// </summary>
        /// <param name="labelZplValuesId"></param>
        /// <param name="labelZplId"></param>
        /// <param name="zplIndex"></param>
        /// <param name="zplValues"></param>
        public LabelZPLValuesInfo(Int32 labelZplValuesId, Int32 labelZplId, Int32 zplIndex, String zplValues)
        {
            this.labelZplValuesId = labelZplValuesId;
            this.labelZplId = labelZplId;
            this.zplIndex = zplIndex;
            this.zplValues = zplValues;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LabelZplValuesId
        {
            get { return this.labelZplValuesId; }
            set { this.labelZplValuesId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LabelZplId
        {
            get { return this.labelZplId; }
            set { this.labelZplId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ZplIndex
        {
            get { return this.zplIndex; }
            set { this.zplIndex = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ZplValues
        {
            get { return this.zplValues; }
            set { this.zplValues = value; }
        }
    }
}