using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Labels.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Labels.Pdf;
using System.Linq;

namespace SKT.LeanMES.Labels.BLL
{
    public class LabelDocument
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 根据产品id获取对应数据信息
        /// </summary>
        /// <param name="ItemId"></param>
        /// <returns></returns>
        public List<LabelDocumentInfo> GetDocumentByItemId(Int32 ItemId)
        {
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();
            LabelDocumentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]
            {
                  new SqlParameter("@ItemId",SqlDbType.Int)
            };
            parms[0].Value = ItemId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetDocumentByItemId", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelDocumentInfo();
                    entity.LabelDocumentId = rdr.GetInt32(0);
                    entity.DocumentName = rdr.GetString(1);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 编辑（添加或更新） LabelDocument 信息。
        /// </summary>
        /// <param name="entity">LabelDocument 实体对象。</param>
        public Int32 Edit(LabelDocumentInfo entity)
        {
            string str = "";
            if (entity.PrintWayId == 78 && entity.TemplateID > 0)
            {
                PrintTemplateInfo info = new PrintTemplate().GetEnityByTempId(entity.TemplateID);
                if (info == null)
                    throw new Exception("获取打印模式设计失败");
                List<PrintTemplateDtl> list= Newtonsoft.Json.JsonConvert.DeserializeObject<List<PrintTemplateDtl>>(info.TempSet);
                List<int> ids = new List<int>();
                list.ForEach(item =>
                {
                    if (!string.IsNullOrWhiteSpace(item.key))
                        ids.Add(Convert.ToInt32(item.key));
                });
                str = string.Join(",", ids.Distinct().ToArray());
            }
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LabelDocumentId", SqlDbType.Int),
                new SqlParameter("@DocumentName", SqlDbType.NVarChar, 20),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@TemplateID", SqlDbType.Int),
                new SqlParameter("@TemplateName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Print_Qty", SqlDbType.Int),
                new SqlParameter("@Print_By", SqlDbType.NVarChar, 20),
                new SqlParameter("@Print_Method", SqlDbType.NVarChar, 20),
                new SqlParameter("@Document_Type", SqlDbType.NVarChar, 20),
                new SqlParameter("@Status", SqlDbType.NVarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@PrintWayId",  SqlDbType.Int),
                new SqlParameter("@TemplatePath", SqlDbType.NVarChar, 300),
                new SqlParameter("@PlateQty", SqlDbType.Int),
                new SqlParameter("@PrinterName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ids", SqlDbType.VarChar, 8000)
            };

            parms[0].Value = entity.LabelDocumentId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.DocumentName;
            parms[2].Value = entity.Description;
            parms[3].Value = entity.TemplateID;
            parms[4].Value = entity.TemplateName;
            parms[5].Value = entity.Print_Qty;
            parms[6].Value = entity.Print_By;
            parms[7].Value = entity.Print_Method;
            parms[8].Value = entity.Document_Type;
            parms[9].Value = entity.Status;
            parms[10].Value = entity.CreateBy;
            parms[11].Value = entity.ModifyBy;
            parms[12].Value = entity.Remark;

            parms[13].Value = entity.PrintWayId;
            parms[14].Value = entity.TemplatePath;
            parms[15].Value = entity.PlateQty;
            parms[16].Value = entity.PrinterName;
            parms[17].Value = str;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_LabelDocument_Edit", parms);
            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LabelDocumentId 字符串删除 LabelDocument 信息。
        /// </summary>
        /// <param name="idString">LabelDocumentId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_LabelDocument_Delete", parms);
        }

        /// <summary>
        /// 根据 LabelDocumentId 获取实体信息。
        /// </summary>
        /// <param name="labelDocumentId">LabelDocumentId。</param>
        /// <returns>LabelDocument 实体对象。</returns>
        public LabelDocumentInfo GetInfo(Int32 labelDocumentId)
        {
            LabelDocumentInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = labelDocumentId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_LabelDocument_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LabelDocumentInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3),
                        rdr.GetString(4), rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8),
                        rdr.GetString(9), rdr.GetInt32(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDateTime(13),
                        rdr.GetString(14), rdr.GetDateTime(15), rdr.GetString(16));

                    entity.PrintWayId = rdr.GetInt32(17);
                    entity.TemplatePath = rdr.GetString(18);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LabelDocument 实体对象。</returns>
        public LabelDocumentInfo GetInfo(String fieldValue)
        {
            LabelDocumentInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_LabelDocument_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LabelDocumentInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3),
                        rdr.GetString(4), rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8),
                        rdr.GetString(9), rdr.GetInt32(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDateTime(13),
                        rdr.GetString(14), rdr.GetDateTime(15), rdr.GetString(16));

                    entity.PrintWayId = rdr.GetInt32(17);
                    entity.TemplatePath = rdr.GetString(18);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 LabelDocument 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="labelDocumentCount">labelDocument 总数。</param>
        /// <returns>LabelDocument 列表。</returns>
        public List<LabelDocumentInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();
            LabelDocumentInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_LabelDocument", "LabelDocumentId",////Basal_LabelDocument
                "[LabelDocumentId], [DocumentName], [Description], [TemplateID], [TemplateName], [PrinterName],[Print_Qty], [Print_By], [Print_Method], [Document_Type], [PlateQty], [Status], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], [PrintWayId], [TemplatePath]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelDocumentInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3),
                        rdr.GetString(4), rdr.GetString(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8),
                        rdr.GetString(9), rdr.GetInt32(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDateTime(13),
                        rdr.GetString(14), rdr.GetDateTime(15), rdr.GetString(16));
                    entity.PrintWayId = rdr.GetInt32(17);
                    entity.TemplatePath = rdr.GetString(18);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 根据SN获取对应的文档id
        /// </summary>
        /// <param name="SN"></param>
        /// <returns></returns>
        public List<LabelDocumentInfo> GetAllDocumentBySN(String SN, int isPackSN)
        {
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();
            LabelDocumentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]
            {
                  new SqlParameter("@SN",SqlDbType.NVarChar,100),
                  new SqlParameter("@IsPackSN",SqlDbType.Bit)
            };
            parms[0].Value = SN;
            parms[1].Value = isPackSN;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetAllLabelDocumentIdBySN", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelDocumentInfo();
                    entity.LabelDocumentId = rdr.GetInt32(0);
                    entity.DocumentName = rdr.GetString(1);
                    entity.Description = rdr.GetString(2);
                    entity.PrinterName = rdr.GetString(3);
                    entity.ItemId = rdr.GetInt32(4);
                    entity.ProdOrderId = rdr.GetInt32(5);
                    entity.TemplatePath = rdr.GetString(6);
                    entity.PrintWayId = rdr.GetInt32(7);
                    entity.Document_Type = rdr.GetInt32(8).ToString();
                    entity.SN = rdr.GetString(9);
                    entity.Print_Qty = rdr.GetInt32(10);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}