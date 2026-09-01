using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class InspectionOrderMember
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） InspectionOrderMember 信息。
        /// </summary>
        /// <param name="entity">InspectionOrderMember 实体对象。</param>
        public Int32 Edit(InspectionOrderMemberInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOMemberId", SqlDbType.Int),
                new SqlParameter("@IOrderId", SqlDbType.Int),
                new SqlParameter("@SerialNumber", SqlDbType.NVarChar, 50),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@Qty", SqlDbType.Int),
                new SqlParameter("@InspectionResult", SqlDbType.NVarChar, 20),
                new SqlParameter("@DealResult", SqlDbType.NVarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.IOMemberId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.IOrderId;
            parms[2].Value = entity.SerialNumber;
            parms[3].Value = entity.ItemId;
            parms[4].Value = entity.Qty;
            parms[5].Value = entity.InspectionResult;
            parms[6].Value = entity.DealResult;
            parms[7].Value = entity.CreateBy;
            parms[8].Value = entity.ModifyBy;
            parms[9].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionOrderMember_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 InspectionOrderMemberId 字符串删除 InspectionOrderMember 信息。
        /// </summary>
        /// <param name="idString">InspectionOrderMemberId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionOrderMember_Delete", parms);
        }

        /// <summary>
        /// 根据 InspectionOrderMemberId 获取实体信息。
        /// </summary>
        /// <param name="inspectionOrderMemberId">InspectionOrderMemberId。</param>
        /// <returns>InspectionOrderMember 实体对象。</returns>
        public InspectionOrderMemberInfo GetInfo(Int32 inspectionOrderMemberId)
        {
            InspectionOrderMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = inspectionOrderMemberId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionOrderMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new InspectionOrderMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionOrderMember 实体对象。</returns>
        public InspectionOrderMemberInfo GetInfo(String fieldValue)
        {
            InspectionOrderMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionOrderMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new InspectionOrderMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 InspectionOrderMember 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionOrderMemberCount">inspectionOrderMember 总数。</param>
        /// <returns>InspectionOrderMember 列表。</returns>
        public List<InspectionOrderMemberInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionOrderMemberInfo> list = new List<InspectionOrderMemberInfo>();
            InspectionOrderMemberInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[dbo].[Quality_InspectionOrderMember] a INNER JOIN dbo.Quality_InspectionOrder b ON a.IOrderId = b.IOrderId", "IOMemberId",
                "[IOMemberId], a.[IOrderId], [SerialNumber], [ItemId], [Qty], a.[InspectionResult], a.[DealResult], a.[CreateBy], a.[CreateDateTime], a.[ModifyBy], a.[ModifyDateTime], a.[Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new InspectionOrderMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetString(6) == "" ? "未检" : rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11));

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


        public string InspectionAdditionalMember(ref int IOrderId,int InspectionTypeId, int ItemId, string ItemCode, string SNStr, string CreateBy,int OpeID)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionTypeId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@SNStr", SqlDbType.NVarChar, -1),
                new SqlParameter("@CreateBy",SqlDbType.NVarChar, 20),
                new SqlParameter("@IOrderId", SqlDbType.Int),
                new SqlParameter("@IOrderNo", SqlDbType.NVarChar, 50),
                 new SqlParameter("@OpeId",SqlDbType.NVarChar, 20),
            };

            parms[0].Value = InspectionTypeId;
            parms[1].Value = ItemId;
            parms[2].Value = ItemCode;
            parms[3].Value = SNStr;
            parms[4].Value = CreateBy;
            parms[5].Value = IOrderId;
            parms[5].Direction = ParameterDirection.InputOutput;
            parms[6].Value = "";
            parms[6].Direction = ParameterDirection.InputOutput;
            parms[7].Value = OpeID;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCreateInspection", parms);
            IOrderId = Convert.ToInt32(parms[5].Value);
            return IOrderId+","+Convert.ToString(parms[6].Value); ;
        }




        public string InspectionAdditionalMemberGeneral(ref int IOrderId, int InspectionTypeId, int ItemId, 
            string ItemCode, string SNStr, string CreateBy, int OpeID, int LineId, int ResourceId, int StationId, int OrderId, int TemplateId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionTypeId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@SNStr", SqlDbType.NVarChar, -1),
                new SqlParameter("@CreateBy",SqlDbType.NVarChar, 20),
                new SqlParameter("@IOrderId", SqlDbType.Int),
                new SqlParameter("@IOrderNo", SqlDbType.NVarChar, 50),
                 new SqlParameter("@OpeId",SqlDbType.NVarChar, 20),
                new SqlParameter("@LineId",SqlDbType.NVarChar, 20),
                new SqlParameter("@ResourceId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.NVarChar, 50),
                 new SqlParameter("@OrderId",SqlDbType.NVarChar, 20),
                 new SqlParameter("@TemplateId",SqlDbType.NVarChar, 20),
            };

            parms[0].Value = InspectionTypeId;
            parms[1].Value = ItemId;
            parms[2].Value = ItemCode;
            parms[3].Value = SNStr;
            parms[4].Value = CreateBy;
            parms[5].Value = IOrderId;
            parms[5].Direction = ParameterDirection.InputOutput;
            parms[6].Value = "";
            parms[6].Direction = ParameterDirection.InputOutput;
            parms[7].Value = OpeID;
            parms[8].Value = LineId;
            parms[9].Value = ResourceId;
            parms[10].Value = StationId;
            parms[11].Value = OrderId;
            parms[12].Value = TemplateId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCreateInspectionGeneral", parms);
            IOrderId = Convert.ToInt32(parms[5].Value);
            return IOrderId+","+Convert.ToString(parms[6].Value); ;
        }


        /// <summary>
        /// 生成IPQC检验单号
        /// </summary>
        /// <returns></returns>
        public string InspectionIPQCGeneral()
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOrderNo", SqlDbType.NVarChar, 50){ Value = "",Direction=ParameterDirection.InputOutput}
            };

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateIPQCOrder", parms);
            return Convert.ToString(parms[0].Value); 
        }

        /// <summary>
        /// 生成工程检验单号
        /// </summary>
        /// <returns></returns>
        public string InspectionProjectGeneral()
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOrderNo", SqlDbType.NVarChar, 50){ Value = "",Direction=ParameterDirection.InputOutput}
            };

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateProjectOrder", parms);
            return Convert.ToString(parms[0].Value);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="IOrderId"></param>
        /// <param name="InspectionTypeId"></param>
        /// <param name="ItemId"></param>
        /// <param name="ItemCode"></param>
        /// <param name="SNStr"></param>
        /// <param name="CreateBy"></param>
        /// <param name="OpeID"></param>
        /// <param name="LineId"></param>
        /// <param name="ResourceId"></param>
        /// <param name="StationId"></param>
        /// <param name="OrderId"></param>
        /// <param name="TemplateId"></param>
        /// <param name="LotCode"></param>
        /// <param name="EquipmentId"></param>
        /// <param name="sampleQty"></param>
        /// <param name="sendman"></param>
        /// <param name="classType"></param>
        /// <returns></returns>
        public string InspectionAdditionalMemberGeneral(ref int IOrderId, int InspectionTypeId, int ItemId,
            string ItemCode, string SNStr, string CreateBy, int OpeID, int LineId, int ResourceId, int StationId,
            int OrderId, int TemplateId, string LotCode, int EquipmentId, int sampleQty, string sendman, string classType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionTypeId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@SNStr", SqlDbType.NVarChar, -1),
                new SqlParameter("@CreateBy",SqlDbType.NVarChar, 20),
                new SqlParameter("@IOrderId", SqlDbType.Int),
                new SqlParameter("@IOrderNo", SqlDbType.NVarChar, 50),
                 new SqlParameter("@OpeId",SqlDbType.NVarChar, 20),
                new SqlParameter("@LineId",SqlDbType.NVarChar, 20),
                new SqlParameter("@ResourceId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.NVarChar, 50),
                 new SqlParameter("@OrderId",SqlDbType.NVarChar, 20),
                 new SqlParameter("@TemplateId",SqlDbType.NVarChar, 20),
                 new SqlParameter("@EquipmentId",SqlDbType.NVarChar, 20),
                 new SqlParameter("@LotCode",SqlDbType.NVarChar, 50),
                 new SqlParameter("@SampleQty",SqlDbType.Int),
                 new SqlParameter("@SendMan",SqlDbType.NVarChar,20),
                 new SqlParameter("@ClassType",SqlDbType.NVarChar,20)
            };

            parms[0].Value = InspectionTypeId;
            parms[1].Value = ItemId;
            parms[2].Value = ItemCode;
            parms[3].Value = SNStr;
            parms[4].Value = CreateBy;
            parms[5].Value = IOrderId;
            parms[5].Direction = ParameterDirection.InputOutput;
            parms[6].Value = "";
            parms[6].Direction = ParameterDirection.InputOutput;
            parms[7].Value = OpeID;
            parms[8].Value = LineId;
            parms[9].Value = ResourceId;
            parms[10].Value = StationId;
            parms[11].Value = OrderId;
            parms[12].Value = TemplateId;
            parms[13].Value = EquipmentId;
            parms[14].Value = LotCode;
            parms[15].Value = sampleQty;
            parms[16].Value = sendman;
            parms[17].Value = classType;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCreateInspectionGeneralTwo", parms);
            IOrderId = Convert.ToInt32(parms[5].Value);
            return IOrderId + "," + Convert.ToString(parms[6].Value); ;
        }
        public int GetInspectionUnqualifiedQty(int IOrderId, string InspectionItemName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOrderId", SqlDbType.Int),
                new SqlParameter("@InspectionItemName", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = IOrderId;
            parms[1].Value = InspectionItemName;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionUnqualifiedQty", parms))
            {
                int count = 0;
                while (rdr.Read())
                {
                     count  = rdr.GetInt32(0);
                }
                rdr.Close();
                return count;
            }
        }

        public int GetInspectionEDQty(int IOrderId, string InspectionItemName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOrderId", SqlDbType.Int),
                new SqlParameter("@InspectionItemName", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = IOrderId;
            parms[1].Value = InspectionItemName;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionInspectionEDQty", parms))
            {
                int count = 0;
                while (rdr.Read())
                {
                    count = rdr.GetInt32(0);
                }
                rdr.Close();
                return count;
            }
        }

        public string GetInspectionNeedQtyPercentage(int IOrderId, string InspectionItemName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOrderId", SqlDbType.Int),
                new SqlParameter("@InspectionItemName", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = IOrderId;
            parms[1].Value = InspectionItemName;

            string Count = "";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionNeedQtyPercentage", parms))
            {
                while (rdr.Read())
                {
                    Count = rdr.GetString(0);
                }
                rdr.Close();
            }
            return Count;
        }
    }
}