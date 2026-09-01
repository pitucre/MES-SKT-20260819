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
    public class PrintTemplate
    {
        private Int32 recordCount = 0;
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        public List<PrintTemplateInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PrintTemplateInfo> list = new List<PrintTemplateInfo>();
            PrintTemplateInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_PrintTemplate", "TempId",////Basal_PrintTemplate
                "TempId,TempSet,PanelWidth,PanelHeight,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,TempName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrintTemplateInfo()
                    {
                        TempId = Convert.ToInt32(rdr["TempId"]),
                        CreateBy = rdr["CreateBy"].ToString(),
                        CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]),
                        ModifyBy = rdr["ModifyBy"].ToString(),
                        ModifyDateTime = Convert.ToDateTime(rdr["ModifyDateTime"]),
                        TempName = rdr["TempName"].ToString(),
                        PanelHeight = Convert.ToSingle(rdr["PanelHeight"]),
                        PanelWidth = Convert.ToSingle(rdr["PanelWidth"]),
                        TempSet = rdr["TempSet"].ToString()
                    };

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        public void Edit(PrintTemplateInfo entity, string ids)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TempId", SqlDbType.Int),
                new SqlParameter("@TempName", SqlDbType.NVarChar,50),
                new SqlParameter("@TempSet", SqlDbType.NVarChar,-1),
                new SqlParameter("@PanelWidth", SqlDbType.Decimal),
                new SqlParameter("@PanelHeight", SqlDbType.Decimal),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@CreateDateTime", SqlDbType.DateTime),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@ModifyDateTime",  SqlDbType.DateTime),
                new SqlParameter("@ids",  SqlDbType.VarChar,-1)
            };

            parms[0].Value = entity.TempId;
            parms[1].Value = entity.TempName;
            parms[2].Value = entity.TempSet;
            parms[3].Value = entity.PanelWidth;
            parms[4].Value = entity.PanelHeight;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.CreateDateTime;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.ModifyDateTime;
            parms[9].Value = ids;

            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, @"
            if exists(select * from Basal_PrintTemplate where TempId=@TempId)
            begin
                if exists(select 1 from Basal_PrintTemplate where TempName=@TempName and TempId<>@TempId)
                begin
                   RAISERROR('模板名称已经存在！',12,1);
                   RETURN;
                end
                update Basal_PrintTemplate set TempName = @TempName,TempSet = @TempSet, PanelWidth = @PanelWidth, PanelHeight = @PanelHeight, ModifyBy = @ModifyBy, ModifyDateTime =getdate() 
                where TempId = @TempId
            end
            else
            begin
                if exists(select 1 from Basal_PrintTemplate where TempName=@TempName)
                begin
                   RAISERROR('模板名称已经存在！',12,1);
                   RETURN;
                end
                insert into Basal_PrintTemplate(TempName, TempSet, PanelWidth, PanelHeight, CreateBy, CreateDateTime, ModifyBy, ModifyDateTime)
                values(@TempName, @TempSet, @PanelWidth, @PanelHeight, @CreateBy, @CreateDateTime, @ModifyBy, getdate())
            end
            delete dbo.Basal_LabelField WHERE LabelFieldID in(select LabelDocumentId from Basal_LabelDocument where PrintWayId=78 and TemplateID=@TempId)
            insert into Basal_LabelField(LabelFieldID,FieldDfID,FieldSeq,FieldDesc,CreateBy,CreateDateTime,ModifyBy,ModifyDataTime)
            select t3.LabelDocumentId,t2.FieldDfID,0,t2.FieldDfName,@CreateBy,getdate(),@CreateBy,getdate() from [dbo].[fn_SplitStringToStrTable](@ids,',') t1
            inner join Basal_LabelFieldDF t2 on t1.value=t2.FieldDfID
            inner join Basal_LabelDocument t3 on t3.PrintWayId=78 and t3.TemplateID=@TempId
            ", parms);
        }

        public PrintTemplateInfo GetEnityByTempId(int TempId)
        {
            PrintTemplateInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@TempId", SqlDbType.Int) };
            parms[0].Value = TempId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, "select TempId,TempSet,PanelWidth,PanelHeight,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,TempName from Basal_PrintTemplate where TempId=@TempId", parms))
            {
                if (rdr.Read())
                {
                    entity = new PrintTemplateInfo
                    {
                        TempId = Convert.ToInt32(rdr["TempId"]),
                        CreateBy = rdr["CreateBy"].ToString(),
                        CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]),
                        ModifyBy = rdr["ModifyBy"].ToString(),
                        ModifyDateTime = Convert.ToDateTime(rdr["CreateDateTime"]),
                        TempName = rdr["TempName"].ToString(),
                        PanelHeight = Convert.ToSingle(rdr["PanelHeight"]),
                        PanelWidth = Convert.ToSingle(rdr["PanelWidth"]),
                        TempSet = rdr["TempSet"].ToString()
                    };
                }
                rdr.Close();
            }
            return entity;
        }
        public void Delete(int TempId)
        {
            SqlParameter[] parms = new SqlParameter[] { new SqlParameter("@TempId", SqlDbType.Int) };
            parms[0].Value = TempId;
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, @"
            if exists(select * from Basal_LabelDocument where printwayid=78 and TemplateID=@TempId)
            begin
                RAISERROR('模板被引用不能删除', 12, 1)
	            RETURN
            end
            delete Basal_PrintTemplate where TempId=@TempId", parms);
        }

        public void AddPrintData(Guid id, int tempId, string data)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@Id", SqlDbType.UniqueIdentifier),
                new SqlParameter("@TempId", SqlDbType.Int),
                new SqlParameter("@Data", SqlDbType.NVarChar,-1)
            };
            parms[0].Value = id;
            parms[1].Value = tempId;
            parms[2].Value = data;
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, "insert into Basal_PrintData(Id,TempId,Data,[Time])values(@Id,@TempId,@Data,getdate())", parms);
        }
        public string GetPrintData(Guid id)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@Id", SqlDbType.UniqueIdentifier)
            };
            parms[0].Value = id;
            string data = "";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, @"select Data from Basal_PrintData where Id=@Id
delete Basal_PrintData where Id = @Id
delete Basal_PrintData where[Time] < DATEADD(HOUR, -1, getdate())", parms))
            {
                if (rdr.Read())
                {
                    data = rdr["Data"].ToString();
                }
                rdr.Close();
            }
            return data;
        }
    }
}
