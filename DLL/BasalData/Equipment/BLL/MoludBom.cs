using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Equipment.BLL
{
    public class MoludBom
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentRepair 信息。
        /// </summary>
        /// <param name="entity">EquipmentRepair 实体对象。</param>
        public Int32 Edit(MoludBomInfo entity,string dtlJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MouldBomId", SqlDbType.Int),
                new SqlParameter("@BomName", SqlDbType.VarChar, 50),
                new SqlParameter("@InternalDiameter", SqlDbType.Decimal, 20),
                new SqlParameter("@ExternalDiameter", SqlDbType.Decimal, 20),
                new SqlParameter("@Acreage", SqlDbType.Decimal, 20),
                new SqlParameter("@MaxPressure", SqlDbType.Int,4),
                new SqlParameter("@Describe", SqlDbType.VarChar, 500),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@MouldDtl", SqlDbType.NVarChar,Int32.MaxValue)
            };

            parms[0].Value = entity.MouldBomId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.BomName;
            parms[2].Value = entity.InternalDiameter;
            parms[3].Value = entity.ExternalDiameter;
            parms[4].Value = entity.Acreage;
            parms[5].Value = entity.MaxPressure;
            parms[6].Value = entity.Describe;
            parms[7].Value = entity.CreateBy;
            parms[8].Value = dtlJson;


            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMouldBomEdit", parms);

            return (Int32)parms[0].Value;
        }

        /*获取模具BOM明细数据*/
        public List<MoludBomChildInfo> GetMouldBomChildInfo(int mouldBomId)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@MouldBomId",SqlDbType.Int)
            };
            param[0].Value = mouldBomId;
            var list = ComMethod.GetList<MoludBomChildInfo>("uspGetMouldBomChildInfo", param);
            return list;
        }

        /// <summary>
        /// 编辑（添加或更新） EquipmentRepair 信息。
        /// </summary>
        /// <param name="entity">EquipmentRepair 实体对象。</param>
        public Int32 EditBomChild(MoludBomChildInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MouldBomChildId", SqlDbType.Int),
                new SqlParameter("@MouldBomId", SqlDbType.Int,4),
                new SqlParameter("@MouldTypeId", SqlDbType.Int,4),
                new SqlParameter("@ComponentCode", SqlDbType.VarChar),
                new SqlParameter("@Describe", SqlDbType.VarChar,50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 30),
                new SqlParameter("@ReplaceComponentName", SqlDbType.VarChar, 200),
            };

            parms[0].Value = entity.MouldBomChildId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MouldBomId;
            parms[2].Value = entity.MouldTypeId;
            parms[3].Value = entity.ComponentCode;
            parms[4].Value = entity.Describe;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ReplaceComponentName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMouldBomChildEdit", parms);

            return (Int32)parms[0].Value;
        }


       

        /// <summary>
        /// 检验设备号是否存在未完成的换模申请单
        /// </summary>
        /// <param name="itemId"></param>
        /// <returns></returns>
        public int CheckEquimentRepair(int itemId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@EquimentId", SqlDbType.Int,4),
                    new SqlParameter("@Result",SqlDbType.Int,4)
                };
            parms[0].Value = itemId;
            parms[1].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckEquimentMould", parms);

            return Convert.ToInt32(parms[1].Value);
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

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_MouldeBom_Delete", parms);
        }

        /// <summary>
        /// 根据 EquipmentRepairId 字符串删除 EquipmentRepair 信息。
        /// </summary>
        /// <param name="idString">EquipmentRepairId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void DeleteBomChild(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_MouldBomChild_Delete", parms);
        }

        /// <summary>
        /// 根据 cid 获取实体信息。
        /// </summary>
        /// <param name="cid">cid。</param>
        /// <returns>EquipmentRepair 实体对象。</returns>
        public MoludBomInfo GetInfo(Int32 cid)
        {
            MoludBomInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = cid;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MouldBom_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MoludBomInfo();
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]); 
                    entity.InternalDiameter = Convert.ToDecimal(rdr["InternalDiameter"]);
                    entity.ExternalDiameter = Convert.ToDecimal(rdr["ExternalDiameter"]);
                    entity.Acreage = Convert.ToDecimal(rdr["Acreage"]);
                    entity.MaxPressure = Convert.ToInt32(rdr["MaxPressure"]);
                    entity.Describe = Convert.ToString(rdr["Describe"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);

                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 cid 获取实体信息。
        /// </summary>
        /// <param name="cid">cid。</param>
        /// <returns>EquipmentRepair 实体对象。</returns>
        public MoludBomChildInfo GetBomChildInfo(Int32 cid)
        {
            MoludBomChildInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = cid;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MouldBomChild_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MoludBomChildInfo();
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);
                    entity.MouldBomChildId = Convert.ToInt32(rdr["MouldBomChildId"]);
                    entity.MouldTypeId = Convert.ToInt32(rdr["MouldTypeId"]);
                    entity.ComponentCode = Convert.ToString(rdr["ComponentCode"]);
                    entity.EquipmentTypeCode = Convert.ToString(rdr["EquipmentTypeCode"]);
                    entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
                    entity.Describe = Convert.ToString(rdr["Describe"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.ReplaceComponentName = Convert.ToString(rdr["ReplaceComponentName"]);
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
        public List<MoludBomInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MoludBomInfo> list = new List<MoludBomInfo>();
            MoludBomInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vw_Basal_MouldBom", "MouldBomId",
                @" MouldBomId ,
                    BomName,
                    InternalDiameter ,
                    ExternalDiameter ,
                    Acreage ,
                    MaxPressure ,
                    Describe ,
                    CreateBy ,
                    CreateTime,ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MoludBomInfo();
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]);
                    entity.InternalDiameter = Convert.ToDecimal(rdr["InternalDiameter"]);
                    entity.ExternalDiameter = Convert.ToDecimal(rdr["ExternalDiameter"]);
                    entity.Acreage = Convert.ToDecimal(rdr["Acreage"]);
                    entity.MaxPressure = Convert.ToInt32(rdr["MaxPressure"]);
                    entity.Describe = Convert.ToString(rdr["Describe"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
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
        /// 获取申请换模详细信息列表。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <returns>EquipmentRepair 列表。</returns>
        public List<MoludBomChildInfo> GetBomChildAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MoludBomChildInfo> list = new List<MoludBomChildInfo>();
            MoludBomChildInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vWMouldBomChild", "MouldBomChildId",
                @"MouldBomChildId,MouldBomId ,
                    MouldTypeId ,
                    ComponentCode ,
                    Describe ,
                    CreateBy ,
                    CreateTime ,
                    EquipmentTypeCode ,
                    EquipmentTypeName,ReplaceComponentName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MoludBomChildInfo();
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);
                    entity.MouldBomChildId = Convert.ToInt32(rdr["MouldBomChildId"]);
                    entity.MouldTypeId = Convert.ToInt32(rdr["MouldTypeId"]);
                    entity.ComponentCode = Convert.ToString(rdr["ComponentCode"]);
                    entity.EquipmentTypeCode = Convert.ToString(rdr["EquipmentTypeCode"]);
                    entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
                    entity.Describe = Convert.ToString(rdr["Describe"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.ReplaceComponentName = Convert.ToString(rdr["ReplaceComponentName"]);
                    


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