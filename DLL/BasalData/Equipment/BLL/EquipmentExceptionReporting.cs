using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentExceptionReporting
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） InspectionTemplate 信息。
        /// </summary>
        /// <param name="entity">InspectionTemplate 实体对象。</param>
        public Int32 Edit(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ExceptionReportingId", SqlDbType.Int),
                new SqlParameter("@ExceptionReportingCode", SqlDbType.NVarChar),
                new SqlParameter("@ExceptionReportingName", SqlDbType.NVarChar),
                new SqlParameter("@Creater", SqlDbType.NVarChar),
                new SqlParameter("@CreateTime", SqlDbType.DateTime),
                new SqlParameter("@Description", SqlDbType.NVarChar),
                new SqlParameter("@ExceptionReportingItemIdList", SqlDbType.NVarChar),
                new SqlParameter("@Status", SqlDbType.Bit),
                new SqlParameter("@TempItems", SqlDbType.Structured),
                new SqlParameter("@Version", SqlDbType.NVarChar),
                new SqlParameter("@ExceptionType", SqlDbType.NVarChar),
            };
            parms[0].Direction = ParameterDirection.InputOutput;
            ComMethod.Edit<EquipmentExceptionReportingInfo>(strJson, "Equipment_ExceptionReporting_Edit", parms);
            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 根据 InspectionTemplateId 字符串删除 InspectionTemplate 信息。
        /// </summary>
        /// <param name="idString">InspectionTemplateId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Equipment_ExceptionReporting_Delete");
        }

        /// <summary>
        /// 根据 InspectionTemplateId 获取实体信息。
        /// </summary>
        /// <param name="inspectionTemplateId">InspectionTemplateId。</param>
        /// <returns>InspectionTemplate 实体对象。</returns>
        public EquipmentExceptionReportingInfo GetInfo(Int32 inspectionTemplateId)
        {
            return ComMethod.GetInfo<EquipmentExceptionReportingInfo>(inspectionTemplateId, "Equipment_ExceptionReporting_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionTemplate 实体对象。</returns>
        public EquipmentExceptionReportingInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<EquipmentExceptionReportingInfo>(fieldValue, "Equipment_ExceptionReporting_GetInfo");
        }

        /// <summary>
        /// 分页获取 InspectionTemplate 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionTemplateCount">inspectionTemplate 总数。</param>
        /// <returns>InspectionTemplate 列表。</returns>
        public List<EquipmentExceptionReportingInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentExceptionReportingInfo> list = new List<EquipmentExceptionReportingInfo>();
            //表名或者视图
            string strTb = "VWEquipmentExceptionReporting";
            //主键
            string strKey = "ExceptionReportingId";
            //查询栏位字串
            string strColumns = @"ExceptionReportingId,[ExceptionReportingCode],ExceptionReportingName, [Creater], 
            CreateTime, [Description], [ExceptionReportingItemIdList], [Status] ,Version,ModifyBy,ModifyTime ,ExceptionType";
            list = ComMethod.GetComList<EquipmentExceptionReportingInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

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
        public List<EquipmentExceptionReportingMemberInfo> GetAllMember(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentExceptionReportingMemberInfo> list = new List<EquipmentExceptionReportingMemberInfo>();
            //表名或者视图
            string strTb = "VWEquipmentExceptionReportingMember";
            //主键
            string strKey = "ExceptionReportingMemberId";
            //查询栏位字串
            string strColumns = @"ExceptionReportingMemberId,ExceptionReportingId,ExceptionReportingGrade,TimeOutLength,TimeOutUnit,ReportingUser,ReportingUserName,ReportingUserEmail,Creater,CreateTime ";
            list = ComMethod.GetComList<EquipmentExceptionReportingMemberInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}