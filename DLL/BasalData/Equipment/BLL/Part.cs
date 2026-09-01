using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class Part
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Part 信息。
        /// </summary>
        /// <param name="entity">Part 实体对象。</param>
        public Int32 Edit(PartInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PartId", SqlDbType.Int),
                new SqlParameter("@PartName", SqlDbType.NVarChar, 50),
                new SqlParameter("@PartCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@EquimentTypeId", SqlDbType.Int),
                new SqlParameter("@PartStand", SqlDbType.NVarChar, 50),
                new SqlParameter("@FactoryId", SqlDbType.Int),

                new SqlParameter("@PartSupplierId", SqlDbType.Int),
                new SqlParameter("@Position", SqlDbType.Int),
                new SqlParameter("@PartLive", SqlDbType.NVarChar, 50),
                new SqlParameter("@MinStock", SqlDbType.Int),
                new SqlParameter("@MaxStock", SqlDbType.Int),
                new SqlParameter("@CurrentStock", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@Qty", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50),
                new SqlParameter("@Unitname", SqlDbType.VarChar, 50)

            };

            parms[0].Value = entity.PartId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.PartName;
            parms[2].Value = entity.PartCode;
            parms[3].Value = entity.EquipmentTypeId;
            parms[4].Value = entity.PartStand;
            parms[5].Value = entity.FactoryId;
            parms[6].Value = entity.PartSupplierId;
            parms[7].Value = entity.Position;
            parms[8].Value = entity.PartLive;
            parms[9].Value = entity.MinStock;
            parms[10].Value = entity.MaxStock;
            parms[11].Value = entity.CurrentStock;
            parms[12].Value = entity.Remark;
            parms[13].Value = entity.Qty;
            parms[14].Value = entity.CreateBy;
            parms[15].Value = entity.ModifyBy;
            parms[16].Value = entity.UnitName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Part_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PartId 字符串删除 Part 信息。
        /// </summary>
        /// <param name="idString">PartId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Part_Delete", parms);
        }

        /// <summary>
        /// 根据 PartId 获取实体信息。
        /// </summary>
        /// <param name="partId">PartId。</param>
        /// <returns>Part 实体对象。</returns>
        public PartInfo GetInfo(Int32 partId)
        {
            PartInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{ 
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = partId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Part_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PartInfo();
                    entity.PartId = Convert.ToInt32(rdr["PartId"]);
                    entity.PartName = Convert.ToString(rdr["PartName"]);
                    entity.PartCode = Convert.ToString(rdr["PartCode"]);
                    entity.EquipmentTypeId = Convert.ToInt32(rdr["EquipmentTypeId"]);
                    entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
                    entity.PartStand = Convert.ToString(rdr["PartStand"]);
                    entity.FactoryId = Convert.ToInt32(rdr["FactoryID"]);
                    entity.FactoryName = Convert.ToString(rdr["FactoryName"]);

                    entity.PartSupplierId = Convert.ToInt32(rdr["PartSupplierId"]);
                    entity.FactoryDate = Convert.ToDateTime(rdr["FactoryDate"]);
                    entity.PartLive = Convert.ToString(rdr["PartLive"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);

                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]);
                    entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr["ModifyDateTime"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);

                    entity.SupplierName = Convert.ToString(rdr["VendorName"]);
                    entity.Qty = Convert.ToInt32(rdr["Qty"]);
                    entity.CurrentStock = Convert.ToInt32(rdr["CurrentStock"]);
                    entity.MinStock = Convert.ToInt32(rdr["MinStock"]);

                    entity.MaxStock = Convert.ToInt32(rdr["MaxStock"]);
                    entity.UnitName = Convert.ToString(rdr["UnitName"]);
                    entity.Position = Convert.ToInt32(rdr["Position"]);
                    entity.PositionName = Convert.ToString(rdr["PositionName"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Part 实体对象。</returns>
        public PartInfo GetInfo(String fieldValue)
        {
            PartInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Part_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PartInfo();
                    entity.PartId = Convert.ToInt32(rdr["PartId"]);
                    entity.PartName = Convert.ToString(rdr["PartName"]);
                    entity.PartCode = Convert.ToString(rdr["PartCode"]);
                    entity.EquipmentTypeId = Convert.ToInt32(rdr["EquipmentTypeId"]);
                    entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
                    entity.PartStand = Convert.ToString(rdr["PartStand"]);
                    entity.FactoryId = Convert.ToInt32(rdr["FactoryID"]);
                    entity.FactoryName = Convert.ToString(rdr["FactoryName"]);

                    entity.PartSupplierId = Convert.ToInt32(rdr["PartSupplierId"]);
                    entity.FactoryDate = Convert.ToDateTime(rdr["FactoryDate"]);
                    entity.PartLive = Convert.ToString(rdr["PartLive"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);

                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]);
                    entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr["ModifyDateTime"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);

                    entity.SupplierName = Convert.ToString(rdr["VendorName"]);
                    entity.Qty = Convert.ToInt32(rdr["Qty"]);
                    entity.CurrentStock = Convert.ToInt32(rdr["CurrentStock"]);
                    entity.MinStock = Convert.ToInt32(rdr["MinStock"]);

                    entity.MaxStock = Convert.ToInt32(rdr["MaxStock"]);
                    entity.UnitName = Convert.ToString(rdr["UnitName"]);
                    entity.Position = Convert.ToInt32(rdr["Position"]);
                    entity.PositionName = Convert.ToString(rdr["PositionName"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Part 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="partCount">part 总数。</param>
        /// <returns>Part 列表。</returns>
        public List<PartInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PartInfo> list = new List<PartInfo>();
            PartInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetPartList", "PartId",
                "PartId, PartName,PartCode,EquipmentTypeId,EquipmentTypeName,PartStand,FactoryID,FactoryName,PartSupplierId,FactoryDate,PartLive,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,Remark, VendorName,Qty,CurrentStock,MinStock,MaxStock,UnitName,Position,PositionName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PartInfo();
                    entity.PartId = Convert.ToInt32(rdr["PartId"]);
                    entity.PartName = Convert.ToString(rdr["PartName"]);
                    entity.PartCode = Convert.ToString(rdr["PartCode"]); 
                    entity.EquipmentTypeId = Convert.ToInt32(rdr["EquipmentTypeId"]);
                    entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
                    entity.PartStand = Convert.ToString(rdr["PartStand"]);
                    entity.FactoryId = Convert.ToInt32(rdr["FactoryID"]);
                    entity.FactoryName = Convert.ToString(rdr["FactoryName"]);

                    entity.PartSupplierId = Convert.ToInt32(rdr["PartSupplierId"]);
                    entity.FactoryDate = Convert.ToDateTime(rdr["FactoryDate"]);
                    entity.PartLive = Convert.ToString(rdr["PartLive"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);

                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]);
                    entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr["ModifyDateTime"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                  
                    entity.SupplierName = Convert.ToString(rdr["VendorName"]);
                    entity.Qty = Convert.ToInt32(rdr["Qty"]);
                    entity.CurrentStock = Convert.ToInt32(rdr["CurrentStock"]);
                    entity.MinStock = Convert.ToInt32(rdr["MinStock"]);

                    entity.MaxStock = Convert.ToInt32(rdr["MaxStock"]);
                    entity.UnitName = Convert.ToString(rdr["UnitName"]);
                    entity.Position = Convert.ToInt32(rdr["Position"]);
                    entity.PositionName = Convert.ToString(rdr["PositionName"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 获备件与部件关系列表
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<PartInfo> GetAllPartEqu(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PartInfo> list = new List<PartInfo>();
            PartInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetPartEquimentList", "PartId",
                "[PartId], [PartCode], [PartName],[EquimentId],[EquipmentCode],[EquipmentName],[CreateDateTime],", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PartInfo();
                    entity.PartId = rdr.GetInt32(0);
                    entity.PartCode = rdr.GetString(1);
                    entity.PartName = rdr.GetString(2);
                    entity.EquimentId = rdr.GetInt32(3);
                    entity.EquimentCode = rdr.GetString(4);
                    entity.EquimentName = rdr.GetString(5);
                    entity.CreateDateTime = rdr.GetDateTime(6);
                 
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 出入库
        /// </summary>
        /// <param name="Code"></param>
        /// <param name="Type">1 入库 2 出库</param>
        public void InOut(int PartId, int Type, int Qty)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PartId", SqlDbType.Int),
                new SqlParameter("@Type", SqlDbType.Int),
                new SqlParameter("@Qty", SqlDbType.Int),
            };

            parms[0].Value = PartId;
            parms[1].Value = Type;
            parms[2].Value = Qty;
        }

        /// <summary>
        /// 获备件与部件关系列表 add zhuxi 20171016
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<PartInfo> GetAllPartEquNew(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PartInfo> list = new List<PartInfo>();
            PartInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetPartEquimentListNew", "PartId",
                "Id,[PartId], [PartCode], [PartName],[EquipmentId],[EquipmentCode],[EquipmentName],[CreateTime],[CreateBy],PartStand,FactoryName,VendorName,MinStock,MaxStock,CurrentStock,UseStock,PositionName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PartInfo();
                    entity.Id = Convert.ToInt32(rdr["Id"]);
                    entity.PartId =Convert.ToInt32(rdr["PartId"]);
                    entity.PartCode = Convert.ToString(rdr["PartCode"]);
                    entity.PartName = Convert.ToString(rdr["PartName"]);
                    entity.EquimentId = Convert.ToInt32(rdr["EquipmentId"]);
                    entity.EquimentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquimentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.CreateDateTime =Convert.ToDateTime(rdr["CreateTime"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.PartStand = Convert.ToString(rdr["PartStand"]);
                    entity.FactoryName = Convert.ToString(rdr["FactoryName"]);
                    entity.SupplierName = Convert.ToString(rdr["VendorName"]);
                    entity.MinStock = Convert.ToInt32(rdr["MinStock"]);
                    entity.MaxStock = Convert.ToInt32(rdr["MaxStock"]);
                    entity.CurrentStock = Convert.ToInt32(rdr["CurrentStock"]);
                    entity.UseStock = Convert.ToInt32(rdr["UseStock"]);
                    entity.PositionName = Convert.ToString(rdr["PositionName"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 获备件与部件关联信息 add zhuxi 20171016
        /// </summary>
        /// <param name="partId"></param>
        /// <returns></returns>
        public PartInfo GetPartEquInfo(int partId)
        {
            PartInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PartId", SqlDbType.Int)
            };

            parms[0].Value = partId;
    

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_PartEquipment_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PartInfo();
                    entity.PartId = Convert.ToInt32(rdr["PartId"]);
                    entity.PartName = Convert.ToString(rdr["PartName"]);
                    entity.PartCode = Convert.ToString(rdr["PartCode"]);
                    entity.EquimentId= Convert.ToInt32(rdr["EquipmentId"]);
                    entity.EquipmentTypeId = Convert.ToInt32(rdr["EquipmentTypeId"]);
                    entity.EquimentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquimentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateTime"]);
                   
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 出入库
        /// </summary>
        /// <param name="Code"></param>
        /// <param name="Type">1 入库 2 出库</param>
        /// <param name="opType">Type=1(0=新增入库  1=产线入库)  Type=2(0=使用出库 1=报废出库)</param>
        public void InOut(int PartId, int Type,int Qty,string createBy,string remark,int opType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PartId", SqlDbType.Int),
                new SqlParameter("@Type", SqlDbType.Int),
                new SqlParameter("@Qty", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar),
                new SqlParameter("@Remark", SqlDbType.VarChar),
                new SqlParameter("@OpType", SqlDbType.Int),
            };

            parms[0].Value = PartId;
            parms[1].Value = Type;
            parms[2].Value = Qty;
            parms[3].Value = createBy;
            parms[4].Value = remark;
            parms[5].Value = opType;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPartInOrOut", parms);
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        /// <summary>
        /// 新增备件与设备关系
        /// </summary>
        /// <param name="partId">备件ID</param>
        /// <param name="createBy">用户名</param>
        /// <param name="itemIdString">设备ID</param>
        /// <returns></returns>
        public Int32 SavePartInEquiment(int partId, string itemIdString, string createBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PartId", SqlDbType.Int),
                new SqlParameter("@ItemIDString", SqlDbType.VarChar, 4000),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = partId;
            parms[1].Value = itemIdString;
            parms[2].Value = createBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Part_EditInEquipment", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 删除备件设备关系
        /// </summary>
        /// <param name="partId">备件ID</param>
        /// <param name="createBy">用户名</param>
        /// <param name="itemIdString">设备ID</param>
        public void RemovePartOutEquiment(int partId, string itemIdString, string createBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PartId", SqlDbType.Int),
                new SqlParameter("@ItemIDString", SqlDbType.VarChar, 4000),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = partId;
            parms[1].Value = itemIdString;
            parms[2].Value = createBy;
       
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Part_EquipmentDelete", parms);
        }


        /// <summary>
        /// 获取出入库记录信息 add zhuxi 20171016
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<PartInfo> GetAllInOutStockList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PartInfo> list = new List<PartInfo>();
            PartInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetPartInOutStockList", "Rid",
                "Rid,[PartId], [PartCode], [PartName],[Qty],[OptType],[OperationType],[CreateTime],[CreateBy],Remark", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PartInfo();

                    entity.Rid = Convert.ToInt32(rdr["Rid"]);
                    entity.PartId = Convert.ToInt32(rdr["PartId"]);
                    entity.PartCode = Convert.ToString(rdr["PartCode"]);
                    entity.PartName = Convert.ToString(rdr["PartName"]);
                    entity.Qty = Convert.ToInt32(rdr["Qty"]);
                    entity.OptType = Convert.ToInt32(rdr["OptType"]);
                    entity.OperationType = Convert.ToString(rdr["OperationType"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 获取出入库记录信息 add zhuxi 20171016
        /// </summary>
        /// <param name="rid"></param>
       
        /// <returns></returns>
        public PartInfo GetInOutStockInfo(int rid)
        {
            PartInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Rid", SqlDbType.Int)
            };

            parms[0].Value = rid;


            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_PartInOutStock_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PartInfo();
                    entity.Rid = rid;
                    entity.PartId = Convert.ToInt32(rdr["PartId"]);
                    entity.PartCode = Convert.ToString(rdr["PartCode"]);
                    entity.PartName = Convert.ToString(rdr["PartName"]);
                    entity.Qty = Convert.ToInt32(rdr["Qty"]);
                    entity.OptType = Convert.ToInt32(rdr["OptType"]);
                    entity.OperationType = Convert.ToString(rdr["OperationType"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.Remark= Convert.ToString(rdr["Remark"]);
                }
                rdr.Close();
            }

            return entity;
        }

    }
}