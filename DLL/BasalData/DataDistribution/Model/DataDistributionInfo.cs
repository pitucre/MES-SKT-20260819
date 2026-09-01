using System;

namespace SKT.LeanMES.DataDistribution.Model
{
    [Serializable]
    public class DataDistributionInfo
    {
        public DataDistributionInfo() { }
        public DataDistributionInfo(Int32 Id,string tableDisPlayName,string tableName,string tableDescription,bool isCondition, string conditionStr
            ,string addPerson,string addPersonName,DateTime addTime,string updatePerson,string updatePersonName,DateTime updateTime) {
            this.Id = Id;
            this.tableDisPlayName = tableDisPlayName;
            this.tableName = tableName;
            this.tableDescription = tableDescription;
            this.isCondition = isCondition;
            this.conditionStr = conditionStr;
            this.addPerson = addPerson;
            this.addPersonName = addPersonName;
            this.addTime = addTime;
            this.updatePerson = updatePerson;
            this.updatePersonName = updatePersonName;
            this.updateTime = updateTime;
        }
        private Int32 Id;
        private string tableDisPlayName;
        private string tableName;
        private string tableDescription;
        private bool isCondition;
        private string conditionStr;
        private string addPerson;
        private string addPersonName;
        private DateTime? addTime;
        private string updatePerson;
        private string updatePersonName;
        private DateTime? updateTime;

        /// <summary>
        /// 获取或设置Unique Identifier
        /// </summary>
        public Int32 ID
        {
            get { return this.Id; }
            set { this.Id = value; }
        }

        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String TableDisPlayName
        {
            get { return this.tableDisPlayName; }
            set { this.tableDisPlayName = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String TableName
        {
            get { return this.tableName; }
            set { this.tableName = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String TableDescription
        {
            get { return this.tableDescription; }
            set { this.tableDescription = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public Boolean IsCondition
        {
            get { return this.isCondition; }
            set { this.isCondition = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String ConditionStr
        {
            get { return this.conditionStr; }
            set { this.conditionStr = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String AddPerson
        {
            get { return this.addPerson; }
            set { this.addPerson = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String AddPersonName
        {
            get { return this.addPersonName; }
            set { this.addPersonName = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public DateTime? AddTime
        {
            get { return this.addTime; }
            set { this.addTime = value; }
        }
             /// <summary>
             /// 获取或设置项目名称。
             /// </summary>
        public String UpdatePerson
        {
            get { return this.updatePerson; }
            set { this.updatePerson = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String UpdatePersonName
        {
            get { return this.updatePersonName; }
            set { this.updatePersonName = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public DateTime? UpdateTime
        {
            get { return this.updateTime; }
            set { this.updateTime = value; }
        }
    }
}
