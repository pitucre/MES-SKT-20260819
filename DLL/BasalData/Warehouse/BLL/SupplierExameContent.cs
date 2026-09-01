using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Warehouse.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Warehouse.BLL
{
    public class SupplierExameContent
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） InspectionItem 信息。
        /// </summary>
        /// <param name="entity">InspectionItem 实体对象。</param>
        public Int32 Edit(SupplierExameContentInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SupplierExameContentId", SqlDbType.Int),
                new SqlParameter("@ParentId", SqlDbType.Int),
                new SqlParameter("@SupplierExameName", SqlDbType.VarChar, 50),
                new SqlParameter("@SupplierExameType", SqlDbType.Int),
                new SqlParameter("@SupplierExameCompute", SqlDbType.VarChar, 50),
                new SqlParameter("@Creater", SqlDbType.VarChar,20),
                new SqlParameter("@Description", SqlDbType.VarChar,200),
                new SqlParameter("@IsEnable", SqlDbType.Int),
                new SqlParameter("@IsParent", SqlDbType.Bit),
                new SqlParameter("@Sorting", SqlDbType.Int)
            };

            parms[0].Value = entity.SupplierExameContentId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ParentId;
            parms[2].Value = entity.SupplierExameName;
            parms[3].Value = entity.SupplierExameType;
            parms[4].Value = entity.SupplierExameCompute;
            parms[5].Value = entity.Creater;
            parms[6].Value = entity.Description;
            parms[7].Value = entity.IsEnable;
            parms[8].Value = entity.isParent;
            parms[9].Value = entity.Sorting;
            ComMethod.Edit("Basal_SupplierExameContent_Edit", parms);
            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 InspectionItemId 字符串删除 InspectionItem 信息。
        /// </summary>
        /// <param name="idString">InspectionItemId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Basal_SupplierExameContent_Delete");
        }

        /// <summary>
        /// 根据 InspectionItemId 获取实体信息。
        /// </summary>
        /// <param name="inspectionItemId">InspectionItemId。</param>
        /// <returns>InspectionItem 实体对象。</returns>
        public SupplierExameContentInfo GetInfo(Int32 supplierExameContentId)
        {
            return ComMethod.GetInfo<SupplierExameContentInfo>(supplierExameContentId, "Basal_SupplierExameContent_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionItem 实体对象。</returns>
        public SupplierExameContentInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<SupplierExameContentInfo>(fieldValue, "Basal_SupplierExameContent_GetInfo");
        }

        /// <summary>
        /// 分页获取 SupplierExameContent 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionItemCount">inspectionItem 总数。</param>
        /// <returns>InspectionItem 列表。</returns>
        public List<SupplierExameContentInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierExameContentInfo> list = new List<SupplierExameContentInfo>();
            //表名或者视图
            string strTb = "Basal_SupplierExameContent";
            //主键
            string strKey = "SupplierExameContentId";
            //查询栏位字串
            string strColumns = @"[SupplierExameContentId], [ParentId], [SupplierExameName], [SupplierExameType], [SupplierExameCompute], [Creater],[CreateTime],[Description],[IsEnable],[isParent],[Sorting]";
            list = ComMethod.GetComList<SupplierExameContentInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        /// <summary>
        /// 分页获取 SupplierExameContent 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionItemCount">inspectionItem 总数。</param>
        /// <returns>InspectionItem 列表。</returns>
        public List<SupplierExameItemInfo> GetExameItemAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierExameItemInfo> list = new List<SupplierExameItemInfo>();
            //表名或者视图
            string strTb = "vwBasal_SupplierExameContent";
            //主键
            string strKey = "SupplierExameContentId";
            //查询栏位字串
            string strColumns = @"[SupplierExameContentId],[SupplierExameName], [SupplierExameType], [SupplierExameCompute]";
            list = ComMethod.GetComList<SupplierExameItemInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        public List<SupplierExameContentInfo> GetAllTree(int ParentId = -1)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ParentId", SqlDbType.Int)
            };
            parms[0].Value = ParentId;
            return ComMethod.GetList<SupplierExameContentInfo>("Basal_SupplierExameContent_Tree", parms);
        }
    }
}
