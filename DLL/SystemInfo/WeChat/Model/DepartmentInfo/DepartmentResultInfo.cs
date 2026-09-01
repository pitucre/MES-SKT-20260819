using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.CropWeChat.Model
{
    /// <summary>
    /// 部门类型
    /// </summary>
    public class DepartmentResultInfo : CommonResultInfo
    {
        /// <summary>
        /// 部门列表数据s
        /// </summary>
        public List<DepartmentInfo> department { get; set; }
    }
 
    public class DepartmentInfo 
    {
        /// <summary>
        /// 部门id
        /// </summary>
        [JsonProperty(DefaultValueHandling = DefaultValueHandling.Ignore)]//默认值不序列化
        public int id { get; set; }
        /// <summary>
        /// 部门名称 ：长度限制为1~32个字符，字符不能包括\:?”<>｜
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// 父亲部门id。根部门为1
        /// </summary>
        public int parentid { get; set; }
        /// <summary>
        /// 在父部门中的次序值。order值大的排序靠前。值范围是[0, 2^32)
        /// </summary>
        public int order { get; set; }
    }

   
}
