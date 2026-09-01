using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.CropWeChat.Model
{
    public class CorpUserSimpleInfo : CommonResultInfo
    {
        /// <summary>
        /// 成员列表
        /// </summary>
        public List<CorpUserSimpleListInfo> userlist { get; set; }
    }

    public class CorpUserSimpleListInfo
    {
        /// <summary>
        /// 成员UserID。对应管理端的帐号
        /// </summary>
        public string userid { get; set; }
        /// <summary>
        /// 成员名称
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// 成员所属部门
        /// </summary>
        public int[] department { get; set; }
    }
}
