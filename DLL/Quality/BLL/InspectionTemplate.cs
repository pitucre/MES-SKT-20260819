using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class InspectionTemplate
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
            ComMethod.Edit<InspectionTemplateInfo>(strJson, "Quality_InspectionTemplate_Edit", parms);
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
            ComMethod.Edit<InspectionTemplateInfo>(strJson, "Quality_InspectionTemplate_EditJW", parms);
            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 根据 InspectionTemplateId 字符串删除 InspectionTemplate 信息。
        /// </summary>
        /// <param name="idString">InspectionTemplateId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Quality_InspectionTemplate_Delete");
        }

        /// <summary>
        /// 根据 InspectionTemplateId 获取实体信息。
        /// </summary>
        /// <param name="inspectionTemplateId">InspectionTemplateId。</param>
        /// <returns>InspectionTemplate 实体对象。</returns>
        public InspectionTemplateInfo GetInfo(Int32 inspectionTemplateId)
        {
            return ComMethod.GetInfo<InspectionTemplateInfo>(inspectionTemplateId, "Quality_InspectionTemplate_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionTemplate 实体对象。</returns>
        public InspectionTemplateInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<InspectionTemplateInfo>(fieldValue, "Quality_InspectionTemplate_GetInfo");
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
        public List<InspectionTemplateInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionTemplateInfo> list = new List<InspectionTemplateInfo>();
            //表名或者视图
            string strTb = "VWQualityInspectionTemplate";
            //主键
            string strKey = "InspectionTemplateId";
            //查询栏位字串
            string strColumns = @"InspectionTemplateId,[InspectionTemplateName], [Creater], 
            CreateTime, [Description], [InspectionItemIdList], [Status], InspectionTypeId , InspectionTypeName,Version,ModifyBy,ModifyTime ";
            list = ComMethod.GetComList<InspectionTemplateInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
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
        public List<InspectionTemplateInfo> GetInspectionTemplateReItemAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionTemplateInfo> list = new List<InspectionTemplateInfo>();
            //表名或者视图
            string strTb = "VWQualityInspectionTemplateReItem";
            //主键
            string strKey = "InspectionTemplateId";
            //查询栏位字串
            string strColumns = @"InspectionTemplateId,[InspectionTemplateName],InspectionTypeName,InspectionTypeId,FileSaveName";
            list = ComMethod.GetComList<InspectionTemplateInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public Boolean InspectionItemExists(int ItemId,int SystemType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int){ Value = ItemId},
                new SqlParameter("@SystemType", SqlDbType.Int){ Value = SystemType},
                new SqlParameter("@ItemExists", SqlDbType.Bit){ Value = 0,Direction=ParameterDirection.InputOutput}
            };
            ComMethod.Edit("uspGetInspectionItemExists", parms);
            return (Boolean)parms[2].Value;
        }

        public void DeleteFAIInspectionTemplateFile(int Id)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int){ Value = Id}
            };
            ComMethod.Edit("uspDeleteFAIInspectionTemplateFile", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}