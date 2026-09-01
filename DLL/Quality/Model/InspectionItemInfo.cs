using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class InspectionItemInfo
    {

        private String inspectionItemName;
        private String creater;
        private DateTime createTime;
        private String description;
        public int InspectionItemId { get; set; }
        public bool InspectionResult { get; set; }
        public int ParentId { get; set; }
        public Boolean isParent { get; set; }
        public string ParentName { get; set; }
        public string name { get { return inspectionItemName; } }

        public string testMethod;

        public string testBasis;


        public int id { get { return InspectionItemId; } }

        public int Sorting { get; set; }
        /// <summary>
        /// 录入方式Id
        /// </summary>
        public int InspectionMethodId { get; set; }
        public string InspectionMethodName { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionItemInfo 类的新实例。
        /// </summary>
        public InspectionItemInfo()
        {
        }

        /// <summary>
        /// 获取或设置检验项名
        /// </summary>
        public String InspectionItemName
        {
            get { return this.inspectionItemName; }
            set { this.inspectionItemName = value; }
        }


        /// <summary>
        /// 测试方法
        /// </summary>
        public String TestMethod
        {
            get { return this.testMethod; }
            set { this.testMethod = value; }
        }


        /// <summary>
        /// 测试依据
        /// </summary>
        public String TestBasis
        {
            get { return this.testBasis; }
            set { this.testBasis = value; }
        }
        

        /// <summary>
        /// 获取或设置检验项创建者
        /// </summary>
        public String Creater
        {
            get { return this.creater; }
            set { this.creater = value; }
        }

        /// <summary>
        /// 获取或设置检验项创建时间
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

        /// <summary>
        /// 获取或设置检验项说明
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置检验项的状态，默认为启用 1, 禁用为0
        /// </summary>
        public Boolean Status { get; set; }

        /// <summary>
        /// 单位名称
        /// </summary>
        public string UnitName { set; get; }
        /// <summary>
        /// 检验方法
        /// </summary>
        public string Inpsectionmethods { set; get; }
    }
}