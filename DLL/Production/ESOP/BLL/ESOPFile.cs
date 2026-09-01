using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.ESOP.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.ESOP.BLL
{
    public class ESOPFile
    {

        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Item 信息。
        /// </summary>
        /// <param name="entity">Item 实体对象。</param>
        public Int32 Edit(ESOPFileInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EsopFileId", SqlDbType.Int),
                new SqlParameter("@EsopFileName", SqlDbType.NVarChar, 100),
                new SqlParameter("@EsopFileUrl", SqlDbType.NVarChar, 100),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@IsCurrent", SqlDbType.Bit),
                new SqlParameter("@Remark", SqlDbType.NVarChar,50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateDate", SqlDbType.DateTime),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar,20),
                new SqlParameter("@ModifyDate", SqlDbType.DateTime),
                new SqlParameter("@IsVideo", SqlDbType.Bit),
                new SqlParameter("@ESOPID", SqlDbType.Int),
                new SqlParameter("@FileType", SqlDbType.NVarChar,50),
                new SqlParameter("@Sequence", SqlDbType.Int)

              };

            parms[0].Value = entity.EsopFileId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.EsopFileName;
            parms[2].Value = entity.EsopFileUrl;
            parms[3].Value = entity.ItemId;
            //parms[4].Value = entity.StationId;
            parms[4].Value = entity.IsCurrent;
            parms[5].Value = entity.Remark;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = DateTime.Now;
            parms[8].Value = entity.ModifyBy;
            parms[9].Value = DateTime.Now;
            parms[10].Value = entity.IsVideo;
            parms[11].Value = entity.ESOPID;
            parms[12].Value = entity.FileType;
            parms[13].Value = entity.Sequence;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ESOPFile_Edit", parms);
            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 EsopFileId 字符串删除 Item 信息。
        /// </summary>
        /// <param name="idString">EsopFileId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ESOPFile_Delete", parms);
        }

        /// <summary>
        /// 根据 ESOPFileId 获取实体信息。
        /// </summary>
        /// <param name="itemId">ItemId。</param>
        /// <returns>ESOPFileInfo 实体对象。</returns>
        public ESOPFileInfo GetInfo(Int32 itemId)
        {
            ESOPFileInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = itemId;
            parms[1].Value = true;

            //using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Item_GetInfo", parms))
            //{
            //    if (rdr.Read())
            //    {
            //        entity = new ESOPFileInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4),
            //            rdr.GetString(5), rdr.GetBoolean(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9),rdr.GetDateTime(10),
            //            rdr.GetString(11), rdr.GetString(12), rdr.GetString(13), rdr.GetBoolean(14), rdr.GetString(15),rdr.GetString(16),rdr.GetString(17),rdr.GetInt32(18));
            //    }
            //    rdr.Close();
            //}

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Item 实体对象。</returns>
        public ESOPFileInfo GetInfo(String fieldValue, string itemName, string station)
        {
            ESOPFileInfo entity = new ESOPFileInfo();

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit),
                new SqlParameter("@ItemName", SqlDbType.NVarChar, 150),
                new SqlParameter("@Station", SqlDbType.NVarChar, 20)
                };

            parms[0].Value = fieldValue;
            parms[1].Value = false;
            parms[2].Value = itemName;
            parms[3].Value = station;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Item_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ESOPFileInfo();
                    entity.EsopFileId = rdr.GetInt32(0);
                    entity.EsopFileName = rdr.GetString(1);
                    entity.EsopFileUrl = rdr.GetString(2);
                    entity.ItemId = rdr.GetInt32(3);
                    //entity.StationId = rdr.GetInt32(4);
                    entity.Remark = rdr.GetString(5);
                    entity.IsCurrent = rdr.GetBoolean(6);
                    entity.ModifyBy = rdr.GetString(7);
                    entity.ModifyDate = rdr.GetDateTime(8);
                    entity.CreateBy = rdr.GetString(9);
                    entity.CreateDate = rdr.GetDateTime(10);
                    entity.ItemName = rdr.GetString(11);
                    //entity.Station = rdr.GetString(12);
                    entity.IsCurrent_CN = rdr.GetString(13);
                    entity.IsVideo = rdr.GetBoolean(14);
                    entity.IsVideo_CN = rdr.GetString(15);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ESOP 审核列表。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemCount">item 总数。</param>
        /// <returns>Prod_ESOPFile 列表。</returns>
        public List<ESOPAuditInfo> GetAllAuditList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ESOPAuditInfo> list = new List<ESOPAuditInfo>();
            ESOPAuditInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, " vw_ESOPAuditList ", "ESOPId",
                "ESOPId,AuditNo,ESOPName,StationName,ESOPFileName,IsEnableName,AuditStates,AuditUserName,AuditDatatime,AuditRemark,ESOPFileNameURL,IsEnableApproval,ApprovalStates,ApprovalUser,ApprovalDatatime,ApprovalRemark,ModifyBy,ModifyDate", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ESOPAuditInfo();
                    entity.ESOPId = rdr.GetInt32(0);
                    entity.AuditNo = rdr.GetString(1);
                    entity.ESOPName = rdr.GetString(2);
                    entity.StationName = rdr.GetString(3);
                    entity.ESOPFileName = rdr.GetString(4);
                    entity.IsEnableName = rdr.GetString(5);
                    entity.AuditStates = rdr.GetString(6);
                    entity.AuditUserName = rdr.GetString(7);
                    entity.AuditDatatime = rdr.GetString(8);
                    entity.AuditRemark = rdr.GetString(9);
                    entity.ESOPFileNameURL = rdr.GetString(10);
                    entity.IsEnableApproval = rdr.GetString(11);
                    entity.ApprovalStates = rdr.GetString(12);
                    entity.ApprovalUser = rdr.GetString(13);
                    entity.ApprovalDatatime = rdr.GetString(14);
                    entity.ApprovalRemark = rdr.GetString(15);
                    entity.ModifyBy = rdr.GetString(16);
                    entity.ModifyDate = rdr.GetDateTime(17);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 ESOP 审核列表。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemCount">item 总数。</param>
        /// <returns>Prod_ESOPFile 列表。</returns>
        public List<ESOPAuditInfo> GetAllFastViewList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ESOPAuditInfo> list = new List<ESOPAuditInfo>();
            ESOPAuditInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, " vw_ESOPFastViewList ", "ESOPId",
                "ESOPId,ESOPName,StationName,ItemCode,ItemName,ESOPFileName,ESOPFileNameURL", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ESOPAuditInfo();
                    entity.ESOPId = rdr.GetInt32(0);
                    entity.ESOPName = rdr.GetString(1);
                    entity.StationName = rdr.GetString(2);
                    entity.ItemCode = rdr.GetString(3);
                    entity.ItemName = rdr.GetString(4);
                    entity.ESOPFileName = rdr.GetString(5);
                    entity.ESOPFileNameURL = rdr.GetString(6);
                    list.Add(entity);

                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 Prod_ESOPFile 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemCount">item 总数。</param>
        /// <returns>Prod_ESOPFile 列表。</returns>
        public List<ESOPFileInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ESOPFileInfo> list = new List<ESOPFileInfo>();
            ESOPFileInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, " Prod_ESOPFile ", "ESOPFileID",
                "[ESOPFileID], [ESOPFileName], [ESOPFileUrl], [Remark], [IsCurrent] , [ModifyBy], [ModifyDate], [CreateBy], [CreateDate], FileType, Sequence,ESOPID ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ESOPFileInfo();
                    entity.EsopFileId = rdr.GetInt32(0);
                    entity.EsopFileName = rdr.GetString(1);
                    entity.EsopFileUrl = rdr.GetString(2);
                    entity.Remark = rdr.GetString(3);
                    entity.IsVideo = rdr.GetBoolean(4);
                    entity.ModifyBy = rdr.GetString(5);
                    entity.ModifyDate = rdr.GetDateTime(6);
                    entity.CreateBy = rdr.GetString(7);
                    entity.CreateDate = rdr.GetDateTime(8);
                    entity.FileType = rdr.GetString(9);
                    entity.Sequence = rdr.GetInt32(10);
                    list.Add(entity);

                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        /// <summary>
        /// 获取已绑定工位的ESOP文件
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ESOPTreeInfo> GetAllESOPTree(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ESOPTreeInfo> list = new List<ESOPTreeInfo>();
            ESOPTreeInfo entity = null;

            SqlParameter[] stationParms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, " dbo.Basal_Station a INNER JOIN (SELECT StationId FROM dbo.Prod_ESOP GROUP BY StationId) AS b ON a.StationId = b.StationId ", "a.StationId",
                " a.[StationId],a.[Station] ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", stationParms))
            {
                while (rdr.Read())
                {
                    entity = new ESOPTreeInfo(rdr.GetInt32(0), 0, rdr.GetString(1));
                    list.Add(entity);

                }
                rdr.Close();
            }

            SqlParameter[] esopParms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, " Prod_ESOP ", "ESOPID",
                " [ESOPID],[StationId],[ESOPName] ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", esopParms))
            {
                while (rdr.Read())
                {
                    entity = new ESOPTreeInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2));
                    list.Add(entity);

                }
                rdr.Close();
            }
            //recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 更新ESOP文件序号
        /// </summary>
        /// <param name="oldFileId"></param>
        /// <param name="newFileId"></param>
        /// <param name="oldSquence"></param>
        /// <param name="newSquence"></param>
        public void EsopFileSquenceEdit(int oldFileId, int newFileId, int oldSquence, int newSquence)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OldFileId", SqlDbType.Int),
                new SqlParameter("@NewFileId", SqlDbType.Int),
                new SqlParameter("@OldSquence", SqlDbType.Int),
                new SqlParameter("@NewSquence", SqlDbType.Int),
                };
            parms[0].Value = oldFileId;
            parms[1].Value = newFileId;
            parms[2].Value = oldSquence;
            parms[3].Value = newSquence;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEsopSquenceEdit", parms);
        }

        /// <summary>
        /// 增加上传文件的内容
        /// </summary>
        public void InsertFile(string RowType, string FileType, string FileUpName, string FileSaveName, string FilePath, decimal FromID, string FromCode, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RowType", SqlDbType.VarChar),
                new SqlParameter("@FileUpName", SqlDbType.VarChar),
                new SqlParameter("@FileType", SqlDbType.VarChar),
                new SqlParameter("@FileSaveName", SqlDbType.VarChar),
                new SqlParameter("@FilePath", SqlDbType.VarChar),
                new SqlParameter("@FromID", SqlDbType.BigInt),
                new SqlParameter("@FromCode", SqlDbType.VarChar),
                new SqlParameter("@CreateBy", SqlDbType.VarChar)
                };
            parms[0].Value = RowType;
            parms[1].Value = FileUpName;
            parms[2].Value = FileType;
            parms[3].Value = FileSaveName;

            parms[4].Value = FilePath;
            parms[5].Value = FromID;
            parms[6].Value = FromCode;
            parms[7].Value = UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "usp_UpLoadFileAdd", parms);
        }
    }
}
