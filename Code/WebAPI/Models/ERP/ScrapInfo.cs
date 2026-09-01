using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebAPI.Models.ERP
{
    public class ScrapInfo
    {
        /// <summary>
        /// 状态(0-待报废，1-报废中，2-报废完成，3-已提交（扫码完成）)
        /// </summary>
        public int Statue {  get; set; }
    }
}
