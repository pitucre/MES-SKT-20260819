using SKT.Common.Account.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.SessionState;

namespace SKT.LeanMES.SubUserMembership.BLL
{
    public class SubUser:IRequiresSessionState
    {
        private int recordCount = 0;

        public List<MembershipInfo> GetAll(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
            List<MembershipInfo> list = new List<MembershipInfo>();
            string ConnStr = Convert.ToString(System.Web.HttpContext.Current.Session["ConnStr"]);
            SqlParameter[] array = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwUserMembership", "UserId", "UserId,CName,EName,Sex,Phone,Email,EmployeeId,EmployeeNo,DepartNo,DepartName,UserName, IsApproved, IsLockedOut, Status, UserType, DepartId,IsOnline,CreateBy,CreateDateTime", searchSettings, sortExpression);
            using (SqlDataReader sqlDataReader = SQLHelper.ExecuteReaderStoredProcedure(ConnStr, "Common_GetPageRecords", array))
            {
                while (sqlDataReader.Read())
                {
                    list.Add(new MembershipInfo
                    {
                        UserId = Convert.ToInt32(sqlDataReader["UserId"]),
                        EmployeeCName = sqlDataReader["CName"].ToString(),
                        EmployeeEName = sqlDataReader["EName"].ToString(),
                        Sex = Convert.ToInt32(sqlDataReader["Sex"]),
                        Phone = sqlDataReader["Phone"].ToString(),
                        Email = sqlDataReader["Email"].ToString(),
                        EmployeeNo = sqlDataReader["EmployeeNo"].ToString(),
                        DepartNo = sqlDataReader["DepartNo"].ToString(),
                        DepartName = sqlDataReader["DepartName"].ToString(),
                        UserName = sqlDataReader["UserName"].ToString(),
                        IsApproved = Convert.ToBoolean(sqlDataReader["IsApproved"]),
                        IsLockedOut = Convert.ToBoolean(sqlDataReader["IsLockedOut"]),
                        UserStatus = Convert.ToInt32(sqlDataReader["Status"]),
                        UserType = Convert.ToInt32(sqlDataReader["UserType"]),
                        DepartId = Convert.ToInt32(sqlDataReader["DepartId"]),
                        CreateBy = sqlDataReader["CreateBy"].ToString(),
                        CreateDateTime = Convert.ToDateTime(sqlDataReader["CreateDateTime"])
                    });
                }
                sqlDataReader.Close();
            }
            this.recordCount = Convert.ToInt32(array[array.Length - 1].Value);
            return list;
        }

        public int GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
