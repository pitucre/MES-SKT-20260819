
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Labels.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Labels.BLL
{
    public class Printer
    {
        private Int32 recordCount = 0;
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        public void EditUserPrinterGroup(int userId, List<string> list, string username)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(@"delete SYS_UserPrinterGroup where UserId=@UserId");
            foreach (var item in list)
            {
                sb.AppendLine("insert into SYS_UserPrinterGroup(UserId, GroupName, CreateBy, CreateDateTime) values(@UserId, '" + item.Replace("'", "''") + "', @CreateBy, getdate())");
            }
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UserId", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 20)
            };
            parms[0].Value = userId;
            parms[1].Value = username;
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString,sb.ToString(), parms);
        }
        public List<PrinterInfo> GetUserPrinter(int userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UserId", SqlDbType.Int)
            };
            parms[0].Value = userId;
            List<PrinterInfo> list = new List<PrinterInfo>();
            PrinterInfo entity = null;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, @"if(@UserId<0)
            begin
	            select t2.Name,t2.ComputerMAC,t2.WSIP,t2.WSPort from SYS_Printer t2
	            order by t2.GroupName
            end
            else
            begin
	            select t2.Name,t2.ComputerMAC,t2.WSIP,t2.WSPort from SYS_UserPrinterGroup t1
	            inner join SYS_Printer t2 on t1.GroupName = t2.GroupName
	            where userId =@UserId order by t2.GroupName
            end", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrinterInfo()
                    {
                        Name = rdr["Name"].ToString(),
                        ComputerMAC = rdr["ComputerMAC"].ToString(),
                        WSIP = rdr["WSIP"].ToString(),
                        WSPort = Convert.ToInt32(rdr["WSPort"])
                    };
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        public List<string> GetUserPrinterGroup(int userId)
        {
            List<string> list = new List<string>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, "select GroupName from SYS_UserPrinterGroup where userId=" + userId))
            {
                while (rdr.Read())
                {
                    list.Add(rdr["GroupName"].ToString());
                }
                rdr.Close();
            }
            return list;
        }
        public List<string> GetGroupName()
        {
            List<string> list = new List<string>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, "select distinct groupname from SYS_Printer where groupname is not null and groupname!=''"))
            {
                while (rdr.Read())
                {
                    list.Add(rdr["groupname"].ToString());
                }
                rdr.Close();
            }
            return list;
        }
        public List<PrinterInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PrinterInfo> list = new List<PrinterInfo>();
            PrinterInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSYS_Printer", "Id",////SYS_Printer
                "Id,Name,GroupName,ComputerMAC,WSIP,WSPort,Remark,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrinterInfo()
                    {
                        Id = Convert.ToInt32(rdr["Id"]),
                        CreateBy = rdr["CreateBy"].ToString(),
                        CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]),
                        ModifyBy = rdr["ModifyBy"].ToString(),
                        ModifyDateTime = Convert.ToDateTime(rdr["ModifyDateTime"]),
                        Name = rdr["Name"].ToString(),
                        WSIP = rdr["WSIP"].ToString(),
                        WSPort = Convert.ToInt32(rdr["WSPort"]),
                        Remark = rdr["Remark"].ToString(),
                        GroupName = rdr["GroupName"].ToString(),
                        ComputerMAC = rdr["ComputerMAC"].ToString()
                    };

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        public void Edit(PrinterInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@GroupName", SqlDbType.VarChar,50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 20)
            };
            parms[0].Value = entity.Id;
            parms[1].Value = entity.GroupName;
            parms[2].Value = entity.Remark;
            parms[3].Value = entity.ModifyBy;
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, @"update SYS_Printer set GroupName = @GroupName,Remark = @Remark,ModifyBy = @ModifyBy, ModifyDateTime =getdate() where Id = @Id ", parms);
        }
        public void Add(string ip,int port,string mac, string printers, string user)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ComputerMAC", SqlDbType.VarChar,12),
                new SqlParameter("@Printers", SqlDbType.VarChar, 8000),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@WSIP", SqlDbType.VarChar, 20),
                new SqlParameter("@WSPort", SqlDbType.Int)
            };

            parms[0].Value = mac;
            parms[1].Value = printers;
            parms[2].Value = user;
            parms[3].Value = ip;
            parms[4].Value = port;

            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, @"delete SYS_Printer where ComputerMAC=@ComputerMAC
insert into SYS_Printer(Name,GroupName,ComputerMAC,WSIP,WSPort,Remark,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime)
select value,'',@ComputerMAC,@WSIP,@WSPort,'',@CreateBy,getdate(),@CreateBy,getdate() from [dbo].[fn_SplitStringToStrTable](@Printers,',')", parms);
        }

        public PrinterInfo GetEnity(int id)
        {
            PrinterInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@Id", SqlDbType.Int) };
            parms[0].Value = id;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, "select Id,Name,GroupName,ComputerMAC,WSIP,WSPort,Remark,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime from SYS_Printer where Id=@Id", parms))
            {
                if (rdr.Read())
                {
                    entity = new PrinterInfo
                    {
                        Id = Convert.ToInt32(rdr["Id"]),
                        CreateBy = rdr["CreateBy"].ToString(),
                        CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]),
                        ModifyBy = rdr["ModifyBy"].ToString(),
                        ModifyDateTime = Convert.ToDateTime(rdr["CreateDateTime"]),
                        Name = rdr["Name"].ToString(),
                        WSIP = rdr["WSIP"].ToString(),
                        WSPort = Convert.ToInt32(rdr["WSPort"]),
                        Remark = rdr["Remark"].ToString(),
                        GroupName = rdr["GroupName"].ToString(),
                        ComputerMAC = rdr["ComputerMAC"].ToString()
                    };
                }
                rdr.Close();
            }
            return entity;
        }
        public void Delete(int id)
        {
            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@Id", SqlDbType.Int) };
            parms[0].Value = id;
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, @"delete SYS_Printer where Id=@Id", parms);
        }
    }
}
