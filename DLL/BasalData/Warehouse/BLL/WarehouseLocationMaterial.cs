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
    public class WarehouseLocationMaterial
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Warehouse 信息。
        /// </summary>
        /// <param name="entity">Warehouse 实体对象。</param>
        public Int32 Edit(WarehouseLocationMaterialInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WarehouseLocationMaterialId", SqlDbType.Int),
                new SqlParameter("@ItemId",  SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 50),
                new SqlParameter("@CWhId", SqlDbType.Int),
                new SqlParameter("@CWhCode", SqlDbType.VarChar, 50),
                new SqlParameter("@CWlId", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 400),

            };

            parms[0].Value = entity.WarehouseLocationMaterialId;
            parms[1].Value = entity.ItemId;
            parms[2].Value = entity.ItemCode;
            parms[3].Value = entity.CWhId;
            parms[4].Value = entity.CWhCode;
            parms[5].Value = entity.CWlId;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.Remark;


            ComMethod.Edit("Basal_WarehouseLocationMaterial_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 WarehouseId 字符串删除 Warehouse 信息。
        /// </summary>
        /// <param name="idString">WarehouseId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Basal_WarehouseLocationMaterial_Delete");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Warehouse 实体对象。</returns>
        public WarehouseLocationMaterialInfo GetInfo(Int32 fieldValue)
        {
            return ComMethod.GetInfo<WarehouseLocationMaterialInfo>(fieldValue, "Basal_WarehouseLocationMaterial_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Warehouse 实体对象。</returns>
        public WarehouseLocationMaterialInfo GetInfo(string fieldValue)
        {
            return ComMethod.GetInfo<WarehouseLocationMaterialInfo>(fieldValue, "Basal_WarehouseLocationMaterial_GetInfo");
        }

        /// <summary>
        /// 分页获取 Warehouse 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warehouseCount">warehouse 总数。</param>
        /// <returns>Warehouse 列表。</returns>
        public List<WarehouseLocationMaterialInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseLocationMaterialInfo> list = new List<WarehouseLocationMaterialInfo>();
            //表名或者视图
            string strTb = "vmWarehouseLocationMaterial";
            //主键
            string strKey = "WarehouseLocationMaterialId    ";
            //查询栏位字串
            string strColumns = @"[WarehouseLocationMaterialId],[ItemId],[ItemCode],[CWhId],[CWhCode] ,[CWlId],[CBarCode],[CreateBy],[CreateDateTime],[ModifyBy],[ModifyDateTime],[Remark]";
            list = ComMethod.GetComList<WarehouseLocationMaterialInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}