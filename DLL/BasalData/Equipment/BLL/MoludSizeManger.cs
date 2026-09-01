using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Linq;

namespace SKT.LeanMES.Equipment.BLL
{
    public class MoludSizeManger
    {
        private Int32 recordCount = 0;


        /// <summary>
        /// 编辑（添加或更新） EquipmentRepair 信息。
        /// </summary>
        /// <param name="entity">EquipmentRepair 实体对象。</param>
        public Int32 Edit(MoludSizeMangerInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MsmId", SqlDbType.Int),
                new SqlParameter("@MouldId", SqlDbType.Int),
                new SqlParameter("@MouldBomId", SqlDbType.Int),
                new SqlParameter("@MouldTypeId", SqlDbType.Int),
                new SqlParameter("@ExternalDiameter1", SqlDbType.Decimal),
                new SqlParameter("@ExternalDiameter2", SqlDbType.Decimal),
                new SqlParameter("@ExternalDiameter3", SqlDbType.Decimal),
                new SqlParameter("@ExternalDiameterAvg", SqlDbType.Decimal),
                new SqlParameter("@InternalDiameter1", SqlDbType.Decimal),
                new SqlParameter("@InternalDiameter2", SqlDbType.Decimal),
                new SqlParameter("@InternalDiameter3", SqlDbType.Decimal),
                new SqlParameter("@InternalDiameterAvg", SqlDbType.Decimal),
                new SqlParameter("@Hardness", SqlDbType.Int),
                new SqlParameter("@Result", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar,20),
                new SqlParameter("@Remark", SqlDbType.NVarChar),
                new SqlParameter("@ExternalDiameterMin", SqlDbType.Decimal),
                new SqlParameter("@ExternalDiameterMax", SqlDbType.Decimal),
                new SqlParameter("@InternalDiameterMin", SqlDbType.Decimal),
                new SqlParameter("@InternalDiameterMax", SqlDbType.Decimal),
                 new SqlParameter("@TestItem3_1", SqlDbType.Decimal),
                new SqlParameter("@TestItem3_2", SqlDbType.Decimal),
                new SqlParameter("@TestItem3_3", SqlDbType.Decimal),
                new SqlParameter("@TestItem3Avg", SqlDbType.Decimal),
                 new SqlParameter("@TestItem3Min", SqlDbType.Decimal),
                new SqlParameter("@TestItem3Max", SqlDbType.Decimal),
                new SqlParameter("@Units", SqlDbType.NVarChar),
            };

            parms[0].Value = entity.MsmId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MouldId;
            parms[2].Value = entity.MouldBomId;
            parms[3].Value = entity.MouldTypeId;
            parms[4].Value = entity.ExternalDiameter1;
            parms[5].Value = entity.ExternalDiameter2;
            parms[6].Value = entity.ExternalDiameter3;
            parms[7].Value = entity.ExternalDiameterAvg;
            parms[8].Value = entity.InternalDiameter1;
            parms[9].Value = entity.InternalDiameter2;
            parms[10].Value = entity.InternalDiameter3;
            parms[11].Value = entity.InternalDiameterAvg;
            parms[12].Value = entity.Hardness;
            parms[13].Value = entity.Result;
            parms[14].Value = entity.CreateBy;
            parms[15].Value = entity.Remark;
            parms[16].Value = entity.ExternalDiameterMin;
            parms[17].Value = entity.ExternalDiameterMax;
            parms[18].Value = entity.InternalDiameterMin;
            parms[19].Value = entity.InternalDiameterMax;
            parms[20].Value = entity.TestItem3_1;
            parms[21].Value = entity.TestItem3_2;
            parms[22].Value = entity.TestItem3_3;
            parms[23].Value = entity.TestItem3Avg;
            parms[24].Value = entity.TestItem3Min;
            parms[25].Value = entity.TestItem3Max;
            parms[26].Value = entity.Units;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCreateMouldSizeManagerEdit", parms);

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

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_MouldSizeManger_Delete", parms);
        }

