using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Language.Model
{
    public class LanguageInfo
    {
        public int LanguageId { get; set; }
        public string LanguageKey { get; set; }
        public string CN { get; set; }
        public string EN { get; set; }
        public string CreateBy { get; set; }
        public DateTime? CreateDateTime { get; set; }
        public string ModifyBy { get; set; }
        public DateTime? ModifyDateTime { get; set; }
    }
}
