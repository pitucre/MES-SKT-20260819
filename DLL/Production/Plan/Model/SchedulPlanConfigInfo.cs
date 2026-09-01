using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Plan.Model
{
   public class SchedulPlanConfigInfo
   {
       public int Pid { get; set; }
       public string Name { get; set; }
       public int IsEnable { get; set; }
       public string Remark { get; set; }
       public string CreateBy { get; set; }

       public DateTime CreateTime { get; set; }
       public string PlanTimeDetials { get; set; }

   }

    public class SchedulPlanConfigDetailInfo
    {
        public int PdId { get; set; }
        public int Pid { get; set; }
        public string PlanTime { get; set; }
    }
        
     }
