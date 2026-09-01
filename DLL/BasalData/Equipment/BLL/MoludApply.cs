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
    public class MoludApply
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentRepair 信息。
        /// </summary>
        /// <param name="entity">EquipmentRepair 实体对象。</param>
        public Int32 Edit(MoludApplyInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Cid", SqlDbType.Int),
                new SqlParameter("@ApplyNo", SqlDbType.VarChar, 50),
                new SqlParameter("@ItemId", SqlDbType.VarChar, 50),
                new SqlParameter("@DeptId", SqlDbType.VarChar, 200),
                new SqlParameter("@EquimentId", SqlDbType.VarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@MouldBomId", SqlDbType.Int),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@ChangeoverPlanTime", SqlDbType.DateTime),
                new SqlParameter("@ActualStartTime", SqlDbType.DateTime),
                new SqlParameter("@ActualFinish", SqlDbType.DateTime),
                new SqlParameter("@NeedTime", SqlDbType.DateTime),
                new SqlParameter("@ApplyRemark", SqlDbType.VarChar, 500),
                new SqlParameter("@ChangeOverRemark", SqlDbType.VarChar, 500),
                new SqlParameter("@Operator", SqlDbType.VarChar, 30),
                

            };

            parms[0].Value = entity.Cid;
            parms[1].Value = entity.ApplyNo;
            parms[2].Value = entity.ItemId;
            parms[3].Value = entity.DeptId;
            parms[4].Value = entity.EquimentId;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.MouldBomId;
            parms[7].Value = entity.Status;
            parms[8].Value = entity.ChangeoverPlanTime;
            parms[9].Value = entity.ActualStartTime;
            parms[10].Value = entity.ActualFinish;
            parms[11].Value = entity.NeedTime;
            parms[12].Value = entity.ApplyRemark;
            parms[13].Value = entity.ChangeOverRemark;
            parms[14].Value = entity.Operator;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCreateApplyChangeOverEdit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 编辑（添加或更新） EquipmentRepair 信息。
        /// </summary>
        /// <param name="cid">EquipmentRepair 实体对象。</param>
        /// <param name="operators">EquipmentRepair 实体对象。</param>
        public Int32 EditOperator(int cid,string operators)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Cid", SqlDbType.Int),
                new SqlParameter("@Operator", SqlDbType.VarChar),


            };

            parms[0].Value = cid;
            parms[1].Value = operators;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMouldEditOperator", parms);

            return (Int32)parms[0].Value;
        }
        
        /// <summary>
        /// 编辑（添加或更新） EquipmentRepair 信息。
        /// </summary>
        /// <param name="entity">EquipmentRepair 实体对象。</param>
        public Int32 EditChange(MoludApplyInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Cid", SqlDbType.Int),
                new SqlParameter("@ChangeoverPlanTime", SqlDbType.DateTime),
                new SqlParameter("@ActualStartTime", SqlDbType.DateTime),
                new SqlParameter("@ActualFinish", SqlDbType.DateTime),
                new SqlParameter("@ChangeOverRemark", SqlDbType.VarChar, 500),
                new SqlParameter("@Operator", SqlDbType.VarChar, 30),
                new SqlParameter("@DocXml", SqlDbType.VarChar),
                new SqlParameter("@InitialPress", SqlDbType.Int),
                new SqlParameter("@CurrentPress", SqlDbType.Int)
            };

            parms[0].Value = entity.Cid;
            parms[1].Value = entity.ChangeoverPlanTime;
            parms[2].Value = entity.ActualStartTime;
            parms[3].Value = entity.ActualFinish;
            parms[4].Value = entity.ChangeOverRemark;
            parms[5].Value = entity.Operator;
            parms[6].Value = entity.DocXml;
            parms[7].Value = entity.InitialPress;
            parms[8].Value = entity.CurrentPress;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspChangeOverEdit", parms);

            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 编辑（添加或更新） EquipmentRepair 信息。
        /// </summary>
        /// <param name="entity">EquipmentRepair 实体对象。</param>
        public Int32 EditConfimEdit(MoludApplyInfo entity, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Cid", SqlDbType.Int),
                new SqlParameter("@Isqualified", SqlDbType.Bit),
                new SqlParameter("@ChangeConfirmRemark", SqlDbType.VarChar, 500),
                new SqlParameter("@AffirmUserName", SqlDbType.VarChar, 20),
                new SqlParameter("@ActualFinish", SqlDbType.DateTime)
            };

            parms[0].Value = entity.Cid;
            parms[1].Value = entity.Isqualified;
            parms[2].Value = entity.ChangeConfirmRemark;
            parms[3].Value = userName;
            parms[4].Value = entity.ActualFinish;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspChangeOverConfimEdit", parms);

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
        /// 获取申请换模单号 
        /// </summary>
        /// <returns></returns>
        public string GetEquipmentRepairNo(int serialNumberType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@NextNumberType", SqlDbType.Int),
                    new SqlParameter("@ItemId", SqlDbType.Int),
                    new SqlParameter("@WOID", SqlDbType.Int),
                    new SqlParameter("@SN",SqlDbType.VarChar,50)
                };
            parms[0].Value = serialNumberType;
            parms[1].Value = -1;
            parms[2].Value = -1;
            parms[3].Value = -1;
            parms[3].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateItemSN", parms);

            return parms[3].Value.ToString();
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

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentMoulde_Delete", parms);
        }

        /// <summary>
        /// 根据 cid 获取实体信息。
        /// </summary>
        /// <param name="cid">cid。</param>
        /// <returns>EquipmentRepair 实体对象。</returns>
        public MoludApplyInfo GetInfo(Int32 cid)
        {
            MoludApplyInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = cid;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MouldApply_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MoludApplyInfo();
                    entity.Cid = Convert.ToInt32(rdr["Cid"]);
                    entity.EquimentId = Convert.ToInt32(rdr["EquimentId"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.ApplyNo = Convert.ToString(rdr["ApplyNo"]);
                    entity.ItemId = Convert.ToInt32(rdr["ItemId"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.NeedTime = Convert.ToDateTime(rdr["NeedTime"]);
                    entity.DeptId = Convert.ToInt32(rdr["DeptId"]);
                    entity.DepartName = Convert.ToString(rdr["DepartName"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.ChangeoverPlanTime = Convert.ToDateTime(rdr["ChangeoverPlanTime"]);
                    entity.ActualStartTime = Convert.ToDateTime(rdr["ActualStartTime"]);
                    entity.ActualFinish = Convert.ToDateTime(rdr["ActualFinish"]);
                    entity.Status = Convert.ToInt32(rdr["Status"]);
                    entity.ApplyRemark = Convert.ToString(rdr["ApplyRemark"]);
                    entity.ChangeOverRemark = Convert.ToString(rdr["ChangeOverRemark"]);
                    entity.Operator = Convert.ToString(rdr["Operator"]);
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]);
                    entity.InitialPress= Convert.ToInt32(rdr["InitialPress"]);
                    entity.CurrentPress= Convert.ToInt32(rdr["CurrentPress"]);
                    entity.IsMouldUnload = Convert.ToBoolean(rdr["IsMouldUnload"]);
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
        public MoludApplyInfo GetInfo(String fieldValue)
        {
            MoludApplyInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_MouldApply_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MoludApplyInfo();
                    entity.Cid = Convert.ToInt32(rdr["Cid"]);
                    entity.EquimentId = Convert.ToInt32(rdr["EquimentId"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.ApplyNo = Convert.ToString(rdr["ApplyNo"]);
                    entity.ItemId = Convert.ToInt32(rdr["ItemId"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.NeedTime = Convert.ToDateTime(rdr["NeedTime"]);
                    entity.DeptId = Convert.ToInt32(rdr["DeptId"]);
                    entity.DepartName = Convert.ToString(rdr["DepartName"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.ChangeoverPlanTime = Convert.ToDateTime(rdr["ChangeoverPlanTime"]);
                    entity.ActualStartTime = Convert.ToDateTime(rdr["ActualStartTime"]);
                    entity.ActualFinish = Convert.ToDateTime(rdr["ActualFinish"]);
                    entity.Status = Convert.ToInt32(rdr["Status"]);
                    entity.ApplyRemark = Convert.ToString(rdr["ApplyRemark"]);
                    entity.ChangeOverRemark = Convert.ToString(rdr["ChangeOverRemark"]);
                    entity.Operator = Convert.ToString(rdr["Operator"]);
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]);
                    entity.IsMouldUnload = Convert.ToBoolean(rdr["IsMouldUnload"]);
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
        public List<MoludApplyInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MoludApplyInfo> list = new List<MoludApplyInfo>();
            MoludApplyInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vWMouldApply", "Cid",
                @"Cid,EquimentId ,
                    EquipmentCode,
                    EquipmentName,
                  ApplyNo,
                  ItemId,
                  ItemCode,
                  ItemName,
                  NeedTime,
                  DeptId,
                  DepartName,
                  CreateBy,
                  CreateTime,
                  ChangeoverPlanTime,
                  ActualStartTime,
                  ActualFinish,
                  Status,
                  ApplyRemark,
                  ChangeOverRemark,
                  Operator,MouldBomId,
				  BomName,AffirmUserName,ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MoludApplyInfo();
                    entity.Cid = Convert.ToInt32(rdr["Cid"]);
                    entity.EquimentId = Convert.ToInt32(rdr["EquimentId"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.ApplyNo = Convert.ToString(rdr["ApplyNo"]);
                    entity.ItemId = Convert.ToInt32(rdr["ItemId"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.NeedTime = Convert.ToDateTime(rdr["NeedTime"]);
                    entity.DeptId = Convert.ToInt32(rdr["DeptId"]);
                    entity.DepartName = Convert.ToString(rdr["DepartName"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.ChangeoverPlanTime = Convert.ToDateTime(rdr["ChangeoverPlanTime"]);
                    entity.ActualStartTime = Convert.ToDateTime(rdr["ActualStartTime"]);
                    entity.ActualFinish = Convert.ToDateTime(rdr["ActualFinish"]);
                    entity.Status = Convert.ToInt32(rdr["Status"]);
                    entity.ApplyRemark = Convert.ToString(rdr["ApplyRemark"]);
                    entity.ChangeOverRemark = Convert.ToString(rdr["ChangeOverRemark"]);
                    entity.Operator = Convert.ToString(rdr["Operator"]);
                    entity.MouldBomId = Convert.ToInt32(rdr["MouldBomId"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]);
                    entity.AffirmUserName = Convert.ToString(rdr["AffirmUserName"]);

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
        public List<MoludApplyDetailInfo> GetDetailAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MoludApplyDetailInfo> list = new List<MoludApplyDetailInfo>();
            MoludApplyDetailInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vWChangeoverApplyDetail", "Cd_Id",
                @"Cd_Id,Cid,CurrentMouldId ,ReplaceMouldId,
                    CurrentMouldCode,
                    CurrentMouldName,
                  ReplaceMouldCode,
                  ReplaceMouldName,ReplaceMouldType,CurrentMouldType", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MoludApplyDetailInfo();
                    entity.Cd_Id= Convert.ToInt32(rdr["Cd_Id"]);
                    entity.Cid = Convert.ToInt32(rdr["Cid"]);
                   
                    entity.CurrentMouldId = Convert.ToInt32(rdr["CurrentMouldId"]);
                    entity.ReplaceMouldId = Convert.ToInt32(rdr["ReplaceMouldId"]);
                    entity.CurrentMouldType = Convert.ToInt32(rdr["CurrentMouldType"]);
                    entity.ReplaceMouldType = Convert.ToInt32(rdr["ReplaceMouldType"]);
                    entity.CurrentMouldCode = Convert.ToString(rdr["CurrentMouldCode"]);
                    entity.CurrentMouldName = Convert.ToString(rdr["CurrentMouldName"]);
                    entity.ReplaceMouldCode = Convert.ToString(rdr["ReplaceMouldCode"]);
                    entity.ReplaceMouldName = Convert.ToString(rdr["ReplaceMouldName"]);
                   

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 获取模具装在设备上视图列表。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <returns>EquipmentRepair 列表。</returns>
  //      public List<EquimentMouldInfo> GetEquimentMouldAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
  //      {
  //          List<EquimentMouldInfo> list = new List<EquimentMouldInfo>();
  //          EquimentMouldInfo entity = null;

  //          SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vWEquimentMould", "EmId",
  //              @"EmId ,
  //      EquimentId ,
		//MouldId,
		//MouldType,
		//EquipmentTypeCode,
		//EquipmentTypeName,
  //      EquipmentCode ,
  //      EquipmentName ,
  //      MouldCode ,
  //     MouldName,CreateBy,CreateTime", searchSettings, sortExpression);

  //          using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
  //          {
  //              while (rdr.Read())
  //              {
  //                  entity = new EquimentMouldInfo();
  //                  entity.EmId = Convert.ToInt32(rdr["EmId"]);
  //                  entity.EquimentId = Convert.ToInt32(rdr["EquimentId"]);
  //                  entity.MouldId = Convert.ToInt32(rdr["MouldId"]);
  //                  entity.MouldType = Convert.ToInt32(rdr["MouldType"]);
  //                  entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
  //                  entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
  //                  entity.MouldCode = Convert.ToString(rdr["MouldCode"]);
  //                  entity.MouldName = Convert.ToString(rdr["MouldName"]);
  //                  entity.EquipmentTypeCode = Convert.ToString(rdr["EquipmentTypeCode"]);
  //                  entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
  //                  entity.CreateBy= Convert.ToString(rdr["CreateBy"]);
  //                  entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
  //                  list.Add(entity);
  //              }
  //              rdr.Close();
  //          }

  //          recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
  //          return list;
  //      }


        public List<MoldFixtureUpLine> GetEquimentMouldAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MoldFixtureUpLine> list = new List<MoldFixtureUpLine>();
            //表名或者视图
            string strTb = "vWEquimentMould";//"Prod_Apply";
                                                   //主键
            string strKey = "MoldFixtureUpLineId";//"ApplyId";
                                 //查询栏位字串         
            string strColumns = @"MoldFixtureUpLineId,MoudleCode,MoudleName,EquipmentCode,EquipmentName,CreateDateTime,CreateBy";
            list = ComMethod.GetComList<MoldFixtureUpLine>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }


        #region 获取设备在机模具查询列表
        /// <summary>
        /// 获取设备在机模具查询列表 todo 
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <returns>EquipmentRepair 列表。</returns>
        public List<EquimentMouldInfo> GetEquipmentOnLineMouldList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquimentMouldInfo> list = new List<EquimentMouldInfo>();
            EquimentMouldInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vWEquimentMould", "EmId",
                @"EmId ,
        EquimentId ,
		MouldId,
		MouldType,
		EquipmentTypeCode,
		EquipmentTypeName,
        EquipmentCode ,
        EquipmentName ,
        MouldCode ,
       MouldName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquimentMouldInfo();
                    entity.EmId = Convert.ToInt32(rdr["EmId"]);
                    entity.EquimentId = Convert.ToInt32(rdr["EquimentId"]);
                    entity.MouldId = Convert.ToInt32(rdr["MouldId"]);
                    entity.MouldType = Convert.ToInt32(rdr["MouldType"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.MouldCode = Convert.ToString(rdr["MouldCode"]);
                    entity.MouldName = Convert.ToString(rdr["MouldName"]);
                    entity.EquipmentTypeCode = Convert.ToString(rdr["EquipmentTypeCode"]);
                    entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        #endregion

        /// <summary>
        /// 根据 cid 获取实体信息。
        /// </summary>
        /// <param name="equimentId">cid。</param>
        /// <returns>EquipmentRepair 实体对象。</returns>
        public List<EquipmentTypeInfo> GetEquimentMouldTypeList(Int32 equimentId)
        {
            List<EquipmentTypeInfo> list=new List<EquipmentTypeInfo>();
            EquipmentTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquimentId", SqlDbType.Int, 4)
               
            };

            parms[0].Value = equimentId;
         

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEquimentMouldTypeList", parms))
            {
                while(rdr.Read())
                {
                    entity = new EquipmentTypeInfo();
                    entity.EquipmentTypeId = Convert.ToInt32(rdr["EquipmentTypeId"]);
                    entity.EquipmentTypeCode = Convert.ToString(rdr["EquipmentTypeCode"]);
                    entity.EquipmentTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }


        /// <summary>
        /// 根据 cid 获取实体信息。
        /// </summary>
        /// <param name="equimentId">cid。</param>
        /// <returns>EquipmentRepair 实体对象。</returns>
        public List<EquimentMouldBomChild> GetEquimentMouldBomChildList(Int32 equimentId)
        {
            List<EquimentMouldBomChild> list = new List<EquimentMouldBomChild>();
            EquimentMouldBomChild entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquimentId", SqlDbType.Int, 4)

            };

            parms[0].Value = equimentId;


            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEquimentMouldBomChildList", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquimentMouldBomChild();
                    entity.MouldType = Convert.ToInt32(rdr["MouldType"]);
                    entity.IsAdd = Convert.ToInt32(rdr["IsAdd"]);
                    entity.MouldTypeName = Convert.ToString(rdr["EquipmentTypeName"]);
                    entity.ComponentCode= Convert.ToString(rdr["ComponentCode"]);
                    entity.Describe = Convert.ToString(rdr["Describe"]);
                    entity.ReplaceComponentName = Convert.ToString(rdr["ReplaceComponentName"]);
                    
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