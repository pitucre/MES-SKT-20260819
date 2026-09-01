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
    public class InspectionTemplateItem
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） InspectionTemplateItem 信息。
        /// </summary>
        /// <param name="entity">InspectionTemplateItem 实体对象。</param>
        public Int32 Edit(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionTemplateItemId", SqlDbType.Int),
                new SqlParameter("@InspectionTemplateId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@AQLRuleId", SqlDbType.Int),
                new SqlParameter("@LotAudit", SqlDbType.NVarChar, 50),
                new SqlParameter("@VendorCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@AQLSampleId", SqlDbType.Int),
                new SqlParameter("@CategoryOne", SqlDbType.VarChar,50),
                new SqlParameter("@CategoryTwo", SqlDbType.VarChar,50),
                new SqlParameter("@CategoryThree", SqlDbType.VarChar,50),
            };

            parms[0].Direction = ParameterDirection.InputOutput;
            ComMethod.Edit<InspectionTemplateItemInfo>(strJson, "Quality_InspectionTemplateItem_Edit", parms);
			
            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 InspectionTemplateItemId 字符串删除 InspectionTemplateItem 信息。
        /// </summary>
        /// <param name="idString">InspectionTemplateItemId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Quality_InspectionTemplateItem_Delete");
        }

        /// <summary>
        /// 根据 InspectionTemplateItemId 获取实体信息。
        /// </summary>
        /// <param name="inspectionTemplateItemId">InspectionTemplateItemId。</param>
        /// <returns>InspectionTemplateItem 实体对象。</returns>
        public InspectionTemplateItemInfo GetInfo(Int32 inspectionTemplateItemId)
        {
            return ComMethod.GetInfo<InspectionTemplateItemInfo>(inspectionTemplateItemId, "Quality_InspectionTemplateItem_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionTemplateItem 实体对象。</returns>
        public InspectionTemplateItemInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<InspectionTemplateItemInfo>(fieldValue, "Quality_InspectionTemplateItem_GetInfo");
        }

        /// <summary>
        /// 分页获取 InspectionTemplateItem 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionTemplateItemCount">inspectionTemplateItem 总数。</param>
        /// <returns>InspectionTemplateItem 列表。</returns>
        public List<InspectionTemplateItemInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionTemplateItemInfo> list = new List<InspectionTemplateItemInfo>();
            //表名或者视图
            string strTb = "vwInspectionTemplateItem";
            //主键
            string strKey = "InspectionTemplateItemId";
            //查询栏位字串
            string strColumns = @"[InspectionTemplateItemId], [InspectionTemplateId], [ItemId], [CreateBy], 
                [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],InspectionTemplateName,ItemCode,
                InspectionTypeId,InspectionTypeName,AQLRuleId, AQLRuleName, AQLRuleTypeName, LotAudit, LotName,VendorCode,VendorName,AQLSampleName,
                CategoryOne,CategoryTwo,CategoryThree,CategoryOneName,CategoryTwoName,CategoryThreeName";
            list = ComMethod.GetComList<InspectionTemplateItemInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 分页获取 InspectionTemplateItem 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionTemplateItemCount">inspectionTemplateItem 总数。</param>
        /// <returns>InspectionTemplateItem 列表。</returns>
        public List<InspectionTemplateItemInfo> GetLotList()
        {
            string strSql = @"SELECT COLUMN_NAME AS LotAudit, 
                        CASE WHEN COLUMN_NAME LIKE 'Audit_S%' THEN '特殊水平' ELSE '一般水平' END + SUBSTRING(COLUMN_NAME, 7, LEN(COLUMN_NAME) - 6) LotName
                    FROM INFORMATION_SCHEMA.columns WHERE TABLE_NAME='Quality_AQLLotSize' AND COLUMN_NAME LIKE 'Audit%'";
            return ComMethod.GetListBySql<InspectionTemplateItemInfo>(strSql, null);
        }

    }
}