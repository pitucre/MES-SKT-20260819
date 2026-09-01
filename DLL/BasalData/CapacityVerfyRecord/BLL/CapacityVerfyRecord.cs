using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.CapacityVerfyRecord.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.CapacityVerfyRecord.BLL
{
    public class CapacityVerfyRecord
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） CapacityVerfyRecord 信息。
        /// </summary>
        /// <param name="entity">CapacityVerfyRecord 实体对象。</param>
        public Int32 Edit(CapacityVerfyRecordInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@VerfyType", SqlDbType.Int),
                new SqlParameter("@OperateId", SqlDbType.Int),
                new SqlParameter("@EquipmentId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@Salary", SqlDbType.Decimal),
                new SqlParameter("@Qty", SqlDbType.Decimal),
                new SqlParameter("@NGQty", SqlDbType.Decimal),
                new SqlParameter("@CreateTime", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@UserID", SqlDbType.Int),
                new SqlParameter("@QueryDate", SqlDbType.DateTime),
                new SqlParameter("@Remark", SqlDbType.VarChar, 50),
                new SqlParameter("@PieceWageID", SqlDbType.Int),
                new SqlParameter("@Price", SqlDbType.Decimal),
                new SqlParameter("@State", SqlDbType.Int),
                new SqlParameter("@Modifyby", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.VerfyType;
            parms[2].Value = entity.OperateId;
            parms[3].Value = entity.EquipmentId;
            parms[4].Value = entity.ItemId;
            parms[5].Value = entity.Salary;
            parms[6].Value = entity.Qty;
            parms[7].Value = entity.NGQty;
            parms[8].Value = entity.CreateTime;
            parms[9].Value = entity.CreateBy;
            parms[10].Value = entity.UserID;
            parms[11].Value = entity.QueryDate;
            parms[12].Value = entity.Remark;
            parms[13].Value = entity.PieceWageID;
            parms[14].Value = entity.Price;
            parms[15].Value = entity.State;
            parms[16].Value = entity.Modifyby;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_CapacityVerfyRecord_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 修改工资
        /// </summary>
        /// <param name="ID"></param>
        /// <param name="Salary"></param>
        /// <param name="ModifyBy"></param>
        /// <returns></returns>
        public Int32 Update(int ID, string Salary, string ModifyBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@Salary", SqlDbType.Decimal),
                new SqlParameter("@Modifyby", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = ID;
            parms[1].Value = Salary;
            parms[2].Value = ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SaveUpdateCapacityVerfyRecord", parms);

            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 审核
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void Audit(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 100)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "UspCapacityVerfyRecordAudit", parms);
        }

        /// <summary>
        /// 根据 CapacityVerfyRecordId 字符串删除 CapacityVerfyRecord 信息。
        /// </summary>
        /// <param name="idString">CapacityVerfyRecordId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_CapacityVerfyRecord_Delete", parms);
        }

        /// <summary>
        /// 根据 CapacityVerfyRecordId 获取实体信息。
        /// </summary>
        /// <param name="capacityVerfyRecordId">CapacityVerfyRecordId。</param>
        /// <returns>CapacityVerfyRecord 实体对象。</returns>
        public CapacityVerfyRecordInfo GetInfo(Int32 capacityVerfyRecordId)
        {
            CapacityVerfyRecordInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = capacityVerfyRecordId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_CapacityVerfyRecord_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CapacityVerfyRecordInfo();
                    entity.ID = Convert.ToInt32(rdr[0]);
                    entity.UserName = Convert.ToString(rdr[1]);
                    entity.NO = Convert.ToString(rdr[2]);
                    entity.QueryDate = Convert.ToDateTime(rdr[3]);
                    entity.OperateId = Convert.ToInt32(rdr[4]);
                    entity.Station = Convert.ToString(rdr[5]);
                    entity.EquipmentId = Convert.ToInt32(rdr[6]);
                    entity.EquipmentCode = Convert.ToString(rdr[7]);
                    entity.ItemId = Convert.ToInt32(rdr[8]);
                    entity.ItemCode = Convert.ToString(rdr[9]);
                    entity.ItemName = Convert.ToString(rdr[10]);
                    entity.Qty = Convert.ToDecimal(rdr[11]);
                    entity.Price = Convert.ToDecimal(rdr[12]);
                    entity.Salary = Convert.ToDecimal(rdr[13]);
                    entity.CreateTime = Convert.ToDateTime(rdr[14]);
                    entity.CreateBy = Convert.ToString(rdr[15]);
                    entity.Remark = Convert.ToString(rdr[16]);
                    entity.AuditingSalary = Convert.ToDecimal(rdr[17]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 CapacityVerfyRecord 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="capacityVerfyRecordCount">capacityVerfyRecord 总数。</param>
        /// <returns>CapacityVerfyRecord 列表。</returns>
        public List<CapacityVerfyRecordInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CapacityVerfyRecordInfo> list = new List<CapacityVerfyRecordInfo>();
            CapacityVerfyRecordInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwCapacityVerfyRecord", "ID",
                "ID,UserName,NO,QueryDate,StationId,Station,EquipmentId,EquipmentCode,ItemID,ItemCode,ItemName,Qty,Price,Salary,CreateTime,CreateBy,Remark,State,AuditingSalary", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new CapacityVerfyRecordInfo();
                    entity.ID = Convert.ToInt32(rdr[0]);
                    entity.UserName = Convert.ToString(rdr[1]);
                    entity.NO = Convert.ToString(rdr[2]);
                    entity.QueryDate = Convert.ToDateTime(rdr[3]);
                    entity.OperateId= Convert.ToInt32(rdr[4]);
                    entity.Station = Convert.ToString(rdr[5]);
                    entity.EquipmentId = Convert.ToInt32(rdr[6]);
                    entity.EquipmentCode = Convert.ToString(rdr[7]);
                    entity.ItemId = Convert.ToInt32(rdr[8]);
                    entity.ItemCode = Convert.ToString(rdr[9]);
                    entity.ItemName = Convert.ToString(rdr[10]);
                    entity.Qty = Convert.ToDecimal(rdr[11]);
                    entity.Price = Convert.ToDecimal(rdr[12]);
                    entity.Salary = Convert.ToDecimal(rdr[13]);
                    entity.CreateTime = Convert.ToDateTime(rdr[14]);
                    entity.CreateBy = Convert.ToString(rdr[15]);
                    entity.Remark = Convert.ToString(rdr[16]);
                    entity.State = Convert.ToInt32(rdr[17]);
                    entity.AuditingSalary = Convert.ToDecimal(rdr[18]);
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

    }
}