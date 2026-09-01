using System;

namespace SKT.LeanMES.Manufacture.Model
{
    [Serializable]
    public class ClientInfo
    {
        private Int32 type;
        private Int32 stationId;
        private Int32 resourceId;
        private String inputValue;
        private String tagValue;
        private String errorMsg;

        /// <summary>
        /// 验证分类
        /// </summary>
        public Int32 Type
        {
            get { return type; }
            set { type = value; }
        }
     
        /// <summary>
        /// 工位ID
        /// </summary>
        public Int32 StationId
        {
            get { return stationId; }
            set { stationId = value; }
        }
        
        /// <summary>
        /// 资源ID
        /// </summary>
        public Int32 ResourceId
        {
            get { return resourceId; }
            set { resourceId = value; }
        }
       
        /// <summary>
        /// 要验证的值
        /// </summary>
        public String InputValue
        {
            get { return inputValue; }
            set { inputValue = value; }
        }
        
        /// <summary>
        /// 万能备用参数, 需要时赋值使用
        /// </summary>
        public String TagValue
        {
            get { return tagValue; }
            set { tagValue = value; }
        }
       
        /// <summary>
        /// 返回给Client端的错误信息
        /// </summary>
        public String ErrorMsg
        {
            get { return errorMsg; }
            set { errorMsg = value; }
        }
    }
}
