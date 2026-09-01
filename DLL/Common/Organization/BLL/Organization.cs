using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using SKT.Common.Organization.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.Common.Model;
using SKT.Common.Account.Model;

namespace SKT.Common.Organization.BLL
{
    public class Organization
    {
        private Int32 recordCount = 0;
        // Token: 0x06000001 RID: 1 RVA: 0x00002140 File Offset: 0x00000340
        public int Edit(OrganizationInfo entity)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@OrganizationId", SqlDbType.Int) { Value = entity.OrganizationId, Direction = ParameterDirection.InputOutput},
                new SqlParameter("@ParentId", SqlDbType.Int) { Value = entity.ParentId},
                new SqlParameter("@DepartNo", SqlDbType.VarChar, 20) { Value = entity.DepartNo},
                new SqlParameter("@DepartName", SqlDbType.NVarChar, 50){ Value = entity.DepartName},
                new SqlParameter("@SupervisorId", SqlDbType.Int){ Value = entity.SupervisorId},
                new SqlParameter("@Description", SqlDbType.NVarChar, 50){ Value = entity.Description},
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20){ Value = entity.CreateBy},
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20){ Value = entity.ModifyBy},
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50){ Value = entity.Remark}
            }; 
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Organization_Edit", param);
            return (int)param[0].Value;
        }

        // Token: 0x06000002 RID: 2 RVA: 0x000022A0 File Offset: 0x000004A0
        public void Delete(string idString, string userName)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000) { Value = idString},
                new SqlParameter("@UserName", SqlDbType.VarChar, 20) { Value = userName}
            }; 
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Organization_Delete", param);
        }

        // Token: 0x06000003 RID: 3 RVA: 0x00002300 File Offset: 0x00000500
        public OrganizationInfo GetInfo(int organizationId)
        { 
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50){ Value = organizationId},
                new SqlParameter("@IsByID", SqlDbType.Bit){ Value = true}
            };
            return ComMethod.GetList<OrganizationInfo>("SYS_Organization_GetInfo", parms).FirstOrDefault();
        }
             

        // Token: 0x06000004 RID: 4 RVA: 0x00002418 File Offset: 0x00000618
        public OrganizationInfo GetInfo(string fieldValue)
        {

            SqlParameter[] parms = new SqlParameter[]
           {
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50){ Value = fieldValue},
                new SqlParameter("@IsByID", SqlDbType.Bit){ Value = false}
           };
            return ComMethod.GetList<OrganizationInfo>("SYS_Organization_GetInfo", parms).FirstOrDefault();
        }

        // Token: 0x06000005 RID: 5 RVA: 0x0000252C File Offset: 0x0000072C
        public List<OrganizationInfo> GetAll(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {

            List<OrganizationInfo> list = new List<OrganizationInfo>();
            //表名或者视图
            string strTb = "SYS_Organization";//"Prod_Apply";
                                       //主键
            string strKey = "OrganizationId";//"ApplyId";
                                      //查询栏位字串
            string strColumns = @"[OrganizationId], [ParentId], [DepartNo], [DepartName], [SupervisorId], [Description], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]";
            list = ComMethod.GetComList<OrganizationInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }

        // Token: 0x06000006 RID: 6 RVA: 0x00002614 File Offset: 0x00000814
        public int GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        private DataTable treeTable;
        private List<OrganizationInfo> organizationList;
        // Token: 0x06000007 RID: 7 RVA: 0x0000262C File Offset: 0x0000082C
        public List<OrganizationInfo> GetOrganizationTree(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
             
            List<OrganizationInfo> list = new List<OrganizationInfo>();
            //表名或者视图
            string strTb = "SYS_Organization";//"Prod_Apply";
                                              //主键
            string strKey = "OrganizationId";//"ApplyId";
                                             //查询栏位字串
            string strColumns = @"[OrganizationId], [ParentId], [DepartNo], [DepartName], [SupervisorId], [Description], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]";
            list = ComMethod.GetComList<OrganizationInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
             
            this.treeTable.Columns.Add("Level", typeof(string));
            this.treeTable.Columns.Add("PID", typeof(string));
            this.treeTable.Columns.Add("ID", typeof(string));
            this.treeTable.Columns.Add("Desc", typeof(string));
            this.treeTable.Columns.Add("DepartName", typeof(string));
            this.treeTable.Columns.Add("DepartNo", typeof(string));
            this.treeTable.Columns.Add("Supervisor", typeof(string));
            this.treeTable.Columns.Add("HasChild", typeof(string));
            this.organizationList = list;
            return list;
        }

        private OrganizationInfo child;
        private OrganizationInfo parent;
        private List<OrganizationInfo> tmpList;
        private int parentId;
        private int organizationId;
        private int remarkLen;
        private string description;
        private string departName;
        private string departNo;
        private string supervisorId;
        private bool isParent;
        private int childCount;
        // Token: 0x06000008 RID: 8 RVA: 0x00002824 File Offset: 0x00000A24
        private void FillTreeTable(List<OrganizationInfo> list, int level)
        {
            for (int i = 0; i < list.Count; i++)
            {
                this.parent = list[i];
                this.parentId = list[i].ParentId;
                this.organizationId = list[i].OrganizationId;
                this.remarkLen = list[i].Remark.Length;
                this.description = list[i].Description.ToString();
                this.departName = list[i].DepartName.ToString();
                this.departNo = list[i].DepartNo.ToString();
                this.supervisorId = list[i].SupervisorId.ToString();

                this.organizationList.Remove(list[i]);
                List<OrganizationInfo> childList = new List<OrganizationInfo>(); 
                this.isParent = false;
                for (int j = 0; j < this.organizationList.Count; j++)
                {
                    this.child = this.organizationList[j];
                    if (this.child.ParentId == this.organizationId)
                    {
                        this.isParent = true;
                        childList.Add(this.child);
                    }
                }
                this.treeTable.Rows.Add(new object[]
                {
                    this.parentId.ToString(),
                    this.organizationId.ToString(),
                    this.remarkLen.ToString(),
                    this.description.ToString(),
                    this.departName.ToString(),
                    this.departNo.ToString(),
                    this.supervisorId,
                    this.isParent.ToString()
                });
                list.Remove(this.parent);
                this.tmpList = list;
                this.childCount = childList.Count;
                if (childList.Count == 0)
                {
                    childList = this.tmpList;
                    level--;
                }
                else
                {
                    level++;
                }
                this.FillTreeTable(childList, level);
            }
        }

        // Token: 0x06000009 RID: 9 RVA: 0x00002A48 File Offset: 0x00000C48
        public List<MembershipInfo> GetUserByOrganizationId(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {

            List<MembershipInfo> list = new List<MembershipInfo>();
            //表名或者视图
            string strTb = "SYS_Membership";//"Prod_Apply";
                                              //主键
            string strKey = "MembershipId";//"ApplyId";
                                             //查询栏位字串
            string strColumns = @"[MembershipId],[UserId],[CName],[EName],[Sex],[Phone],[Email],[EmployeeNo],[DepartName]";
            list = ComMethod.GetComList<MembershipInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }
 
    }
}
