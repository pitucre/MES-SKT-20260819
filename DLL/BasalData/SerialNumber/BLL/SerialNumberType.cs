using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SerialNumber.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.SerialNumber.BLL
{
    public class SerialNumberType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SerialNumberType 信息。
        /// </summary>
        /// <param name="entity">SerialNumberType 实体对象。</param>
        public void Edit(SerialNumberTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumberTypeId", SqlDbType.Int),
                new SqlParameter("@SerialNumberType", SqlDbType.NVarChar, 50),
                new SqlParameter("@SerialNumberDesc", SqlDbType.NVarChar, 100),              
                new SqlParameter("@CreateBy",SqlDbType.VarChar,20),
                new SqlParameter("@ModifyBy",SqlDbType.VarChar,20)
            };

            parms[0].Value = entity.SerialNumberTypeId;
            parms[1].Value = entity.SerialNumberType;
            parms[2].Value = entity.SerialNumberDesc;             
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SerialNumberType_Edit", parms);
        }

        /// <summary>
        /// 根据 SerialNumberTypeId 字符串删除 SerialNumberType 信息。
        /// </summary>
        /// <param name="idString">SerialNumberTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SerialNumberType_Delete", parms);
        }

        /// <summary>
        /// 根据 SerialNumberTypeId 获取实体信息。
        /// </summary>
        /// <param name="serialNumberTypeId">SerialNumberTypeId。</param>
        /// <returns>SerialNumberType 实体对象。</returns>
        public SerialNumberTypeInfo GetInfo(Int32 serialNumberTypeId)
        {
            return ComMethod.GetInfo<SerialNumberTypeInfo>(serialNumberTypeId, "Basal_SerialNumberType_GetInfo");            
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SerialNumberType 实体对象。</returns>
        public SerialNumberTypeInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<SerialNumberTypeInfo>(fieldValue, "Basal_SerialNumberType_GetInfo"); 
        }

        /// <summary>
        /// 分页获取 SerialNumberType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="serialNumberTypeCount">serialNumberType 总数。</param>
        /// <returns>SerialNumberType 列表。</returns>
        public List<SerialNumberTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SerialNumberTypeInfo> list = new List<SerialNumberTypeInfo>();

            //表名或者视图
            string strTb = "vwBasal_SerialNumberType";////Basal_SerialNumberType
            //主键
            string strKey = "SerialNumberTypeId";
            //查询栏位字串
            string strColumns = @"[SerialNumberTypeId], [SerialNumberType], [SerialNumberDesc],CreateBy,CreateDateTime,ModifyBy,ModifyDateTime";
            //筛选条件--不显示系统内置条码类型
            //searchSettings.ExtensionCondition = " SerialNumberTypeId > 0 ";

            list = ComMethod.GetComList<SerialNumberTypeInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;            
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}