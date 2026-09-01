using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class MoludAbnormal
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑（添加或更新） EquipmentRepair 信息。
        /// </summary>
        /// <param name="entity">EquipmentRepair 实体对象。</param>
        public Int32 Add(MoludAbnormalInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@MouldBomId", SqlDbType.Int, 4),
                new SqlParameter("@EquimentId", SqlDbType.Int, 4),
                new SqlParameter("@ResourceTypeId", SqlDbType.Int, 4),
                new SqlParameter("@AbnormalReason", SqlDbType.VarChar, 500),
                new SqlParameter("@AbnormalPhenomenon", SqlDbType.VarChar, 500),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@StartTime", SqlDbType.DateTime),
                new SqlParameter("@PicFile", SqlDbType.VarChar,100)
            };

            parms[0].Value = entity.Id;
            parms[1].Value = entity.MouldBomId;
            parms[2].Value = entity.EquipmentId;
            parms[3].Value = entity.ResourceTypeId;
            parms[4].Value = entity.AbnormalReason;
            parms[5].Value = entity.AbnormalPhenomenon;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.StartTime;
            parms[8].Value = entity.PicFile;
 
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "usp_MouldAbnormalAdd", parms);

            return (Int32)parms[0].Value;
        }
        /// <summary>
        /// 编辑（添加或更新） EquipmentRepair 信息。
        /// </summary>
        /// <param name="entity">EquipmentRepair 实体对象。</param>
        public Int32 Edit(MoludAbnormalInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@MouldBomId", SqlDbType.Int, 4),
                new SqlParameter("@EquimentId", SqlDbType.Int, 4),
                new SqlParameter("@AnormalTypeId", SqlDbType.Int, 4),
                new SqlParameter("@ResourceTypeId", SqlDbType.Int, 4),
                new SqlParameter("@AbnormalReason", SqlDbType.VarChar, 500),
                new SqlParameter("@AbnormalPhenomenon", SqlDbType.VarChar, 500),
                new SqlParameter("@Conclusion", SqlDbType.VarChar,100),
                new SqlParameter("@HandlePerson", SqlDbType.VarChar, 20),
                new SqlParameter("@MangerPerson", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@StartTime", SqlDbType.DateTime),
                new SqlParameter("@EndTime", SqlDbType.DateTime),
                new SqlParameter("@PicFile", SqlDbType.VarChar,100),
                new SqlParameter("@IsLeak", SqlDbType.Int, 4),
                new SqlParameter("@Rcca", SqlDbType.VarChar, 200),
                new SqlParameter("@Remark", SqlDbType.VarChar, 500),
                new SqlParameter("@DocXml", SqlDbType.VarChar)
            };

            parms[0].Value = entity.Id;
            parms[1].Value = entity.MouldBomId;
            parms[2].Value = entity.EquipmentId;
            parms[3].Value = entity.AnormalTypeId;
            parms[4].Value = entity.ResourceTypeId;
            parms[5].Value = entity.AbnormalReason;
            parms[6].Value = entity.AbnormalPhenomenon;
            parms[7].Value = entity.Conclusion;
            parms[8].Value = entity.HandlePerson;
            parms[9].Value = entity.MangerPerson;
            parms[10].Value = entity.CreateBy;
            parms[11].Value = entity.StartTime;
            parms[12].Value = entity.EndTime;
            parms[13].Value = entity.PicFile;
            parms[14].Value = entity.IsLeak;
            parms[15].Value = entity.Rcca;
            parms[16].Value = entity.Remark;
            parms[17].Value = entity.DocXml;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "usp_MouldAbnormalEdit", parms);

            return (Int32)parms[0].Value;
        }



        /// <summary>
        /// 编辑（添加或更新） EquipmentRepair 信息。
        /// </summary>
        /// <param name="entity">EquipmentRepair 实体对象。</param>
        public Int32 Audit(MoludAbnormalInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.VarChar, 500)

            };

            parms[0].Value = entity.Id;
            parms[1].Value = entity.CreateBy;
            parms[2].Value = entity.Remark;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "usp_MouldAbnormalAudit", parms);

            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 根据 EquipmentRepairId 字符串删除 EquipmentRepair 信息。
        /// </summary>
        /// <param name="idString">EquipmentRepairId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_MouldAbnormal_Delete", parms);
        }

        /// <summary>
        /// 根据 cid 获取实体信息。
        /// </summary>
        /// <param name="id">cid。</param>
        /// <returns>EquipmentRepair 实体对象。</returns>
        public MoludAbnormalInfo GetInfo(Int32 id)
        {
            MoludAbnormalInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = id;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MouldAbnormal_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MoludAbnormalInfo();
                    entity.Id = Convert.ToInt32(rdr["id"]);
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]);
                   
                    entity.EquipmentId = Convert.ToInt32(rdr["EquipmentId"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);

                    entity.AnormalTypeId = Convert.ToInt32(rdr["AnormalTypeId"]);
                    entity.AnormalTypeCode = Convert.ToString(rdr["AnormalTypeCode"]);
                    entity.AnormalTypeName = Convert.ToString(rdr["AnormalTypeName"]);

                    entity.ResourceTypeId = Convert.ToInt32(rdr["ResourceTypeId"]);
                    entity.ResTypeName = Convert.ToString(rdr["ResTypeName"]);

                    entity.AbnormalReason = Convert.ToString(rdr["AbnormalReason"]);
                    entity.AbnormalPhenomenon = Convert.ToString(rdr["AbnormalPhenomenon"]);

                    entity.Conclusion = Convert.ToString(rdr["Conclusion"]);
                    entity.HandlePerson = Convert.ToString(rdr["HandlePerson"]);
                    entity.MangerPerson = Convert.ToString(rdr["MangerPerson"]);

                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.StartTime = Convert.ToDateTime(rdr["StartTime"]);
                    entity.EndTime = Convert.ToDateTime(rdr["EndTime"]);

                    entity.IsLeak = Convert.ToInt32(rdr["IsLeak"]);
                    entity.PicFile = Convert.ToString(rdr["PicFile"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.Rcca = Convert.ToString(rdr["Rcca"]);
                    entity.Status = Convert.ToInt32(rdr["Status"]);
                    entity.StatusStr = Convert.ToString(rdr["StatusStr"]);
                    entity.AuditBy = Convert.ToString(rdr["AuditBy"]);
                    entity.AuditTime = Convert.ToDateTime(rdr["AuditTime"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>EquipmentRepair 实体对象。</returns>
        public MoludAbnormalInfo GetInfo(String fieldValue)
        {
            MoludAbnormalInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MouldAbnormal_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MoludAbnormalInfo();
                    entity.Id = Convert.ToInt32(rdr["id"]);
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]);
                    entity.EquipmentId = Convert.ToInt32(rdr["EquipmentId"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);

                    entity.AnormalTypeId = Convert.ToInt32(rdr["AnormalTypeId"]);
                    entity.AnormalTypeCode = Convert.ToString(rdr["AnormalTypeCode"]);
                    entity.AnormalTypeName = Convert.ToString(rdr["AnormalTypeName"]);

                    entity.ResourceTypeId = Convert.ToInt32(rdr["ResourceTypeId"]);
                    entity.ResTypeName = Convert.ToString(rdr["ResTypeName"]);

                    entity.AbnormalReason = Convert.ToString(rdr["AbnormalReason"]);
                    entity.AbnormalPhenomenon = Convert.ToString(rdr["AbnormalPhenomenon"]);

                    entity.Conclusion = Convert.ToString(rdr["Conclusion"]);
                    entity.HandlePerson = Convert.ToString(rdr["HandlePerson"]);
                    entity.MangerPerson = Convert.ToString(rdr["MangerPerson"]);

                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.StartTime = Convert.ToDateTime(rdr["StartTime"]);
                    entity.EndTime = Convert.ToDateTime(rdr["EndTime"]);

                    entity.IsLeak = Convert.ToInt32(rdr["IsLeak"]);
                    entity.PicFile = Convert.ToString(rdr["PicFile"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.Rcca = Convert.ToString(rdr["Rcca"]);
                    entity.Status = Convert.ToInt32(rdr["Status"]);
                    entity.StatusStr = Convert.ToString(rdr["StatusStr"]);
                    entity.AuditBy = Convert.ToString(rdr["AuditBy"]);
                    entity.AuditTime = Convert.ToDateTime(rdr["AuditTime"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EquipmentRepair 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="equipmentRepairCount">equipmentRepair 总数。</param>
        /// <returns>EquipmentRepair 列表。</returns>
        public List<MoludAbnormalInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MoludAbnormalInfo> list = new List<MoludAbnormalInfo>();
            MoludAbnormalInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vWMouldAbnormal", "id",
                @"Id,MouldBomId ,
		 BomName,
         EquipmentId ,
		 EquipmentCode,
		 EquipmentName,
          AnormalTypeId ,
		 AnormalTypeCode,
		  AnormalTypeName,
         ResourceTypeId ,
		 ResTypeName,
          AbnormalReason ,
          AbnormalPhenomenon ,
          Conclusion ,
          HandlePerson ,
          MangerPerson ,
          CreateBy ,
          CreateTime ,
          StartTime ,
          EndTime ,
          PicFile ,
          IsLeak ,
          Rcca,
          Status,
		  AuditTime,
          StatusStr,
		  AuditBy,
          Remark,CName,ModifyCname", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MoludAbnormalInfo();
                    entity.Id = Convert.ToInt32(rdr["id"]);
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]);
                    entity.EquipmentId = Convert.ToInt32(rdr["EquipmentId"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                
                    entity.AnormalTypeId = Convert.ToInt32(rdr["AnormalTypeId"]);
                    entity.AnormalTypeCode = Convert.ToString(rdr["AnormalTypeCode"]);
                    entity.AnormalTypeName = Convert.ToString(rdr["AnormalTypeName"]);

                    entity.ResourceTypeId = Convert.ToInt32(rdr["ResourceTypeId"]);
                    entity.ResTypeName = Convert.ToString(rdr["ResTypeName"]);

                    entity.AbnormalReason = Convert.ToString(rdr["AbnormalReason"]);
                    entity.AbnormalPhenomenon = Convert.ToString(rdr["AbnormalPhenomenon"]);

                    entity.Conclusion = Convert.ToString(rdr["Conclusion"]);
                    entity.HandlePerson = Convert.ToString(rdr["HandlePerson"]);
                    entity.MangerPerson = Convert.ToString(rdr["MangerPerson"]);

                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.StartTime = Convert.ToDateTime(rdr["StartTime"]);
                    entity.EndTime = Convert.ToDateTime(rdr["EndTime"]);
              
                    entity.IsLeak = Convert.ToInt32(rdr["IsLeak"]);
                    entity.PicFile = Convert.ToString(rdr["PicFile"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);

                    entity.Status = Convert.ToInt32(rdr["Status"]);
                    entity.StatusStr = Convert.ToString(rdr["StatusStr"]);
                    entity.AuditBy = Convert.ToString(rdr["AuditBy"]);
                    entity.AuditTime = Convert.ToDateTime(rdr["AuditTime"]);
                    entity.Rcca= Convert.ToString(rdr["Rcca"]); 
                    entity.CName= Convert.ToString(rdr["CName"]);
                    entity.ModifyCname = Convert.ToString(rdr["ModifyCname"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 分页获取 EquipmentRepair 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <returns>EquipmentRepair 列表。</returns>
        public List<MouldAbnormalDetail> GetDetailAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MouldAbnormalDetail> list = new List<MouldAbnormalDetail>();
            MouldAbnormalDetail entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_MouldAbnormalDetail", "DetailId",
                @"DetailId,MouldAbnormalId ,
              MouldType ,
              CompomentCode ,
              Describe ,
              MouldCode ,
              CreateTime,MouldBomChildId", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MouldAbnormalDetail();
                    entity.DetailId = Convert.ToInt32(rdr["DetailId"]);
                    entity.MouldAbnormalId = Convert.ToInt32(rdr["MouldAbnormalId"]);
                    entity.MouldType = Convert.ToString(rdr["MouldType"]);
                    entity.CompomentCode = Convert.ToString(rdr["CompomentCode"]);
                    entity.Describe = Convert.ToString(rdr["Describe"]);
                    entity.MouldCode = Convert.ToString(rdr["MouldCode"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.MouldBomChildId = Convert.ToInt32(rdr["MouldBomChildId"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// 编辑（添加或更新） EquipmentRepair 信息。
        /// </summary>
        /// <param name="cid">EquipmentRepair 实体对象。</param>
        /// <param name="operators">EquipmentRepair 实体对象。</param>
        public Int32 EditOperator(int id, string operators)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@Operator", SqlDbType.VarChar),
            };

            parms[0].Value = id;
            parms[1].Value = operators;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMoludAbnormalEditOperator", parms);

            return (Int32)parms[0].Value;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}