        /// <summary>
        /// 根据 cid 获取实体信息。
        /// </summary>
        /// <param name="id">cid。</param>
        /// <returns>EquipmentRepair 实体对象。</returns>
        public MoludSizeMangerInfo GetInfo(Int32 id)
        {
            MoludSizeMangerInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = id;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MouldSizeManager_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MoludSizeMangerInfo();
                    entity.MsmId = Convert.ToInt32(rdr["MsmId"]);
                    entity.MouldId = Convert.ToInt32(rdr["MouldId"]);
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);
                    entity.MouldTypeId = Convert.ToInt32(rdr["MouldTypeId"]);
                    entity.ExternalDiameter1 = Convert.ToDecimal(rdr["ExternalDiameter1"]);
                    entity.ExternalDiameter2 = Convert.ToDecimal(rdr["ExternalDiameter2"]);
                    entity.ExternalDiameter3 = Convert.ToDecimal(rdr["ExternalDiameter3"]);
                    entity.ExternalDiameterAvg = Convert.ToDecimal(rdr["ExternalDiameterAvg"]);
                    entity.InternalDiameter1 = Convert.ToDecimal(rdr["InternalDiameter1"]);
                    entity.InternalDiameter2 = Convert.ToDecimal(rdr["InternalDiameter2"]);
                    entity.InternalDiameter3 = Convert.ToDecimal(rdr["InternalDiameter3"]);
                    entity.InternalDiameterAvg = Convert.ToDecimal(rdr["InternalDiameterAvg"]);
                    entity.Hardness = Convert.ToInt32(rdr["Hardness"]);
                    entity.Result = Convert.ToInt32(rdr["Result"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.MouldeCode = Convert.ToString(rdr["MouldeCode"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]);
                    entity.MouldTypeCode = Convert.ToString(rdr["MouldTypeCode"]);
                    entity.MouldTypeName = Convert.ToString(rdr["MouldTypeName"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.ExternalDiameterMin = Convert.ToDecimal(rdr["ExternalDiameterMin"]);
                    entity.ExternalDiameterMax = Convert.ToDecimal(rdr["ExternalDiameterMax"]);
                    entity.InternalDiameterMin = Convert.ToDecimal(rdr["InternalDiameterMin"]);
                    entity.InternalDiameterMax = Convert.ToDecimal(rdr["InternalDiameterMax"]);
                    entity.TestItem3_1 = Convert.ToDecimal(rdr["TestItem3_1"]); 
                    entity.TestItem3_2 = Convert.ToDecimal(rdr["TestItem3_2"]); 
                    entity.TestItem3_3 = Convert.ToDecimal(rdr["TestItem3_3"]); 
                    entity.TestItem3Avg = Convert.ToDecimal(rdr["TestItem3Avg"]); 
                    entity.TestItem3Min = Convert.ToDecimal(rdr["TestItem3Min"]); 
                    entity.TestItem3Max = Convert.ToDecimal(rdr["TestItem3Max"]);
                    entity.Units = Convert.ToString(rdr["Units"]);
                    entity.ComponentName = Convert.ToString(rdr["ComponentName"]);
                    entity.TestCount = Convert.ToInt32(rdr["TestCount"]);
                    entity.UseCount = Convert.ToInt32(rdr["UseCount"]);
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
        public MoludSizeMangerInfo GetInfo(String fieldValue)
        {
            MoludSizeMangerInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MouldSizeManager_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MoludSizeMangerInfo();
                    entity.MsmId = Convert.ToInt32(rdr["MsmId"]);
                    entity.MouldId = Convert.ToInt32(rdr["MouldId"]);
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);
                    entity.MouldTypeId = Convert.ToInt32(rdr["MouldTypeId"]);
                    entity.ExternalDiameter1 = Convert.ToDecimal(rdr["ExternalDiameter1"]);
                    entity.ExternalDiameter2 = Convert.ToDecimal(rdr["ExternalDiameter2"]);
                    entity.ExternalDiameter3 = Convert.ToDecimal(rdr["ExternalDiameter3"]);
                    entity.ExternalDiameterAvg = Convert.ToDecimal(rdr["ExternalDiameterAvg"]);
                    entity.InternalDiameter1 = Convert.ToDecimal(rdr["InternalDiameter1"]);
                    entity.InternalDiameter2 = Convert.ToDecimal(rdr["InternalDiameter2"]);
                    entity.InternalDiameter3 = Convert.ToDecimal(rdr["InternalDiameter3"]);
                    entity.InternalDiameterAvg = Convert.ToDecimal(rdr["InternalDiameterAvg"]);
                    entity.Hardness = Convert.ToInt32(rdr["Hardness"]);
                    entity.Result = Convert.ToInt32(rdr["Result"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.MouldeCode = Convert.ToString(rdr["MouldeCode"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]);
                    entity.MouldTypeCode = Convert.ToString(rdr["MouldTypeCode"]);
                    entity.MouldTypeName = Convert.ToString(rdr["MouldTypeName"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.ExternalDiameterMin = Convert.ToDecimal(rdr["ExternalDiameterMin"]);
                    entity.ExternalDiameterMax = Convert.ToDecimal(rdr["ExternalDiameterMax"]);
                    entity.InternalDiameterMin = Convert.ToDecimal(rdr["InternalDiameterMin"]);
                    entity.InternalDiameterMax = Convert.ToDecimal(rdr["InternalDiameterMax"]);
                    entity.TestItem3_1 = Convert.ToDecimal(rdr["TestItem3_1"]);
                    entity.TestItem3_2 = Convert.ToDecimal(rdr["TestItem3_2"]);
                    entity.TestItem3_3 = Convert.ToDecimal(rdr["TestItem3_3"]);
                    entity.TestItem3Avg = Convert.ToDecimal(rdr["TestItem3Avg"]);
                    entity.TestItem3Min = Convert.ToDecimal(rdr["TestItem3Min"]);
                    entity.TestItem3Max = Convert.ToDecimal(rdr["TestItem3Max"]);
                    entity.Units = Convert.ToString(rdr["Units"]);
                    entity.ComponentName = Convert.ToString(rdr["ComponentName"]);
                    entity.TestCount = Convert.ToInt32(rdr["TestCount"]);
                    entity.UseCount = Convert.ToInt32(rdr["UseCount"]);
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
        public List<MoludSizeMangerInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MoludSizeMangerInfo> list = new List<MoludSizeMangerInfo>();
            MoludSizeMangerInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vWMouldSizeManager", "MsmId",
                @"MsmId ,
        MouldId ,
        MouldBomId ,
        MouldTypeId ,
        ExternalDiameter1 ,
        ExternalDiameter2 ,
        ExternalDiameter3 ,
        ExternalDiameterAvg ,
        InternalDiameter1 ,
        InternalDiameter2 ,
        InternalDiameter3 ,
        InternalDiameterAvg ,
        Hardness ,
        Result ,
        CreateBy ,
        CreateTime ,
        MouldeCode ,
        BomName ,
        MouldTypeCode ,
        MouldTypeName,
        Remark,
        TestItem3_1,
		TestItem3_2,
		TestItem3_3,
		TestItem3Avg,
        Units,
        ComponentName,
        TestCount,
        UseCount,ModifyBy,ModifyTime
		 ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MoludSizeMangerInfo();
                    entity.MsmId = Convert.ToInt32(rdr["MsmId"]);
                    entity.MouldId = Convert.ToInt32(rdr["MouldId"]);
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);
                    entity.MouldTypeId = Convert.ToInt32(rdr["MouldTypeId"]);
                    entity.ExternalDiameter1 = Convert.ToDecimal(rdr["ExternalDiameter1"]);
                    entity.ExternalDiameter2 = Convert.ToDecimal(rdr["ExternalDiameter2"]);
                    entity.ExternalDiameter3 = Convert.ToDecimal(rdr["ExternalDiameter3"]);
                    entity.ExternalDiameterAvg = Convert.ToDecimal(rdr["ExternalDiameterAvg"]);
                    entity.InternalDiameter1 = Convert.ToDecimal(rdr["InternalDiameter1"]);
                    entity.InternalDiameter2 = Convert.ToDecimal(rdr["InternalDiameter2"]);
                    entity.InternalDiameter3 = Convert.ToDecimal(rdr["InternalDiameter3"]);
                    entity.InternalDiameterAvg = Convert.ToDecimal(rdr["InternalDiameterAvg"]);
                    entity.Hardness = Convert.ToInt32(rdr["Hardness"]);
                    entity.Result = Convert.ToInt32(rdr["Result"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.MouldeCode = Convert.ToString(rdr["MouldeCode"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]);
                    entity.MouldTypeCode = Convert.ToString(rdr["MouldTypeCode"]);
                    entity.MouldTypeName = Convert.ToString(rdr["MouldTypeName"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.TestItem3_1 = Convert.ToDecimal(rdr["TestItem3_1"]);
                    entity.TestItem3_2 = Convert.ToDecimal(rdr["TestItem3_2"]);
                    entity.TestItem3_3 = Convert.ToDecimal(rdr["TestItem3_3"]);
                    entity.TestItem3Avg = Convert.ToDecimal(rdr["TestItem3Avg"]);
                    entity.Units = Convert.ToString(rdr["Units"]);
                    entity.ComponentName = Convert.ToString(rdr["ComponentName"]);
                    entity.TestCount = Convert.ToInt32(rdr["TestCount"]);
                    entity.UseCount = Convert.ToInt32(rdr["UseCount"]);

                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyTime"))) {
                        entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                        entity.ModifyTime = Convert.ToDateTime(rdr["ModifyTime"]);
                    }

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取尺寸操作历史
        /// </summary>
        /// <param name="MsmId"></param>
        /// <returns></returns>
        public List<MoludSizeMangerInfo> GetMoludSizeManageHistory(int MsmId)
        {
            string sql = "select * from vWMouldSizeManagerHistory where msmid=@MsmId";
            SqlParameter[] parm = new SqlParameter[]
            {
                 new SqlParameter("@MsmId", SqlDbType.Int),
            };
            parm[0].Value = MsmId;

            var list =  CommonHelper.BLL.ComMethod.GetListBySql<MoludSizeMangerInfo>(sql, parm);
            return list.OrderByDescending(q => q.CreateTime).ToList();
        }


        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}