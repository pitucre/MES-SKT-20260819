using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentInspectionType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） InspectionType 信息。
        /// </summary>
        /// <param name="entity">InspectionType 实体对象。</param>
        public Int32 Edit(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionTypeId", SqlDbType.Int),
                new SqlParameter("@InspectionTypeName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Creater", SqlDbType.NVarChar, 20),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@Status", SqlDbType.Bit),
                new SqlParameter("@InspectionRuleIdList", SqlDbType.NVarChar, 50),
                new SqlParameter("@GenerateNumberTypeId", SqlDbType.Int),
                new SqlParameter("@SystemType", SqlDbType.Int),

            };
            parms[0].Direction = ParameterDirection.InputOutput;
            ComMethod.Edit<EquipmentInspectionTypeInfo>(strJson, "Equipment_InspectionType_Edit", parms);
            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 InspectionTypeId 字符串删除 InspectionType 信息。
        /// </summary>
        /// <param name="idString">InspectionTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Equipment_InspectionType_Delete");
        }

        /// <summary>
        /// 根据 InspectionTypeId 获取实体信息。
        /// </summary>
        /// <param name="inspectionTypeId">InspectionTypeId。</param>
        /// <returns>InspectionType 实体对象。</returns>
        public EquipmentInspectionTypeInfo GetInfo(Int32 inspectionTypeId)
        {
            return ComMethod.GetInfo<EquipmentInspectionTypeInfo>(inspectionTypeId, "Equipment_InspectionType_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionType 实体对象。</returns>
        public EquipmentInspectionTypeInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<EquipmentInspectionTypeInfo>(fieldValue, "Equipment_InspectionType_GetInfo");
        }

        /// <summary>
        /// 分页获取 InspectionType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionTypeCount">inspectionType 总数。</param>
        /// <returns>InspectionType 列表。</returns>
        public List<EquipmentInspectionTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentInspectionTypeInfo> list = new List<EquipmentInspectionTypeInfo>();
            //表名或者视图
            string strTb = "vwEquipmentInspectionType";
            //主键
            string strKey = "InspectionTypeId";
            //查询栏位字串
            string strColumns = @" [InspectionTypeId], [InspectionTypeName],[Creater], [CreateTime], [Description], [Status], [InspectionRuleIdList], 
            GenerateNumberTypeId, SerialNumberType,ModifyBy, ModifyTime, QCTypeName ";
            list = ComMethod.GetComList<EquipmentInspectionTypeInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}