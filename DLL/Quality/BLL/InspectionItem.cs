using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class InspectionItem
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） InspectionItem 信息。
        /// </summary>
        /// <param name="entity">InspectionItem 实体对象。</param>
        public Int32 Edit(InspectionItemInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@InspectionItemId", SqlDbType.Int),
                new SqlParameter("@InspectionItemName", SqlDbType.NVarChar, 150),
                new SqlParameter("@Creater", SqlDbType.NVarChar, 20),
                new SqlParameter("@CreateTime", SqlDbType.DateTime),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@Status", SqlDbType.Bit),
                new SqlParameter("@ParentId", SqlDbType.Int),
                new SqlParameter("@Sorting", SqlDbType.Int),
                new SqlParameter("@InspectionMethodId", SqlDbType.Int),
                new SqlParameter("@UnitName", SqlDbType.NVarChar,50),
                new SqlParameter("@Inpsectionmethods", SqlDbType.NVarChar,50)
            };

            parms[0].Value = entity.InspectionItemId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.InspectionItemName;
            parms[2].Value = entity.Creater;
            parms[3].Value = entity.CreateTime;
            parms[4].Value = entity.Description;
            parms[5].Value = entity.Status;
            parms[6].Value = entity.ParentId;
            parms[7].Value = entity.Sorting;
            parms[8].Value = entity.InspectionMethodId;
            parms[9].Value = entity.UnitName;
            parms[10].Value = entity.Inpsectionmethods;
            ComMethod.Edit("Quality_InspectionItem_Edit", parms);
            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 InspectionItemId 字符串删除 InspectionItem 信息。
        /// </summary>
        /// <param name="idString">InspectionItemId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Quality_InspectionItem_Delete");
        }

        /// <summary>
        /// 根据 InspectionItemId 获取实体信息。
        /// </summary>
        /// <param name="inspectionItemId">InspectionItemId。</param>
        /// <returns>InspectionItem 实体对象。</returns>
        public InspectionItemInfo GetInfo(Int32 inspectionItemId)
        {
            return ComMethod.GetInfo<InspectionItemInfo>(inspectionItemId, "Quality_InspectionItem_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionItem 实体对象。</returns>
        public InspectionItemInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<InspectionItemInfo>(fieldValue, "Quality_InspectionItem_GetInfo");
        }

        /// <summary>
        /// 分页获取 InspectionItem 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionItemCount">inspectionItem 总数。</param>
        /// <returns>InspectionItem 列表。</returns>
        public List<InspectionItemInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionItemInfo> list = new List<InspectionItemInfo>();
            //表名或者视图
            string strTb = "Quality_InspectionItem";
            //主键
            string strKey = "InspectionItemId";
            //查询栏位字串
            string strColumns = @"[InspectionItemId], [InspectionItemName], [Creater], [CreateTime], [Description], [Status],[InspectionMethodId],[TestMethod],[UnitName],[Inpsectionmethods]";
            list = ComMethod.GetComList<InspectionItemInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        public List<InspectionItemInfo> GetAllTree(int ParentId = -1)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ParentId", SqlDbType.Int)
            };
            parms[0].Value = ParentId;
            return ComMethod.GetList<InspectionItemInfo>("Quality_InspectionItem_Tree", parms);
        }
    }
}