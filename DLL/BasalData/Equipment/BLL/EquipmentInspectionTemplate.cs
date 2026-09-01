using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentInspectionTemplate
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） InspectionTemplate 信息。
        /// </summary>
        /// <param name="entity">InspectionTemplate 实体对象。</param>
        public Int32 Edit(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionTemplateId", SqlDbType.Int),
                new SqlParameter("@InspectionTemplateName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Creater", SqlDbType.NVarChar, 20),
                new SqlParameter("@CreateTime", SqlDbType.DateTime),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@InspectionItemIdList", SqlDbType.NVarChar, 50),
                new SqlParameter("@Status", SqlDbType.Bit),
                new SqlParameter("@InspectionTypeId", SqlDbType.Int),
                new SqlParameter("@TempItems", SqlDbType.Structured),
                new SqlParameter("@Version", SqlDbType.NVarChar),
            };
            parms[0].Direction = ParameterDirection.InputOutput;
            ComMethod.Edit<EquipmentInspectionTemplateInfo>(strJson, "Equipment_InspectionTemplate_Edit", parms);
            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 编辑（添加或更新） InspectionTemplate 信息。
        /// </summary>
        /// <param name="entity">InspectionTemplate 实体对象。</param>
        public Int32 EditJW(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionTemplateId", SqlDbType.Int),
                new SqlParameter("@InspectionTemplateName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Creater", SqlDbType.NVarChar, 20),
                new SqlParameter("@CreateTime", SqlDbType.DateTime),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@InspectionItemIdList", SqlDbType.NVarChar, 50),
                new SqlParameter("@Status", SqlDbType.Bit),
                new SqlParameter("@InspectionTypeId", SqlDbType.Int),
                new SqlParameter("@TempItems", SqlDbType.Structured),
                new SqlParameter("@Version", SqlDbType.NVarChar),
            };
            parms[0].Direction = ParameterDirection.InputOutput;
            ComMethod.Edit<EquipmentInspectionTemplateInfo>(strJson, "Equipment_InspectionTemplate_EditJW", parms);
            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 根据 InspectionTemplateId 字符串删除 InspectionTemplate 信息。
        /// </summary>
        /// <param name="idString">InspectionTemplateId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Equipment_InspectionTemplate_Delete");
        }

        /// <summary>
        /// 根据 InspectionTemplateId 获取实体信息。
        /// </summary>
        /// <param name="inspectionTemplateId">InspectionTemplateId。</param>
        /// <returns>InspectionTemplate 实体对象。</returns>
        public EquipmentInspectionTemplateInfo GetInfo(Int32 inspectionTemplateId)
        {
            return ComMethod.GetInfo<EquipmentInspectionTemplateInfo>(inspectionTemplateId, "Equipment_InspectionTemplate_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionTemplate 实体对象。</returns>
        public EquipmentInspectionTemplateInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<EquipmentInspectionTemplateInfo>(fieldValue, "Equipment_InspectionTemplate_GetInfo");
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
        public List<EquipmentInspectionTemplateInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentInspectionTemplateInfo> list = new List<EquipmentInspectionTemplateInfo>();
            //表名或者视图
            string strTb = "VWEquipmentInspectionTemplate";
            //主键
            string strKey = "InspectionTemplateId";
            //查询栏位字串
            string strColumns = @"InspectionTemplateId,[InspectionTemplateName], [Creater], 
            CreateTime, [Description], [InspectionItemIdList], [Status], InspectionTypeId , InspectionTypeName,Version,ModifyBy,ModifyTime ";
            list = ComMethod.GetComList<EquipmentInspectionTemplateInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}