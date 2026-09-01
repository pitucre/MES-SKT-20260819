using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.Common.Organization.Model
{
    [Serializable]
    public class OrganizationInfo
    {

        public string CName { get; set; }

        public string CreateBy { get; set; }

        public DateTime CreateDateTime { get; set; }

        public string DepartName { get; set; }

        public string DepartNo { get; set; }

        public string Description { get; set; }

        public string EmployeeNo { get; set; }

        public string ModifyBy { get; set; }

        public DateTime ModifyDateTime { get; set; }

        public int OrganizationId { get; set; }

        public string ParentDepartName { get; set; }

        public int ParentId { get; set; }
        public string Remark { get; set; }

        public int SupervisorId { get; set; }
    }
}
