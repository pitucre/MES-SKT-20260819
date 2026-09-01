using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.Common.Model;
using System.Data.SqlClient;
using System.Data;

namespace SKT.LeanMES.Quality.BLL
{
    public class OSP
    {
        private Int32 recordCount = 0;

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        #region OSP类型



        /// <summary>
        /// 分页获取 InspectionItem 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionItemCount">inspectionItem 总数。</param>
        /// <returns>InspectionItem 列表。</returns>
        public List<OSPType> GetOSPType(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<OSPType> list = new List<OSPType>();
            //表名或者视图
            string strTb = "vwProd_OSPType";
            //主键
            string strKey = "OSPTypeId";
            //查询栏位字串
            string strColumns = @"[OSPTypeId], [OSPTypeName], [OSPTypeTime], [CreateBy], [CreateDateTime],CASE WHEN IsSystem = 1 THEN '是' ELSE '否' END AS  IsSystem,ModifyBy,ModifyDateTime";
            list = ComMethod.GetComList<OSPType>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// OSP类型编辑
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public Int32 OSPTypeEdit(OSPType entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OSPTypeId", SqlDbType.Int),
                new SqlParameter("@OSPTypeName", SqlDbType.NVarChar, 150),
                new SqlParameter("@OSPTypeTime", SqlDbType.NVarChar, 20),
                new SqlParameter("@UserName", SqlDbType.NVarChar), 

            };

            parms[0].Value = entity.OSPTypeId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.OSPTypeName;
            parms[2].Value = entity.OSPTypeTime;
            parms[3].Value = entity.CreateBy;
          
            ComMethod.Edit("Prod_OSPType_Edit", parms);
            return (Int32)parms[0].Value;
        }

        public OSPType GetOSPTypeInfo(Int32 id)
        {

            return ComMethod.GetInfo<OSPType>(id, "Prod_OSPType_GetInfo");
        }

        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Prod_OSPType_Delete");
        }
        #endregion

        #region OSP产品维护

        /// <summary>
        /// 分页获取 InspectionItem 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionItemCount">inspectionItem 总数。</param>
        /// <returns>InspectionItem 列表。</returns>
        public List<OSPItem> GetOSPItem(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<OSPItem> list = new List<OSPItem>();
            //表名或者视图
            string strTb = "vwOSPItem";
            //主键
            string strKey = "OSPItemId";
            //查询栏位字串
            string strColumns = @"[OSPItemId], [ItemCode], [ItemName],[ItemSpec], [CreateBy], [CreateDateTime],ModifyBy,ModifyDateTime";
            list = ComMethod.GetComList<OSPItem>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public Int32 OSPItemEdit(OSPItem entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OSPItemId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@OSPItemDtl", SqlDbType.NVarChar),              
                new SqlParameter("@UserName", SqlDbType.DateTime),

            };

            parms[0].Value = entity.OSPItemId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ItemId;
            parms[2].Value = entity.OSPItemDtl;
            parms[3].Value = entity.CreateBy;

            ComMethod.Edit("Prod_OSPItem_Edit", parms);
            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 获取OSP 产品 设置信息
        /// </summary>
        /// <param name="OSPItemId"></param>
        /// <returns></returns>
        public List<OSPItemDtl> GetOSPItemDtl(int OSPItemId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OSPItemId", SqlDbType.Int),                

            };
            parms[0].Value = OSPItemId;

            return ComMethod.GetList<OSPItemDtl>("uspGetOSPItemDtl", parms);

        }

        public void OSPItemDelete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Prod_OSPItem_Delete");
        }
        #endregion

    }
}
