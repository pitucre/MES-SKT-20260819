using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Quality.BLL
{
    public class InspectionTemplateMember
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） InspectionTemplateMember 信息。
        /// </summary>
        /// <param name="entity">InspectionTemplateMember 实体对象。</param>
        public Int32 Edit(InspectionTemplateMemberInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionTemplateMemberId", SqlDbType.Int),
                new SqlParameter("@InspectionTemplateId", SqlDbType.Int),
                new SqlParameter("@InspectionItemId", SqlDbType.Int),
                new SqlParameter("@Sorting", SqlDbType.Int),
                new SqlParameter("@MaxValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@MinValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@SpecialRequest", SqlDbType.NVarChar, 50),
                new SqlParameter("@SamplingRate", SqlDbType.Decimal),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.InspectionTemplateMemberId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.InspectionTemplateId;
            parms[2].Value = entity.InspectionItemId;
            parms[3].Value = entity.Sorting;
            parms[4].Value = entity.MaxValue;
            parms[5].Value = entity.MinValue;
            parms[6].Value = entity.SpecialRequest;
            parms[7].Value = entity.SamplingRate;
            parms[8].Value = entity.CreateBy;
            parms[9].Value = entity.ModifyBy;
            parms[10].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionTemplateMember_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 InspectionTemplateMemberId 字符串删除 InspectionTemplateMember 信息。
        /// </summary>
        /// <param name="idString">InspectionTemplateMemberId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionTemplateMember_Delete", parms);
        }

        /// <summary>
        /// 根据 InspectionTemplateMemberId 获取实体信息。
        /// </summary>
        /// <param name="inspectionTemplateMemberId">InspectionTemplateMemberId。</param>
        /// <returns>InspectionTemplateMember 实体对象。</returns>
        public InspectionTemplateMemberInfo GetInfo(Int32 inspectionTemplateMemberId)
        {
            InspectionTemplateMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = inspectionTemplateMemberId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionTemplateMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new InspectionTemplateMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDecimal(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionTemplateMember 实体对象。</returns>
        public InspectionTemplateMemberInfo GetInfo(String fieldValue)
        {
            InspectionTemplateMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionTemplateMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new InspectionTemplateMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDecimal(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 InspectionTemplateMember 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionTemplateMemberCount">inspectionTemplateMember 总数。</param>
        /// <returns>InspectionTemplateMember 列表。</returns>
        public List<InspectionTemplateMemberInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionTemplateMemberInfo> list = new List<InspectionTemplateMemberInfo>();
            //表名或者视图
            string strTb = "[dbo].[Quality_InspectionTemplateMember] a	INNER JOIN [dbo].[Quality_InspectionTemplate] b ON b.InspectionTemplateId = a.InspectionTemplateId	INNER JOIN dbo.Quality_InspectionItem f ON f.InspectionItemId = a.InspectionItemId LEFT JOIN dbo.Quality_AQLRule g ON g.AQLRuleId = a.aqlruleId";
            //主键
            string strKey = "InspectionTemplateMemberId";
            //查询栏位字串
            string strColumns = @"[InspectionTemplateMemberId], a.[InspectionTemplateId], a.[InspectionItemId], a.[Sorting], a.[MaxValue], [MinValue], [SpecialRequest], [SamplingRate], a.[CreateBy], a.[CreateDateTime], a.[ModifyBy], a.[ModifyDateTime], a.[Remark], 
                        f.InspectionItemName, InspectionAccording , IsPercentage, a.aqlruleid, g.RuleName, a.InspectJuge,f.InspectionMethodId,a.InspectionMethodValue
                        ,a.UnitName,IsNull(a.CheckFashion,'') as CheckFashion,IsNull(f.TestMethod,'') as TestMethod, ISNULL(a.OffsetUnitName,'') AS OffsetUnitName";
            list = ComMethod.GetComList<InspectionTemplateMemberInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            
            return list;
        }

        /// <summary>
        /// 分页获取 InspectionTemplateMember 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionTemplateMemberCount">inspectionTemplateMember 总数。</param>
        /// <returns>InspectionTemplateMember 列表。</returns>
        public List<InspectionTemplateMemberInfo> GetAllJW(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionTemplateMemberInfo> list = new List<InspectionTemplateMemberInfo>();
            //表名或者视图
            string strTb = "[dbo].[Quality_InspectionTemplateMember] a	INNER JOIN [dbo].[Quality_InspectionTemplate] b ON b.InspectionTemplateId = a.InspectionTemplateId	INNER JOIN dbo.Quality_InspectionItem f ON f.InspectionItemId = a.InspectionItemId LEFT JOIN dbo.Quality_AQLRule g ON g.AQLRuleId = a.aqlruleId  LEFT JOIN  Basal_Station as Sta  on  Sta.StationId=a.OpenId";
            //主键
            string strKey = "InspectionTemplateMemberId";
            //查询栏位字串
            string strColumns = @"[InspectionTemplateMemberId], a.[InspectionTemplateId], a.[InspectionItemId], a.[Sorting], a.[MaxValue], [MinValue], [SpecialRequest], [SamplingRate], a.[CreateBy], a.[CreateDateTime], a.[ModifyBy], a.[ModifyDateTime], a.[Remark], 
                        f.InspectionItemName, InspectionAccording , IsPercentage, a.aqlruleid, g.RuleName, a.InspectJuge,f.InspectionMethodId,a.InspectionMethodValue
                        ,a.UnitName,IsNull(a.CheckFashion,'') as CheckFashion,IsNull(f.TestMethod,'') as TestMethod,[OpenId],isnull(Sta.Station,'') as OpenName";
            list = ComMethod.GetComList<InspectionTemplateMemberInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }


        /// <summary>
        /// add by zhuxi on 2017/09/25 
        /// 获取检验单明细信息
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="wareCode"></param>
        public List<InspectionTemplateMemberInfo> GetInspectionMemberInfoById(Int32 IOrderId)
        {
            List<InspectionTemplateMemberInfo> list = new List<InspectionTemplateMemberInfo>();
            InspectionTemplateMemberInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@IOrderId",SqlDbType.Int),
            };
            parms[0].Value = IOrderId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionOrderById", parms))
            {
                while (rdr.Read())
                {
                    entity = new InspectionTemplateMemberInfo();
                    entity.InspectionItemName = rdr.GetString(0);
                    entity.TestMethod = rdr.GetString(1);
                    entity.InspectionAccording = rdr.GetString(2);
                    entity.InspectionResult = rdr.GetString(3);
                    entity.Remark = rdr.GetString(4);
                    entity.NCCode = rdr.GetString(5);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }


        public List<InspectionTemplateMemberInfo> GetInspectionMemberDetailById(int IOrderId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@IOrderId",SqlDbType.Int){ Value = IOrderId}
            };

            return ComMethod.GetList<InspectionTemplateMemberInfo>("uspGetInspectionMemberDetailById", parms);
        }

        public List<InspectionTemplateMemberInfo> GetAllJoinItem(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionTemplateMemberInfo> list = new List<InspectionTemplateMemberInfo>();
            InspectionTemplateMemberInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[dbo].[Quality_InspectionTemplateMember] a	INNER JOIN [dbo].[Quality_InspectionTemplate] b ON b.InspectionTemplateId = a.InspectionTemplateId	INNER JOIN [dbo].[Quality_InspectionTemplateItem] c ON c.InspectionTemplateId = b.InspectionTemplateId	INNER JOIN dbo.Basal_Item d ON c.ItemID = d.ItemID 	INNER JOIN [dbo].[Quality_InspectionOrder] e ON e.ItemCode = d.ItemCode AND e.InspectionTypeId = b.InspectionTypeId	INNER JOIN dbo.Quality_InspectionItem f ON f.InspectionItemId = a.InspectionItemId"
                , "InspectionTemplateMemberId", "[InspectionTemplateMemberId], a.[InspectionTemplateId], a.[InspectionItemId], a.[Sorting], a.[MaxValue], [MinValue], [SpecialRequest], [SamplingRate], a.[CreateBy], a.[CreateDateTime], a.[ModifyBy], a.[ModifyDateTime], a.[Remark],f.InspectionItemName,isnull(e.InspectionQty,0),isnull(e.ItemCode,''),isnull(e.InspectionOrderNo,''),isnull(InspectionAccording,''),IOrderId", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new InspectionTemplateMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDecimal(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));

                    entity.InspectionItemName = rdr.GetString(13);
                    entity.InspectionOrderQty = rdr.GetInt32(14);
                    entity.ItemCode = rdr.GetString(15);
                    entity.InspectionOrderNo = rdr.GetString(16);
                    entity.InspectionAccording = rdr.GetString(17);
                    entity.IOrderId = rdr.GetInt32(18);
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