using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ESOP.Model;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.ESOP.BLL
{
    public class ESOP
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ESOP 信息。
        /// </summary>
        /// <param name="entity">ESOP 实体对象。</param>
        public Int32 Edit(ESOPInfo entity)
        {
            DataTable fileTable = new DataTable();
            fileTable.Columns.Add("EsopFileName", typeof(System.String));
            fileTable.Columns.Add("EsopFileUrl", typeof(System.String));
            fileTable.Columns.Add("ItemId", typeof(System.Int32));
            fileTable.Columns.Add("Remark", typeof(System.String));
            fileTable.Columns.Add("IsCurrent", typeof(System.Boolean));
            fileTable.Columns.Add("ModifyBy", typeof(System.String));
            fileTable.Columns.Add("CreateBy", typeof(System.String));
            fileTable.Columns.Add("IsVideo", typeof(System.Boolean));
            fileTable.Columns.Add("FileType", typeof(System.String));
            fileTable.Columns.Add("Sequence", typeof(System.Int32));
            fileTable.Columns.Add("ESOPID", typeof(System.Int32));

            DataTable fileItemTable = new DataTable();
            fileItemTable.Columns.Add("ItemID", typeof(System.Int32));
            fileItemTable.Columns.Add("ESOPFileID", typeof(System.Int32));

            if (entity.FileList.Count > 0)
            {

                foreach (ESOPFileInfo fileInfo in entity.FileList)
                {
                    DataRow row = fileTable.NewRow();
                    row["EsopFileName"] = fileInfo.EsopFileName;
                    row["EsopFileUrl"] = fileInfo.EsopFileUrl;
                    row["ItemId"] = fileInfo.ItemId;
                    row["IsCurrent"] = fileInfo.IsCurrent;
                    row["Remark"] = fileInfo.Remark;
                    row["CreateBy"] = entity.CreateBy;
                    row["ModifyBy"] = entity.ModifyBy;
                    row["IsVideo"] = fileInfo.IsVideo;
                    row["ESOPID"] = fileInfo.ESOPID;
                    row["FileType"] = fileInfo.FileType;
                    row["Sequence"] = fileInfo.Sequence;
                    fileTable.Rows.Add(row);
                }
            }

            if (entity.FileItemList.Count > 0)
            {
                foreach (ESOPFileItemRelation fileItemInfo in entity.FileItemList)
                {
                    DataRow row = fileItemTable.NewRow();
                    row["ESOPFileID"] = fileItemInfo.ESOPFileID;
                    row["ItemId"] = fileItemInfo.ItemID;
                    fileItemTable.Rows.Add(row);
                }
            }

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ESOPID", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@ESOPName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.VarChar, 500),
                new SqlParameter("@FileTable",SqlDbType.Structured),
                new SqlParameter("@FileItemTable",SqlDbType.Structured)
            };

            parms[0].Value = entity.ESOPID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.StationId;
            parms[2].Value = entity.ESOPName;
            parms[3].Value = entity.ModifyBy;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.Remark;
            parms[6].Value = fileTable;
            parms[7].Value = fileItemTable;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ESOP_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ESOPId 字符串删除 ESOP 信息。
        /// </summary>
        /// <param name="idString">ESOPId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(int esopId, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ESOPID", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = esopId;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ESOP_Delete", parms);
        }

        /// <summary>
        /// 根据 ESOPId 获取实体信息。
        /// </summary>
        /// <param name="eSOPId">ESOPId。</param>
        /// <returns>ESOP 实体对象。</returns>
        public ESOPInfo GetInfo(Int32 eSOPId)
        {
            ESOPInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = eSOPId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ESOP_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ESOPInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ESOP 实体对象。</returns>
        public ESOPInfo GetInfo(String fieldValue)
        {
            ESOPInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ESOP_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ESOPInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ESOP 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="eSOPCount">eSOP 总数。</param>
        /// <returns>ESOP 列表。</returns>
        public List<ESOPInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ESOPInfo> list = new List<ESOPInfo>();
            ESOPInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_ESOP", "ESOPId",
                "[ESOPID], [StationId], [ESOPName], [ModifyBy], [ModifyDate], [CreateBy], [CreateDate], [Remark],CutTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ESOPInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8));

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
        ///保存Esop主表信息及ESOP和产品Item关系
        /// </summary>
        /// <param name="stationId">工序ID</param>
        /// <param name="esopName">Esop名称</param>
        /// <param name="CutTime">切屏时间</param>
        /// <param name="ItemIDString">选中的产品ID</param>
        /// <param name="UserName">创建人</param>
        /// <returns></returns>
        public Int32 SaveEsopInItem(int esopId, int stationId, string esopName, int CutTime, string ItemIDString, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@esopId", SqlDbType.Int),
                new SqlParameter("@stationId", SqlDbType.Int),
                new SqlParameter("@esopName", SqlDbType.NVarChar, 50),
                new SqlParameter("@CutTime", SqlDbType.Int),
                new SqlParameter("@ItemIDString", SqlDbType.NVarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = esopId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = stationId;
            parms[2].Value = esopName;
            parms[3].Value = CutTime;
            parms[4].Value = ItemIDString;
            parms[5].Value = UserName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ESOP_EditInItem", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 保存ESOP
        /// </summary>
        /// <param name="esopId">主键ID</param>
        /// <param name="stationId">工序ID</param>
        /// <param name="esopName">ESOP名称</param>
        /// <param name="CutTime">切屏时间</param>
        /// <returns></returns>
        public Int32 SaveEsop(int esopId, int stationId, string esopName, int CutTime, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@esopId", SqlDbType.Int),
                new SqlParameter("@stationId", SqlDbType.Int),
                new SqlParameter("@esopName", SqlDbType.NVarChar, 50),
                new SqlParameter("@CutTime", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = esopId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = stationId;
            parms[2].Value = esopName;
            parms[3].Value = CutTime;
            parms[4].Value = UserName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ESOP_EditInfo", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 删除esop产品关系
        /// </summary>
        /// <param name="stationId">工序</param>
        /// <param name="esopName">esop名称</param>
        /// <param name="ItemIDString">产品ID</param>
        public void RemoveEsopOutItem(int stationId, string esopName, string ItemIDString, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@stationId", SqlDbType.Int),
                new SqlParameter("@esopName", SqlDbType.VarChar, 20),
                new SqlParameter("@ItemIDString", SqlDbType.VarChar, 4000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 50)
            };

            parms[0].Value = stationId;
            parms[1].Value = esopName;
            parms[2].Value = ItemIDString;
            parms[3].Value = UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ESOPFile_ItemDelete", parms);
        }


        /// <summary>
        /// 根据条件获取esop
        /// </summary>
        /// <param name="operationId">工序</param>
        /// <param name="resId">资源</param>
        /// <returns>esop文件信息列表</returns>
        public List<ESOPFileInfo> GetEsopListByField(int operationId, int resId)
        {
            List<ESOPFileInfo> list = new List<ESOPFileInfo>();
            ESOPFileInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@operationId", SqlDbType.Int),
                new SqlParameter("@resId", SqlDbType.Int)
            };
            parms[0].Value = operationId;
            parms[1].Value = resId;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Prod_ESOP_GetInfo", parms))
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    entity = new ESOPFileInfo();
                    entity.ESOPID = Convert.ToInt32(dt.Rows[i]["ESOPID"]);
                    entity.EsopFileId = Convert.ToInt32(dt.Rows[i]["ESOPFileID"]);
                    entity.EsopFileName = dt.Rows[i]["EsopFileName"].ToString();
                    entity.EsopFileUrl = dt.Rows[i]["EsopFileUrl"].ToString();
                    entity.FileType = dt.Rows[i]["FileType"].ToString();

                    entity.CreateBy = dt.Rows[i]["CreateBy"].ToString();
                    entity.CreateDate = Convert.ToDateTime(dt.Rows[i]["CreateDate"]);
                    entity.ModifyBy = dt.Rows[i]["ModifyBy"].ToString();
                    entity.ModifyDate = Convert.ToDateTime(dt.Rows[i]["ModifyDate"]);
                    entity.CutTime = Convert.ToInt32(dt.Rows[i]["CutTime"]);
                    entity.ItemId = Convert.ToInt32(dt.Rows[i]["ItemID"]);
                    entity.ItemSpec = dt.Rows[i]["ItemSpec"].ToString();

                    list.Add(entity);
                }
            }
            return list;


        }
      
    }
}
